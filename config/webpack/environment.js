const {
  environment
} = require('@rails/webpacker')
const webpack = require('webpack')
const coffee = require('./loaders/coffee')
const sourceMap = require('./loaders/source-map-loader')

environment.loaders.prepend('coffee', coffee)
environment.loaders.prepend('source-map-loader', sourceMap)
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    _: 'underscore/underscore'
  })
)
module.exports = environment