require "sequel"
require "json"
require_relative "./dropbox.rb"

DB = Sequel.connect(ENV["HEROKU_POSTGRESQL_OLIVE_URL"] || "sqlite://database.db")
#DB = Sequel.sqlite

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
    foreign_key :images
    foreign_key :comments
end

DB.create_table? :images do
    primary_key :id
    String :extname
    foreign_key :sighting_id
end

DB.create_table? :comments do
    primary_key :id
    String :name
    String :text
    foreign_key :sighting_id
end

class Sighting < Sequel::Model
    one_to_many :images
    one_to_many :comments
    plugin :json_serializer
end

class Image < Sequel::Model
    many_to_one :sighting
    plugin :json_serializer
end

class Comment < Sequel::Model
    many_to_one :sighting
    plugin :json_serializer
end