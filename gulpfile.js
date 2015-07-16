'use strict';

var gulp = require('gulp');

// Load plugins
var $ = require('gulp-load-plugins')();
var please = require('gulp-pleeease');
var sourcemaps = require('gulp-sourcemaps');
var browserify = require('browserify');
var watchify = require('watchify');
var source = require('vinyl-source-stream'),
    sourceFile = './app/scripts/app.coffee';

gulp.task('css-prod', function(){
  gulp.src('./web/src/**/*.less')
  .pipe(please({
    less: true,
    autoprefixer: { "browsers": ["> 5%"] },
    minifier: true,
    sourcemaps: {
      map: {
        inline: false
      }
    },
    out: 'style.min.css'
  }))
  .pipe(gulp.dest('./web/dist/styles'));
});

gulp.task('css', ['css-prod']);
