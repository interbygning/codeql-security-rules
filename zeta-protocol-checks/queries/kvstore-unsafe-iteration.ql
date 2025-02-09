/**
 * @name Unsafe Iteration in KVStore
 * @description Detects the use of `KVStore.Iterator` or `KVStore.ReverseIterator` without validating the start and end key prefixes.
 * Related to Cosmos SDK Pull Request: https://github.com/cosmos/cosmos-sdk/pull/23634
 * @kind problem
 * @precision medium
 * @problem.severity warning
 * @id zetachain/kvstore-unsafe-iteration
 * @tags zetachain, security, kvstore, correctness
 * @references https://github.com/cosmos/cosmos-sdk/pull/23634
 */

 import go

 predicate isKVStoreIteratorFunction(CallExpr call) {
   call.getTarget().hasQualifiedName("KVStore", ["Iterator", "ReverseIterator"])
 }
 
 predicate isUnboundedIteration(CallExpr call) {
   // Detect if start and end keys are empty or identical
   exists (Expr startKey, Expr endKey |
     startKey = call.getArgument(0) and endKey = call.getArgument(1) and
     (
       startKey.toString() = "\"\"" or
       endKey.toString() = "\"\"" or
       startKey.toString() = endKey.toString()
     )
   )
 }
 
 from CallExpr kvOp
 where
   isKVStoreIteratorFunction(kvOp) and
   isUnboundedIteration(kvOp)
 select kvOp, "Unsafe iteration detected in KVStore. Ensure that start and end keys are properly validated to avoid unintended access."
 