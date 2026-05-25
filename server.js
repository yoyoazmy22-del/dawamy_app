const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, 'backend', '.env') });

const app = express();

const PORT = process.env.PORT || 3000;
const ALLOWED_ORIGINS = (process.env.ALLOWED_ORIGINS || '*').split(',');

app.use(cors({ origin: ALLOWED_ORIGINS, credentials: true }));
app.use(morgan('dev'));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// API routes
app.use('/api/sync', require('./backend/src/routes/syncRoutes'));

app.get('/api/health', (req, res) => {
  res.json({ success: true, status: 'ok', timestamp: new Date().toISOString(), version: '1.0.0' });
});

app.use(require('./backend/src/middleware/errorHandler'));

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Dawamy Backend running on http://0.0.0.0:${PORT}`);
});
