import Pairing_bls12381
import Common

fq12_add () = do
  let (a6, b6, c6, d6) = getFq6Values ()
  let a12 = Fq12 a6 b6
  let b12 = Fq12 c6 d6
  let x = a12 + b12
  putStr "Fq12 Add: "
  print x

fq12_sub () = do
  let (a6, b6, c6, d6) = getFq6Values ()
  let a12 = Fq12 a6 b6
  let b12 = Fq12 c6 d6
  let x = a12 - b12
  putStr "Fq12 Sub: "
  print x

fq12_mul () = do
  let (a6, b6, c6, d6) = getFq6Values ()
  let a12 = Fq12 a6 b6
  let b12 = Fq12 c6 d6
  let x = a12 * b12
  putStr "Fq12 Mul: "
  print x

-- inv (Fq12 a1 a0) =
--   Fq12 (-a1 * factor) (a0 * factor)
--   where
--     factor = inv (a0 * a0 - mul_nonres (a1 * a1))
fq12_inv () = do
  let (a6, b6, c6, d6) = getFq6Values ()
  let a12 = Fq12 a6 b6
  let b12 = Fq12 c6 d6

  let a1 = w1 a12
  let a0 = w0 a12
  let factor = inv (a0 * a0 - mul_nonres (a1 * a1))
  let neg_a1_factor = -a1 * factor
  print neg_a1_factor
  -- let x = inv a12
  -- putStr "Fq12 Inv1: "
  -- print x
  -- let x = inv b12
  -- putStr "Fq12 Inv2: "
  -- print x

main = do
  -- fq12_add ()
  -- fq12_sub ()
  -- fq12_mul ()
  fq12_inv ()