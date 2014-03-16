#!/usr/bin/env ruby

# Delete the dropbox files if we are starting from a fresh database.
require_relative "./dropbox"

if not File.exists?("database.db")
	DropboxApi.new.clear
end

# Create the database and include the Sinatra application.
require_relative "./squatch-sighter"

# Check if we need to run with dart or not.
dart = false
ARGV.each do |a|
	if a == "-d" or a == "--dart"
		dart = true
	end
end

# Run the app.
if dart
	SquatchSighterDart.run!
else
	SquatchSighter.run!
end