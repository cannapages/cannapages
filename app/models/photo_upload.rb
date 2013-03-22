class PhotoUpload
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
	has_mongoid_attached_file :photo_upload, :styles => { thumb: "75x75#", medium: "150x150#", large: "250x250#" }
	belongs_to :listing
end
