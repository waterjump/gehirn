class WelcomeController < ApplicationController
  def home
  end

  def query
    Rails.logger.info "69BOT - params: #{params['q']}"
    client = MediawikiApi::Client.new("https://de.wiktionary.org/w/api.php")
    wiki = client.action(:parse, page: params['q'])
    noko = Nokogiri::HTML(wiki.data['text']['*'])
    Rails.logger.info "69BOT - ipa: #{noko.css('span.IPA')}"
    ipa = noko.css('span.ipa').first.children.first.text
    # => "/ɡəˈhɪʁn/"
    # sound = noko.css('source').select { |a| a['src'] =~ /ogg/ }.first.attributes['src'].value
    sound = noko.css('a').detect { |a| a.attributes['href'].value =~ /upload.*ogg/ }['href']
    # //upload.wikimedia.org/wikipedia/commons/0/00/De-Gehirn.ogg
    render json: { ipa: ipa, sound: sound }
  end
end
