require "fx_lib/version"
require "open-uri"
require "timeout"
require "nokogiri"
require "date"
require "time"

module FxLib
  class ExchangeRate
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
      ers_base     = FxRate.find_by_downloaded_at_and_currency(d,base_curr)
      ers_counter  = FxRate.find_by_downloaded_at_and_currency(d,counter_curr)
      base_rate    = ers_base.rate
      counter_rate = ers_counter.rate
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
          date    = (Date.today - d - 3).strftime("%Y-%m-%d")
          extract = file.xpath("//Cube[@time='#{date}']/Cube")
          puts date.inspect
          extract.each do |e|
            er = FxRate.create(downloaded_at: date, currency: e.attr('currency'), rate: e.attr('rate'))
            puts er.inspect
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

require "fx_lib/engine"
