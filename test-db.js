
const pool = require("./db");

async function testConnection() {
  try {
    const [rows] = await pool.query("SELECT 1 + 1 AS result");
    console.log("Database connected! Test query result:", rows[0].result);
  } catch (err) {
    console.error("DB connection failed:", err.message);
  }
}

testConnection();
