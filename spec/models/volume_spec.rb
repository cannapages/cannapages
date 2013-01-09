require 'spec_helper'

describe Volume do

	let(:volume) do
		FactoryGirl.build :volume
	end

	it "Should have a working factory" do
		volume.should be_valid
	end

end
