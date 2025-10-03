const mysql = require('mysql2/promise');
const { createClient } = require('@supabase/supabase-js');

// MySQL connection
const mysqlPool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '123456', // your MySQL password
  database: 'luct_reporting',
  port: 3306,
});

// Supabase client
const supabaseUrl = 'https://ouzbytnnkuzgdcthctpo.supabase.co';
const supabaseKey = 'YOUR_SUPABASE_SERVICE_ROLE_KEY'; // find in Supabase → Settings → API → Service Role Key
const supabase = createClient(supabaseUrl, supabaseKey);

async function migrateUsers() {
  try {
    // Get all users from MySQL
    const [rows] = await mysqlPool.query('SELECT * FROM users');

    for (const user of rows) {
      const { id, name, username, password, role, faculty_id } = user;

      // Insert into Supabase
      const { error } = await supabase.from('users').insert([
        { id, name, username, password, role, faculty_id },
      ]);

      if (error) console.error('Supabase insert error:', error);
      else console.log(`Migrated user: ${username}`);
    }

    console.log('Migration complete!');
    process.exit(0);
  } catch (err) {
    console.error('Migration error:', err);
    process.exit(1);
  }
}

migrateUsers();
