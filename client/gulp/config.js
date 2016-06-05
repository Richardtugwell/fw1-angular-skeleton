var argv        = require('yargs').argv;

// Check for --production flag
//TODO: should be in some kind of ENV implementation
var isProduction = !!(argv.production);

// Browsers to target when prefixing CSS.
var COMPATIBILITY = ['last 2 versions', 'ie >= 9'];

// File paths to various assets are defined here.
var SOURCE = {
    apps: 'src/apps/',
    common: 'src/common/',
    fonts: [
        'bower_components/bootstrap-sass/assets/fonts/bootstrap/**/*.*'
    ],
    appScss: 'src/assets/scss/app.scss',
    sass: [
        'bower_components/bootstrap-sass/assets/stylesheets',
        'bower_components/angularjs-toaster'
    ],
    apptemplates: [
        'src/apps/**/*.html'
    ],
    javascript: [
        'bower_components/fastclick/lib/fastclick.js',
        'bower_components/angular/angular.js',
        'bower_components/angular-sanitize/angular-sanitize.js',
        'bower_components/lodash/dist/lodash.js',
        'bower_components/restangular/dist/restangular.js',
        'bower_components/angular-animate/angular-animate.js',
        'bower_components/angular-messages/angular-messages.js',
        'bower_components/message-center/message-center.js',
        'bower_components/angularjs-toaster/toaster.js',
        'bower_components/angular-ui-router/release/angular-ui-router.js',
        'bower_components/angular-bootstrap/ui-bootstrap.js',
        'bower_components/angular-bootstrap/ui-bootstrap-tpls.js'
    ]
};

// File paths to WATCH.
var WATCH = {
    sass: [
        'src/assets/scss/**/*.scss',
        'src/common/**/*.scss',
        'src/apps/**/*.scss'
    ],
    javascript: [
        'src/assets/js/**/*.js',
        'src/apps/**/*.js',
        'src/common/**/*.js'
    ],
    templates: [
        'src/apps/**/*.html',
        'src/common/**/*.html'
    ]
};

// File paths to various targets.
var TARGET = {
    assets: '../server/application/webroot/assets'
};

// Config - gets passed to all tasks.
module.exports = {
    isProduction: isProduction,
    PORT: 8079,
    SERVERROOT: './build',
    TASKDIR: './gulp/tasks/',
    COMPATIBILITY: COMPATIBILITY,
    WATCH: WATCH,
    SOURCE: SOURCE,
    TARGET: TARGET
};
