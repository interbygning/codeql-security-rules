/**
 * @name Zetachain: Avoid Direct Use of Bech32 Constants
 * @description Direct usage of Bech32 constants is discouraged in Zetachain. Use `sdk.GetConfig().GetBech32...` and `sdk.GetConfig().SetBech32...` to ensure proper configuration management and avoid potential inconsistencies.
 * This query is based on the original work by [jaspersurmont](https://github.com/cosmos/cosmos-sdk/pull/8461) and has been adapted and improved for Zetachain's specific needs.
 * See related improvements in Cosmos SDK:
 * - https://github.com/cosmos/cosmos-sdk/pull/8461
 * - https://github.com/cosmos/cosmos-sdk/pull/9212
 * @kind problem
 * @precision medium
 * @problem.severity warning
 * @id zetachain/bech32-constant-checks
 * @tags zetachain, security, correctness, configuration
 * @references https://github.com/cosmos/cosmos-sdk/pull/8461, https://github.com/cosmos/cosmos-sdk/pull/9212
 */

 import go
 import abci
 
 from Constant cn, ConsensusCriticalFuncDecl f
 where
   // Check if the Bech32 constant is directly used without passing it through SetBech32Prefix or configuration methods
   cn.getDeclaration().getName().matches("Bech32%") and cn.getARead().getRoot() = f
 select cn, "Direct use of Bech32 constants detected. Use sdk.GetConfig().GetBech32... for safe and consistent configuration in Zetachain."
 