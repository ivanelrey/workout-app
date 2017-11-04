require "rails_helper"

RSpec.feature "Showing Friend Workout" do 
	before do 
		@john = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
		@sarah = User.create(first_name: "Sarah", last_name: "Doe", email: "sarah@example.com", password: "password")
		
		@ex1 = @john.exercises.create(duration_in_min: 20,
		 workout: "My body building activity", workout_date: Date.today)
		
		@ex2 = @sarah.exercises.create(duration_in_min: 55,
		 workout: "Weight ligting", workout_date: 2.day.ago)

		login_as(@john)

		@following = Friendship.create(user: @john, friend: @sarah)
	end

	scenario "shows friend's workout for last 7 days" do 
		visit "/"

		click_link "My Lounge"
		click_link @sarah.full_name

		expect(page).to have_content(@sarah.full_name + "'s Exercises")
		expect(page).to have_content(@ex2.workout)
		expect(page).to have_css("div#chart")
	end

end