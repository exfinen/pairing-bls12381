# Pairing on the BLS12-381 Curve

This library is a simple and self-contained Haskell implementation of pairing
operations over the BLS12-381 elliptic curve. It contains prime-extension 
finite-field arithmetic configured over a tower (Fq1, Fq2, Fq6 and Fq12), the
group law for both curve groups, and culminates in the Ate pairing.

> **Please note:** This code is for educational purposes and is not suitable
> for production. While a limited testing infrastructure is provided, the code 
> may be incomplete, inefficient, incorrect and/or insecure. Specifically, 
> both the algorithms within the code and (the use of) Haskell's big integers 
> are clearly not constant-time and thus introduce timing side channels.
>
> The code has not undergone a security audit; use at your own risk.

The short and well-commented code resides in `Crypto/Pairing_bls12381.hs`. The
standard Hackage documentation can be found at (to be revised!)
<https://hackage.haskell.org/package/abides-0.0.1/docs/Test-Abides-Control-Alternative.html>


## Quick start

After installing Stack, getting started is extremely simple and fast:

    $ git clone https://github.com/nccgroup/pairing-bls12381.git
    $ cd ./pairing-bls12381
    $ stack test
    
        pairing-bls12381> test (suite: pairing-bls12381-test)
    
        Running Tests
          huTstSmokeTest:  OK (1.99s)
          huTstCurve:      OK (0.76s)
          huTstPairingPts: OK (1.53s)
          huTstPairingMul: OK (2.25s)
          huTstPairingGen: OK (9.59s)
    
        All 5 tests passed (9.59s)

        pairing-bls12381> Test suite pairing-bls12381-test passed


## Straightforward API

`g1Point :: Integer -> Integer -> Maybe (Point Fq1)`    
Given x and y, construct a valid point contained in G1.

`g2Point :: Integer -> Integer -> Integer -> Integer -> Maybe (Point Fq2)`    
Given xi, x, yi and y, construct a valid point contained in G2.

`g1Generator :: Maybe (Point Fq1)`    
The standard generator point for G1.

`g2Generator :: Maybe (Point Fq2)`    
The standard generator point for G2.

`pointMul :: (Field a, Eq a) => Integer -> Point a -> Maybe (Point a)`    
Multiply a positive integer and valid point in either G1 or G2.

`pairing :: Point Fq1 -> Point Fq2 -> Maybe Fq12`    
Pairing calculation for a point in G1 and another point in G2.

`prime :: Integer`    
The field prime constant used in BLS12-381 is exported for reference.

`order :: Integer`    
The curve order constant of BLS12-381 is exported for reference.

`smokeTest :: Bool`    
A quick test of externally inaccessible functionality; returns success.


## Example usage

Let's demonstrate the following equality (note the constants shifting positions):

`pairing((12+34)*56*g1, 78*g2) == pairing(78*g1, 12*56*g2) * pairing(78*g1, 34*56*g2)`

... where g1 and g2 are group generators. Below is a `ghci` interpreter session.

    $ ghci Crypto\/Pairing_bls12381.hs
    
    *Pairing_bls12381> p_12p34m56 = g1Generator >>= pointMul ((12 + 34) * 56)
    *Pairing_bls12381> q_78 = g2Generator >>= pointMul 78
    *Pairing_bls12381> leftSide = pairing \<$\> p_12p34m56 \<*\> q_78 >>= id
    *Pairing_bls12381>
    *Pairing_bls12381> p_78 = g1Generator >>= pointMul 78
    *Pairing_bls12381> q_12m56 = g2Generator >>= pointMul (12 * 56)
    *Pairing_bls12381> q_34m56 = g2Generator >>= pointMul (34 * 56)
    *Pairing_bls12381> pair2 = pairing \<$\> p_78 \<*\> q_12m56 >>= id
    *Pairing_bls12381> pair3 = pairing \<$\> p_78 \<*\> q_34m56 >>= id
    *Pairing_bls12381> rightSide = (*) \<$\> pair2 \<*\> pair3
    *Pairing_bls12381>
    *Pairing_bls12381> (==) \<$\> leftSide \<*\> rightSide
    Just True


## References

* Pairings for beginners, Craig Costello, <http://www.craigcostello.com.au/pairings/PairingsForBeginners.pdf>
* On the Implementation of Pairing-Based Cryptography, Ben Lynn PhD Dissertation, <https://crypto.stanford.edu/pbc/thesis.html>
* BLS12-381: New zk-SNARK Elliptic Curve Construction, Sean Bowe of Zcash, <https://electriccoin.co/blog/new-snark-curve/>
* BLS12-381 For The Rest Of Us, <https://hackmd.io/@benjaminion/bls12-381>
* Pairing-Friendly Curves, draft-irtf-cfrg-pairing-friendly-curves-04, <https://datatracker.ietf.org/doc/draft-irtf-cfrg-pairing-friendly-curves/>

Copyright (c) 2020 Eric Schorn, NCC Group Plc; Provided under the BSD3 License.