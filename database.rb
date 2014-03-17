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

class Sighting < Sequel::Model; 
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

puts "__________________________________"
puts Sighting[1].name
Sighting[1].update(:description => "I was filming two of my friends, Dave and Joe, fishing when a sasquatch snuck up on us. The next thing I knew, the big foot had ripped Dave's heart out and fed it to him! Next he just ripped his arm off. Then he threw Dave's arm at Joe, with such a great force that it knocked him into the water, and killed him!

I am just amazed he left me alone.

I was also able to film the whole event, and even uploaded it to youtube - https://www.youtube.com/watch?v=XleygjgB-uA")
puts "__________________________________"
Sighting[1].description
puts "__________________________________"