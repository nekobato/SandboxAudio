const config = require('../config');
const browserSync = require('browser-sync');
const webpackDevMiddleware = require('webpack-dev-middleware');
const webpackHotMiddleware = require('webpack-hot-middleware');

module.exports = function() {

  const browser = browserSync.create();
  const webpackConfig = require('../webpack.dev.config');
  const compiler = require('webpack')(webpackConfig);

  browser.init({
    ui: false,
    notify: false,
    ghostMode: false,
    open: false,
    port: 3030,
    proxy: {
      target: 'http://localhost:3000',
      middleware: [
        webpackDevMiddleware(compiler, {
          publicPath: webpackConfig.output.publicPath,
          stats: webpackConfig.stats
        }),
        webpackHotMiddleware(compiler),
      ]
    },
    files: [
      'assets/**/*'
    ],
  });
};
