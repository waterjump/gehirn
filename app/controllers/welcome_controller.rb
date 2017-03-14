class WelcomeController < ApplicationController
  def home
  end

  def query
    search_term = SearchTerm.new(params['language'], params['q'])
    render json: search_term.results
  end
end
