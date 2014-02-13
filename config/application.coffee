# Exports a function which returns an object that overrides the default &
#   plugin grunt configuration object.
#
# You can familiarize yourself with Lineman's defaults by checking out:
#
#   - https://github.com/testdouble/lineman/blob/master/config/application.coffee
#   - https://github.com/testdouble/lineman/blob/master/config/plugins
#
# You can also ask Lineman's about config from the command line:
#
#   $ lineman config #=> to print the entire config
#   $ lineman config concat.js #=> to see the JS config for the concat task.
#
# lineman-lib-template config options can be found in "config/lib.json"

libConfig = require('./lib')

module.exports = (lineman) ->
  _ = require("underscore")
  app = lineman.config.application
  grunt = lineman.grunt

  # We want to include matcher wrapper ahead of given.
  concat:
    uncompressedDist:
      src: _(app.concat.uncompressedDist.src).without("<%= files.coffee.generated %>").concat("<%= files.coffee.generated %>")

  loadNpmTasks: app.loadNpmTasks.concat("grunt-jasmine-bundle")

  removeTasks:
    common: ["jshint"]

  hooks:
    loadNpmTasks:
      afterLoad:
        "grunt-jasmine-bundle": ->
          grunt.renameTask("spec", "nodeSpec")

  nodeSpec:
    e2e:
      options:
        minijasminenode:
          showColors: true
        helpers: "spec-e2e/helpers/**/*.{js,coffee}"
        specs: ["spec-e2e/**/*.{js,coffee}", "!spec-e2e/tmp/**"]

