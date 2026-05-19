const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const config = require('./config/env');
const syncRoutes = require('./routes/syncRoutes');
const errorHandler = require('./middleware/errorHandler');
const logger = require('./utils/logger');

const app = express();

app.use(cors({
  origin: config.allowedOrigins,
  credentials: true,
}));

app.use(morgan('dev'));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

app.use('/api/sync', syncRoutes);

app.get('/api/health', (req, res) => {
  res.json({
    success: true,
    status: 'ok',
    timestamp: new Date().toISOString(),
    version: '1.0.0',
  });
});

app.use(errorHandler);

app.listen(config.port, '0.0.0.0', () => {
  logger.info(`Dawamy Backend running on http://0.0.0.0:${config.port}`);
  logger.info(`Allowed origins: ${config.allowedOrigins.join(', ')}`);
  logger.info(`Environment: ${config.nodeEnv}`);
});
