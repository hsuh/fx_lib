require 'spec_helper'

describe FxLib do
  it "should have a method for ExchangeRate.at" do
    lambda do
      FxLib::ExchangeRate.at(Date.today, 'GBP', 'USD')
    end.should_not raise_error
  end

  #Tests for fetching data
  it "should have a method ExchangeRate.fetch_data" do
    lambda do
      FxLib::ExchangeRate.fetch_data('url', 1)
    end.should_not raise_error
  end

  #check no_of_days should be > 0 and < 9
  it 'should check the date range' do
    str = FxLib::ExchangeRate.fetch_data('url', 0)
    str.should eq("Days should be within 1 and 90")
  end

  #check if db exists if not notify user
  #check url validity
  #check timeout
  #parse data
  #create a new table if it doesn't exist
  #add new rows to table
end
