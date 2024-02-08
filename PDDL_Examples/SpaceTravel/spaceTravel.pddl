(define (domain spaceTravel) ; Especificación del nombre del dominio
(:requirements :strips :equality :typing) ; Simula a #include o import. "Hereda" de otro dominio "padre" la mayor parte de sus componentes.
;strips permite añadir effects
(:types
  robot spaceship planet - object
)

(:predicates ; En un predicado "not" niega una sentencia logica
  (robotAt ?rob - robot ?plnt - planet)
  (robotIn ?rob - robot ?spcship - spaceship)
  (spaceshipAt ?spcship - spaceship ?plnt - planet)
)

(:action fly ; En una acción "not" asigna el valor false a un predicado válido
  :parameters (?spcship - spaceship ?plnt_from - planet ?plnt_to - planet)
  :precondition (and
    (spaceshipAt ?spcship ?plnt_from) ; No se comprueba la existencia de los parametros ya que si han sido creados es que existe
  )
  :effect (and
    (not (spaceshipAt ?spcship ?plnt_from))
    (spaceshipAt ?spcship ?plnt_to)
  )
  ; :expansion ; en desuso
)

(:action Load
  :parameters (?rob - robot ?spcship - spaceship ?plnt - planet)
  :precondition (and
    (robotAt ?rob ?plnt)
    (spaceshipAt ?spcship ?plnt)
  )
  :effect (and
    (not (robotAt ?rob ?plnt))
    (robotIn ?rob ?spcship)
  )
)

(:action Unload
  :parameters (?rob - robot ?spcship - spaceship ?plnt - planet)
  :precondition (and
    (robotIn ?rob ?spcship)
    (spaceshipAt ?spcship ?plnt)
  )
  :effect (and
    (not (robotIn ?rob ?spcship))
    (robotAt ?rob ?plnt)
  )
)
)
