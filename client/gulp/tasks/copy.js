var gulp = require('gulp');
var $       = require('gulp-load-plugins')();

// Copy files out of the assets folder
// This task skips over the "img", "js", and "scss" folders, which are parsed separately
module.exports = function(config) {

    gulp.task('copy', ['copy:fonts'] );

    gulp.task('copy:fonts', function () {
        return gulp.src(config.SOURCE.fonts)
            .pipe(gulp.dest(config.TARGET.assets + '/fonts/bootstrap'));
    });



};
