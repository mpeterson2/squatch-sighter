require "dropbox_sdk"


class DropboxApi
	attr_accessor :client
	
	# Constants used to access Dropbox. Access token is the only important one now.
	@@KEY = "tx3c32bd3sdjk4o"
	@@SECRET = "5044j0uk99zm1vx"
	@@ACCESS_TOKEN = "zgbrMY0CepAAAAAAAAAAAVdlx8oEVyTotf34CgAGk77fQTZ1CNNPozPrgZQeiyDG"

	@@FOLDER_NAME

	def initialize
		puts ENV["ENVIRONMENT"].methods.sort
		if ENV["ENVIRONMENT"].nil?
			@@FOLDER_NAME = "local/images/"
		else
			@@FOLDER_NAME = "heroku/images/"
		end
		@client = DropboxClient.new(@@ACCESS_TOKEN)
	end

	def upload(name, file)
		@client.put_file(@@FOLDER_NAME + name, file, true)
	end

	def download(name)
		@client.get_file(@@FOLDER_NAME + name)
	end

	def get_url(name)
		@client.media(@@FOLDER_NAME + name)
	end

	def clear
		begin
			@client.file_delete(@@FOLDER_NAME)
		rescue
		end
	end
end