class Package
  attr_reader :id, :carrier, :shipping_date, :origin_country, :destination_country

  def initialize(package_data)
    @id = package_data["id"]
    @carrier = package_data["carrier"]
    @shipping_date = Date.parse(package_data["shipping_date"])
    @origin_country = package_data["origin_country"]
    @destination_country = package_data["destination_country"]
  end

  def date_of_next?(day)
    start_date = shipping_date
    start_date += 1 until start_date.strftime("%A") == day
    start_date
  end
end
