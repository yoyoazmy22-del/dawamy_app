const validateSyncRequest = (req, res, next) => {
  const { userId, data } = req.body;

  if (req.method === 'POST' && (!userId || !data)) {
    return res.status(400).json({
      success: false,
      error: { message: 'userId and data are required', code: 'VALIDATION_ERROR' },
    });
  }

  next();
};

module.exports = { validateSyncRequest };
