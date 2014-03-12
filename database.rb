require "sequel"

configure do
	DB = Sequel.connect(ENV["DATABASE_URL"] || "sqlite://database/database.db")

	DB.create_table? :sightings do
		primary_key :id
		String :name
		Float :longitude
		Float :latitude
	end

	class Sighting < Sequel::Model
	end
end