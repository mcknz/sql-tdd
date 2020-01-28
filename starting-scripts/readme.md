# SQL TDD - starting scripts

This directory contains the SQL scripts necessary to duplicate the test-driven development examples shown in the presentation *Hey, You Got Your TDD In My SQL DB*. Your goal is to create, using TDD, a stored procedure called MergeCustomer, that takes two duplicate customers, each with an order history, and merges them into a single customer record that contains all orders.

The [completed scripts and tests](../completed-scripts/readme.md) are also available for review.

## Setting up the environment
Steps to set up the Docker environment (requires Docker for Windows/Mac/Linux):

1. From a bash/shell prompt in the `sql-examples` directory, execute the following command to create the food-and-stuff Docker image that contains SQL Server and the required SQL scripts:

  ```sh
  docker build -t food-and-stuff:latest . 
  ```
 You can also execute the included `build.sh` script, which contains this command. This will download the latest version of the Docker image for SQL Server for Linux if not already present in the local repository.

2. Edit the included `docker-compose.yml` file to accept the SQL Server for Linux EULA, as well as set your own sysadmin (sa) password:

  ```sh
  environment: 
      - SA_PASSWORD=[your password here]
      - ACCEPT_EULA=Y
  ```  

  Ensure that your password conforms to [SQL Server password policy](https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy). See [https://hub.docker.com/_/microsoft-mssql-server](https://hub.docker.com/_/microsoft-mssql-server) for more information on running/building SQL Server for Linux on Docker.
 
3. From a bash/shell prompt in the root directory, execute the following command to run the food-and-stuff Docker container, which starts SQL Server, creates the sample database, and installs the tSQLt framework:

  ```sh
  docker-compose up
  ```
  
 Wait at least 30 seconds for the `**** SETUP COMPLETE ****` message to display.

## Working with the samples
Once the environment setup is complete and the container is running, you can use a SQL Server client to connect to the SQL Server instance running on localhost.

### Installing the samples
In order to write your own tests, you must install some required code as outlined in the steps below. 

1. From your SQL client, open this SQL script:

  `starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Install-start.sql`
  
  This script contains:
  1. the stored procedure `FAS_Tests.InsertTestData`, which inserts test data -- the duplicate customers and orders that need to be merged.
  2. the stored procedure `FAS_Tests.Setup`, which tSQLt automatically executes before each unit test is run.
  3. the first tSQLt unit test `FAS_Tests.[test GivenMergeCustomers-ThenCustomerIsCorrect]`.
  4. the second tSQLt unit test, `FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]`.

2. Execute the `FAS_Tests_Install-start.sql` script to install the necessary stored procedures in the `FAS_Tests` schema of the `Food_And_Stuff` database.

### Writing your own tests
Installing the samples creates skeleton tests, which are failing by default. They can be further developed to pass by following the steps below.

1. From your SQL client, open this SQL script:

  `starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Run-start.sql`
  
  This script contains SQL statements that execute the tSQLt tests.
  
2. Execute the following SQL statement, which is in the script you opened in step 1:

  `EXEC tSQLt.Run N'FAS_Tests.[test GivenMergeCustomers-ThenCustomerIsCorrect]'`
  
  This is a tSQLt command that will execute the first test. Because you haven't created the MergeCustomer stored procedure yet, your test should fail. This test verifies that the correct customer information exists in the Customer table, after the MergeCustomer procedure is executed.
  
3. From your SQL client, open this SQL script:

  `starting-scripts/Food_And_Stuff/Procedures/FAS-Proc-MergeCustomer-start.sql`
  
  This script contains the skeleton of the MergeCustomer stored procedure.

  Write the least amount of SQL required to make the first test pass, then execute the script to create the procedure in the database.
  
4. Repeat steps 2 and 3 until the first test passes.

5. Execute this SQL statement, which is in the script you opened in step 1:

  `EXEC tSQLt.Run N'FAS_Tests.[test GivenMergeCustomers-ThenOrderIsCorrect]'`
  
  This is a tSQLt command that executes the second test. Because you haven't written any SQL for the Order table yet, your test should fail. This test verifies that the correct order information exists in the Order table, after the MergeCustomer procedure is executed.

6. Continue to edit the MergeCustomer stored procedure:

  `starting-scripts/Food_And_Stuff/Procedures/FAS-Proc-MergeCustomer-start.sql`
  
  Write the least amount of SQL required to make the second test pass, then execute the script to create the procedure in the database.
  
7. Repeat steps 7 and 8 until the second test passes.

### Confirming your unit tests using an integration test
Once both unit tests are passing, open this SQL script:

  `starting-scripts/Food_And_Stuff/Tests/RunCustomerMerge-start.sql`

This script is an integration test that runs the MergeCustomer stored procedure against the actual tables, and displays the results.

### If the integration test fails
If you get an error when running the integration test, open the this SQL script, which should contain your unit tests:

  `starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Install-start.sql`

Insert the following SQL in the `FAS_Tests.Setup` stored procedure, immediately before the `FAS_Tests.InsertTestData` procedure is executed:

  `EXEC tSQLt.ApplyConstraint N'dbo.Order', N'FK_Order_Customer_CustomerId'`

Run the `FAS_Tests_Install-start.sql` to write the change to the database.

### Fix your unit tests
Run the tests that are in the `starting-scripts/Food_And_Stuff/Tests/FAS_Tests_Run-start.sql` file. The error that appeared in your integration test should now appear in your unit tests.

Now write the least amount of code that will cause both unit tests to pass. Then verify that your integration test works as well.