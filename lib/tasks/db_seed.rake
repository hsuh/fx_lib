namespace :fx_lib do
  task db_seed: :environment do
    FxLib::ExchangeRate.fetch_data(ENV['FX_URL'],90)
  end
end
