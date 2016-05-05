//
// このファイルは直接使わない
//

const path = require('path');
const config = require('./config');

module.exports = {
  entry: {
    main: path.join(config.dir.src, 'main'),
  },
  output: {
    publicPath: '/assets/',
    path: config.dir.dist,
    filename: '[name].js'
  },
  resolve: {
    extensions: ["", ".js", ".coffee"],
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        loader: 'babel',
        include: config.dir.src,
        exclude: /node_modules/,
        query: {
          presets: ['es2015']
        }
      },
      {
        test: /\.json$/,
        loader: 'json'
      },
      {
        test: /\.(png|jpe?g|gif|svg|woff2?|eot|ttf|otf)(\?.*)?$/,
        loader: 'url',
        query: {
          limit: 10000,
          name: path.join(config.dir.dist, '[name].[hash:7].[ext]')
        }
      }
    ]
  }
}
