const fs = require('fs');
const path = require('path');
const config = require('../config/env');
const logger = require('../utils/logger');

class SyncService {
  constructor() {
    this.dbPath = path.resolve(config.dbPath);
    this._ensureDbFile();
  }

  _ensureDbFile() {
    const dir = path.dirname(this.dbPath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    if (!fs.existsSync(this.dbPath)) {
      fs.writeFileSync(this.dbPath, JSON.stringify({ users: {} }));
    }
  }

  _readDb() {
    try {
      const data = fs.readFileSync(this.dbPath, 'utf-8');
      return JSON.parse(data);
    } catch (err) {
      logger.error('Failed to read DB', err);
      return { users: {} };
    }
  }

  _writeDb(db) {
    fs.writeFileSync(this.dbPath, JSON.stringify(db, null, 2));
  }

  async getUserData(userId) {
    const db = this._readDb();
    return db.users[userId] || null;
  }

  async saveUserData(userId, data) {
    const db = this._readDb();
    db.users[userId] = {
      ...db.users[userId],
      ...data,
      lastSyncAt: new Date().toISOString(),
    };
    this._writeDb(db);
    return db.users[userId];
  }

  async syncAll(userId, data) {
    const db = this._readDb();
    if (!db.users[userId]) {
      db.users[userId] = {};
    }
    db.users[userId] = {
      ...db.users[userId],
      ...data,
      lastSyncAt: new Date().toISOString(),
    };
    this._writeDb(db);
    return { success: true, lastSyncAt: db.users[userId].lastSyncAt };
  }

  async getHealth() {
    return {
      status: 'ok',
      timestamp: new Date().toISOString(),
      dbPath: this.dbPath,
      users: Object.keys(this._readDb().users).length,
    };
  }
}

module.exports = new SyncService();
