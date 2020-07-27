module.exports = {
  module: {
    loaders: [
      // Files with the .eco extension will use the eco-loader.
      {
        test: /\.eco$/,
        loader: 'eco-loader'
      }
    ]
  },
  resolve: {
    // .eco added to the default extensions.
    extensions: ['.eco']
  }
};