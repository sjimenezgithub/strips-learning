# -*- coding: utf-8 -*-

from __future__ import print_function

import sys
import copy

import graph
import pddl
import random
import itertools

def parse_typed_list(alist, only_variables=False,
                     constructor=pddl.TypedObject,
                     default_type="object"):
    aux = copy.deepcopy(alist)
    alist = []
    for item in aux:
        if item.startswith("-") and not item == "-":
            alist.append("-")
            alist.append(item[1:])
        else:
            alist.append(item)
    result = []
    while alist:
        try:
            separator_position = alist.index("-")
            pass
        except ValueError:
            items = alist
            _type = default_type
            alist = []
        else:
            items = alist[:separator_position]
            _type = alist[separator_position + 1]
            alist = alist[separator_position + 2:]
        for item in items:
            assert not only_variables or item.startswith("?"), \
                   "Expected item to be a variable: %s in (%s)" % (
                item, " ".join(items))
            entry = constructor(item, _type)
            result.append(entry)
    return result


def set_supertypes(type_list):
    # TODO: This is a two-stage construction, which is perhaps
    # not a great idea. Might need more thought in the future.
    type_name_to_type = {}
    child_types = []
    for type in type_list:
        type.supertype_names = []
        type_name_to_type[type.name] = type
        if type.basetype_name:
            child_types.append((type.name, type.basetype_name))
    for (desc_name, anc_name) in graph.transitive_closure(child_types):
        type_name_to_type[desc_name].supertype_names.append(anc_name)


def parse_predicate(alist):
    name = alist[0]
    arguments = parse_typed_list(alist[1:], only_variables=True)
    return pddl.Predicate(name, arguments)


def parse_function(alist, type_name):
    name = alist[0]
    arguments = parse_typed_list(alist[1:])
    return pddl.Function(name, arguments, type_name)


def parse_condition(alist, type_dict, predicate_dict):
    condition = parse_condition_aux(alist, False, type_dict, predicate_dict)
    # TODO: The next line doesn't appear to do anything good,
    # since uniquify_variables doesn't modify the condition in place.
    # Conditions in actions or axioms are uniquified elsewhere, but
    # it looks like goal conditions are never uniquified at all
    # (which would be a bug).
    condition.uniquify_variables({})
    return condition


def parse_condition_aux(alist, negated, type_dict, predicate_dict):
    """Parse a PDDL condition. The condition is translated into NNF on the fly."""
    tag = alist[0]
    if tag in ("and", "or", "not", "imply"):
        args = list()
        for arg in alist[1:]:
            if arg[0] == "=":
                continue
            if arg[0] == "not" and arg[1][0] == "=":
                continue
            args.append(arg)
        if tag == "imply":
            assert len(args) == 2
        if tag == "not":
            assert len(args) == 1
            return parse_condition_aux(
                args[0], not negated, type_dict, predicate_dict)
    elif tag in ("forall", "exists"):
        parameters = parse_typed_list(alist[1])
        args = alist[2:]
        assert len(args) == 1
    else:
        return parse_literal(alist, type_dict, predicate_dict, negated=negated)

    if tag == "imply":
        parts = [parse_condition_aux(
                args[0], not negated, type_dict, predicate_dict),
                 parse_condition_aux(
                args[1], negated, type_dict, predicate_dict)]
        tag = "or"
    else:
        parts = [parse_condition_aux(part, negated, type_dict, predicate_dict) for part in args]

    if tag == "and" and not negated or tag == "or" and negated:
        return pddl.Conjunction(parts)
    elif tag == "or" and not negated or tag == "and" and negated:
        return pddl.Disjunction(parts)
    elif tag == "forall" and not negated or tag == "exists" and negated:
        return pddl.UniversalCondition(parameters, parts)
    elif tag == "exists" and not negated or tag == "forall" and negated:
        return pddl.ExistentialCondition(parameters, parts)


