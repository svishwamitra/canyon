class Image < ActiveRecord::Base
 require 'paperclip'
# ============= Attachments
  AVATAR_SW = 113
  AVATAR_SH = 76
  AVATAR_NW = 500
  AVATAR_NH = 400

has_attached_file :picture, :styles => { :large => "#{AVATAR_NW}x#{AVATAR_NH}>",
                       :small => "#{AVATAR_SW}x#{AVATAR_SH}#" },
							  :url  => "/assets/images/:id/:style/:basename.:extension",
							  :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension",
                       :processors => [:cropper] 
# ============= Validations for Attachments
	validates_attachment_presence :picture
	validates_attachment_size :picture, :less_than => 5.megabytes
	validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/gif']

# ============= Validations
	validates_presence_of :image_type#, :message => "Please select Image Type"

# ============= 
	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
	after_update :reprocess_picture, :if => :cropping?

# ============= Search friendly URLs
 def to_param   
   "#{id}-#{name.rstrip.gsub(/[^a-z0-9]+/i, '-')}"
 end

# ============= Search
 def self.search(page, type)
#	condition = ""
#	if type
#		condition = "image_type = '#{type}'"
#	end
	paginate :per_page => 20, :page => page, :conditions => ["image_type = '#{type}'"], :order => ["created_at DESC"]
 end
 
  def self.search_images(type, page)
    paginate :per_page => 20, :page => page, :conditions => ["image_type = '#{type}'"], :order => "created_at DESC "
  end

# ============= Cropping attachments   
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def picture_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(picture.path(style))
  end
  
  private
  
  def reprocess_picture
    picture.reprocess!
  end

end
