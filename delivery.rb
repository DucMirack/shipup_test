class Delivery
  DELAY_MARGIN_DAYS = 1

  attr_reader :package, :carrier

  def initialize(package, carrier)
    @package = package
    @carrier = carrier
  end

  def expected_delivery_date
    package.shipping_date + carrier.delivery_promise + DELAY_MARGIN_DAYS
  end

  def range_days
    @range_days ||= (package.shipping_date..expected_delivery_date)
  end
end
