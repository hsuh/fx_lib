ActiveRecord::Schema.define do
  #
  create_table :exchange_rates, :force => true do |t|
    t.string :currency
    t.float  :fx_rate
    t.string :downloaded_at
    t.timestamps
  end
end
