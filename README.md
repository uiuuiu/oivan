# OIVAN PROJECT

- Framework: Sinatra (newest version)
- Ruby version: 2.7.2

## Setup

### Development

  1.  run `bundle install`
  2.  run `rake storage:create`
  3.  run `rackup`

### Production
  1.  run `bundle install`
  2.  run `RACK_ENV=production rake storage:create`
  3.  run `RACK_ENV=production rake assets:compile`
  4.  run `RACK_ENV=production rackup`

### Test
  1.  run `bundle install`
  2.  run `RACK_ENV=test rake storage:create`
  3.  run `rspec [file_path]`
### Testing
