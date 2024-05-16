const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors());

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'devcrm',
});

connection.connect();

function createTableIfNotExists(tableName, createTableQuery) {
  return new Promise((resolve, reject) => {
    connection.query(`SHOW TABLES LIKE '${tableName}'`, (error, results) => {
      if (error) {
        reject(error);
      } else {
        if (results.length === 0) {
          connection.query(createTableQuery, (error) => {
            if (error) {
              reject(error);
            } else {
              resolve();
            }
          });
        } else {
          resolve();
        }
      }
    });
  });
}

// Leads API Endpoints
app.get('/api/leads', async (req, res) => {
  try {
    await createTableIfNotExists('leads', 'CREATE TABLE leads (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), phone VARCHAR(255))');
    connection.query('SELECT * FROM leads', (error, results) => {
      if (error) throw error;
      res.json(results);
    });
  } catch (error) {
    res.status(500).send('Internal Server Error');
  }
});

app.post('/api/leads', async (req, res) => {
  try {
    await createTableIfNotExists('leads', 'CREATE TABLE leads (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), phone VARCHAR(255))');
    const { name, email, phone } = req.body;
    connection.query('INSERT INTO leads (name, email, phone) VALUES (?, ?, ?)', [name, email, phone], (error, results) => {
      if (error) throw error;
      res.send('Lead added successfully');
    });
  } catch (error) {
    res.status(500).send('Internal Server Error');
  }
});

  // Contacts API Endpoints
app.get('/api/contacts', async (req, res) => {
  try {
    await createTableIfNotExists('contacts', 'CREATE TABLE contacts (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), phone VARCHAR(255),company VARCHAR(255))');
    connection.query('SELECT * FROM contacts', (error, results) => {
      if (error) throw error;
      res.json(results);
    });
  } catch (error) {
    res.status(500).send('Internal Server Error');
  }
});

app.post('/api/contacts', async (req, res) => {
  try {
    await createTableIfNotExists('contacts', 'CREATE TABLE contacts (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), phone VARCHAR(255)),company VARCHAR(255)');
    const { name, email, phone, company } = req.body;
    connection.query('INSERT INTO contacts (name, email, phone,company) VALUES (?, ?, ?, ?)', [name, email, phone, company], (error, results) => {
      if (error) throw error;
      res.send('Contact added successfully');
    });
  } catch (error) {
    res.status(500).send('Internal Server Error');
  }
});

app.put('/api/contacts/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { name, email, phone, company } = req.body;
    
    // Check if the contact exists
    const contactExists = await contactExistsById(id);
    if (!contactExists) {
      return res.status(404).send('Contact not found');
    }

    // Update the contact details
    connection.query('UPDATE contacts SET name=?, email=?, phone=?, company=? WHERE id=?', 
      [name, email, phone, company, id], 
      (error, results) => {
        if (error) throw error;
        res.send('Contact updated successfully');
      }
    );
  } catch (error) {
    res.status(500).send('Internal Server Error');
  }
});

app.delete('/api/contacts/:id', async (req, res) => {
  try {
    const { id } = req.params;

    // Check if the contact exists
    const contactExists = await contactExistsById(id);
    if (!contactExists) {
      return res.status(404).send('Contact not found');
    }

    // Delete the contact
    connection.query('DELETE FROM contacts WHERE id = ?', [id], (error, results) => {
      if (error) throw error;
      res.send('Contact deleted successfully');
    });
  } catch (error) {
    res.status(500).send('Internal Server Error');
  }
});

// Function to check if a contact exists by ID
function contactExistsById(id) {
  return new Promise((resolve, reject) => {
    connection.query('SELECT * FROM contacts WHERE id = ?', [id], (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results.length > 0);
      }
    });
  });
}

// Accounts API Endpoints
app.get('/api/accounts', (req, res) => {
  connection.query('SELECT * FROM accounts', (error, results) => {
    if (error) throw error;
    res.json(results);
  });
});

app.post('/api/accounts', (req, res) => {
  const { name, address, industry } = req.body;
  connection.query('INSERT INTO accounts (name, address, industry) VALUES (?, ?, ?)', [name, address, industry], (error, results) => {
    if (error) throw error;
    res.send('Account added successfully');
  });
});

// Deals API Endpoints
app.get('/api/deals', (req, res) => {
  connection.query('SELECT * FROM deals', (error, results) => {
    if (error) throw error;
    res.json(results);
  });
});

app.post('/api/deals', (req, res) => {
  const { name, amount, accountId } = req.body;
  connection.query('INSERT INTO deals (name, amount, account_id) VALUES (?, ?, ?)', [name, amount, accountId], (error, results) => {
    if (error) throw error;
    res.send('Deal added successfully');
  });
});

// Tasks API Endpoints
app.get('/api/tasks', (req, res) => {
  connection.query('SELECT * FROM tasks', (error, results) => {
    if (error) throw error;
    res.json(results);
  });
});

app.post('/api/tasks', (req, res) => {
  const { title, description, assignedTo } = req.body;
  connection.query('INSERT INTO tasks (title, description, assigned_to) VALUES (?, ?, ?)', [title, description, assignedTo], (error, results) => {
    if (error) throw error;
    res.send('Task added successfully');
  });
});

// Meetings API Endpoints
app.get('/api/meetings', (req, res) => {
  connection.query('SELECT * FROM meetings', (error, results) => {
    if (error) throw error;
    res.json(results);
  });
});

app.post('/api/meetings', (req, res) => {
  const { title, datetime, location, accountId } = req.body;
  connection.query('INSERT INTO meetings (title, datetime, location, account_id) VALUES (?, ?, ?, ?)', [title, datetime, location, accountId], (error, results) => {
    if (error) throw error;
    res.send('Meeting added successfully');
  });
});

// Calls API Endpoints
app.get('/api/calls', (req, res) => {
  connection.query('SELECT * FROM calls', (error, results) => {
    if (error) throw error;
    res.json(results);
  });
});

app.post('/api/calls', (req, res) => {
  const { datetime, duration, contactId } = req.body;
  connection.query('INSERT INTO calls (datetime, duration, contact_id) VALUES (?, ?, ?)', [datetime, duration, contactId], (error, results) => {
    if (error) throw error;
    res.send('Call added successfully');
  });
});

// Analytics API Endpoints
app.get('/api/analytics', (req, res) => {
  connection.query('SELECT * FROM analytics', (error, results) => {
    if (error) throw error;
    res.json(results);
  });
});

// Reports API Endpoints
app.get('/api/reports', (req, res) => {
  connection.query('SELECT * FROM reports', (error, results) => {
    if (error) throw error;
    res.json(results);
  });
});

app.post('/api/reports', (req, res) => {
  const { title, description, accountId } = req.body;
  connection.query('INSERT INTO reports (title, description, account_id) VALUES (?, ?, ?)', [title, description, accountId], (error, results) => {
    if (error) throw error;
    res.send('Report added successfully');
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
