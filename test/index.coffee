#
# test/index.coffee
#
# Copyright (c) 2012 Lee Olayvar <leeolayvar@gmail.com>
# MIT Licensed
#
dork = require 'dork'



exports.emighter = require './emighter'
exports.options = require './options'
if require.main is module then dork.run()