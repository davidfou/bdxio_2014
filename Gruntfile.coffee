module.exports = (grunt) ->

  grunt.initConfig
    clean: ["<%= dir.public %>"]

    dir:
      src_javascript : "assets/js/"
      public         : "public/"

    requirejs:
      compile:
        options:
          baseUrl: "<%= dir.public + dir.src_javascript %>"
          out: '<%= dir.public + dir.src_javascript %>application.js'
          optimize: "uglify2"
          cjsTranslate: false
          generateSourceMaps: true
          preserveLicenseComments: false
          name: "main"
          insertRequire: ['main']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'

