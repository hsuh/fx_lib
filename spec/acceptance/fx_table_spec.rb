require 'spec_helper'
require 'date'
require './lib/fx_lib.rb'

#test for generating a fx table
describe 'Generating a fx table' do
  #url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"
  url = './spec/internal/eurofx90d.xml'

  it 'should fetch all data given correct url' do
    FxLib::ExchangeRate.fetch_data(url)
    expect(FxRate.where(currency: 'USD', rate: '1.3727')).not_to be_empty
  end

  it 'should fetch data for a given date' do
    date = DateTime.new(2013,12,13)
    FxLib::ExchangeRate.fetch_data_on(url, date)
    expect(FxRate.where(currency: 'USD', rate: '1.3727')).not_to be_empty
  end
end
