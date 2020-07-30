module.exports = {
  rules: [{
    test: /\.js$/,
    enforce: 'pre',
    use: ['source-map-loader'],
  }, ],
};