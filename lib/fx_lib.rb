require "fx_lib/version"
require "active_support/dependencies"
require "open-uri"
require "timeout"
require "nokogiri"
require "date"
require "time"

module FxLib

  mattr_accessor :app_root

  def self.setup
    yield self
  end

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

    def self.fetch_data_on(url, date)
      begin
        file = open_xml_file(url)
        d    = date.strftime("%Y-%m-%d")
        extract = file.xpath("//Cube[@time='#{d}']/Cube")
        extract.each do |e|
          er = FxRate.create(downloaded_at: d, currency: e.attr('currency'), rate: e.attr('rate'))
          er.save
        end
      rescue Exception => e
        puts e.to_s
        return e.to_s
      end
    end

    def self.fetch_data(url)
      begin
        file         = open_xml_file(url)
        time_cubes   = file.xpath("//Cube[@time]")
        time_cubes.each do |tc|
          cubes    = tc.xpath("./Cube")
          cubes.each do |c|
            date     = tc.attr('time')
            currency = c.attr('currency')
            rate     = c.attr('rate')
            er       = FxRate.create(downloaded_at: date, currency: currency, rate: rate)
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
