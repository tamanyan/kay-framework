module.exports = (grunt)->
  
  grunt.task.loadNpmTasks 'grunt-contrib-connect'
  grunt.task.loadNpmTasks 'grunt-open'
  grunt.task.loadNpmTasks 'grunt-contrib-sass'
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
        files: "files/scss/*.scss"
        tasks: ["compass"]
      coffee:
        files: "files/coffee/*.coffee"
        tasks: [
          "coffee"
          "concat"
          "uglify"
          "copy"
        ]
      javascript:
        files: "files/js/*.js"
        tasks: [
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
      login:
        src: [
          "files/js/lib/index.js",
        ]
        dest: "files/js/login.js"
    uglify:
      index:
        src:'files/js/index.js'
        dest:'../media/js/index.min.js'
      login:
        src:'files/js/login.js'
        dest:'../media/js/login.min.js'
    sass:
      dist:
        options:
          style: 'expanded'
          compass: true
        files:
          '../media/css/login.min.css': 'files/scss/login.scss'
          '../media/css/index.min.css': 'files/scss/index.scss'
    copy:
      js:
        files: [
          expand: true
          cwd: 'files/js/'
          src: [
            'index.js',
            'login.js'
          ]
          dest: '../media/js'
        ]

  grunt.registerTask('default', ['watch','compass','coffee','concat','uglify','sass','copy'])
  grunt.registerTask 'build', 'build task.', () ->
    grunt.task.run('compass','coffee','concat','uglify','sass','copy')
