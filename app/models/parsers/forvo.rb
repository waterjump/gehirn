module Parsers
  class Forvo
    def self.client
      ForvoApiClient::Client.new(
        Rails.application.secrets.forvo['api_key']
      )
    end

    def initialize(q)
      @q = q
      @response = fetch_response
    end

    def sound
      return '' unless @response.present?
      @response.first['pathogg']
    rescue
      ''
    end

    private

    def fetch_response
      self.class.client.word_pronunciations(
        @q,
        language: 'de'
      )
    rescue => e
      Rails.logger.info "Problem with Forvo response: #{e.inspect}"
      nil
    end
  end
end
