require 'spec_helper'

describe Article do

	let(:the_article) do
		Article.new title: "Some Title",
								content: "KLJLKJLJLJK:LJLJKLJLKJL DFSKLJLJLLK DFSJLKJ:L"
	end

  it "Should have a working fixture" do
		the_article.save.should be_true
	end

	it "Should initialize anylitics" do
		the_article.save
		[ :views, :likes ].each do |attr|
			the_article.send(attr).should eql 0
		end
	end

	it "Should only allow certain HTML tags for content" do
		the_article.content = "<html><body><p><b>Something important</b>More stuff</p></body></html>"
		the_article.save
		the_article.content.should eql "<p><b>Something important</b>More stuff</p>"
	end

	it "Should copy to a volume" do

	end
end
