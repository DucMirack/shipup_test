class Parser
  def carriers
    data["carriers"]
  end

  def packages
    data["packages"]
  end

  def data
    JSON.parse(input_content)
  end

  def input_content
    @input_content ||= File.open('data/input.json').read
  end
end
