
# Zetachain CodeQL Security Checks

This repository contains **CodeQL security checks** for Zetachain's smart contracts and protocol code. These queries help identify potential security issues, non-deterministic constructs, and platform-dependent vulnerabilities in Zetachain's consensus-critical code.

---

## Repository Structure

The repository is organized as follows:

```
├── zeta-protocol-checks
│   └── queries        # CodeQL queries for Zetachain protocol security checks
└── zeta-sc-checks  
    └── queries    # CodeQL queries for Zetachain smart contract checks
```

Each subdirectory focuses on a specific aspect of Zetachain’s security:

1. **`zeta-protocol-checks`:**  
   Contains CodeQL queries for Zetachain protocol-level security checks, focusing on consensus-critical code, non-deterministic constructs, and platform-dependent types.

2. **`zeta-sc-checks`:**  
   Focuses on CodeQL queries for Zetachain smart contract security, addressing common vulnerabilities like reentrancy, integer overflow, access control issues, and unsafe external calls.

---

## How to Run the Queries

1. **Setup CodeQL CLI:**  
   Install the [CodeQL CLI](https://codeql.github.com/docs/codeql-cli/) and ensure it’s available in your `$PATH`.

2. **Clone the Repository:**  
   ```sh
   git clone https://github.com/zetachain/codeql-security-rules.git
   cd codeql-security-rules
   ```

3. **Analyze the Codebase:**  
   Run the queries on your Go or Solidity codebase using CodeQL:

   ```sh
   codeql query run --database=/path/to/your-database zeta-protocol-checks/queries/*.ql
   codeql query run --database=/path/to/your-database zeta-sc-checks/queries/*.ql
   ```

4. **Compile and Verify the Queries:**  
   To compile the queries and check for errors:
   ```sh
   codeql query compile zeta-protocol-checks/queries/*.ql
   ```

---

## Example Queries

### 1. **Map Iteration Check (`zeta-protocol-checks`)**
Detects non-deterministic iterations over Go maps in consensus-critical code.

**Reference:** [Go Map Iteration Order](https://go.dev/blog/maps#iteration-order)

### 2. **Platform-Dependent Type Check (`zeta-protocol-checks`)**
Identifies usage of platform-dependent types (`int`, `uint`, `uintptr`) that may cause non-determinism.

**Reference:** [Go Spec - Numeric Types](https://go.dev/ref/spec#Numeric_types)


---

## Contributing

We welcome contributions! To add a new query or improve existing ones:

1. Create a new branch.
2. Add your query in the appropriate directory (`zeta-protocol-checks` or `zeta-sc-checks`).
3. Submit a pull request for review.

---

## License

This repository is licensed under the **MIT License**. See the `LICENSE` file for details.

---

## References

- [Go CodeQL Documentation](https://codeql.github.com/docs/codeql-language-reference/go/)
- [Solidity Security Best Practices](https://consensys.net/diligence/blog/2020/09/guide-to-solidity-security-best-practices/)
- [Zetachain](https://zetachain.com)
