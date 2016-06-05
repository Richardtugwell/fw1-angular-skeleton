var gulp        = require('gulp');
var sequence    = require('run-sequence');
var utils       = require('./gulp/utils');
//config contains all constants and variables - passed to all tasks. Also parses command parms
var config = require('./gulp/config');

//recursively imports all task modules
utils.readDir(config.TASKDIR)
    .map(function(file) {
        require(config.TASKDIR + file)(config);
    });

// (re)Build the target folder by running the defined tasks
gulp.task('build', ['sass', 'javascript', 'templates', 'copy'] );

// default task cleans target drectory, builds source, starts server and watches source for changes
gulp.task('default',  function () {
    sequence('clean', 'build' );
    // watch could be more granular if running tasks gets lengthy
    gulp.watch(config.WATCH.sass, ['sass']);
    gulp.watch(config.WATCH.javascript, ['javascript']);
    gulp.watch(config.WATCH.templates, ['templates']);
})
