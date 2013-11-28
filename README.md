# UstidnrValidator

This is simple wraper for the xmlrpc https://evatr.bff-online.de/eVatR/xmlrpc/

## Installation

Add this line to your application's Gemfile:

    gem 'ustidnr_validator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ustidnr_validator

## Config

set your own USt-IdNr

    UstidnrValidator.owner_ustid ='DEXXXXXXXXX'

set your own logger

    UstidnrValidator.external_logger =  Rails.logger

## Usage

from the command line

    bin/ustidnr_validator 'your_ustid', 'ustid_To_check', 'company_name', 'city'

in your application

     company = UstidnrValidator::Company.build :ust_id_nr => "some value", :city => "some value", :name => "some value"
     company.errors.full_messages.join("\n") unless company.valid?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
