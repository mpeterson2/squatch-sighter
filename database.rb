require "sequel"
require "json"

DB = Sequel.connect(ENV["HEROKU_POSTGRESQL_OLIVE_URL"] || "sqlite://database/database.db")
#DB = Sequel.sqlite

DB.create_table? :sightings do 
    primary_key :id
    column :title, :text
    column :description, :text
    column :name, :text
    column :contact_info, :text
    column :longitude, :float
    column :latitude, :float
    column :date, :date
    column :record_date, :date 
    foreign_key :images
end

DB.create_table? :images do
    primary_key :id
    column :file_type, :text
    foreign_key :sighting_id
end

class Sighting < Sequel::Model; 
    one_to_many :images
    plugin :json_serializer
end

class Image < Sequel::Model
    many_to_one :sighting
    plugin :json_serializer
end