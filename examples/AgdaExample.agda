module AgdaExample where

open import Data.Nat
open import Relation.Binary.PropositionalEquality using (_≡_; refl)

factorial : ℕ → ℕ
factorial zero = 1
factorial (suc n) = suc n * factorial n

5!≡120 : factorial 5 ≡ 120
5!≡120 = refl
