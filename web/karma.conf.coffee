module.exports = (config) ->
  config.set
    basePath: './'
    frameworks: ['jasmine', 'commonjs']
    # browsers: ['Chrome']
    plugins: [
      'karma-jasmine',
      'karma-chrome-launcher'
    ]
    files: [
      'web/unit/**/*_test.coffee'
    ]
    preprocessors: {
      '**/*_test.coffee': ['commonjs']
    },
