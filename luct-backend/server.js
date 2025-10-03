const express = require("express");
const cors = require("cors");
const authRoutes = require("./routes/auth");
const reportsRoutes = require("./routes/reports");
const classesRoutes = require("./routes/classes");
const coursesRoutes = require("./routes/courses");
const ratingsRoutes = require("./routes/ratings");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(express.json());
app.use(cors({
  origin: process.env.FRONTEND_URL,
  credentials: true,
}));

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/reports", reportsRoutes);
app.use("/api/classes", classesRoutes);
app.use("/api/courses", coursesRoutes);
app.use("/api/ratings", ratingsRoutes);

// Root route
app.get("/", (req, res) => {
  res.send("Backend running!");
});

app.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`);
});
