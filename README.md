# FxLib

FxLib pull foreign exchange rates from xml feed and store it in a table and provides exchange ratesconversion method

## Installation

Add this line to your application's Gemfile:

    gem 'fx_lib'

And then execute:

    $ rails generate fx_lib:migration
    $ rake db:migrate

To seed the database with current fx rates from xml file please run the following rake task

    $ rake FX_URL="Your url to the xml file" fx_lib:db_seed

Or install it yourself as:

    $ gem install fx_lib

## Usage

Methods:
1. `FxLib::Exchange_Rate.at(Date, Base currency, Counter currency)`
2. `FxLib::fetch_data_on(URL, Date)` - Fetch data for a particular date - cron jobs
3. `FxLib::fetch_data(URL)` - Fetch, parse, store the feed

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
