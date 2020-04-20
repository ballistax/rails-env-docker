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

`**Example**: rails-app`

#### Step 3 - Copy .env.example to .env

Change directory into the project and copy .env file:

`$ cp .env.example .env`

Note: Must change APP_NAME same your project's folder name!

#### Step 4 - Config nnvironment  

Edit .env file before next step

#### Step 5 - Run docker-compose as follows:

`$ docker-compose up rails`

Note: This will NOT actually run `yarn install` and/or `rake db:setup`!

#### Step 6 - Run bundle install

`docker-compose run --rm rails bundle install`

#### Step 7 - Run yarn install like so:

`$ docker-compose run --rm rails yarn install --check-files`

#### Step 8 - Run rake db:setup on docker container like so:

`$ docker-compose run --rm rails rake db:setup`

#### Step 9 - Start the entire environment (postgres and redis should already be running)

`$ docker-compose up rails`

#### Step 10 - Start webpacker (for frontend development)

`$ docker-compose up webpacker`

## Commonly used commands during development

### start rails development server

`$ docker-compose up rails`

Control-C will stop the rails container. 

### list all running containers

`$ docker-compose ps`

### exec a shell on the rails container

```
# exec /bin/bash on the rails container
$ docker-compose exec rails /bin/bash

# exec /bin/bash on the postgres container
$ docker-compose exec -u ***{DB_USER in .env}*** postgres /bin/bash
```

### stop all containers

`docker-compose down`

## Dip Integration

[dip](https://github.com/bibendi/dip) is a 'CLI gives the "native" interaction with applications configured with Docker Compose.' 

You can skips steps 5 - 9 by simply running:

`dip provision`