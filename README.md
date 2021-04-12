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

To enable webhooks delivery you have to run the background worker as well, along with the server run the following on another terminal:

```
$ bundle exec sidekiq
```

The application works without it but it's features get limited :cry:

### Usage

POST requests to `/tickets` with the following format are valid and create a ticket on the system, which updates the tags and reports the most used to https://webhook.site/526c9190-3486-406b-8ae3-ebec4121adb1

```json
{
  "user_id" : 1234,
  "title" : "My title",
  "tags" : ["tag1", "tag2"]
}
```

## Testing

If you need to extend or make this program better you should always check if nothing gets broken in the process, use the following command to do that:

```
$ bundle exec rspec
```
