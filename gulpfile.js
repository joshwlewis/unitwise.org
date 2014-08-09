var gulp         = require('gulp');
var gcoffee      = require('gulp-coffee');
var gconcat      = require('gulp-concat');
var gconnect     = require('gulp-connect');
var gif          = require('gulp-if');
var gjade        = require('gulp-jade');
var gjst         = require('gulp-jst-concat');
var gless        = require('gulp-less');
var gmaps        = require('gulp-sourcemaps');
var gmin         = require('gulp-minify-css');
var gpages       = require("gulp-gh-pages");
var grename      = require('gulp-rename');
var gdel         = require('del');
var guglify      = require('gulp-uglify');
var gutil        = require('gulp-util');

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
              'src/scripts/views/unit_view.coffee',
              'src/scripts/views/measurement/show.coffee',
              'src/scripts/views/measurement/edit.coffee',
              'src/scripts/views/calculation_view.coffee',
              'src/scripts/collections/*.coffee',
              'tmp/templates.js'
            ]
}

gulp.task('connect', function() {
  gconnect.server({
    root: 'build',
    livereload: true
  });
});

gulp.task('clean', function() {
  gdel(['build/**/*', 'dist/**/*'], function(){})
});

gulp.task('build-images', function() {
  gulp.src('src/images/**/*')
      .pipe(gulp.dest('build/images'))
});

gulp.task('compile-images', function() {
  gulp.src('src/images/**/*')
      .pipe(gulp.dest('dist/images'))
});

gulp.task('build-scripts', function() {
  gulp.src(paths.scripts)
      .pipe(gmaps.init())
      .pipe(gif(/[.]coffee$/, gcoffee({ bare: true }).on('error', function(err) {
            gutil.log(gutil.colors.red(err))
      })))
      .pipe(gconcat('application.js'))
      .pipe(gmaps.write())
      .pipe(gulp.dest('build/scripts'))
      .pipe(gconnect.reload());
});

gulp.task('compile-scripts', function() {
  gulp.src(paths.scripts)
      .pipe(gif(/[.]coffee$/, gcoffee({ bare: true })))
      .pipe(gconcat('application.js'))
      .pipe(guglify())
      .pipe(gulp.dest('dist/scripts'))
});

// Precompile jade templates into a JST
gulp.task('templates', function(){
  gulp.src(['src/templates/**/*.jade'])
    .pipe(gjade().on('error', function (err) {
      gutil.log(gutil.colors.red(err))
    }))
    .pipe(gjst('templates.js', { renameKeys: ['^.*templates/(.*).html$', '$1'] }))
    .pipe(gulp.dest('tmp/'));
});

gulp.task('build-styles', function() {
  gulp.src(['src/styles/**/*.{css,less}'])
      .pipe(gmaps.init())
      .pipe(gless().on('error', function(err){
        gutil.log(gutil.colors.red(err.message))
      }))
      .pipe(gmaps.write())
      .pipe(gulp.dest('build/styles'))
      .pipe(gconnect.reload());
});

gulp.task('compile-styles', function() {
  gulp.src(['src/styles/**/*.{css,less}'])
      .pipe(gless())
      .pipe(gmin({keepSpecialComments: false}))
      .pipe(gulp.dest('dist/styles'))
});

gulp.task('build-content', function() {
  gulp.src(['src/content/**/*.jade', '!src/content/layouts/**'])
      .pipe(gjade().on('error', function(err){
        gutil.log(gutil.colors.red(err))
      }))
      .pipe(gulp.dest('build'))
      .pipe(gconnect.reload());
});

gulp.task('compile-content', function() {
  gulp.src(['src/content/**/*.jade', '!src/content/layouts/**'])
      .pipe(gjade())
      .pipe(gulp.dest('dist'))
});


gulp.task('build',['templates','build-images','build-content','build-styles','build-scripts']);
gulp.task('compile', ['templates','compile-images','compile-content','compile-styles','compile-scripts']);

gulp.task('watch', function() {
  gulp.watch(['src/images/**'],['build-images']);
  gulp.watch(['src/templates/**'],['templates']);
  gulp.watch(['src/content/**'],['build-content']);
  gulp.watch(['src/styles/**'],['build-styles']);
  gulp.watch(paths.scripts,['build-scripts']);
});

gulp.task('deploy', function () {
    gulp.src("dist/**/*")
        .pipe(gpages());
});

gulp.task('default',['connect','build','watch']);