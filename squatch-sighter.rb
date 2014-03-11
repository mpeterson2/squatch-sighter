#!/usr/bin/env ruby

require 'json'
require "sinatra"
require_relative "database.rb"

# Settings for Sinatra.
set :public_folder, 'public/squatch_sighter/web'
mime_type :dart, 'application/dart'

# Create the Databse.
db = Database.new

# Routing stuff.

# Main index page.
get "/" do
	redirect "/map.html"
end

# Add a new Sighting.
post "/sighting/new" do
	data = JSON.parse(request.body.read)
	id = db.sightings.insert(
		:name => 'name',
		:latitude => data["lat"],
		:longitude => data["lng"]
		)
	id.to_s
end

# Grab all of the sightings.
get "/sighting/all" do
	content_type :json
	db.sightings.all.to_json
end

# Grab a sighting by ID.
get "/sighting/:id" do
	content_type :json
	id = params[:id]
	sighting = db.sightings.where(:id => id)
	sighting[:id].to_json
end