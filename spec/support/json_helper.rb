module JsonHelper
  def json_response
    JSON.parse(response.body)
  rescue StandardError
    {}
  end
end
