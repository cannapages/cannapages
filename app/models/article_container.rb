class ArticleContainer
  include Mongoid::Document
	embeds_many :articles
end
