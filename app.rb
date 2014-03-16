#!/usr/bin/env ruby

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