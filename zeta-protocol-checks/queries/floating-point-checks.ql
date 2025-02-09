/**
 * @name Zetachain: Floating Point Arithmetic Detection
 * @description Floating point operations are not associative and may lead to non-deterministic behavior, which can compromise Zetachain's consensus reliability.
 * This query is based on the original work by [jaspersurmont](https://github.com/crytic/building-secure-contracts/tree/master/not-so-smart-contracts/cosmos/non_determinism) and has been adapted for Zetachain to provide enhanced detection.
 * @kind problem
 * @problem.severity warning
 * @precision low
 * @id zetachain/floating-point-checks
 * @tags zetachain, security, consensus, non-determinism
 * @references https://github.com/crytic/building-secure-contracts/tree/master/not-so-smart-contracts/cosmos/non_determinism
 */

 import go
 import abci
 
 from ConsensusCriticalFuncDecl f, ArithmeticBinaryExpr e
 where
   (
     e.getLeftOperand().getType() instanceof FloatType or
     e.getRightOperand().getType() instanceof FloatType
   ) and
   f = e.getEnclosingFunction()
 select e,
   "Floating point arithmetic operations are not associative and may lead to non-deterministic behavior, posing a risk to Zetachain consensus."
 