def parse_literal(alist, type_dict, predicate_dict, negated=False):
    if alist[0] == "not":
        assert len(alist) == 2
        alist = alist[1]
        negated = not negated

    pred_id, arity = _get_predicate_id_and_arity(
        alist[0], type_dict, predicate_dict)

    if arity != len(alist) - 1:
        raise SystemExit("predicate used with wrong arity: (%s)"
                         % " ".join(alist))

    if negated:
        return pddl.NegatedAtom(pred_id, alist[1:])
    else:
        return pddl.Atom(pred_id, alist[1:])


SEEN_WARNING_TYPE_PREDICATE_NAME_CLASH = False
def _get_predicate_id_and_arity(text, type_dict, predicate_dict):
    global SEEN_WARNING_TYPE_PREDICATE_NAME_CLASH

    the_type = type_dict.get(text)
    the_predicate = predicate_dict.get(text)

    if the_type is None and the_predicate is None:
        raise SystemExit("Undeclared predicate: %s" % text)
    elif the_predicate is not None:
        if the_type is not None and not SEEN_WARNING_TYPE_PREDICATE_NAME_CLASH:
            msg = ("Warning: name clash between type and predicate %r.\n"
                   "Interpreting as predicate in conditions.") % text
            print(msg, file=sys.stderr)
            SEEN_WARNING_TYPE_PREDICATE_NAME_CLASH = True
        return the_predicate.name, the_predicate.get_arity()
    else:
        assert the_type is not None
        return the_type.get_predicate_name(), 1


def parse_effects(alist, result, type_dict, predicate_dict):
    """Parse a PDDL effect (any combination of simple, conjunctive, conditional, and universal)."""
    tmp_effect = parse_effect(alist, type_dict, predicate_dict)
    normalized = tmp_effect.normalize()
    cost_eff, rest_effect = normalized.extract_cost()
    add_effect(rest_effect, result)
    if cost_eff:
        return cost_eff.effect
    else:
        return None

def add_effect(tmp_effect, result):
    """tmp_effect has the following structure:
       [ConjunctiveEffect] [UniversalEffect] [ConditionalEffect] SimpleEffect."""

    if isinstance(tmp_effect, pddl.ConjunctiveEffect):
        for effect in tmp_effect.effects:
            add_effect(effect, result)
        return
    else:
        parameters = []
        condition = pddl.Truth()
        if isinstance(tmp_effect, pddl.UniversalEffect):
            parameters = tmp_effect.parameters
            if isinstance(tmp_effect.effect, pddl.ConditionalEffect):
                condition = tmp_effect.effect.condition
                assert isinstance(tmp_effect.effect.effect, pddl.SimpleEffect)
                effect = tmp_effect.effect.effect.effect
            else:
                assert isinstance(tmp_effect.effect, pddl.SimpleEffect)
                effect = tmp_effect.effect.effect
        elif isinstance(tmp_effect, pddl.ConditionalEffect):
            condition = tmp_effect.condition
            assert isinstance(tmp_effect.effect, pddl.SimpleEffect)
            effect = tmp_effect.effect.effect
        else:
            assert isinstance(tmp_effect, pddl.SimpleEffect)
            effect = tmp_effect.effect
        assert isinstance(effect, pddl.Literal)
        # Check for contradictory effects
        condition = condition.simplified()
        new_effect = pddl.Effect(parameters, condition, effect)
        contradiction = pddl.Effect(parameters, condition, effect.negate())

        ### REMOVED CONTRADICTION CHECK
        result.append(new_effect)

        # if not contradiction in result:
        #     result.append(new_effect)
        # else:
        #     # We use add-after-delete semantics, keep positive effect
        #     if isinstance(contradiction.literal, pddl.NegatedAtom):
        #         result.remove(contradiction)
        #         result.append(new_effect)

