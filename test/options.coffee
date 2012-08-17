#
# test/options.coffee
#
# The options for our tests.
#
# Copyright (c) 2012 Lee Olayvar <leeolayvar@gmail.com>
# MIT Licensed
#
dork = require 'dork'




dork.options
  global: true
  reporters: [new dork.reporters.StdoutReporter()]