const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// Database connection
const db = mysql.createConnection({
  host: "localhost",
  user: "root", // Your MySQL username
  password: "password", // Your MySQL password
  database: "AuctionDB",
});

db.connect((err) => {
  if (err) {
    console.error("Database connection failed: " + err.message);
  } else {
    console.log("Connected to MySQL Database!");
  }
});

// User Registration API
app.post("/register", (req, res) => {
  const { User_ID, Username, Email, Password, Phone, Address } = req.body;
  const query = "INSERT INTO Users (User_ID, Username, Email, Password, Phone, Address, Registration_Date) VALUES (?, ?, ?, ?, ?, ?, CURDATE())";
  db.query(query, [User_ID, Username, Email, Password, Phone, Address], (err, result) => {
    if (err) {
      res.status(500).json({ message: "Error registering user", error: err });
    } else {
      res.status(201).json({ message: "User registered successfully" });
    }
  });
});

// Get Products API
app.get("/products", (req, res) => {
  db.query("SELECT * FROM Products", (err, results) => {
    if (err) {
      res.status(500).json({ message: "Error fetching products", error: err });
    } else {
      res.json(results);
    }
  });
});

// Start Server
app.listen(3001, () => {
  console.log("Server running on port 3001");
});