def parse_effect(alist, type_dict, predicate_dict):
    tag = alist[0]
    if tag == "and":
        return pddl.ConjunctiveEffect(
            [parse_effect(eff, type_dict, predicate_dict) for eff in alist[1:]])
    elif tag == "forall":
        assert len(alist) == 3
        parameters = parse_typed_list(alist[1])
        effect = parse_effect(alist[2], type_dict, predicate_dict)
        return pddl.UniversalEffect(parameters, effect)
    elif tag == "when":
        assert len(alist) == 3
        condition = parse_condition(
            alist[1], type_dict, predicate_dict)
        effect = parse_effect(alist[2], type_dict, predicate_dict)
        return pddl.ConditionalEffect(condition, effect)
    elif tag == "increase":
        assert len(alist) == 3
        assert alist[1] == ['total-cost']
        assignment = parse_assignment(alist)
        return pddl.CostEffect(assignment)
    else:
        # We pass in {} instead of type_dict here because types must
        # be static predicates, so cannot be the target of an effect.
        return pddl.SimpleEffect(parse_literal(alist, {}, predicate_dict))


def parse_expression(exp):
    if isinstance(exp, list):
        functionsymbol = exp[0]
        return pddl.PrimitiveNumericExpression(functionsymbol, exp[1:])
    elif exp.replace(".", "").isdigit():
        return pddl.NumericConstant(float(exp))
    elif exp[0] == "-":
        raise ValueError("Negative numbers are not supported")
    else:
        return pddl.PrimitiveNumericExpression(exp, [])

def parse_assignment(alist):
    assert len(alist) == 3
    op = alist[0]
    head = parse_expression(alist[1])
    exp = parse_expression(alist[2])
    if op == "=":
        return pddl.Assign(head, exp)
    elif op == "increase":
        return pddl.Increase(head, exp)
    else:
        assert False, "Assignment operator not supported."


def parse_action(alist, type_dict, predicate_dict):
    iterator = iter(alist)
    action_tag = next(iterator)
    assert action_tag == ":action"
    name = next(iterator)
    parameters_tag_opt = next(iterator)
    if parameters_tag_opt == ":parameters":
        parameters = parse_typed_list(next(iterator),
                                      only_variables=True)
        precondition_tag_opt = next(iterator)
    else:
        parameters = []
        precondition_tag_opt = parameters_tag_opt
    if precondition_tag_opt == ":precondition":
        precondition_list = next(iterator)
        if not precondition_list:
            # Note that :precondition () is allowed in PDDL.
            precondition = pddl.Conjunction([])
        else:
            precondition = parse_condition(
                precondition_list, type_dict, predicate_dict)
            precondition = precondition.simplified()
        effect_tag = next(iterator)
    else:
        precondition = pddl.Conjunction([])
        effect_tag = precondition_tag_opt
    assert effect_tag == ":effect"
    effect_list = next(iterator)
    eff = []
    if effect_list:
        try:
            cost = parse_effects(
                effect_list, eff, type_dict, predicate_dict)
        except ValueError as e:
            raise SystemExit("Error in Action %s\nReason: %s." % (name, e))
    for rest in iterator:
        assert False, rest
    # if eff:
    #     return pddl.Action(name, parameters, len(parameters),
    #                        precondition, eff, cost)
    # else:
    #     return None

    return pddl.Action(name, parameters, len(parameters),
                           precondition, eff, None)


def parse_axiom(alist, type_dict, predicate_dict):
    assert len(alist) == 3
    assert alist[0] == ":derived"
    predicate = parse_predicate(alist[1])
    condition = parse_condition(
        alist[2], type_dict, predicate_dict)
    return pddl.Axiom(predicate.name, predicate.arguments,
                      len(predicate.arguments), condition)


