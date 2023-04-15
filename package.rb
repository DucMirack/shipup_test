class Package
  attr_reader :id, :carrier, :shipping_date

  def initialize(package_data)
    @id = package_data["id"]
    @carrier = package_data["carrier"]
    @shipping_date = package_data["shipping_date"]
  end
end
