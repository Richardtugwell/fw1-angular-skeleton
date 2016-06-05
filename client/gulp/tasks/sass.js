var gulp            = require('gulp');
var path            = require('path');
var $               = require('gulp-load-plugins')();
// Compile Sass into CSS
// This creates one css file for each src/apps/<app> folder, each including Bootstrap SASS files
// In production, the CSS is compressed
module.exports = function(config) {

    gulp.task('sass', $.folders(config.SOURCE.apps, function(folder){

        var minifycss = $.if(config.isProduction, $.cleanCss());

        var uncss = $.if(config.isProduction, $.uncss({
            html: ['src/**/*.html'],
            ignore: [
            ]
        }));

        var injectFiles = gulp.src([
          config.SOURCE.common + '/**/*.scss',
          config.SOURCE.apps + folder + '/**/*.scss'

        ], { read: false });

        var injectOptions = {
          transform: function(filePath) {
            return '@import \'' + filePath + '\';';
          },
          starttag: '// injector',
          endtag: '// endinjector',
          addRootSlash: false
        };

        return gulp.src(config.SOURCE.appScss)
            .pipe($.sourcemaps.init())
            .pipe($.inject(injectFiles, injectOptions))
            .pipe($.sass({
                    includePaths: config.SOURCE.sass
                })
                .on('error', $.sass.logError))
            .pipe($.autoprefixer({
                browsers: config.COMPATIBILITY
            }))
            .pipe($.concat('app.' + folder + '.css'))
            .pipe(minifycss)
            .pipe($.if(!config.isProduction, $.sourcemaps.write()))
            .pipe(gulp.dest(config.TARGET.assets + '/css'))

    }));
};
