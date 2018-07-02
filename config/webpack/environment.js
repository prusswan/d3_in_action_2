const { environment } = require('@rails/webpacker')
const { resolve } = require('path')

const basePath = resolve(".");

// environment.config.set('resolve.modules', basePath + '/node_modules')
// environment.config.set('resolve.mainFields', ['module', 'main']) //, 'main', 'browser'])

environment.resolvedModules.prepend('root', basePath + '/node_modules')
module.exports = environment

console.log("basePath", basePath);
console.log("webpack config", environment);
