const neostandard = require('neostandard')

module.exports = [
  {
    ignores: ['coverage/**', 'test/output*', 'test/*.html']
  },
  ...neostandard(),
  {
    languageOptions: {
      parserOptions: {
        requireConfigFile: false
      }
    }
  }
]
