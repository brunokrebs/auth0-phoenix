# API to power a software built with Phoenix and Auth0

A software to handle authentication with Auth0.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them:

- [Docker](https://docs.docker.com/)

### Installing

#### 1. Clone the repository

```
git clone git@github.com:ghoshnirmalya/auth0-phoenix.git && cd auth0-phoenix
```

#### 2. Build the project

```
docker-compose build
```

#### 3. Create the database

```
docker-compose run auth0.phoenix.web mix ecto.create
```

#### 4. Run the migrations

```
docker-compose run auth0.phoenix.web mix ecto.migrate
```

## Running the tests

You can run all the specs using the following command:

```
docker exec -it auth0-phoenix_auth0.phoenix.web_1 mix test
```

If you need to create the test database, you can do so using the following command:

```
docker exec -it auth0-phoenix_auth0.phoenix.web_1 env MIX_ENV=test mix ecto.create
```

You can migrate your test database using the following command:

```
docker exec -it auth0-phoenix_auth0.phoenix.web_1 env MIX_ENV=test mix ecto.migrate
```

## Built With

- [Phoenix Framework](https://phoenixframework.org/) - The web framework used to build the app
- [Docker](https://www.docker.com/) - Used to containerize the app
- [Postgresql](https://www.postgresql.org/) - The database used to store the data

## Contributing

If you find any bugs, please feel free to create an issue for that.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
