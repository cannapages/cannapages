class DeadPipe
  include Mongoid::Document
	include Mongoid::Paperclip
  field :pipe_name, type: String
  field :pipe_age, type: Integer
	field :story, type: String
	has_mongoid_attached_file :pipe_eulogy, :styles => { large: "448x342#" }
end
