class Carrier
  attr_reader :code, :delivery_promise, :saturday_deliveries, :oversea_delay_threshold

  def initialize(carrier_data)
    @code = carrier_data["code"]
    @delivery_promise = carrier_data["delivery_promise"]
    @saturday_deliveries = carrier_data["saturday_deliveries"]
    @oversea_delay_threshold = carrier_data["oversea_delay_threshold"]
  end
end
