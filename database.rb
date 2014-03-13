require "sequel"

configure do
	DB = Sequel.connect(ENV["DATABASE_URL"] || "sqlite://database/database.db")

	DB.create_table? :sightings do
		primary_key :id
		String :title
		String :description
		String :name
		String :contact_info
		Float :longitude
		Float :latitude
		Date :date
		Date :record_date
	end

	DB.create_table? :users do
		primary_key :id
		String :f_name
		String :l_name
		String :user_name, :unique => true
		String :email, :unique => true
	end

	class Sighting < Sequel::Model
	end

	class User < Sequel::Model
	end
end

=begin
Users
Comments
=end