class WelcomeController < ApplicationController
  def home
  end

  def query
    response = Parsers::Wiktionary.new(params['q']).parse
    render json: response
  end
end
