const gulp = require('gulp');

gulp.task('serve', require('./build/gulptasks/serve'));
gulp.task('browser-sync', require('./build/gulptasks/browser-sync'));

gulp.task('default', ['browser-sync', 'serve']);
