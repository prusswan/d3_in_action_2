process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

const { resolve } = require('path')
const basePath = resolve(".");
console.log("basePath", basePath);

// environment.config.set('resolve.modules', basePath + '/node_modules')
// heroku: .heroku/node/lib/node_modules/
// environment.config.set('resolve.mainFields', ['module', 'main']) //, 'main', 'browser'])

environment.resolvedModules.prepend('root', basePath + '/node_modules')

module.exports = environment.toWebpackConfig()
