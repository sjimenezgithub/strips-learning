1) Set the path of the Madagascar planner in compiler.py
PLANNER_PATH = "/home/sjimenez/data/software/madagascar/"

2) Example of runs
./compiler.py ../benchmarks/handpicked/blocks/ test plan 0
./compiler.py ../benchmarks/handpicked/visitall/ test plan 0
./compiler.py ../benchmarks/handpicked/gripper/ test plan 0
./compiler.py ../benchmarks/handpicked/miconic/ test plan 0
./compiler.py ../benchmarks/handpicked/floortile/ test plan 0
./compiler.py ../benchmarks/handpicked/zenotravel/ test plan 0
./compiler.py ../benchmarks/handpicked/transport/ test plan 0
./compiler.py ../benchmarks/handpicked/pegsol/ test plan 0

3) The learned action model is output to: learned_domain.pddl

4) Evaluate the model

./evaluator.py ../benchmarks/reference/blocks/domain.pddl learned_domain.pddl ../benchmarks/handpicked/blocks/test-1.pddl
./evaluator.py ../benchmarks/reference/visitall/domain.pddl learned_domain.pddl ../benchmarks/handpicked/visitall/test-1.pddl
./evaluator.py ../benchmarks/reference/gripper/domain.pddl learned_domain.pddl ../benchmarks/handpicked/gripper/test-1.pddl
./evaluator.py ../benchmarks/reference/miconic/domain.pddl learned_domain.pddl ../benchmarks/handpicked/miconic/test-1.pddl
./evaluator.py ../benchmarks/reference/floortile/domain.pddl learned_domain.pddl ../benchmarks/handpicked/floortile/test-1.pddl
./evaluator.py ../benchmarks/reference/zenotravel/domain.pddl learned_domain.pddl ../benchmarks/handpicked/zenotravel/test-1.pddl
./evaluator.py ../benchmarks/reference/transport/domain.pddl learned_domain.pddl ../benchmarks/handpicked/transport/test-1.pddl
./evaluator.py ../benchmarks/reference/pegsol/domain.pddl learned_domain.pddl ../benchmarks/handpicked/pegsol/test-1.pddl
