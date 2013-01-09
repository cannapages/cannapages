require 'spec_helper'

describe Strain do
	let(:strain) do
		FactoryGirl.build :strain
	end

	it "Should have a working factory" do
		strain.should be_valid
	end
	
	it "Should only allow indica sativa or hybrid for dominance" do
		strain.dominance = "NotValid"
		strain.should_not be_valid
		strain.dominance = "Hybrid"
		strain.should be_valid
	end

	it "Should auto populate Hybrid for dominance if unspecified" do
		strain.dominance = nil
		strain.save
		strain.dominance.should eql "Hybrid"
	end

	it "Should only allow percent range for thc cbd cbn ie 0-100" do
		strain.thc = 103
		strain.should_not be_valid
		strain.cbd = 103
		strain.should_not be_valid
		strain.cbn = 103
		strain.should_not be_valid
	end

	it "Should ensure the sum of cbd cbn and thc is less than or equal to 100" do
		strain.thc = 10
		strain.cbd = 50
		strain.cbn = 50
		strain.should_not be_valid
	end
end
