require 'json'
require 'date'
require_relative '../carrier'
require_relative '../package'
require_relative '../parser'
require_relative '../delivery'
require 'byebug'

class Level3
  def call
    deliveries = packages.map do |package|
      package = Package.new(package)
      carrier_data = carriers.find { |carrier| carrier["code"] == package.carrier }
      carrier = Carrier.new(carrier_data)
      delivery = Delivery.new(package, carrier)

      expected_delivery = delivery.expected_delivery_date

      unless carrier.saturday_deliveries
        next_saturday = package.date_of_next?("Saturday")
        expected_delivery += 1 if delivery.range_days.cover?(next_saturday)
      end

      next_sunday = package.date_of_next?("Sunday")
      expected_delivery += 1 if delivery.range_days.cover?(next_sunday)

      distance_kilometers = country_distances[package.origin_country][package.destination_country]
      oversea_delay = distance_kilometers / carrier.oversea_delay_threshold
      expected_delivery += oversea_delay

      {
        "package_id" => package.id,
        "expected_delivery" => expected_delivery.to_s,
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
