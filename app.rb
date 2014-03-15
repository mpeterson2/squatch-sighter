#!/usr/bin/env ruby

require "optparse"
require "pp"

options = {:dart => false}

optparse = OptionParser.new do|opts|
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end

  opts.on("-d", "--dart", "Serve Dart files") do
  	options[:dart] = true
  end

end.parse!

pp "Options:", options
pp "ARGV:", ARGV

require_relative "./squatch-sighter"
require_relative "./database"

if options[:dart]
	SquatchSighterDart.run!
else
	SquatchSighter.run!
end