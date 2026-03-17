const { defineConfig } = require('@vue/cli-service')
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin')




// const webpack = require('webpack');

module.exports = defineConfig({
  transpileDependencies: true,
  // 基本路径
  publicPath: './',
  lintOnSave: false,
  configureWebpack: {
    plugins: [new NodePolyfillPlugin()],
    // plugins: [
    //   new webpack.ProvidePlugin({
    //     process: 'process/browser', 
    //     Buffer: ['buffer', 'Buffer']
    //   })
    // ],
    resolve: {
      extensions: ['.ts', '.js'],
      fallback: {
        // "stream": require.resolve("stream-browserify"),
        "buffer": require.resolve("buffer")
      }
      // },
    }}

    // plugins: [
    //   // Work around for Buffer is undefined:
    //   // https://github.com/webpack/changelog-v5/issues/10
    //   new webpack.ProvidePlugin({
    //     Buffer: ['buffer', 'Buffer'],
    //   }),
    //   new webpack.ProvidePlugin({
    //     process: 'process/browser',
    //   }),
    // ],
    // resolve: {
    //   extensions: ['.ts', '.js'],
    //   fallback: {
    //     // "stream": require.resolve("stream-browserify"),
    //     "buffer": require.resolve("buffer")
    //   }
    // },
  })
