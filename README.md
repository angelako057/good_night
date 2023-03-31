# Goodnight API

Goodnight API is a ruby on rails application that allows users to create sleeping time schedule and follow other users.


## Set up

1. Run `bundle install` to check setup
2. Run `rake db:setup` and `rake db:migrate` to setup database.


## Testing Endpoint
1. Run `rails s` to start server
2. In another terminal/cmd run the following payload


### Schedule

- Create

```
curl -XPOST -H 'Content-Type: application/json' -d '{ "sleep_schedule": { "user_name": "<NAME_SHOULD_BE_UNIQUE>", "sleep_time": "10:00 PM", "wake_time": "8:00 AM" } }' 'localhost:3000/api/v1/sleep_schedules'
```

This command will create a sleeping time schedule for user_name params. If user is not yet registered, this user will be auto created.


- Update

```
curl -X PUT -H 'Content-Type: application/json' -d '{ "sleep_schedule": { "user_name": "<NAME_SHOULD_BE_UNIQUE>", "sleep_time": "10:00 PM", "wake_time": "9:00 AM" } }' 'localhost:3000/api/v1/sleep_schedules/1'
```

This will update the data based on provided attributes

- Delete

```
curl -X DELETE -H 'Content-Type: application/json' -d '{ "sleep_schedule": {} }' 'localhost:3000/api/v1/sleep_schedules/1'
```

This will delete the specific data


- Index

```
curl -XGET -H 'Content-Type: application/json' -d '{ "sleep_schedule": { "user_id": "<OPTIONAL>" } }' 'localhost:3000/api/v1/sleep_schedules'
```

This command will return all available sleeping time schedules in the table if user_id params not available. If user_id is present, this will return all sleeping time schedule of this user.



### User

- Create

```
curl -XPOST -H 'Content-Type: application/json' -d '{ "user": { "name": "<NAME_SHOULD_BE_UNIQUE>" } }' 'localhost:3000/api/v1/users'
```

This command should create a new user using the name parameters, unless name is already saved to table.


- Index

```
curl -XGET -H 'Content-Type: application/json' -d '{ "user_name": "<NAME_SHOULD_BE_UNIQUE>" }' 'localhost:3000/api/v1/users'
```

This command will list all of the following users of provided user_name params from last week to current day. If the user has no following, records should be empty.


### Follow

- follow

```
curl -XPOST -H 'Content-Type: application/json' -d '{ "follower_id": "2", "followee_id": "1" }' 'localhost:3000/api/v1/follows'
```

- unfollow

```
curl -X DELETE -H 'Content-Type: application/json' -d '{ "follower_id": 2, "followee_id": 1 }' 'localhost:3000/api/v1/follows/1'
```