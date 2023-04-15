class OverseaDelayCalculator

  attr_reader :country_distances, :origin_country, :destination_country, :threshold

  def initialize(country_distances, origin_country, destination_country, threshold)
    @country_distances = country_distances
    @origin_country = origin_country
    @destination_country = destination_country
    @threshold = threshold
  end

  def get_distance
    country_distances[origin_country][destination_country]
  end

  def compute
    distance = get_distance
    distance / threshold
  end
end
