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
```
bundle exec rake environment importation:imports_data
```

If you're curious and want to check the code of the task you can see it in `/lib/tasks/import_data.rake`

### What you can do with the form
You can search for an available pro based on the services they offer and the area they cover. However, it's not yet possible to filter by opening hours or check if a professional is available at a specific time. Sorry about that — implementing that would take me quite more time than five hours, especially since I still need to wrap my head around how forms work.
