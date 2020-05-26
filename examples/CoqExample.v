Require Import Arith.

Fixpoint factorial n :=
  match n with
  | 0 => 1
  | S m => n * factorial m
  end.

Compute factorial 5.
