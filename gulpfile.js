var gulp         = require('gulp');
var gcoffee      = require('gulp-coffee');
var gconcat      = require('gulp-concat');
var gconnect     = require('gulp-connect');
var gif          = require('gulp-if');
var gjade        = require('gulp-jade');
var gjst         = require('gulp-jst-concat');
var gless        = require('gulp-less');
var gmaps        = require('gulp-sourcemaps');
var grename      = require('gulp-rename');
var guglify      = require('gulp-uglify');
var gutil        = require('gulp-util');

gulp.task('connect', function() {
  gconnect.server({
    root: 'build',
    livereload: true
  });
});

var paths = {
  scripts: [
              'bower_components/modernizr/modernizr.js',
              'bower_components/lodash/dist/lodash.js',
              'bower_components/jquery/dist/jquery.js',
              'bower_components/sifter/sifter.js',
              'bower_components/microplugin/src/microplugin.js',
              'bower_components/selectize/dist/js/selectize.js',
              'bower_components/backbone/backbone.js',
              'bower_components/backbone.marionette/lib/backbone.marionette.js',
              'src/scripts/extensions/*.coffee',
              'src/scripts/application.coffee',
              'src/scripts/models/model.coffee',
              'src/scripts/models/unit.coffee',
              'src/scripts/models/measurement.coffee',
              'src/scripts/models/calculation.coffee',
              'src/scripts/views/value_picker_view.coffee',
              'src/scripts/views/unit_view.coffee',
              'src/scripts/views/measurement_view.coffee',
              'src/scripts/views/calculation_view.coffee',
              'src/scripts/collections/*.coffee',
              'tmp/templates.js'
            ]
}

gulp.task('scripts', function() {
  gulp.src(paths.scripts)
      .pipe(gmaps.init())
      .pipe(gif(/[.]coffee$/, gcoffee({ bare: true }).on('error', function(err) {
            gutil.log(gutil.colors.red(err))
      })))
      // .pipe(guglify())
      .pipe(gconcat('application.js'))
      .pipe(gmaps.write())
      .pipe(gulp.dest('build/scripts'))
      .pipe(gconnect.reload());
});

// Precompile gjade templates into a JST
gulp.task('templates', function(){
  gulp.src(['src/templates/**/*.jade'])
    .pipe(gjade().on('error', function (err) {
      gutil.log(gutil.colors.red(err))
    }))
    .pipe(gjst('templates.js', { renameKeys: ['^.*templates/(.*).html$', '$1'] }))
    .pipe(gulp.dest('tmp/'));
});

gulp.task('styles', function() {
  gulp.src(['src/styles/**/*.{css,less}'])
      .pipe(gmaps.init())
      .pipe(gless().on('error', function(err){
        gutil.log(gutil.colors.red(err.message))
      }))
      .pipe(gmaps.write())
      .pipe(gulp.dest('build/styles'))
      .pipe(gconnect.reload());
});

gulp.task('content', function() {
  gulp.src(['src/content/**/*.jade', '!src/content/layouts/**'])
      .pipe(gjade().on('error', function(err){
        gutil.log(gutil.colors.red(err))
      }))
      .pipe(gulp.dest('build'))
      .pipe(gconnect.reload());
});

gulp.task('build',['content','styles','templates','scripts']);

gulp.task('watch', function() {
  gulp.watch(['src/content/**'],['content']);
  gulp.watch(['src/styes/**'],['styles']);
  gulp.watch(['src/templates/**'],['templates'])
  gulp.watch(paths.scripts,['scripts']);
});

gulp.task('default',['connect','build','watch']);