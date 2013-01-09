require 'spec_helper'

describe StrainTest do
	
	let(:strain_test) do
		FactoryGirl.build :strain_test
	end

	it "Should have a working factory" do
		strain_test.should be_valid
	end
	
	it "Should only allow indica sativa or hybrid for dominance" do
		strain_test.dominance = "NotValid"
		strain_test.should_not be_valid
		strain_test.dominance = "Hybrid"
		strain_test.should be_valid
	end

	it "Should auto populate Hybrid for dominance if unspecified" do
		strain_test.dominance = nil
		strain_test.save
		strain_test.dominance.should eql "Hybrid"
	end

	it "Should only allow percent range for thc cbd cbn ie 0-100" do
		strain_test.thc = 103
		strain_test.should_not be_valid
		strain_test.cbd = 103
		strain_test.should_not be_valid
		strain_test.cbn = 103
		strain_test.should_not be_valid
	end

	it "Should ensure the sum of cbd cbn and thc is less than or equal to 100" do
		strain_test.thc = 10
		strain_test.cbd = 50
		strain_test.cbn = 50
		strain_test.should_not be_valid
	end

end
