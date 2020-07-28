const {
  environment
} = require('@rails/webpacker')
const webpack = require('webpack')
const coffee = require('./loaders/coffee')
const eco = require('./loaders/eco')

environment.loaders.prepend('coffee', coffee)
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    _: 'underscore/underscore'
  })
)
module.exports = environment