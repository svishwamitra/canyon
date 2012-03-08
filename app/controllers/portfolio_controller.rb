class PortfolioController < ApplicationController

  def logo
	  @images = Image.all(:conditions => ["image_type = 'Logo'"], :order => "created_at DESC")#search_images("Logo", params[:page]) 
  end

  def print_design
	  @images = Image.search_images("Print Design", params[:page])
  end

  def packaging
	  @images = Image.search_images("Packaging", params[:page])
  end

  def web_design
	  @images = Image.search_images("Web Design", params[:page])
  end

  def stall_interior_design
	  @images = Image.search_images("Stall/Interior", params[:page])
  end

end
