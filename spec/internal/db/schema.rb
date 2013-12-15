ActiveRecord::Schema.define do
  #
  create_table :fx_rates, :force => true do |t|
    t.string :currency
    t.float  :rate
    t.string :downloaded_at
    t.timestamps
  end
end
