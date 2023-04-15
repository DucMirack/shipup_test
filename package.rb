class Package
  attr_reader :id, :carrier, :shipping_date

  def initialize(package_data)
    @id = package_data["id"]
    @carrier = package_data["carrier"]
    @shipping_date = Date.parse(package_data["shipping_date"])
  end

  def date_of_next?(day)
    start_date = shipping_date
    start_date += 1 until start_date.strftime("%A") == day
    start_date
  end
end
