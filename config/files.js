/* Exports a function which returns an object that overrides the default &
 *   plugin file patterns (used widely through the app configuration)
 *
 * To see the default definitions for Lineman's file paths and globs, see:
 *
 *   - https://github.com/linemanjs/lineman/blob/master/config/files.coffee
 */
module.exports = function(lineman) {
  //Override file patterns here
  return {
    js: {
      vendor: [
        "vendor/js/jquery.js",
        "vendor/js/handlebars.runtime.js",
        "vendor/js/ember.js",
        "vendor/js/ember.oauth2.js",
        "vendor/js/ember.data.js",
        "vendor/js/**/*.js"
      ]
    }
  };
};
