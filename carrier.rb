class Carrier
  attr_reader :code, :delivery_promise

  def initialize(carrier_data)
    @code = carrier_data["code"]
    @delivery_promise = carrier_data["delivery_promise"]
  end
end
