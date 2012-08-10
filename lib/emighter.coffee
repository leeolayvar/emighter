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
  
  
  emit: (namespace, args, extra_args...) =>
    callback = ->
    
    if not @_fns[namespace]?
      return
    
    if not (args instanceof Array)
      args = [args]
    else if extra_args[0] instanceof Function
      callback = (extra_args.splice 0, 1)[0]
    else
      args = [args]
    
    args.push extra_args...
    
    @_iterate_fns @_fns[namespace], args, -> callback()



class EmighterNamespaced
  constructor: ->
    @_emighter = new Emighter()
  
  on: (args...) => @_emighter.on args...
  
  emit: (args...) => @_emighter.emit args...




exports.create = create
exports.Emighter = Emighter
exports.EmighterNamespaced = EmighterNamespaced
