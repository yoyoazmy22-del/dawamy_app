require('dotenv').config();

const config = {
  port: parseInt(process.env.PORT, 10) || 3000,
  nodeEnv: process.env.NODE_ENV || 'development',
  allowedOrigins: (process.env.ALLOWED_ORIGINS || 'http://localhost:4173,http://localhost:3000').split(','),
  dbPath: process.env.DB_PATH || './data/db.json',
};

module.exports = config;
