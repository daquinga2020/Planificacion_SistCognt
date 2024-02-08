(define (problem spaceTravel_Problem)
(:domain spaceTravel)
(:objects
  r2d2 c3p0 - robot
  milleniumFalcon Xwing - spaceship
  Naboo Alderaan Kessel Tatooine - planet
)

; Initially everything is on the floor and robot is by the table
(:init
  (robotAt r2d2 Naboo)
  (robotAt c3p0 Tatooine)
  (spaceshipAt milleniumFalcon Alderaan)
  (spaceshipAt Xwing Kessel)
)

; The goal is to clean the floor!
(:goal (and
    (robotAt r2d2 Tatooine)
    (robotAt c3p0 Naboo)
  )
)
)
