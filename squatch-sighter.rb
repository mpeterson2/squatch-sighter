require "sinatra"
require "json"
require_relative "./database.rb"

class SquatchSighter < Sinatra::Base
	# Main index page.
	get "/" do
		redirect "/map.html"
	end

	# Add a new Sighting.
	post "/sighting/new" do
		data = JSON.parse(request.body.read)
		id = Sighting.insert(
			:title => data["title"],
			:description => data["description"],
			:name => data["name"],
			:contact_info => data["contact_info"],
			:latitude => data["lat"],
			:longitude => data["lng"],
			:date => Date.parse(data["date"]),
			:record_date => DateTime.now
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
end