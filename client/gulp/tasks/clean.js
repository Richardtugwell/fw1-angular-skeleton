var gulp    = require('gulp');
var del     = require('del');
// Delete the target assets folder
// This happens every time a build starts
module.exports = function(config) {
    gulp.task('clean', function () {
        return del(
            config.TARGET.assets, {force: true}
        );
    })
};
