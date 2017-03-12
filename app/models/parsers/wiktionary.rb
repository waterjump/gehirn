module Parsers
  class Wiktionary
    def self.client
      MediawikiApi::Client.new('https://de.wiktionary.org/w/api.php')
    end

    def initialize(q)
      @q = q
      @response = fetch_response
    end

    def parse
      { q: @q, ipa: ipa, sound: sound }
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
          a.attributes['href'].value =~ /upload.*ogg/
        end['href']
    rescue => e
      Rails.logger.info "No sound found for #{@q}: #{e.inspect}"
      ''
    end

    def fetch_response
      self.class.client.action(:parse, page: @q)
    rescue MediawikiApi::ApiError => e
      if e.message =~ /missingtitle/
        @q = @q.capitalize
        self.class.client.action(:parse, page: @q)
      else
        raise e
      end
    end

    def nokogiri
      @nokogiri ||= Nokogiri::HTML(@response.data['text']['*'])
    end
  end
end
