/**
 * @name Unsafe Key Access in KVStore
 * @description Detects unsafe key usage in KVStore operations (Get, Set, Has, Delete) without validation.
 * This helps prevent runtime errors and potential security issues.
 * Related to Cosmos SDK Pull Request: https://github.com/cosmos/cosmos-sdk/pull/22714
 * @kind problem
 * @precision high
 * @problem.severity warning
 * @id zetachain/kvstore-unsafe-key-access
 * @tags zetachain, security, kvstore, correctness
 * @references https://github.com/cosmos/cosmos-sdk/pull/22714
 */

import go

predicate isKVStoreFunction(CallExpr call) {
  call.getTarget().hasQualifiedName("KVStore", ["Get", "Set", "Has", "Delete"])
}

predicate isUnsafeKey(Expr key) {
  key instanceof Literal and
  key.toString() = "\"\"" // Detect empty string key
}

from CallExpr kvOp, Expr key
where
  isKVStoreFunction(kvOp) and
  key = kvOp.getArgument(0) and
  isUnsafeKey(key)
select kvOp, "Unsafe key access detected in KVStore operation. Ensure the key is validated for length and format."
