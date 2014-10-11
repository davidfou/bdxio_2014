module.exports = (grunt) ->

  grunt.initConfig
    clean: ["public"]

    concat:
      javascript:
        src: [
          "src/assets/js/vendor/jquery.js"
          "src/assets/js/vendor/jquery-ui-1.10.3.js"
          "src/assets/js/vendor/json2.js"
          "src/assets/js/vendor/underscore.js"
          "src/assets/js/vendor/backbone.js"
          "src/assets/js/vendor/backbone.picky.js"
          "src/assets/js/vendor/backbone.syphon.js"
          "src/assets/js/vendor/backbone.localstorage.js"
          "src/assets/js/vendor/backbone.marionette.js"
          "src/assets/js/vendor/spin.js"
          "src/assets/js/vendor/spin.jquery.js"
          "src/assets/js/apps/config/marionette/regions/dialog.js"
          "src/assets/js/app.js"
          "src/assets/js/apps/config/storage/localstorage.js"
          "src/assets/js/entities/common.js"
          "src/assets/js/entities/header.js"
          "src/assets/js/entities/contact.js"
          "src/assets/js/common/views.js"
          "src/assets/js/apps/contacts/contacts_app.js"
          "src/assets/js/apps/contacts/common/views.js"
          "src/assets/js/apps/contacts/list/list_view.js"
          "src/assets/js/apps/contacts/list/list_controller.js"
          "src/assets/js/apps/contacts/show/show_view.js"
          "src/assets/js/apps/contacts/show/show_controller.js"
          "src/assets/js/apps/contacts/edit/edit_view.js"
          "src/assets/js/apps/contacts/edit/edit_controller.js"
          "src/assets/js/apps/contacts/new/new_view.js"
          "src/assets/js/apps/about/about_app.js"
          "src/assets/js/apps/about/show/show_view.js"
          "src/assets/js/apps/about/show/show_controller.js"
          "src/assets/js/apps/header/header_app.js"
          "src/assets/js/apps/header/list/list_view.js"
          "src/assets/js/apps/header/list/list_controller.js"
        ]
        dest: "public/assets/js/app.js"

    copy:
      html:
        files: [
          src: ["src/index.html"]
          dest: "public/index.html"
        ]
      css:
        files: [
          expand: true
          cwd: "src/assets/css/"
          src: ["**"]
          dest: "public/assets/css"
        ]
      img:
        files: [
          expand: true
          cwd: "src/assets/img/"
          src: ["**"]
          dest: "public/assets/img"
        ]

    watch:
      all:
        options:
          atBegin: true
          livereload: true
        files: ["src/**/*"]
        tasks: ["clean", "copy", "concat"]

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['watch']
