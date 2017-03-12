module Parsers
  class Wiktionary
    def self.client
      MediawikiApi::Client.new('https://de.wiktionary.org/w/api.php')
    end

    def initialize(q)
      @q = q
      @tries = 0
      @response = fetch_response
    end

    def parse
      return { q: @q, ipa: ipa, sound: sound } unless @response.nil?
      { error: 'No results.' }
    end

    private

    def ipa
      "/#{nokogiri.css('span.ipa').first.children.first.text}/"
    rescue => e
      Rails.logger.info "No ipa found for #{@q}: #{e.inspect}"
      ''
    end

    def sound
      nokogiri
        .css('a')
        .detect do |a|
          a.attributes['href'].value =~ /upload.*De.*\.ogg/i
        end['href']
    rescue => e
      Rails.logger.info "No sound found for #{@q}: #{e.inspect}"
      ''
    end

    def fetch_response
      @tries += 1
      self.class.client.action(:parse, page: @q)
    rescue MediawikiApi::ApiError => e
      if e.message =~ /missingtitle/ && @tries < 2
        @q = @q.capitalize
        fetch_response
      else
        Rails.logger.info "Error fetching response from Wiktionary: #{e.inspect}"
        nil
      end
    end

    def nokogiri
      @nokogiri ||= Nokogiri::HTML(@response.data['text']['*'])
    end
  end
end
