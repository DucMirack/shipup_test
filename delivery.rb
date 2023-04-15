class Delivery
  DELAY_MARGIN_DAYS = 1

  attr_reader :package, :carrier
  attr_accessor :expected_date

  def initialize(package, carrier)
    @package = package
    @carrier = carrier
    @expected_date = base_expected_date
  end

  def base_expected_date
    package.shipping_date + carrier.delivery_promise + DELAY_MARGIN_DAYS
  end

  def compute_expected_date_with_weekend_days
    unless carrier.saturday_deliveries
      next_saturday = package.date_of_next?("Saturday")
      @expected_date += 1 if range_days.cover?(next_saturday)
    end

    next_sunday = package.date_of_next?("Sunday")
    @expected_date += 1 if range_days.cover?(next_sunday)
  end

  def range_days
    @range_days ||= (package.shipping_date..expected_date)
  end
end
