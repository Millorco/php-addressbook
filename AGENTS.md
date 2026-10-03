# Agent Instructions

This document provides instructions for agents working on this codebase.

## Offline Regression Testing

To run the full test suite in an environment that mimics the CI setup, you can use the `regression-tests.sh` script. This script automates the test environment setup, including the database.

**Prerequisites:**

*   **PHP:** PHP with the `mysqli` extension must be installed and available in your system's PATH (verified with PHP 8.5; the CI still covers PHP 5.4+).
*   **MySQL:** A MySQL server must be running (verified with MySQL 26.7; the CI still covers MySQL 5.5).
*   **Database User:** A MySQL user named `root` with the password `root` must exist and have privileges to create and drop databases.

**Usage:**

```bash
bash .github-offline/regression-tests.sh
```

The script will handle the following:

1.  Drop and recreate the `addressbook` test database.
2.  Import the database schema.
3.  Configure the application to use the test database.
4.  Start a temporary PHP built-in web server.
5.  Run the SimpleTest suite.
6.  Stop the web server.
