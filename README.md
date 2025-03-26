# Wecasa Technical test

## How to set up the project

### Prerequisites
The setups steps expect following tools installed on the system.

- Ruby 3.3.0
- Rails 7.1.3
- PostgreSQL 14.10
- Docker

### Start the ecosystem
This project include a `docker-compose.yml` file that contains definitions for PostgreSQL. You can start it easily using:

```docker compose up````

### Setup the environment
This step will install gems, create database, clear existing logs, and restart your Rails server if needed

```
bin/setup
```

### Fills the database with pre existing datas
In order to fill the database you need to run
````
bundle exec rake environment importation:imports_data
```

If you're curious and want to check the code of the task you can see it in `/lib/tasks/import_data.rake`
