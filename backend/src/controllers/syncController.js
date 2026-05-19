const syncService = require('../services/syncService');
const logger = require('../utils/logger');

const syncController = {
  async getSync(req, res, next) {
    try {
      const { userId } = req.query;
      if (!userId) {
        return res.status(400).json({
          success: false,
          error: { message: 'userId query parameter is required', code: 'VALIDATION_ERROR' },
        });
      }
      const data = await syncService.getUserData(userId);
      res.json({ success: true, data, userId });
    } catch (err) {
      next(err);
    }
  },

  async postSync(req, res, next) {
    try {
      const { userId, data } = req.body;
      const result = await syncService.syncAll(userId, data);
      res.json({ success: true, ...result });
    } catch (err) {
      next(err);
    }
  },

  async health(req, res) {
    const health = await syncService.getHealth();
    res.json({ success: true, ...health });
  },
};

module.exports = syncController;
