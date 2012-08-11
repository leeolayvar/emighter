#
# lib/emighter.coffee
#
# Copyright (c) 2012 Lee Olayvar <leeolayvar@gmail.com>
# MIT Licensed
#




# Create a new Emighter instance.
create = (args...) -> new Emighter args...


# A simple emitter class.
class Emighter
  constructor: ->
    @_fns = {}
  
  
  _iterate_fns: (fns=[], args, callback, index=0) =>
    item = fns[index]
    
    if not item?
      callback()
      return
    
    [fn, options] = item
    
    _done = =>
      @_iterate_fns fns, args, callback, ++index
    
    switch options.callback
      when true
        fn args..., _done
      when false
        fn args...
        _done()
      else
        if fn.length <= args.length
          fn args...
          _done()
        else
          fn args..., _done
  
  
  on: (namespace, fn, options={}) =>
    options.post ?= true
    
    if not @_fns[namespace]?
      @_fns[namespace] = []
    
    if options.post
      @_fns[namespace].push [fn, options]
    else
      @_fns[namespace].splice 0, 0, [fn, options]
  
  
  emit: (namespace, args...) =>
    callback = ->
    
    if not @_fns[namespace]?
      return
    
    if args[0] instanceof Array and args[1] instanceof Function
      callback = (args.splice 1, 1)[0]
      args[0].push args[1..]...
      args = args[0]
    
    @_iterate_fns @_fns[namespace], args, -> callback()



class EmighterNamespaced
  constructor: ->
    @__emighter = new Emighter()
  
  on: (args...) => @_emighter.on args...
  
  emit: (args...) => @_emighter.emit args...




exports.create = create
exports.Emighter = Emighter
exports.EmighterNamespaced = EmighterNamespaced
