#
# test/index.coffee
#
# Copyright (c) 2012 Lee Olayvar <leeolayvar@gmail.com>
# MIT Licensed
#
dork = require 'dork'
should = require 'should'
require './options'



describe 'Emighter', ->
  Emighter = (require '../lib/emighter').Emighter
  emighter = undefined
  
  before_each ->
    emighter = new Emighter()
  
  it 'should call matching namespace functions', ->
    called = false
    emighter.on 'foo', -> called = true
    emighter.emit 'foo'
    called.should.be.true
  
  it 'should only call matching namespace functions', ->
    emighter.on 'foo', -> throw new Error 'Non-matching namespace called.'
    emighter.emit 'bar'
  



describe 'Namespaced', ->
  Namespaced = (require '../lib/emighter').EmighterNamespaced
  
  it 'should only expose public methods.', ->
    namespaced = new Namespaced()
    for k, v of namespaced
      if k isnt '__emighter'
        k[0].should.not.equal '_'




if require.main is module then dork.run()