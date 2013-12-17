require 'spec_helper'
require './lib/fx_lib.rb'

describe 'FxLib' do
  #url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"
  url = './spec/internal/eurofx90d.xml'

  it 'set up block yields self' do
    FxLib.setup do |config|
      assert_equal FxLib, config
    end
  end

  #Tests for fetching data
  it "should have a method ExchangeRate.fetch_data" do
    lambda do
      FxLib::ExchangeRate.fetch_data(url)
    end.should_not raise_error
  end

  it "should have a method for ExchangeRate.at" do
    lambda do
      FxLib::ExchangeRate.fetch_data(url)
      date = DateTime.new(2013,12,13)
      FxLib::ExchangeRate.at(date, 'GBP', 'USD')
    end.should_not raise_error
  end

  it 'should calculate exchange rate' do
    date = DateTime.new(2013,12,13)
    FxLib::ExchangeRate.fetch_data_on(url, date)
    rate = FxLib::ExchangeRate.at(date, 'GBP', 'USD')
    rate.should eq(1.627)
  end
end
