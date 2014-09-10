class SitesController < ApplicationController
  def new
    @site = Site.new
  end

  def create
  require 'open-uri'
  url = params.require(:site)[:url]
  site = Site.create(url: url)
  LinksWorker.perform_async(site.id)

  redirect_to site_path(site)
end

  def show
    @site_links = Site.order(created_at: :desc).first.links
  end
end
