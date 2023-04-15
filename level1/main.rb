require 'json'
require 'date'
require_relative '../carrier'
require_relative '../package'
require_relative '../parser'
require_relative '../delivery'
require 'byebug'

class Level1
  def call
    deliveries_data = packages.map do |package|
      package = Package.new(package)
      carrier_data = carriers.find { |carrier| carrier["code"] == package.carrier }
      carrier = Carrier.new(carrier_data)
      delivery = Delivery.new(package, carrier)
      {
        "package_id" => package.id,
        "expected_delivery" => delivery.expected_date.to_s,
      }
    end
    input = { "deliveries" => deliveries_data }
    puts "Input:           #{input}"
    puts "Expected output: #{parser.expected_output}"
    puts "Input and expected output are the same: #{input == parser.expected_output}"
  end

  def parser
    @parser ||= Parser.new
  end

  def packages
    parser.packages
  end

  def carriers
    parser.carriers
  end
end

Level1.new.call
