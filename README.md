# SQL TDD

This repo contains the SQL scripts necessary to duplicate the test-driven development examples shown in the presentation *Hey, You Got Your TDD In My SQL DB*. Your goal is to create, using TDD, a stored procedure called MergeCustomer, that takes two duplicate customers, each with an order history, and merges them into a single customer record that contains all orders.

To get started, set up the SQL environment as detailed below.

Then, to create your own tests and code, see the [starting scripts directory](./starting-scripts/).

The [completed scripts and tests](./completed-scripts/) are also available for review.

## Setting up the environment
Steps to set up the Docker environment (requires Docker for Windows/Mac/Linux):

1. From a bash/shell prompt in this root directory, execute the following command to create the food-and-stuff Docker image that contains SQL Server and the required SQL scripts:

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
