#
# test/index.coffee
#
# Copyright (c) 2012 Lee Olayvar <leeolayvar@gmail.com>
# MIT Licensed
#
dork = require 'dork'
should = require 'should'


dork.options
  global: true


###
describe 'Namespaced', ->
  Namespaced = (require '../lib/emighter').EmighterNamespaced
  describe 'when created', ->
    namespaced = null
    before_each ->
      namespaced = new Namespaced()
    it 'should only expose public methods.', ->
      for k, v of namespaced
        if k isnt '__emighter'
          k[0].should.not.equal '_'

###


if require.main is module then dork.run()