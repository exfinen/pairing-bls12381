import Pairing_bls12381

main :: IO ()

main = do
  let a1 = Fq1 3
  let b1 = Fq1 5
  let c1 = Fq1 7
  let d1 = Fq1 9
  let a1b1 = a1 * b1
  let b1c1 = b1 * c1
  let c1d1 = c1 * d1
  -- let inv_a1b1 = inv a1b1
  -- let inv_b1c1 = inv b1c1
  -- print inv_a1b1
  -- print inv_b1c1

  let a2 = Fq2 a1b1 b1c1
  let b2 = Fq2 b1c1 a1b1
  let c2 = Fq2 b1c1 c1d1
  -- let inv_a2 = inv a2
  -- let inv_b2 = inv b2
  -- print inv_a2
  -- print inv_b2
  let a6 = Fq6 a2 b2 c2
  let b6 = Fq6 b2 c2 a2
  let inv_a6 = inv a6
  print inv_a6