const express = require("express");
const router = express.Router();
const pool = require("../db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
require("dotenv").config();

// REGISTER
router.post("/register", async (req, res) => {
  const { username, password, role, name, faculty_id } = req.body;
  if (!username || !password || !role)
    return res.status(400).json({ error: "Username, password, and role are required" });

  const allowedRoles = ["student", "lecturer", "prl", "pl"];
  if (!allowedRoles.includes(role))
    return res.status(400).json({ error: "Invalid role" });

  try {
    const checkUser = await pool.query(
      "SELECT * FROM users WHERE username = $1",
      [username]
    );
    if (checkUser.rows.length > 0)
      return res.status(400).json({ error: "Username already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);

    await pool.query(
      "INSERT INTO users (name, username, password, role, faculty_id) VALUES ($1, $2, $3, $4, $5)",
      [name || null, username, hashedPassword, role, faculty_id || null]
    );

    res.status(201).json({ message: "User registered successfully" });
  } catch (err) {
    console.error("Register error:", err);
    res.status(500).json({ error: "Registration failed" });
  }
});

// LOGIN
router.post("/login", async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password)
    return res.status(400).json({ error: "Username and password are required" });

  try {
    const userResult = await pool.query(
      "SELECT * FROM users WHERE username = $1",
      [username]
    );
    if (userResult.rows.length === 0)
      return res.status(401).json({ error: "Invalid username or password" });

    const user = userResult.rows[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(401).json({ error: "Invalid username or password" });

    const token = jwt.sign(
      { id: user.id, role: user.role, faculty_id: user.faculty_id },
      process.env.JWT_SECRET,
      { expiresIn: "1d" }
    );

    res.json({
      token,
      user: {
        id: user.id,
        name: user.name,
        username: user.username,
        role: user.role,
        faculty_id: user.faculty_id,
      },
    });
  } catch (err) {
    console.error("Login error:", err);
    res.status(500).json({ error: "Login failed" });
  }
});

module.exports = router;
