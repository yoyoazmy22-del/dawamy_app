const express = require('express');
const router = express.Router();
const syncController = require('../controllers/syncController');
const { validateSyncRequest } = require('../middleware/validation');

router.get('/', syncController.getSync);
router.post('/', validateSyncRequest, syncController.postSync);
router.get('/health', syncController.health);

module.exports = router;
