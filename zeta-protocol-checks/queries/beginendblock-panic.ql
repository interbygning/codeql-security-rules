/**
 * @name Zetachain: Panic in BeginBlocker or EndBlocker Consensus Methods
 * @description Panics in BeginBlocker and EndBlocker can lead to a chain halt, potentially affecting Zetachain's reliability and security. This query identifies such panics to help mitigate chain halts.
 * This query is based on the original work by [jaspersurmont](https://github.com/crytic/building-secure-contracts/tree/master/not-so-smart-contracts/cosmos/abci_panic) and has been adapted for Zetachain to provide more precise and context-specific detection.
 * @kind path-problem
 * @precision high
 * @problem.severity warning
 * @id zetachain/beginendblock-panic
 * @tags zetachain, security, consensus, reliability
 * @references https://github.com/crytic/building-secure-contracts/tree/master/not-so-smart-contracts/cosmos/abci_panic
 */

 import go
 import abci
 
 query predicate edges(CallNode a, CallNode b) {
   a.getACallee() = b.getRoot()
 }
 
 from CallNode panic, CallNode src
 where
   panic.getTarget().mustPanic() and
   edges*(src, panic) and
   // Panics are often expected in these specific packages; skip those
   not panic.getFile().getPackageName().matches(["crisis", "upgrade", "%mock%"]) and
   src.getEnclosingCallable().asFunction() = getABeginEndBlockFunc()
 select panic, src, panic, 
   "Potential panic detected in BeginBlocker or EndBlocker consensus methods. This could cause Zetachain to halt unexpectedly. Consider adding proper error handling."
 