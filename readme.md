# Docker rails development environment

## Development Environment Setup

According to the Evil Martians presentation and blog article, this setup will work on macbooks with
only 4 GB of RAM. This setup has been optimized to run on laptops by using caching of
bundle (installed gems), and other things.
  
#### Step 1 - Clone this repository

Run the following command:

`$ git clone https://github.com/ballistax/rails-env-docker.git`

#### Step 2 - Create project or clone folder to root path

Make your rails project to root path:

**Example**: make project `rails-app`
```
📦root-path
 ┣ 📂.dockerdev
 ┃ ┣ 📂postgres
 ┃ ┃ ┣ 📂scripts
 ┃ ┃ ┃ ┗ 📜create_postgres_databases.sh
 ┃ ┃ ┗ 📜dot.psqlrc
 ┃ ┣ 📜Aptfile
 ┃ ┗ 📜dot.bashrc
 ┣ 📂rails-app
 ┃ ┣ 📂app
 ┃ ┣ 📂bin
 ┃ ┣ 📂config
 ┃ ┣ 📂db
 ┃ ┣ 📂...
 ┣ 📜.env.example
 ┣ 📜.gitignore
 ┣ 📜dip.yml
 ┣ 📜docker-compose.yml
 ┣ 📜Dockerfile.rails
 ┗ 📜readme.md
```

#### Step 3 - Copy .env.example to .env

copy .env file following command:

`$ cp .env.example .env`

#### Step 4 - Config environment  

Edit .env file before next step

Note: Must change **APP_NAME** same your project's folder name!

#### Step 5 - Run docker-compose as follows:

`$ docker-compose up -d runner`

Note: This will NOT actually run `yarn install` and/or `rake db:setup`!

#### Step 6 - Run bundle install

`$ docker-compose run --rm runner bundle install`

or

```
# exec /bin/bash on the runner container
# if you exec to runner container already skip this
$ docker-compose exec runner /bin/bash

$ bundle install
```

#### Step 7 - Run yarn install like so:

`$ docker-compose run --rm runner yarn install`

or

```
# exec /bin/bash on the runner container
# if you exec to runner container already skip this
$ docker-compose exec runner /bin/bash

$ yarn install
```

#### Step 8 - Run rake db:setup on docker container like so:

before run command please update **config/database.yml** follow example.

**Example**:
```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  url: <%= ENV['DATABASE_URL'] %>
```

or

```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: postgres
  username: your_pg_username
  password: your_pg_password
```

then run command:

`$ docker-compose run --rm runner rake db:setup`

or

```
# exec /bin/bash on the runner container
# if you exec to runner container already skip this
$ docker-compose exec runner /bin/bash

$ rake db:setup
```

#### Step 9 - Start the entire environment

```
# exec /bin/bash on the runner container
# if you exec to runner container already skip this
$ docker-compose exec runner /bin/bash

$ bundle exec rails s -b 0.0.0.0
```

or another way

`$ docker-compose up rails`

Note: You must stop runner container before run this by

`$ docker-compose stop runner`

#### Step 10 - Start webpacker (for frontend development)

`$ docker-compose up webpacker`

## Commonly used commands during development

### start rails development server

```
$ docker-compose up -d runner

$ docker-compose exec runner /bin/bash

$ bundle exec rails s -b 0.0.0.0
```

or

`$ docker-compose up rails`

Control-C will stop the rails container. 

### list all running containers

`$ docker-compose ps`

### exec a shell on the rails container

```
# exec /bin/bash on the runner container
$ docker-compose exec runner /bin/bash

# exec /bin/bash on the postgres container
$ docker-compose exec -u {DB_USER} postgres /bin/bash
```

### stop all containers

`$ docker-compose down`

## Dip Integration

[dip](https://github.com/bibendi/dip) is a 'CLI gives the "native" interaction with applications configured with Docker Compose.' 

`$ dip provision`