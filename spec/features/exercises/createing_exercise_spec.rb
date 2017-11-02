require "rails_helper"

RSpec.feature "Creating Exercise" do 
	before do
		@john = User.create(email: john@example.com, password: "password")
		login_as(@john)
	end

	scenario "with valid inputs" do 

	end
end