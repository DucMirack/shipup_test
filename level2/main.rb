require 'json'
require 'date'
require_relative '../carrier'
require_relative '../package'
require_relative '../parser'
require 'byebug'

class Level2
  DELAY_MARGIN_DAYS = 1

  def call
    deliveries = packages.map do |package|
      package = Package.new(package)
      carrier_data = carriers.find { |carrier| carrier["code"] == package.carrier }
      carrier = Carrier.new(carrier_data)
      expected_delivery = package.shipping_date + carrier.delivery_promise + DELAY_MARGIN_DAYS
      delivery_range_days = (package.shipping_date..expected_delivery)
      unless carrier.saturday_deliveries
        next_saturday = package.date_of_next?("Saturday")
        expected_delivery += 1 if delivery_range_days.cover?(next_saturday)
      end
      next_sunday = package.date_of_next?("Sunday")
      expected_delivery += 1 if delivery_range_days.cover?(next_sunday)
      {
        "package_id" => package.id,
        "expected_delivery" => expected_delivery.to_s,
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
