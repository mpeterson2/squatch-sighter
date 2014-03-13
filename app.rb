#!/usr/bin/env ruby

require_relative "./squatch-sighter"
require_relative "./database"


# configuring for dart.
#SquatchSighter.set :public_folder, 'public/squatch_sighter/web'
#SquatchSighter.mime_type :dart, "application/dart"
#SquatchSighter.set :public_folder, 'public/squatch_sighter/build/web'

SquatchSighter.run!