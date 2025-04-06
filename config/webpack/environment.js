const { environment } = require('@rails/webpacker')

module.exports = environment

// Bootstrap用に追記 2025/4/6
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)