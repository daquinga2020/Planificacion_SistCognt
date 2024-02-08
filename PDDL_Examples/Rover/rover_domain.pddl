(define (domain rover)
    (:requirements :typing :fluents)
    (:types robot waypoint - object)

    (:functions
        (battery_capacity ?r - robot)
    )

    (:predicates
        (robot_at ?r - robot ?wp - waypoint)
        (connected ?c1 ?c2 - waypoint)
        (visit ?wp - waypoint)
        (charger_at ?wr - waypoint)
    )

    (:action move
        :parameters (?r - robot ?from ?to - waypoint)
        :precondition (and
            (> (battery_capacity ?r) 1)
            (connected ?from ?to)
            (robot_at ?r ?from)
        )
        :effect (and
            (decrease (battery_capacity ?r) 1)
            (not (robot_at ?r ?from))
            (robot_at ?r ?to)
            (visit ?from)
            (visit ?to)
        )
    )

    (:action recharge
        :parameters (?r - robot ?wr - waypoint)
        :precondition (and
            (robot_at ?r ?wr)
            (charger_at ?wr)
            (< (battery_capacity ?r) 2)
        )
        :effect (and 
            (assign (battery_capacity ?r) 6)
        )
    )
    
)