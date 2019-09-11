class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    @resp = Faraday.get '' do |req|
      req.params['client_id'] = ENV[GITHUB_CLIENT]
      req.params['client_secret'] = ENV[GITHUB_SECRET]
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["info"]["name"]
      name, html_url, description
    else
      @error = body["meta"]["errorDetail"]
    end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
