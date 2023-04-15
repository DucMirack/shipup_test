require 'json'
require 'date'
require_relative '../carrier'
require_relative '../package'
require_relative '../parser'
require_relative '../delivery'
require_relative '../oversea_delay_calculator'
require 'byebug'

class Level3
  def call
    deliveries = packages.map do |package|
      package = Package.new(package)
      carrier_data = carriers.find { |carrier| carrier["code"] == package.carrier }
      carrier = Carrier.new(carrier_data)
      delivery = Delivery.new(package, carrier)
      delivery.compute_expected_date_with_weekend_days
      oversea_delay = OverseaDelayCalculator.new(country_distances, package.origin_country, package.destination_country, carrier.oversea_delay_threshold).compute
      delivery.expected_date += oversea_delay

      {
        "package_id" => package.id,
        "expected_delivery" => delivery.expected_date.to_s,
        "oversea_delay" => oversea_delay,
      }
    end
    hash = { "deliveries" => deliveries }
    puts "Input: #{hash}"
    puts "Output: #{expected_output}"
    puts "Input and output are the same : #{hash == expected_output}"
  end

  def packages
    Parser.new.packages
  end

  def carriers
    Parser.new.carriers
  end

  def country_distances
    Parser.new.country_distances
  end

  def expected_output
    JSON.parse(File.open('data/expected_output.json').read)
  end
end

Level3.new.call
