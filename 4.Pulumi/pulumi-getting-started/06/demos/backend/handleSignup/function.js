const { Client } = require("pg");

const dbSocketPath = process.env.DB_SOCKET_PATH || "/cloudsql";
const socketPath = `${dbSocketPath}/${process.env.CLOUD_SQL_CONNECTION_NAME}`;

module.exports.handleSignup = async (req, res) => {
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "POST, OPTIONS");

  if(req.method === "OPTIONS") {
    res.set("Access-Control-Allow-Headers", "Content-Type");
    res.set("Access-Control-Max-Age", "60");
    res.status(200).end();
    return;
  }

  const client = new Client({
    host: socketPath,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
  });

  await client.connect();

  await client.query(`
    CREATE TABLE IF NOT EXISTS submissions (
      id SERIAL PRIMARY KEY,
      name text NOT NULL,
      email text NOT NULL
    );
  `);

  await client.query(`INSERT INTO submissions (name, email) values ($1::text, $2::text)`, [
    req.body.name || "",
    req.body.email || "",
  ]);

  await client.end();

  res.status(200)
    .append("Content-Type", "application/json")
    .send({
      message: `Request received, ${req.body.name}, we'll be in touch shortly!`
    });
}
