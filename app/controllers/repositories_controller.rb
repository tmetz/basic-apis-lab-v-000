class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
      req.params['q'] = params[:query]
      req.params['client_id'] = ENV[GITHUB_CLIENT]
      req.params['client_secret'] = ENV[GITHUB_SECRET]
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @results = body["items"]
    else
      @error = body["meta"]["message"]
    end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
