var gulp            = require('gulp');
var path            = require('path');
var $               = require('gulp-load-plugins')();
// In production, the CSS is compressed
module.exports = function(config) {

    gulp.task('templates', ['templates:applications', 'templates:common']);

    gulp.task('templates:applications', $.folders(config.SOURCE.apps, function(folder){

        return gulp.src(path.join(config.SOURCE.apps, folder, '**/*.html'))

        .pipe($.ngHtml2js({
          prefix: folder + '/',
          moduleName: folder,
          declareModule: false
        }))
        .pipe($.uglify())
        .pipe($.concat('app.' + folder + '.templates.js'))
        .pipe(gulp.dest(config.TARGET.assets + '/js'))
    }));

    gulp.task('templates:common', function() {

        return gulp.src('src/common/**/*.html')

        .pipe($.ngHtml2js({
          prefix: 'common/',
          moduleName: 'common',
          declareModule: false
        }))
        .pipe($.uglify())
        .pipe($.concat('app.common.templates.js'))
        .pipe(gulp.dest(config.TARGET.assets + '/js'))
    });


};
