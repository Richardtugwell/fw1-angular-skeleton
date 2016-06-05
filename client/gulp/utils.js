var wrench    = require('wrench');

var readDir =  function(path) {
    return wrench.readdirSyncRecursive(path).filter(function(file) {
      return (/\.(js|coffee)$/i).test(file);
    })
};

module.exports = {
    readDir: readDir
};
