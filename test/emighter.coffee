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
  
  it 'should properly remove a function', ->
    baz_count = zed_count = 0
    baz = -> baz_count += 1
    zed = -> zed_count += 1
    emighter.on 'foo', baz
    emighter.on 'foo', zed
    emighter.on 'bar', baz
    emighter.on 'bar', zed
    emighter.remove 'foo', baz
    emighter.emit 'foo'
    emighter.emit 'bar'
    baz_count.should.equal 1
    zed_count.should.equal 2



describe 'Namespaced', ->
  Namespaced = (require '../lib/emighter').EmighterNamespaced
  
  it 'should only expose public methods.', ->
    namespaced = new Namespaced()
    for k, v of namespaced
      if k isnt '__emighter'
        k[0].should.not.equal '_'




if require.main is module then dork.run()