## S.E.M

  S.E.M is short for Staged Event Module.
  This module is responsible for all custom events to be registered and dispatched while ticking.

  Events can be registered in different tick stages, following the order below:
    - PreDateTime
    - PreCharacter
    - PreOperation
    - PreSignal
    - PreConsult
    - PostConsult
