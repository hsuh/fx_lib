require 'spec_helper'
require './lib/fx_lib.rb'

describe 'FxLib' do
  url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"

  it "should have a method for ExchangeRate.at" do
    lambda do
      FxLib::ForeignExchange.at(Date.today, 'GBP', 'USD')
    end.should_not raise_error
  end

  #Tests for fetching data
  it "should have a method ExchangeRate.fetch_data" do
    lambda do
      FxLib::ForeignExchange.fetch_data(url, 1)
    end.should_not raise_error
  end

  #check no_of_days should be > 0 and < 9
  it 'should check the date range' do
    str = FxLib::ForeignExchange.fetch_data(url, 0)
    str.should eq("Days should be within 1 and 90")
  end

  it 'should calculate exchange rate' do
    FxLib::ForeignExchange.fetch_data(url, 1)
    date = DateTime.new(2013,12,13)
    rate = FxLib::ForeignExchange.at(date, 'GBP', 'USD')
    rate.should eq(1.6270)
  end
  #check timeout
  #parse data
  #create a new table if it doesn't exist
  #add new rows to table
end
