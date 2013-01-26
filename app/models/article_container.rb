class ArticleContainer
  include Mongoid::Document
	embeds_many :articles

	class << self
		def search( query )
			(articles.where( title: (%r[#{query}]i) ).to_a + articles.where( content: (%r[#{query}]i) ).to_a).uniq!
		end
	end
end
