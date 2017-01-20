const webpack = require('webpack')

module.exports = {
  entry: './app/main.js',
  output: {
    path: '/public',
    publicPath: '/public/',
    filename: 'bundle.js',
    crossOriginLoading: 'anonymous'
  },
  plugins: [
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.ProvidePlugin({ riot: 'riot' })
  ],
  module: {
    preLoaders: [
      {
        test   : /\.js$|.tag$|.es6$/,
        exclude: /node_modules/,
        loader : 'eslint-loader'
      },
      {
        test   : /\.tag$/,
        exclude: /node_modules/,
        loader : 'riotjs-loader'
      }
    ],
    loaders: [
      {
        test   : /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "url-loader?limit=10000&minetype=application/font-woff"
      },
      { test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "file-loader"
      }
    ],
    postLoaders: [
      {
        test   : /\.js$|\.tag$/,
        exclude: /node_modules/,
        loader : 'babel-loader',
        query  : {
          presets: ['es2015-riot']
        }
      }
    ]
  },
  devServer: {
    historyApiFallback: true,
    watchOptions: { aggregateTimeout: 300, poll: 1000 },
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, PATCH, OPTIONS",
      "Access-Control-Allow-Headers": "X-Requested-With, content-type, Authorization"
    }
  }

}
