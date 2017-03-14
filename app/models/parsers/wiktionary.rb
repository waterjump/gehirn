module Parsers
  class Wiktionary < Parser
    attr_reader :entry_found

    def self.endpoints
      { 'de' => 'https://de.wiktionary.org/w/api.php' }
    end

    def initialize(language, q)
      super
      @entry_found = @response.present?
    end

    def ipa
      "/#{nokogiri.css('span.ipa').first.children.first.text}/"
    rescue => e
      Rails.logger.info "No ipa found for #{@q}: #{e.inspect}"
      'No pronunciation found'
    end

    def sound
      nokogiri
        .css('a')
        .detect do |a|
          a.attributes['href'].value =~ /upload.*De.*\.ogg/i
        end['href']
    rescue => e
      nil
    end

    private

    def fetch_response
      client.action(:parse, page: @q)
    rescue MediawikiApi::ApiError => e
      Rails.logger.info "Error fetching response from Wiktionary: #{e.inspect}"
      nil
    end

    def nokogiri
      @nokogiri ||= Nokogiri::HTML(@response.data['text']['*'])
    end

    def client
      @client ||= MediawikiApi::Client.new(self.class.endpoints[ @language ])
    end
  end
end
