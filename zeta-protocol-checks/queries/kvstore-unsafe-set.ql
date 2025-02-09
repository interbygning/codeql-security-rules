/**
 * @name Unsafe KVStore Set Operation
 * @description Detects the use of `KVStore.Set` without validating the key or value length. This can lead to data corruption or denial-of-service attacks.
 * Related to Cosmos SDK Pull Request: https://github.com/cosmos/cosmos-sdk/pull/23495
 * @kind problem
 * @precision medium
 * @problem.severity warning
 * @id zetachain/kvstore-unsafe-set
 * @tags zetachain, security, kvstore, correctness
 * @references https://github.com/cosmos/cosmos-sdk/pull/23495
 */

 import go

 predicate isKVStoreSetFunction(CallExpr call) {
   call.getTarget().hasQualifiedName("KVStore", "Set")
 }
 
 predicate isMissingLengthCheck(Expr key, Expr value) {
   // Detect cases where key or value length is not validated before calling `Set`
   not exists (CallExpr lengthCheck |
     lengthCheck.getTarget().getName() = "len" and
     (
       lengthCheck.getArgument(0) = key or
       lengthCheck.getArgument(0) = value
     )
   )
 }
 
 from CallExpr kvOp, Expr key, Expr value
 where
   isKVStoreSetFunction(kvOp) and
   key = kvOp.getArgument(0) and
   value = kvOp.getArgument(1) and
   isMissingLengthCheck(key, value)
 select kvOp, "Unsafe use of KVStore.Set detected. Ensure key and value length are validated before calling this method to prevent potential vulnerabilities."
 