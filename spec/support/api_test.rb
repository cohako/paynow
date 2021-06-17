
module ApiTest
  def parsed_body
    JSON.parse(response.body)
  end
end