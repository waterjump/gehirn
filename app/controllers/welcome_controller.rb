class WelcomeController < ApplicationController
  def home
  end

  def query
    images = Parsers::Google.new(params['q']).images
    response = Parsers::Wiktionary.new(params['q']).parse
    render json: response.merge(images: images)
  end
end
