require 'spec_helper'
require './lib/fx_lib.rb'

#test for generating a fx table
describe 'Generating a fx table' do
  url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"
  let(:exchange_rate) { ExchangeRate.create }

  it 'should fetch the data given correct url and date' do
    FxLib::ForeignExchange.fetch_data(url, 1)
    puts ExchangeRate.first.inspect
    puts ExchangeRate.last.inspect
    expect(ExchangeRate.where(currency: 'USD', fx_rate: '1.3727')).not_to be_empty
  end
end
