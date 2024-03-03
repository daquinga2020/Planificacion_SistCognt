from unified_planning.shortcuts import *

Block = UserType("Block")

on = Fluent("on", BoolType(), x=Block, y=Block)
clear = Fluent("clear", BoolType(), x=Block)
on_table = Fluent("on_table", BoolType(), x=Block)


move = InstantaneousAction("move", b=Block, fro=Block, to=Block)
b = move.parameter("b")
fro = move.parameter("fro")
to = move.parameter("to")
move.add_precondition(clear(b))
move.add_precondition(clear(to))
move.add_precondition(on(b, fro))
move.add_precondition(Not(Equals(b, fro)))
move.add_precondition(Not(Equals(b, to)))
move.add_precondition(Not(Equals(fro, to)))
move.add_effect(on(b, to), True)
move.add_effect(clear(fro), True)
move.add_effect(on(b, fro), False)
move.add_effect(clear(to), False)

move_to_table = InstantaneousAction("move_to_table", b=Block, fro=Block)
b = move_to_table.parameter("b")
fro = move_to_table.parameter("fro")
move_to_table.add_precondition(on(b, fro))
move_to_table.add_precondition(clear(b))
move_to_table.add_precondition(Not(Equals(b, fro)))
move_to_table.add_effect(on_table(b), True)
move_to_table.add_effect(clear(fro), True)
move_to_table.add_effect(on(b, fro), False)

move_from_table = InstantaneousAction("move_from_table", b=Block, to=Block)
b = move_from_table.parameter("b")
fro = move_from_table.parameter("to")
move_from_table.add_precondition(on_table(b))
move_from_table.add_precondition(clear(b))
move_from_table.add_precondition(clear(to))
move_from_table.add_effect(on_table(b), False)
move_from_table.add_effect(clear(to), False)
move_from_table.add_effect(on(b, to), True)


block1 = Object("block1", Block)
block2 = Object("block2", Block)
block3 = Object("block3", Block)
block4 = Object("block4", Block)

problem = Problem("blocks")
problem.add_fluent(on, default_initial_value=False)
problem.add_fluent(clear, default_initial_value=False)
problem.add_fluent(on_table, default_initial_value=False)
problem.add_action(move)
problem.add_action(move_to_table)
problem.add_action(move_from_table)
problem.add_object(block1)
problem.add_object(block2)
problem.add_object(block3)
problem.add_object(block4)

problem.set_initial_value(on_table(block1), True)
problem.set_initial_value(on(block2, block1), True)
problem.set_initial_value(on(block3, block2), True)
problem.set_initial_value(on(block4, block3), True)
problem.set_initial_value(clear(block4), True)

problem.add_goal(on(block3, block4))
problem.add_goal(on(block2, block3))
problem.add_goal(on(block1, block2))

print(problem)

with OneshotPlanner(problem_kind=problem.kind) as planner:
    result = planner.solve(problem)
    if result.status in unified_planning.engines.results.POSITIVE_OUTCOMES:
        print(f"{planner.name} found this plan: {result.plan}")
    else:
        print("No plan found.")
