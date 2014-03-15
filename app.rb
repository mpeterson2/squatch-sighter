#!/usr/bin/env ruby

require_relative "./squatch-sighter"

dart = false
ARGV.each do |a|
	if a == "-d" or "--dart"
		dart = true
	end
end


if dart
	SquatchSighterDart.run!
else
	SquatchSighter.run!
end