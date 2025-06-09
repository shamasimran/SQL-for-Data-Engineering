# SQL Architecture Overview

## Components of SQL Engine:
- **Parser**: Validates query syntax.
- **Optimizer**: Determines the most efficient way to execute a query.
- **Executor**: Runs the optimized query plan.
- **Storage Engine**: Reads/writes data from physical storage.
- **Transaction Manager**: Handles ACID transactions.

### Query Execution Flow
1. Query is parsed and validated
2. Optimizer creates best execution plan
3. Execution engine runs the plan
4. Results are returned to client