def parse_task(domain_pddl, task_pddl):
    domain_name, domain_requirements, types, type_dict, constants, predicates, predicate_dict, functions, actions, axioms \
                 = parse_domain_pddl(domain_pddl)
    task_name, task_domain_name, task_requirements, objects, init, goal, use_metric = parse_task_pddl(task_pddl, type_dict, predicate_dict)

    assert domain_name == task_domain_name
    requirements = pddl.Requirements(sorted(set(
                domain_requirements.requirements +
                task_requirements.requirements)))
    objects = constants + objects
    check_for_duplicates(
        [o.name for o in objects],
        errmsg="error: duplicate object %r",
        finalmsg="please check :constants and :objects definitions")
    # init += [pddl.Atom("=", (obj.name, obj.name)) for obj in objects]

    return pddl.Task(
        domain_name, task_name, requirements, types, objects,
        predicates, functions, init, goal, actions, axioms, use_metric)


def parse_domain_pddl(domain_pddl):
    iterator = iter(domain_pddl)

    define_tag = next(iterator)
    assert define_tag == "define"
    domain_line = next(iterator)
    if domain_line[0] == "domain":
        assert domain_line[0] == "domain" and len(domain_line) == 2
    else:
        domain_line = ["domain", "unknown"]
    yield domain_line[1]

    ## We allow an arbitrary order of the requirement, types, constants,
    ## predicates and functions specification. The PDDL BNF is more strict on
    ## this, so we print a warning if it is violated.
    requirements = pddl.Requirements([":strips"])
    the_types = [pddl.Type("object")]
    constants, the_predicates, the_functions = [], [], []
    correct_order = [":requirements", ":types", ":constants", ":predicates",
                     ":functions"]
    seen_fields = []
    first_action = None
    for opt in iterator:
        field = opt[0]
        if field not in correct_order:
            first_action = opt
            break
        if field in seen_fields:
            raise SystemExit("Error in domain specification\n" +
                             "Reason: two '%s' specifications." % field)
        if (seen_fields and
            correct_order.index(seen_fields[-1]) > correct_order.index(field)):
            msg = "\nWarning: %s specification not allowed here (cf. PDDL BNF)" % field
            print(msg, file=sys.stderr)
        seen_fields.append(field)
        if field == ":requirements":
            requirements = pddl.Requirements(opt[1:])
        elif field == ":types":
            the_types.extend(parse_typed_list(
                    opt[1:], constructor=pddl.Type))
        elif field == ":constants":
            constants = parse_typed_list(opt[1:])
        elif field == ":predicates":
            the_predicates = [parse_predicate(entry)
                              for entry in opt[1:]]
            # the_predicates += [pddl.Predicate("=",
            #                      [pddl.TypedObject("?x", "object"),
            #                       pddl.TypedObject("?y", "object")])]
        elif field == ":functions":
            the_functions = parse_typed_list(
                opt[1:],
                constructor=parse_function,
                default_type="number")
    set_supertypes(the_types)
    yield requirements
    yield the_types
    type_dict = dict((type.name, type) for type in the_types)
    yield type_dict
    yield constants
    yield the_predicates
    predicate_dict = dict((pred.name, pred) for pred in the_predicates)
    yield predicate_dict
    yield the_functions

    entries = []
    if first_action is not None:
        entries.append(first_action)
    entries.extend(iterator)

    the_axioms = []
    the_actions = []
    for entry in entries:
        if entry[0] == ":derived":
            axiom = parse_axiom(entry, type_dict, predicate_dict)
            the_axioms.append(axiom)
        else:
            action = parse_action(entry, type_dict, predicate_dict)
            if action is not None:
                the_actions.append(action)
    yield the_actions
    yield the_axioms

