const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig(
  {
    transpileDependencies: true,
    chainWebpack : (config) => {
      config.output.filename('[name].js');
    },
    css: {
      extract: {
        filename: '[name].css',
        chunkFilename: '[name].css'
      }
    },
    publicPath: '/modules/searchstax_studio_vue/dist/'
  }
)
