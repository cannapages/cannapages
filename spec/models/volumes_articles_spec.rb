require 'spec_helper'

describe "Volumes and Articles" do

	let(:articles) do
		array = []
		10.times do
			array << FactoryGirl.create(:article)
		end
		array
	end

	let(:volumes) do
		array = []
		2.times do
			array << FactoryGirl.create(:volume)
		end
		array
	end

	it "Should have working factories" do
		articles.each do |a|
			a.class.should eql Article
		end
		volumes.each do |v|
			v.class.should eql Volume
		end
	end

	it "Should persist changes from articles to all volumes with those articles" do
		volumes.first.articles << articles.first
		volumes.last.articles << articles.first
			
		volumes.each do |v|
			puts v.valid?
		end

		content_update = "New Content its all very exciting"
		articles.first.content = content_update
		articles.first.save

		volumes.each do |v|
			v.reload
		end
		volumes.first.articles.first.content.should eql content_update
		volumes.last.articles.first.content.should eql content_update
	end

end
