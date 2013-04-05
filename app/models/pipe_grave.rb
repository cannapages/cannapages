class PipeGrave
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
	include Mongoid::MultiParameterAttributes
  field :name, type: String
  field :born, type: Date
  field :died, type: Date
  field :eulogy, type: String
	validates_presence_of :name
	validates_presence_of :born
	validates_presence_of :died
	validates_presence_of :eulogy
	validates_presence_of :pipe_grave_image, on: :create
	belongs_to :user
  has_mongoid_attached_file :pipe_grave_image, :styles => { :large => "400x400#", :thumb => "75x75#" }
end
