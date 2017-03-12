module Parsers
  class Wikipedia
    def self.client
      MediawikiApi::Client.new("https://de.wiktionary.org/w/api.php")
    end

    def initialize(q)
      @q = q
      @response = self.class.client.action(:parse, page: q)
    end

    def parse
      { ipa: ipa, sound: sound }
    end

    private

    def ipa
      "/#{nokogiri.css('span.ipa').first.children.first.text}/"
    rescue => e
      Rails.logger.info "No ipa found for #{q}: #{e.inspect}"
      ''
    end

    def sound
      nokogiri.css('a').detect { |a| a.attributes['href'].value =~ /upload.*ogg/ }['href']
    rescue
      Rails.logger.info "No sound found for #{q}: #{e.inspect}"
      ''
    end

    def nokogiri
      @nokogiri ||= Nokogiri::HTML(@response.data['text']['*'])
    end
  end
end
