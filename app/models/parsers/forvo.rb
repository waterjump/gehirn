module Parsers
  class Forvo < Parser
    def self.client
      ForvoApiClient::Client.new(
        Rails.application.secrets.forvo['api_key']
      )
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
        language: @language
      )
    rescue => e
      Rails.logger.info "Problem with Forvo response: #{e.inspect}"
      nil
    end
  end
end
