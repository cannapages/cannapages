class Forum
  include Mongoid::Document
  field :name, type: String
  field :about, type: String
  field :views, type: Integer
  
  embeds_many :threads
  before_save :initialize_analytics
  
  def initialize_anylitics
		self.views = 0
	end

	class << self
		def search( query )
			inject([]) do |forum,result|
				result + threads.inject([]) do |thread,result|
					(thread.posts.where( title: (%r[#{query}]i) ).to_a + thread.posts.where( content: (%r[#{query}]i) ).to_a).uniq!
				end
			end
		end
	end

end
