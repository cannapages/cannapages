require 'spec_helper'

describe Critique do
	let(:the_critique) do
		Critique.new 	title: "Some Title",
									content: "KLJLKJLJLJK:LJLJKLJLKJL DFSKLJLJLLK DFSJLKJ:L"
	end

  it "Should have a working fixture" do
		the_critique.save.should be_true
	end

	it "Should initialize anylitics" do
		the_critique.save
		[ :views, :likes ].each do |attr|
			the_critique.send(attr).should eql 0
		end
	end

	it "Should only allow certain HTML tags for content" do
		the_critique.content = "<html><body><p><b>Something important</b>More stuff</p></body></html>"
		the_critique.save
		the_critique.content.should eql "<p><b>Something important</b>More stuff</p>"
	end
end
