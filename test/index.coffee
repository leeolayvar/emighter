#
# test/index.coffee
#
# Copyright (c) 2012 Lee Olayvar <leeolayvar@gmail.com>
# MIT Licensed
#
dork = require 'dork'




# Define any options we want to use.
dork.options
  global: true




exports.emighter = require './emighter'
if require.main is module then dork.run()