const config = require('../config');
const nodemon = require('gulp-nodemon');
const browserSync = require('browser-sync');

function reload() {
  browserSync.reload({ stream: false });
};

module.exports = function(callback) {

  nodemon({
    script: './bin/www',
    ext: 'js coffee',
    watch: ['config', 'models', 'bin'],
    env: {
      'NODE_ENV': 'development',
      'PORT': 3000
    },
    stdout: false
  }).on('readable', function() {
  this.stdout.on('data', function(chunk) {
  if (/^Express\ server\ listening/.test(chunk)) {
        reload();
      }
      process.stdout.write(chunk);
    });
    this.stderr.on('data', function(chunk) {
      process.stderr.write(chunk);
    });
  });
};
