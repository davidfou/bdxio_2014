module.exports = (grunt) ->

  grunt.initConfig
    clean: ["<%= dir.public %>", "<%= dir.tmp_javascript %>"]

    dir:
      src            : "src/"
      src_javascript : "assets/js/"
      src_css        : "assets/css/"
      src_img        : "assets/img/"
      tmp_javascript : "tmp/js/"
      public         : "public/"

    concat:
      javascript:
        src: [
          "<%= dir.tmp_javascript %>vendor/jquery.js"
          "<%= dir.tmp_javascript %>vendor/jquery-ui-1.10.3.js"
          "<%= dir.tmp_javascript %>vendor/json2.js"
          "<%= dir.tmp_javascript %>vendor/underscore.js"
          "<%= dir.tmp_javascript %>vendor/backbone.js"
          "<%= dir.tmp_javascript %>vendor/backbone.picky.js"
          "<%= dir.tmp_javascript %>vendor/backbone.syphon.js"
          "<%= dir.tmp_javascript %>vendor/backbone.localstorage.js"
          "<%= dir.tmp_javascript %>vendor/backbone.marionette.js"
          "<%= dir.tmp_javascript %>vendor/spin.js"
          "<%= dir.tmp_javascript %>vendor/spin.jquery.js"
          "<%= dir.tmp_javascript %>apps/config/marionette/regions/dialog.js"
          "<%= dir.tmp_javascript %>app.js"
          "<%= dir.tmp_javascript %>apps/config/storage/localstorage.js"
          "<%= dir.tmp_javascript %>entities/common.js"
          "<%= dir.tmp_javascript %>entities/header.js"
          "<%= dir.tmp_javascript %>entities/contact.js"
          "<%= dir.tmp_javascript %>common/views.js"
          "<%= dir.tmp_javascript %>apps/contacts/contacts_app.js"
          "<%= dir.tmp_javascript %>apps/contacts/common/views.js"
          "<%= dir.tmp_javascript %>apps/contacts/list/list_view.js"
          "<%= dir.tmp_javascript %>apps/contacts/list/list_controller.js"
          "<%= dir.tmp_javascript %>apps/contacts/show/show_view.js"
          "<%= dir.tmp_javascript %>apps/contacts/show/show_controller.js"
          "<%= dir.tmp_javascript %>apps/contacts/edit/edit_view.js"
          "<%= dir.tmp_javascript %>apps/contacts/edit/edit_controller.js"
          "<%= dir.tmp_javascript %>apps/contacts/new/new_view.js"
          "<%= dir.tmp_javascript %>apps/about/about_app.js"
          "<%= dir.tmp_javascript %>apps/about/show/show_view.js"
          "<%= dir.tmp_javascript %>apps/about/show/show_controller.js"
          "<%= dir.tmp_javascript %>apps/header/header_app.js"
          "<%= dir.tmp_javascript %>apps/header/list/list_view.js"
          "<%= dir.tmp_javascript %>apps/header/list/list_controller.js"
        ]
        dest: "<%= dir.public + dir.src_javascript %>app.js"

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

    watch:
      all:
        options:
          atBegin: true
          livereload: true
        files: ["src/**/*"]
        tasks: ["clean", "coffee", "copy", "concat"]

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['watch']
