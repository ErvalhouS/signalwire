# README

This is an API to create tickets with tags on it.

## Requirements

 - Ruby 2.7.1
 - PostgreSQL
 - Redis

## Installation

You can deploy this project on your own machine by cloning this repositor and running some installation commands:

```
$ bundle install && bundle exec rake db:reset
```

This will install libraries and setup database.


## Running

To run this API run the following command:

```
$ bundle exec rails server
```

It will spin up the server on the port 3000 and you can start testing it through your localhost by sending a post request to http://localhost:3000/tickets

## Testing

If you need to extend or make this program better you should always check if nothing gets broken in the process, use the following command to do that:

```
$ bundle exec rspec
```
