var WebpackNotifierPlugin = require('webpack-notifier');

module.exports = {
  entry: {
    sunaba: "./src/sunaba"
  },
  output: {
    path: "./assets",
    filename: "[name].js",
    publicPath: "/assets/"
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /(node_modules|assets)/,
        loader: "babel"
      },
      {
        test: /\.jade$/,
        loader: "jade"
      },
      {
        test: /\.less$/,
        loader: "style!css!pleeease"
      },
      {
        test: /.*\.(gif|png|jpe?g|svg)$/i,
        loaders: 'file?name=./build/img/[hash].[ext]!img'
      }
    ]
  },
  pleeease: {
    less: true,
    autoprefixer: { browsers: ["last 2 versions"]},
    minifier: true,
    mqpacker: true
  },
  plugins: [
    new WebpackNotifierPlugin({title: 'Webpack'}),
  ],
  devtool: "#source-map"
}
