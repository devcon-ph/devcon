![image](http://devcon.ph/assets/logo.png)

  * master: [![Build Status](https://travis-ci.org/devcon-ph/devcon.png?branch=master)](https://travis-ci.org/devcon-ph/devcon)
  * release: [![Build Status](https://travis-ci.org/devcon-ph/devcon.png?branch=release)](https://travis-ci.org/devcon-ph/devcon)
  * [![Code Climate](https://codeclimate.com/github/devcon-ph/devcon.png)](https://codeclimate.com/github/devcon-ph/devcon)
  * [![Dependency Status](https://gemnasium.com/devcon-ph/devcon.png)](https://gemnasium.com/devcon-ph/devcon)

# DevCon

This is a work-in-progress revamp for the website of [Developers Connnect Philippines](http://devcon.ph)

## Developer Notes

This is a Ruby 2.0 + Rails 3.2 + PostgreSQL app so running a local copy should look something like:

    git clone git://github.com/devcon-ph/devcon.git
    cd devcon
    bundle
    cp config/database.yml.example config/database.yml
    vim config/database.yml
    rake db:create
    rake db:test:prepare && rake db:migrate
    guard

Guard will run both the Unicorn server at port 3000 and the specs.

This app uses [better\_errors](https://github.com/charliesome/better_errors) for debugging. Don't forget to set the `TRUSTED_IP` environment variable if you're not testing on your local machine.

This app also uses [rails\_panel](https://github.com/dejan/rails_panel) so you don't need to look at the development log while developing.

## Creating a user

To create an admin user, open the console (`rails c`) and enter the following:

    User.create email: "test@example.com", password: "password", password_confirmation: "password", roles: ["admin", "moderator", "author"]

## Plans

All future enhancements are logged at https://github.com/devcon-ph/devcon/issues. Anyone may fork this project and provide pull requests related to those enhancements.

## Deployment

This app has two main branches, the `master` branch for staging i.e. http://beta.devcon.ph, and the `release` branch for production i.e. http://devcon.ph. All enhancements must be performed on the `master` branch and tested prior to merging to the `release` branch.

As of this writing, only [Bry](https://github.com/bryanbibat/) and [Terence](https://github.com/terenceponce) have access rights to deploy to the server.
