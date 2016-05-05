const path = require('path');
const config = require('./config');
const webpack = require('webpack');
const merge = require('lodash/object/merge');
const webpackBaseConfig = require('./webpack.base.config');

module.exports = merge(webpackBaseConfig, {
  devtool: '#eval-source-map',
  plugins: [
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin(),
  ],
  cache: true,
  debug: true,
  stats: {
    colors: true,
    reasons: true,
    hash: false,
    version: false,
    timings: true,
    chunks: false,
    chunkModules: false,
    cached: false,
    cachedAssets: false,
  }
});