def parse_task_pddl(task_pddl, type_dict, predicate_dict):
    iterator = iter(task_pddl)

    define_tag = next(iterator)
    assert define_tag == "define"
    problem_line = next(iterator)
    assert problem_line[0] == "problem" and len(problem_line) == 2
    yield problem_line[1]
    domain_line = next(iterator)
    assert domain_line[0] == ":domain" and len(domain_line) == 2
    yield domain_line[1]

    requirements_opt = next(iterator)
    if requirements_opt[0] == ":requirements":
        requirements = requirements_opt[1:]
        objects_opt = next(iterator)
    else:
        requirements = []
        objects_opt = requirements_opt
    yield pddl.Requirements(requirements)

    if objects_opt[0] == ":objects":
        yield parse_typed_list(objects_opt[1:])
        init = next(iterator)
    else:
        yield []
        init = objects_opt

    assert init[0] == ":init"
    initial = []
    initial_true = set()
    initial_false = set()
    initial_assignments = dict()
    for fact in init[1:]:
        if fact[0] == "=":
            try:
                assignment = parse_assignment(fact)
            except ValueError as e:
                raise SystemExit("Error in initial state specification\n" +
                                 "Reason: %s." %  e)
            if not isinstance(assignment.expression,
                              pddl.NumericConstant):
                raise SystemExit("Illegal assignment in initial state " +
                    "specification:\n%s" % assignment)
            if assignment.fluent in initial_assignments:
                prev = initial_assignments[assignment.fluent]
                if assignment.expression == prev.expression:
                    print("Warning: %s is specified twice" % assignment,
                          "in initial state specification")
                else:
                    raise SystemExit("Error in initial state specification\n" +
                                     "Reason: conflicting assignment for " +
                                     "%s." %  assignment.fluent)
            else:
                initial_assignments[assignment.fluent] = assignment
                initial.append(assignment)
        elif fact[0] == "not":
            atom = pddl.Atom(fact[1][0], fact[1][1:])
            check_atom_consistency(atom, initial_false, initial_true, False)
            initial_false.add(atom)
        else:
            atom = pddl.Atom(fact[0], fact[1:])
            check_atom_consistency(atom, initial_true, initial_false)
            initial_true.add(atom)
    initial.extend(initial_true)
    yield initial

    goal = next(iterator)
    assert goal[0] == ":goal" and len(goal) == 2
    yield parse_condition(goal[1], type_dict, predicate_dict)

    use_metric = False
    for entry in iterator:
        if entry[0] == ":metric":
            if entry[1]=="minimize" and entry[2][0] == "total-cost":
                use_metric = True
            else:
                assert False, "Unknown metric."
    yield use_metric

    for entry in iterator:
        assert False, entry


def get_static_predicates(trajectory, predicates):

    candidates = set([p.name for p in predicates])

    trace_candidates = set()
    for predicate in candidates:
        static = True
        init_literals = set([l for l in trajectory[0] if l.predicate == predicate])
        for state in trajectory[1:]:
            state_literals = set([l for l in state if l.predicate == predicate])

            if init_literals != state_literals:
                static = False
                break

        if static:
            trace_candidates.add(predicate)

    candidates = candidates.intersection(trace_candidates)

    return candidates


