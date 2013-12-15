require "fx_lib/version"

module FxLib
  class ExchangeRate
    def self.at(date,base_curr,counter_curr)
    end

    def self.fetch_data(url, no_of_days)
      begin
         if (no_of_days < 1 || no_of_days > 90)
           raise 'Days should be within 1 and 90'
         end
      rescue Exception => e
        return e.to_s
      end
      #check if db exists if not notify user
      #check url validity
      #check timeout
      #parse data
      #create a new table if it doesn't exist
      #add new rows to table
    end
  end
end
