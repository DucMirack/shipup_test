class Parser
  def carriers
    data["carriers"]
  end

  def packages
    data["packages"]
  end

  def country_distances
    data["country_distance"]
  end

  def data
    JSON.parse(input_content)
  end

  def input_content
    @input_content ||= File.open('data/input.json').read
  end

  def expected_output
    @expected_output ||= JSON.parse(File.open('data/expected_output.json').read)
  end
end
