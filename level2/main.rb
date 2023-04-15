require 'json'
require 'date'
require_relative '../carrier'
require_relative '../package'
require_relative '../parser'
require_relative '../delivery'
require 'byebug'

class Level2
  def call
    deliveries = packages.map do |package|
      package = Package.new(package)
      carrier_data = carriers.find { |carrier| carrier["code"] == package.carrier }
      carrier = Carrier.new(carrier_data)
      delivery = Delivery.new(package, carrier)
      delivery.compute_expected_date_with_weekend_days

      {
        "package_id" => package.id,
        "expected_delivery" => delivery.expected_date.to_s,
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

  def expected_output
    JSON.parse(File.open('data/expected_output.json').read)
  end
end

Level2.new.call
