const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function(app) {
  app.use(
    '/api',
    createProxyMiddleware({
      target: 'https://trade-api.finam.ru',
      changeOrigin: true,
    })
  );
};