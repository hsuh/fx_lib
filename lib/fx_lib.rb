require "fx_lib/version"
require "open-uri"
require "timeout"
require "nokogiri"
require "date"
require "time"

module FxLib
  class ForeignExchange
    def self.open_xml_file(url)
      begin
      status = Timeout::timeout(60) {
        file = Nokogiri.XML(open(url))
        file.remove_namespaces!
        return file
      }
      rescue Timeout::Error => e
        puts e.to_s
        return e.to_s
      end
    end

    def self.at(date,base_curr,counter_curr)
      d            = date.strftime("%Y-%m-%d")
      ers_base     = ExchangeRate.find_by_downloaded_at_and_currency(d,base_curr)
      ers_counter  = ExchangeRate.find_by_downloaded_at_and_currency(d,counter_curr)
      base_rate    = ers_base.fx_rate
      counter_rate = ers_counter.fx_rate
      rate         = (counter_rate/base_rate).round(4)
      return rate
    end

    def self.fetch_data(url, no_of_days)
      begin
        if (no_of_days < 1 || no_of_days > 90)
          raise 'Days should be within 1 and 90'
        end
        file = open_xml_file(url)
        no_of_days.times do |d|
          #ToDo Account for weekends
          date    = (Date.today - d - 2).strftime("%Y-%m-%d")
          extract = file.xpath("//Cube[@time='#{date}']/Cube")
          extract.each do |e|
            er = ExchangeRate.create(downloaded_at: date, currency: e.attr('currency'), fx_rate: e.attr('rate'))
            er.save
          end
        end
      rescue Exception => e
        puts e.to_s
        return e.to_s
      end
    end
  end
end
