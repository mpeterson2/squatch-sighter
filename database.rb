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

	class Sighting < Sequel::Model
	end
end

=begin
Comments
Users
=end