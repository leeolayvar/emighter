#
# lib/index.coffee
#
# Copyright (c) 2012 Lee Olayvar <leeolayvar@gmail.com>
# MIT Licensed
#
emighter = require './emighter'




exports = module.exports = emighter.create
exports.emighter = emighter
exports.Emighter = emighter.EmighterNamespaced
