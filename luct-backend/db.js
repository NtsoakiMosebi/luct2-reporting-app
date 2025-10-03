const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '123456', //MySQL root password
  database: 'luct_reporting',
});

module.exports = pool;
