class CreateFxRateTable < ActiveRecord::Migration
  def self.up
    create_table :fx_rates, :force => true do |t|
      t.string :currency
      t.float  :rate
      t.string :downloaded_at
      t.timestamps
    end
  end

  def self.down
    drop_tabel :fx_rates
  end
end
