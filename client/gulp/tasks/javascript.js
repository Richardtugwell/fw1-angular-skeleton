var gulp            = require('gulp');
var path            = require('path');
var $               = require('gulp-load-plugins')();

// Combine JavaScript into one file
// In production, the file is minified
module.exports = function(config) {

    gulp.task('javascript', ['javascript:bootstrap', 'javascript:common', 'javascript:applications']);

    gulp.task('javascript:bootstrap', function () {
        var uglify = $.if(config.isProduction, $.uglify()
            .on('error', function (e) {
                console.log(e);
            }));
        return gulp.src(config.SOURCE.javascript)
            .pipe($.sourcemaps.init())
            .pipe($.concat('app.js'))
            .pipe(uglify)
            .pipe($.if(!config.isProduction, $.sourcemaps.write()))
            .pipe(gulp.dest(config.TARGET.assets + '/js'))
    });

    gulp.task('javascript:common', function () {
        var uglify = $.if(config.isProduction, $.uglify()
            .on('error', function (e) {
                console.log(e);
            }));
        return gulp.src([ // Concatenate app js in correct order
            'src/common/common.module.js',
            'src/common/common.constants.js',
            '!src/common/{config,components,services,directives}/**/*.spec.js',
            'src/common/{config,components,services,directives}/**/*.js'
            ]
            )
            .pipe($.sourcemaps.init())
            .pipe($.concat('app.common.js'))
            .pipe(uglify)
            .pipe($.if(!config.isProduction, $.sourcemaps.write()))
            .pipe(gulp.dest(config.TARGET.assets + '/js'))
    });

    gulp.task('javascript:applications', $.folders(config.SOURCE.apps, function(folder){

        var uglify = $.if(config.isProduction, $.uglify()
            .on('error', function (e) {
                console.log(e);
            }));
        return gulp.src([ // Concatenate app js in correct order
                '!src/apps/**/*.spec.js',
                path.join(config.SOURCE.apps, folder, folder + '.module.js'),
                path.join(config.SOURCE.apps, folder, folder + '.constants.js'),
                path.join(config.SOURCE.apps, folder, folder + '.pagecontroller.js'),
                path.join(config.SOURCE.apps, folder, '{config,components,services,directives}/**/*.js')
            ]
            )
            .pipe($.sourcemaps.init())
            .pipe($.concat('app.' + folder + '.js'))
            .pipe(uglify)
            .pipe($.if(!config.isProduction, $.sourcemaps.write()))
            .pipe(gulp.dest(config.TARGET.assets + '/js'))

    }));

};
