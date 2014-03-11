require "sequel"

class Database
	attr_accessor :DB

	def DB=(database)
		@DB = database
	end

	def sightings
		@DB[:sightings]
	end

	def initialize() 
		self.DB = Sequel.connect("sqlite://database/database.db")
		self.createTables
	end

	def createTables
		@DB.create_table? :sightings do
			primary_key :id
			String :name
			Float :longitude
			Float :latitude
		end
	end

end