require "sinatra"
require "json"
require_relative "./database.rb"

class SquatchSighter < Sinatra::Base

	configure do
		SquatchSighter.set :public_folder, 'public/squatch_sighter/build/web'
	end

	# Main index page.
	get "/" do
		redirect "/map.html"
	end

	# Add a new Sighting.
	post "/sighting/new" do

		sighting = Sighting.create(
			:title => params["title"],
			:description => params["description"],
			:name => params["name"],
			:contact_info => params["contact_info"],
			:date => DateTime.now, #Date.parse(params["date"]),
			:record_date => DateTime.now,
			:latitude => params["lat"],
			:longitude => params["lng"]
			)

		params.keys.each do |key|
			if key.start_with?("media-")
				name = params[key][:filename]
				file_type = name[name.rindex("."), name.length]
				puts file_type
				
				m_id = Image.insert(
					:file_type => file_type
					)

				sighting.add_image(Image[m_id])
			end
		end

		sighting[:id].to_s
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

class SquatchSighterDart < SquatchSighter
	configure do
		SquatchSighterDart.set :public_folder, 'public/squatch_sighter/web'
		SquatchSighterDart.mime_type :dart, "application/dart"
	end
end