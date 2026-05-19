const logger = require('../utils/logger');

const errorHandler = (err, req, res, next) => {
  logger.error('Request error', err);

  const statusCode = err.statusCode || 500;
  const message = err.message || 'Internal server error';

  res.status(statusCode).json({
    success: false,
    error: {
      message,
      code: err.code || 'INTERNAL_ERROR',
    },
  });
};

module.exports = errorHandler;
