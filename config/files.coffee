# Exports a function which returns an object that overrides the default &
#   plugin file patterns (used widely through the app configuration)
#
# To see the default definitions for Lineman's file paths and globs, see:
#
#   - https://github.com/testdouble/lineman/blob/master/config/files.coffee
#

module.exports = (lineman) ->


  js:
    spec: [
      "spec/**/*.js",
      "!spec/prereq/**"
    ]
    specHelpers: [
      "spec/helpers/jasmine-matcher-wrapper.js",
      "spec/helpers/**/*.js"
    ]
    vendor: []

  coffee:
    spec: [
      "spec/**/*.coffee",
      "!spec/prereq/**"
    ]

