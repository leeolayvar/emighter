#
# lib/emighter.coffee
#
# Copyright (c) 2012 Lee Olayvar <leeolayvar@gmail.com>
# MIT Licensed
#




# Create a new Emighter instance.
create = (args...) -> new Emighter args...


# Desc:
#   A simple emitter class.
class Emighter

  # () -> undefined
  #
  # Desc:
  #   Initalize the Emighter instance.
  constructor: ->
    @_fns = {}
  
  
  # (fns=[], args, callback, index=[]) -> undefined
  #
  # Params:
  #   fns: A list of functions to call.
  #   args: A list of arguments to pass to the function.
  #   callback: A callback, called when there are no more `fns` to iterate.
  #   index: The current index of the `fns` to call.
  #
  # Desc:
  #   Iterate over the supplied functions, calling each one with whatever
  #   args were given. When done, call callback.
  _iterate_fns: (fns=[], args=[], callback=(->), index=0) =>
    item = fns[index]
    
    # If the item is null, bail.
    if not item?
      callback()
      return
    
    [fn, options] = item
    
    # The callback for the iterate. If we are not async, this is manually
    # called.
    _done = =>
      @_iterate_fns fns, args, callback, ++index
    
    # Switch over the callback option. If it's not specified, attempt to
    # calculate whether or not the function is async.
    switch options.callback
      when true
        fn args..., _done
      when false
        fn args...
        _done()
      else
        # If the function has more parameters than the arguments, assume
        # that the greater ammount is due to them defining the async callback.
        # So, treat the functon as if it is async.
        if fn.length > args.length
          fn args..., _done
        else
          fn args...
          _done()
  
  
  # (namespace, fn, options={}) -> undefined
  #
  # Params:
  #   namespace: The namespace to subscribe to.
  #   fn: The function called when the given namespace has an event emitted.
  #   options: Optional. An object of options which accepts the following..
  #     {
  #       callback: true/false
  #     }
  #
  # Desc:
  #   Subscribe to events emitted in the given namespace.
  on: (namespace, fn, options={}) =>
    options.post ?= true
    
    if not @_fns[namespace]?
      @_fns[namespace] = []
    
    if options.post
      @_fns[namespace].push [fn, options]
    else
      @_fns[namespace].splice 0, 0, [fn, options]
  
  
  # (namespace, [[args..], callback, arg, args..] | [arg1, arg2, args..]) ->
  #
  # Params:
  #   namespace: The namespace to emit an event.
  #   args: A list of arguments to pass to the subscribed functions.
  #   callback: A callback called when all the functions have finished. 
  #   args..: Each additional argument is passed along with `args` to the
  #     subscribed functions.
  #   
  #   OR
  #   
  #   namespace: The namespace to emit an event.
  #   args..: Additional arguments will be passed into the subscribed
  #     functions.
  #
  # Desc:
  #   Emit an event to all subscribed functions.
  emit: (namespace, args...) =>
    # Define our default callback, incase the caller doesn't care.
    callback = ->
    
    # If the first arg is a list, and the 2nd arg is a function, treat
    # the first as an argument and the 2nd as a callback.
    if args[0] instanceof Array and args[1] instanceof Function
      callback = (args.splice 1, 1)[0]
      args[0].push args[1..]...
      args = args[0]
    
    # If the namespace doesn't exist, callback and exit.
    #
    # Note, we waited to check if the namespace even exists, because we
    # needed to parse the caller callback, which is done above.
    if not @_fns[namespace]?
      callback()
      return
    
    # Iterate over the functions in the namespace.
    @_iterate_fns @_fns[namespace], args, -> callback()
  
  
  # (namespace, fn, multiple) ->
  #
  # Params:
  #   namespace: The namespace to check for the function.
  #   fn: The function to remove.
  #   multiple: Optional. If true, all copies of the given `fn` will
  #     be removed **from the given namespace**. Not all namespaces.
  #     .. this may change in the future.. hard to say.
  #
  # Desc:
  #   Remove a function from the given namespace.
  remove: (namespace, fn, multiple=false) =>
    if not @_fns[namespace]?
      return
    
    for index in [0...@_fns[namespace].length]
      [f, options] = @_fns[namespace][index]
      if fn is f
        @_fns[namespace].splice index, 1
        if not multiple
          break



# Desc:
#   A wrapper class for Emighter, so that it hides all non-public methods
#   within the `@__emighter` object. Note that these are still "public".
class EmighterNamespaced
  constructor: ->
    @__emighter = new Emighter()
  
  on: (args...) => @__emighter.on args...
  
  emit: (args...) => @__emighter.emit args...
  
  remove: (args...) => @__emighter.remove args...




exports.create = create
exports.Emighter = Emighter
exports.EmighterNamespaced = EmighterNamespaced
