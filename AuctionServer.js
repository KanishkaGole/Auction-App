const express = require('express');
const fs = require('fs');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to serve static files
app.use(express.static('public'));

// Sample data retrieval from a hypothetical database file
app.get('/api/auctions', (req, res) => {
    // Example of reading from a specific database file
    fs.readFile(path.join(__dirname, 'path/to/your/database/file.json'), 'utf8', (err, data) => {
        if (err) {
            return res.status(500).json({ error: 'Failed to read database file' });
        }
        const auctions = JSON.parse(data); // Assuming the data is in JSON format
        res.json(auctions);
    });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});