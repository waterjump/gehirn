class Parser
  def initialize(language, q)
    @q = q
    @language = language
    @response = fetch_response
  end
end
