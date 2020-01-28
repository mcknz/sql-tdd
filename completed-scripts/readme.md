# SQL TDD - completed scripts

This directory contains the final version of SQL scripts that duplicate the test-driven development examples shown in the presentation *Hey, You Got Your TDD In My SQL DB*. The result is a stored procedure called MergeCustomer, created via TDD, that takes two duplicate customers, each with an order history, and merges them into a single customer record that contains all orders.

## Procedures

1. [FAS-Proc-MergeCustomer_0.sql](./Food_And_Stuff/Procedures/FAS-Proc-MergeCustomer_0.sql)<br>
    The initial, skeleton state of the MergeCustomer stored procedure.

2. [FAS-Proc-MergeCustomer_1.sql](./Food_And_Stuff/Procedures/FAS-Proc-MergeCustomer_1.sql)<br>
    Implementation of the MergeCustomer stored procedure that causes the first unit test to pass.

3. [FAS-Proc-MergeCustomer_2.sql](./Food_And_Stuff/Procedures/FAS-Proc-MergeCustomer_2.sql)<br>
    Implementation of the MergeCustomer stored procedure that causes the second unit test to pass.

4. [FAS-Proc-MergeCustomer_final.sql](./Food_And_Stuff/Procedures/FAS-Proc-MergeCustomer_final.sql)<br>
    Final implementation of the MergeCustomer stored procedure that causes all unit and integration tests to pass.

## Tests

1. [FAS_Tests_Install_1.sql](./Food_And_Stuff/Tests/FAS_Tests_Install_1.sql)<br>
This script contains:
    1. the stored procedure `FAS_Tests.InsertTestData`, which inserts test data -- the duplicate customers and orders that need to be merged.<br>
    2. the stored procedure `FAS_Tests.Setup`, which tSQLt automatically executes before each unit test is run.<br>
    3. the first tSQLt unit test `FAS_Tests.[test GivenMergeCustomers-ThenCustomerIsCorrect]`.<br>
    4. the second tSQLt unit test, `FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]`.<br>

2. [FAS_Tests_Install_2.sql](./Food_And_Stuff/Tests/FAS_Tests_Install_2.sql)<br>
    Same stored procedures and unit tests as FAS_Tests_Install_1.sql, except the `FAS_Tests.Setup` stored procedure contains an `tSQLt.ApplyConstraint` command that makes the unit test scenario more closely resemble the actual environment, and duplicate the error originally found in the integration test.

3. [FAS_Tests_Run.sql](./Food_And_Stuff/Tests/FAS_Tests_Run.sql)<br>
    The tSQLt commands that run both unit tests.

4. [RunCustomerMerge.sql](./Food_And_Stuff/Tests/RunCustomerMerge.sql)<br>
    The integration test.
