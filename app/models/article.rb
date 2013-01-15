class Article
  include Mongoid::Document
	include Mongoid::Timestamps
	field :soul_id, type: String
  field :title, type: String
  field :content, type: String
  field :views, type: Integer
  field :likes, type: Integer

	embedded_in :volume
	embedded_in :article_container
	before_save :initialize_anylitics, :remove_unwanted_html_tags, :also_embed_in_article_container

	def also_embed_or_persist_in_article_container

		ac = ArticleContainer.last
		unless ac
			ac = ArticleConatiner.create
		end

		if soul_id
			ac_a = ac.articles.find( soul_id ).first
			ac_a.update_attributes( self )
			
		else
			#Create and tie with soul_id
		end
	end

	def initialize_anylitics
		self.views, self.likes = 0,0
	end

	def remove_unwanted_html_tags
		self.content = Sanitize.clean( content, Sanitize::Config::RELAXED)
	end
end
