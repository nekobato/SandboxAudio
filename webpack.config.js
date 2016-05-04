var WebpackNotifierPlugin = require('webpack-notifier');
var webpack = require('webpack');
var path = require('path');

module.exports = {
  entry: [
    "./src/main"
  ],
  output: {
    path: "./assets",
    filename: "[name].js",
    publicPath: "/"
  },
  resolve: {
    extensions: ['', '.js', '.styl', '.jade']
  },
  module: {
    loaders: [
      {
        test: /\.(png|jpe?g|gif|svg|woff2?|eot|ttf|otf)(\?.*)?$/,
        loader: 'url',
        query: {
          limit: 10000,
          name: path.join('./', '[name].[hash:7].[ext]')
        }
      },
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel',
        query: {
          presets: ['es2015']
        }
      },
      {
        test: /\.json$/,
        loader: "json"
      },
      {
        test: /\.jade$/,
        loader: "jade"
      },
      {
        test: /\.styl$/,
        loader: "style!css!stylus"
      },
      {
        test: /\.css$/,
        loader: "style!css"
      }
    ]
  },
  plugins: [
    new WebpackNotifierPlugin({title: 'Webpack'})
  ],
  devtool: "#source-map",
  devServer: {
    contentBase: "./"
  }
}
