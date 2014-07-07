var gulp         = require('gulp');
var sass         = require('gulp-sass');
var coffee       = require('gulp-coffee');
var jade         = require('gulp-jade');
var gutil        = require('gulp-util');
var connect      = require('gulp-connect');
var rename       = require('gulp-rename');
var jst          = require('gulp-jst-concat');

gulp.task('connect', function() {
  connect.server({
    root: 'build',
    livereload: true
  });
});

gulp.task('vendor', function() {
  gulp.src(['bower_components/modernizr/modernizr.js',
            'bower_components/jquery/dist/jquery.js',
            'bower_components/lodash/dist/lodash.js',
            'bower_components/backbone/backbone.js',
            'bower_components/backbone.marionette/lib/backbone.marionette.js'])
      .pipe(gulp.dest('build/scripts'))
})

gulp.task('scripts', function() {
  gulp.src(['src/scripts/**/*.coffee'])
      .pipe(coffee({ bare: true}).on('error', function(err) {
        gutil.log(gutil.colors.red(err))
      }))
      .pipe(gulp.dest('build/scripts'))
      .pipe(connect.reload());
});

// Precompile jade templates into a JST
gulp.task('templates', function(){
  gulp.src(['src/templates/**/*.jade'])
    .pipe(jade().on('error', function (err) {
      gutil.log(gutil.colors.red(err))
    }))
    .pipe(jst('templates.js', { renameKeys: ['^.*templates/(.*).html$', '$1'] }))
    .pipe(gulp.dest('build/scripts/'));
});

gulp.task('styles', function() {
  gulp.src(['src/styles/**/*.{scss,sass}'])
      .pipe(sass().on('error', function(err){
        gutil.log(gutil.colors.red(err.message))
      }))
      .pipe(gulp.dest('build/styles'))
      .pipe(connect.reload());
});

gulp.task('content', function() {
  gulp.src(['src/content/**/*.jade', '!src/content/layouts/**'])
      .pipe(jade().on('error', function(err){
        gutil.log(gutil.colors.red(err))
      }))
      .pipe(gulp.dest('build'))
      .pipe(connect.reload());
});

gulp.task('start',['vendor','content','styles','templates','scripts']);

gulp.task('watch', function() {
  gulp.watch(['bower_components/**'],['vendor']);
  gulp.watch(['src/content/**'],['content']);
  gulp.watch(['src/styes/**'],['styles']);
  gulp.watch(['src/templates/**'],['templates','scripts'])
  gulp.watch(['src/scripts/**'],['scripts']);
});

gulp.task('default',['connect','start','watch']);