def parse_trace_pddl(trace_pddl, predicates, action_observability=1, state_observability=1, goal_observability=1, positive_goals=False, finite_steps=False):
    random.seed(123)

    iterator = iter(trace_pddl)

    solution_tag = next(iterator)
    assert solution_tag == "solution"

    objects_opt = next(iterator)
    assert objects_opt[0] == ":objects"
    object_list = parse_typed_list(objects_opt[1:])

    all_literals = set()
    for predicate in predicates:
        args = list()
        for i in range(len(predicate.arguments)):
            iargs = list()
            for object in object_list:
                if object.type_name == predicate.arguments[i].type_name:
                    iargs.append(object.name)
            args.append(iargs)

        for tup in itertools.product(*args):
            all_literals.add(pddl.Atom(predicate.name, tup))



    init = next(iterator)
    assert init[0] == ":init"
    initial = parse_state(init[1:], all_literals)

    actions = list()
    states = list()

    for token in iterator:
        if token[0] == ':observations':
            aux_state = parse_state(token[1:], all_literals)
            # new_state = [literal for literal in aux_state if random.random() <= state_observability]
            # if len(new_state) == 0 and finite_steps:
            #     new_state = [aux_state[random.randint(0, len(aux_state))]]
            # states.append(new_state)
            states.append(aux_state)
        elif token[0] == ':goal':
            goal = parse_state(token[1:], all_literals)
            # aux_goal = parse_state(token[1:], all_literals)
            # if positive_goals:
            #     aux_goal = [literal for literal in aux_goal if not literal.negated]
            #
            # goal = [literal for literal in aux_goal if random.random() <= goal_observability]
            # if len(goal) == 0:
            #     goal = [aux_goal[random.randint(0, len(aux_goal))]]

        else:
            if random.random() <= action_observability:
                actions.append(token)
            else:
                actions.append([])

    states = states[1:]


    if positive_goals:
        static_predicates = get_static_predicates(states + [goal], predicates)

    # Apply observability
    for i in range(len(states)):
        state = states[i]
        new_state = [literal for literal in state if random.random() <= state_observability]
        if len(new_state) == 0 and finite_steps:
            new_state = [state[random.randint(0, len(state))]]
        states[i] = new_state


    if positive_goals:
        aux_goal = [literal for literal in goal if not literal.negated and not literal.predicate in static_predicates]
    else:
        aux_goal = [literal for literal in goal]
    goal = [literal for literal in aux_goal if random.random() <= goal_observability]
    if len(goal) == 0:
        goal = [aux_goal[random.randint(0, len(aux_goal))]]


    states = states + [goal]

    return pddl.Trace(object_list, initial, goal, actions, states)


def parse_state(new_state, all_literals):
    state = []
    state_true = set()
    state_false = set()
    state_assignments = dict()
    for fact in new_state:
        if fact[0] == "=":
            try:
                assignment = parse_assignment(fact)
            except ValueError as e:
                raise SystemExit("Error in initial state specification\n" +
                                 "Reason: %s." % e)
            if not isinstance(assignment.expression,
                              pddl.NumericConstant):
                raise SystemExit("Illegal assignment in initial state " +
                                 "specification:\n%s" % assignment)
            if assignment.fluent in state_assignments:
                prev = state_assignments[assignment.fluent]
                if assignment.expression == prev.expression:
                    print("Warning: %s is specified twice" % assignment,
                          "in initial state specification")
                else:
                    raise SystemExit("Error in initial state specification\n" +
                                     "Reason: conflicting assignment for " +
                                     "%s." % assignment.fluent)
            else:
                state_assignments[assignment.fluent] = assignment
                state.append(assignment)
        elif fact[0] == "not":
            atom = pddl.Atom(fact[1][0], fact[1][1:])
            check_atom_consistency(atom, state_false, state_true, False)
            state_false.add(atom)
        else:
            atom = pddl.Atom(fact[0], fact[1:])
            check_atom_consistency(atom, state_true, state_false)
            state_true.add(atom)
    state.extend(state_true)
    for atom in all_literals.difference(state_true):
        state.append(pddl.NegatedAtom(atom.predicate, atom.args))
    return sorted(state)


def check_atom_consistency(atom, same_truth_value, other_truth_value, atom_is_true=True):
    if atom in other_truth_value:
        raise SystemExit("Error in initial state specification\n" +
                         "Reason: %s is true and false." %  atom)
    if atom in same_truth_value:
        if not atom_is_true:
            atom = atom.negate()
        print("Warning: %s is specified twice in initial state specification" % atom)


def check_for_duplicates(elements, errmsg, finalmsg):
    seen = set()
    errors = []
    for element in elements:
        if element in seen:
            errors.append(errmsg % element)
        else:
            seen.add(element)
    if errors:
        raise SystemExit("\n".join(errors) + "\n" + finalmsg)
