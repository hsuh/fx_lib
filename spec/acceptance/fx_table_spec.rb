require 'spec_helper'
require './lib/fx_lib.rb'

#test for generating a fx table
describe 'Generating a fx table' do
  url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"

  it 'should fetch the data given correct url and date' do
    FxLib::ExchangeRate.fetch_data(url, 1)
    expect(FxRate.where(currency: 'USD', rate: '1.3727')).not_to be_empty
  end
end
