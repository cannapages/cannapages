require 'spec_helper'

describe Product do
  let(:product) do
		FactoryGirl.create :product
	end

	it "Should have a working factory" do
		product.class.should eql Product
	end

	it "Should tell if it is in stock or not if in mode one base on a boolean value" do
		product.binary_mode = true
		product.binary_in_stock = false
		product.in_stock?.should eql false
		product.binary_in_stock = true
		product.in_stock?.should eql true	
	end

	it "Should tell if it is in stock or not based on quanity if in mode 2" do
		product.binary_mode = false

		product.quantity_in_stock = 5.0
		product.in_stock?.should eql true
		product.quantity_in_stock -= 5
		product.in_stock?.should eql false

		product.quantity_in_stock = nil
		product.in_stock?.should eql false
	end

	it "Should not allow document to persist with negative stock" do
		product.quantity_in_stock = 5.0
		product.quantity_in_stock -= 5.5
		product.save
		product.reload
		product.quantity_in_stock.should eql 0.0
	end

end
