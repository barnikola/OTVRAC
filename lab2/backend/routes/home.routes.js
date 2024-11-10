const express = require('express');
const router = express.Router();
const path = require('path');

// Route to render the home page
router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../frontend/index.html'));  // Putanja do index.html u frontend direktoriju
});

module.exports = router;