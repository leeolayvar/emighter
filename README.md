
# Emighter.js - A simple async-ok event emitter.

## Description

Emighter.js is a simple, and very limited, event emitter. It's only notable
feature is that it is async-ok. That is to say, like Bork.js, if you define
callbacks for event receivers, the emit chain will hold until that callback
is called.

If you need more, for now at least, look elsewhere. No seriously, Emighter
probably isn't for you.

## Installation

If you insist, run this:

```bash
npm install emighter
```

## Examples

Subscribing to emighter events is as basic as you would expect,

```CoffeeScript
emitter.on 'foo', -> console.log 'Foo Called!'
emitter.on 'bar', -> console.log 'Bar Called!'
```

But you also have the option to define a callback function, or explicitly
define options.

```CoffeeScript
# Implicit
emighter.on 'foo', (done) -> console.log "I'm not going to callback"
emighter.on 'foo', -> console.log "I'll never be called, because ^he^ is lazy."

# Explicit
emighter.on 'bar', (-> console.log "I'm explicitly async!"), callback: true
emighter.on 'bar', console.log "I won't be called either :/"
```

And emitting events is also pretty basic, with one notable point. If the
2nd argument is a list, and the 3rd is a function, the 3rd becomes a callback
and the list becomes a list of arguments to pass. See below..

```CoffeeScript
# These examples do not define an emit callback.
emighter.emit 'foo', 1, 2, 3 # Calls `fn 1, 2, 3`
emighter.emit 'foo', [1], 2, 3 # Calls `fn [1], 2, 3`
emighter.emit 'foo', 1, (->), 3 # Calls `fn 1, (->), 3`

# This example defines an emit callback
emighter.emit 'foo', [1, 2, 3], (->) # Calls `fn 1, 2, 3`
emighter.emit 'foo', [], (-> console.log 'Emitter done!') # Calls `fn()`

# Note that additional arguments are added to the arg list.
emighter.emit 'foo', [1], (->), 2, 3 # Calls `fn 1, 2, 3`
emighter.emit 'foo', [], (->), 1, 2, 3 # Calls `fn 1, 2, 3`
```

And i think that sums Emighter up for now. There are currently no extras, such
as pattern matching namespaces, emitting multiple namespaces at once, and etc.
Like i said, you probably don't want to use this library.

## Author

  - Lee Olayvar &lt;leeolayvar@gmail.com&gt;

## License

The MIT License (MIT)

Copyright (C) 2012 Lee Olayvar &lt;leeolayvar@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.