module.exports = (grunt) ->

  grunt.initConfig
    clean: ["<%= dir.public %>", "<%= dir.tmp_javascript %>"]

    env: "development"
    dir:
      src            : "src/"
      src_javascript : "assets/js/"
      src_templates  : "assets/templates/"
      src_css        : "assets/css/"
      src_img        : "assets/img/"
      tmp_javascript : "tmp/js/"
      public         : "public/"
      vendor         : grunt.file.readJSON(".bowerrc").directory
      resources      : "resources/"

    concat:
      javascript:
        src: [
          "<%= dir.vendor %>jquery/dist/jquery.js"
          "<%= dir.vendor %>jquery-ui/jquery-ui.js"
          "<%= dir.resources %>json2.js"
          "<%= dir.vendor %>underscore/underscore.js"
          "<%= dir.vendor %>backbone/backbone.js"
          "<%= dir.vendor %>backbone.picky/lib/backbone.picky.js"
          "<%= dir.vendor %>backbone.syphon/lib/backbone.syphon.js"
          "<%= dir.vendor %>backbone.localstorage/backbone.localstorage.js"
          "<%= dir.vendor %>marionette/lib/backbone.marionette.js"
          "<%= dir.vendor %>spin.js/spin.js"
          "<%= dir.resources %>spin.jquery.js"
          "<%= dir.tmp_javascript %>templates.js"
          "<%= dir.vendor %>requirejs/require.js"
          "<%= dir.tmp_javascript %>config.js"
        ]
        dest: "<%= dir.public + dir.src_javascript %>application.js"
      build:
        src: [
          "<%= dir.vendor %>jquery/dist/jquery.js"
          "<%= dir.vendor %>jquery-ui/jquery-ui.js"
          "<%= dir.resources %>json2.js"
          "<%= dir.vendor %>underscore/underscore.js"
          "<%= dir.vendor %>backbone/backbone.js"
          "<%= dir.vendor %>backbone.picky/lib/backbone.picky.js"
          "<%= dir.vendor %>backbone.syphon/lib/backbone.syphon.js"
          "<%= dir.vendor %>backbone.localstorage/backbone.localstorage.js"
          "<%= dir.vendor %>marionette/lib/backbone.marionette.js"
          "<%= dir.vendor %>spin.js/spin.js"
          "<%= dir.resources %>spin.jquery.js"
          "<%= dir.tmp_javascript %>templates.js"
          "<%= dir.vendor %>almond/almond.js"
        ]
        dest: "<%= dir.public + dir.src_javascript %>vendor.js"

    copy:
      html:
        files: [
          expand: true
          cwd: "<%= dir.src %>"
          src: ["index.html"]
          dest: "<%= dir.public %>"
        ]
      css:
        files: [
          expand: true
          cwd: "<%= dir.src + dir.src_css %>"
          src: ["**"]
          dest: "<%= dir.public + dir.src_css %>"
        ]
      img:
        files: [
          expand: true
          cwd: "<%= dir.src + dir.src_img %>"
          src: ["**"]
          dest: "<%= dir.public + dir.src_img %>"
        ]
      js:
        files: [
          expand: true
          cwd: "<%= dir.src + dir.src_javascript %>"
          src: ["**/*.js"]
          dest: "<%= dir.tmp_javascript %>"
        ]

    coffee:
      src:
        options:
          bare: true
        expand: true
        cwd: "<%= dir.src + dir.src_javascript %>"
        src: ["**/*.coffee"]
        dest: "<%= dir.tmp_javascript %>"
        ext: '.js'

    transpile:
      src:
        type: "amd"
        files: [
          expand: true
          cwd: "<%= dir.tmp_javascript %>"
          src: ['**/*.js', '!config.js']
          dest: "<%= dir.public + dir.src_javascript %>"
        ]

    jst:
      compile:
        options:
          processName: (name) ->
            reg = new RegExp("^#{grunt.config("dir.src") + grunt.config("dir.src_templates")}(.*)\.html$")
            name.match(reg)[1]
        files:
          "<%= dir.tmp_javascript %>templates.js" : ["<%= dir.src + dir.src_templates %>**/*.html"]

    watch:
      all:
        options:
          atBegin: true
          livereload: true
        files: ["src/**/*"]
        tasks: ["compile", "concat:javascript"]

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

    preprocess:
      html:
        options:
          inline: true
          context:
            ENV: "<%= env %>"
        src: ["<%= dir.public %>index.html"]



  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jst'
  grunt.loadNpmTasks 'grunt-es6-module-transpiler'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-preprocess'

  grunt.registerTask 'compile', ['clean', 'coffee', 'jst', 'copy', 'transpile', 'preprocess']
  grunt.registerTask 'default', ['watch']
  grunt.registerTask 'build'  , ->
    grunt.config 'env', 'production'
    grunt.task.run ['compile', 'requirejs', 'concat:build']
