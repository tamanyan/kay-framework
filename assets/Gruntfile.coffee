module.exports = (grunt)->
  
  grunt.task.loadNpmTasks 'grunt-contrib-connect'
  grunt.task.loadNpmTasks 'grunt-open'
  grunt.task.loadNpmTasks "grunt-contrib-concat"
  grunt.task.loadNpmTasks "grunt-contrib-coffee"
  grunt.task.loadNpmTasks "grunt-contrib-watch"
  grunt.task.loadNpmTasks "grunt-contrib-compass"
  grunt.task.loadNpmTasks "grunt-contrib-uglify"
  grunt.task.loadNpmTasks "grunt-contrib-copy"

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    all:
      tasks: ['coffee', 'concat', 'uglify']
      options:
        interrupt: yes
    connect:
      livereload:
        options:
          port: 9001
    open:
      server:
        path: "http://localhost:<%= connect.livereload.options.port %>"
    watch:
      html:
        files: "files/*.html"
        tasks: []
      sass:
        files: "files/sass/*.scss"
        tasks: ["compass"]
      scripts:
        files: "files/coffee/*.coffee"
        tasks: [
          "coffee"
          "concat"
          "uglify"
          "copy"
        ]
      options:
        livereload: true
        nospawn: true
    compass:
      dist:
        options:
          config: "config.rb"
    coffee:
      compile:
        files: [
          cwd: './files/coffee'
          expand: true
          src: ['*.coffee']
          dest: './files/js'
          ext: '.js'
        ]
        options:
          bare: true
    concat:
        dist:
          src: [
            "files/js/index.js",
          ]
          dest: "files/js/test.js"
    uglify:
      dist:
        src:'files/js/test.js'
        dest:'files/js/test.min.js'
    copy:
      js:
        files: [
          expand: true
          cwd: 'files/js/'
          src: ['index.js']
          dest: '../media/js'
        ]

  grunt.registerTask('default', ['watch','compass','concat','uglify','coffee', 'copy'])
  grunt.registerTask 'build', 'build task.', () ->
    grunt.task.run('compass', 'coffee', 'concat', 'uglify', 'copy')
