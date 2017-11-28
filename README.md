# strips-learning

### Set the project path in src/config.py

PROJECT_PATH = "~/PycharmProjects/strips-learning"

### Example of runs

./compiler.py ../benchmarks/icaps18/blocks/ empty_domain test plan 0

./compiler.py ../benchmarks/icaps18/blocks/ partial_domain test plan 0

 The learned action model is output to: learned_domain.pddl

### Evaluate the model

./evaluator2.py ../benchmarks/icaps18/blocks/full_domain.pddl learned_domain.pddl ../benchmarks/icaps18/blocks/test-1.pddl

./evaluator2.py -p ../benchmarks/icaps18/blocks/partial_domain.pddl ../benchmarks/icaps18/blocks/full_domain.pddl learned_domain.pddl ../benchmarks/icaps18/blocks/test-1.pddl



#### *The results shown in the icaps18 submission were obtained using the scripts in experiments/icaps18/scripts/
