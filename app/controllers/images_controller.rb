class ImagesController < ApplicationController
	before_filter :authorize#, :except => [:]
	layout "admin"
	def index
		@images = Image.search(params[:page], params[:type])

		respond_to do |format|
		  format.html # index.html.erb
		  format.xml  { render :xml => @images }
		end
	end

	# GET /images/1
	# GET /images/1.xml
	def show
		@image = Image.find(params[:id])

		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @image }
		end
	end

	# GET /images/new
	# GET /images/new.xml
	def new
		@image = Image.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @image }
		end
	end

	# GET /images/1/edit
	def edit
		@image = Image.find(params[:id])
	end

	# POST /images
	# POST /images.xml
	def create
		@image = Image.new(params[:image])

		respond_to do |format|
		  if @image.save			
			if params[:image][:picture].blank?
				format.html { redirect_to(@image) }
				flash[:notice] = 'Image was successfully added.'
			else
				format.html { render :action => "crop" }
			end			
			format.xml  { render :xml => @image, :status => :created, :image => @image }
		  else
			format.html { render :action => "new" }
			format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
		  end
		end
	end

#	def crop
#		@image.save	
#	end

	# PUT /images/1
	# PUT /images/1.xml
	def update
		@image = Image.find(params[:id])

		respond_to do |format|
		  if @image.update_attributes(params[:image])			
			if params[:image][:picture].blank?
				format.html { redirect_to(@image) }
				flash[:notice] = 'Image was successfully updated.'
			else
				format.html { render :action => "crop" }
			end
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
		  end
		end
	end

	# DELETE /images/1
	# DELETE /images/1.xml
	def destroy
		@image = Image.find(params[:id])
		@image.destroy

		respond_to do |format|
		  format.html { redirect_to(images_path(:type => params[:type])) }
		  format.xml  { head :ok }
		end
	end
end
