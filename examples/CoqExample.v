Require Import Arith.

Fixpoint factorial n :=
  match n with
  | 0 => 1
  | S m => n * factorial m
  end.

Compute factorial 5.

Lemma factorial_5_is_120 : factorial 5 = 120.
Proof.
  reflexivity.
Qed.
