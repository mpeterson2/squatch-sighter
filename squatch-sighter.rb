#!/usr/bin/env ruby

require "sinatra"
require "json"
require_relative "database.rb"

# Settings for Sinatra.
set :public_folder, 'public/squatch_sighter/web'
mime_type :dart, 'application/dart'

# Main index page.
get "/" do
	redirect "/map.html"
end

# Add a new Sighting.
post "/sighting/new" do
	data = JSON.parse(request.body.read)
	id = Sighting.insert(
		:name => 'name',
		:latitude => data["lat"],
		:longitude => data["lng"]
		)
	id.to_s
end

# Grab all of the sightings.
get "/sighting/all" do
	content_type :json
	Sighting.naked.all.to_json
end

# Grab a sighting by ID.
get "/sighting/:id" do
	content_type :json
	id = params[:id].to_i
	Sighting.naked[id].to_json
end