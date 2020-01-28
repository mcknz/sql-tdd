# SQL TDD - starting scripts

This directory contains the SQL scripts necessary to duplicate the test-driven development examples shown in the presentation *Hey, You Got Your TDD In My SQL DB*. Your goal is to create, using TDD, a stored procedure called MergeCustomer, that takes two duplicate customers, each with an order history, and merges them into a single customer record that contains all orders.

The [completed scripts and tests](../completed-scripts/readme.md) are also available for review.

## Working with the samples
Once the environment setup is complete and the container is running, you can use a SQL Server client to connect to the SQL Server instance running on localhost.

### Installing the samples
In order to write your own tests, you must install some required code as outlined in the steps below. 

1. From your SQL client, open this SQL script:<br><br>`starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Install-start.sql`<br><br>This script contains:
    1. the stored procedure `FAS_Tests.InsertTestData`, which inserts test data -- the duplicate customers and orders that need to be merged.<br>
    2. the stored procedure `FAS_Tests.Setup`, which tSQLt automatically executes before each unit test is run.<br>
    3. the first tSQLt unit test `FAS_Tests.[test GivenMergeCustomers-ThenCustomerIsCorrect]`.<br>
    4. the second tSQLt unit test, `FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]`.<br>

2. Execute the `FAS_Tests_Install-start.sql` script to install the necessary stored procedures in the `FAS_Tests` schema of the `Food_And_Stuff` database.

### Writing your own tests
Installing the samples creates skeleton tests, which are failing by default. They can be further developed to pass by following the steps below.
  
3. In the `starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Install-start.sql` script you opened in step 1, find the first unit test called `FAS_Tests.[test GivenMergeCustomers-ThenCustomerIsCorrect]`<br><br>Write a tSQLt test that verifies the correct customer information exists in the Customer table, after the MergeCustomer procedure is executed. 

4. From your SQL client, open this SQL script:<br><br>`starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Run-start.sql`<br><br>This script contains SQL statements that execute the tSQLt tests.
  
5. Execute the following SQL statement, which is in the script you opened in step 4.<br><br>`EXEC tSQLt.Run N'FAS_Tests.[test GivenMergeCustomers-ThenCustomerIsCorrect]'`<br><br>This is a tSQLt command that will execute the first test. Because you haven't created the MergeCustomer stored procedure yet, your test should fail.
  
6. From your SQL client, open this SQL script:<br><br>`starting-scripts/Food_And_Stuff/Procedures/FAS-Proc-MergeCustomer-start.sql`<br><br>This script contains the skeleton of the MergeCustomer stored procedure.<br><br>Write the least amount of SQL required to make the first test pass, then execute the script to create the procedure in the database.
  
7. Repeat steps 5 and 6 until the first test passes.

8. In the `starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Install-start.sql` script you opened in step 1, find the second unit test called `FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]`<br><br>Write a tSQLt test that verifies the correct order information exists in the Order table, after the MergeCustomer procedure is executed. 

9. Execute this SQL statement, which is in the script you opened in step 1:<br><br>`EXEC tSQLt.Run N'FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]'`<br><br>This is a tSQLt command that executes the second test. Because you haven't written any SQL for the Order table yet, your test should fail.<br><br>This test verifies that the correct order information exists in the Order table, after the MergeCustomer procedure is executed.

10. Continue to edit the MergeCustomer stored procedure:<br><br>`starting-scripts/Food_And_Stuff/Procedures/FAS-Proc-MergeCustomer-start.sql`<br><br>Write the least amount of SQL required to make the second test pass, then execute the script to create the procedure in the database.
  
11. Repeat steps 9 and 10 until the second test passes.

### Confirming your unit tests using an integration test
Once both unit tests are passing, open this SQL script:<br><br>`starting-scripts/Food_And_Stuff/Tests/RunCustomerMerge-start.sql`<br><br>This script is an integration test that runs the MergeCustomer stored procedure against the actual tables, and displays the results.

### If the integration test fails
If you get an error when running the integration test, open the this SQL script, which should contain your unit tests:<br><br>`starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Install-start.sql`<br><br>Insert the following SQL in the `FAS_Tests.Setup` stored procedure, immediately before the `FAS_Tests.InsertTestData` procedure is executed:<br><br>`EXEC tSQLt.ApplyConstraint N'dbo.Order', N'FK_Order_Customer_CustomerId'`<br><br>Run the `FAS_Tests_Install-start.sql` to write the change to the database.

### Fix your unit tests
Run the tests that are in the `starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Run-start.sql` file. The error that appeared in your integration test should now appear in your unit tests.<br><br>Now write the least amount of code that will cause both unit tests to pass. Then verify that your integration test works as well.
