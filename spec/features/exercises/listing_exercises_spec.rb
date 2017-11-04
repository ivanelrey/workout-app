require 'rails_helper'


RSpec.feature "listing exercises" do 
	before do
		@john = User.create(email: "john@example.com", password: "password")
		login_as(@john)

		@ex1 = @john.exercises.create(duration_in_min: 20, workout: "My body building activity", workout_date: Date.today)
		
		@ex2 = @john.exercises.create(duration_in_min: 55, workout: "Weight ligting", workout_date: 2.day.ago)

		@ex3 = @john.exercises.create(duration_in_min: 35, workout: "On treadmill", workout_date: 8.day.ago)
	end

	scenario "show user' workout for last 7 days" do 
		visit "/"

		click_link "My Lounge"

		expect(page).to have_content(@ex1.duration_in_min)
		expect(page).to have_content(@ex1.workout)
		expect(page).to have_content(@ex1.workout_date)

		expect(page).to have_content(@ex2.duration_in_min)
		expect(page).to have_content(@ex2.workout)
		expect(page).to have_content(@ex2.workout_date)

		expect(page).not_to have_content(@ex3.duration_in_min)
		expect(page).not_to have_content(@ex3.workout)
		expect(page).not_to have_content(@ex3.workout_date)
	end

	scenario "shows no exercises if none created" do 
		@john.exercises.delete_all

		visit "/"

		click_link "My Lounge" 

		expect(page).to have_content("No Workouts Yet")
	end
end