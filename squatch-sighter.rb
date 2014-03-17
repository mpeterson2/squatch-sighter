require "sinatra"
require "json"
require_relative "./database.rb"
require_relative "./dropbox.rb"

class SquatchSighter < Sinatra::Base

	@@dropbox_client

	configure do
		SquatchSighter.set :public_folder, 'public/squatch_sighter/build/web'
		@@dropbox_client = DropboxApi.new
	end

	# Main index page.
	get "/" do
		send_file(settings.public_folder + "/map.html")
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
				file =  params[key][:tempfile]
				extname = File.extname(params[key][:filename])
				image = Image.create(:extname => extname)
				name = image.id.to_s
				res = @@dropbox_client.upload(name + extname, file)

				sighting.add_image(image)
			end
		end

		sighting.id.to_s
	end

	# Grab all of the sightings.
	get "/sighting/all" do
		content_type :json
		Sighting.all.to_json
	end

	# Grab a sighting by ID.
	get "/sighting/:id" do
		content_type :json
		id = params[:id].to_i
		Sighting[id].to_json
	end

	get "/sighting/info/:id" do
		id = params[:id].to_i
		@sighting = Sighting[id]
		@images = []
		@sighting.images_dataset.each do |img|
			filename = img.id.to_s + img.extname
			img_url = @@dropbox_client.get_url(filename)["url"]
			@images << img_url
		end
		erb :info
	end

	post "/sighting/info/comment/:id" do
		content_type :json
		id = params[:id]
		newCom = Comment.create(
			:name => params[:name],
			:text => params[:text]
			)

		Sighting[id].add_comment(newCom)
		newCom.to_json
	end

end

class SquatchSighterDart < SquatchSighter
	configure do
		SquatchSighterDart.set :public_folder, 'public/squatch_sighter/web'
		SquatchSighterDart.mime_type :dart, "application/dart"
	end
end