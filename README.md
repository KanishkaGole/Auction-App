# Auction App
A full-stack auction project combining Node.js, HTML/CSS/JavaScript, SQL database scripts, and Python utilities for data and demo workflows.
## Description
This repository contains an auction application with a Node.js backend server, static auction frontend assets, SQL scripts for database setup and queries, plus Python scripts and notebook demos for supporting data workflows.
## Features
- Browser-based auction UI using HTML, CSS, and JavaScript
- Node.js Express server for backend auction logic and data handling
- SQL scripts for creating auctions and querying auction-related data
- Python utilities and Streamlit-friendly scripts for data processing
- Demo notebook and Python resource examples for workflow validation
## Tech Stack
- Node.js
- Express
- csv-parser
- mammoth
- Python 3
- streamlit
- mysql-connector-python
- python-dotenv
- HTML, CSS, JavaScript
- SQL
## Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd auction-app
   ```
2. Install Python dependencies:
   ```bash
   python -m venv myenv
   myenv\Scripts\activate
   pip install -r requirements.txt
   ```
3. Install Node dependencies:
   ```bash
   npm install
   ```
4. Create a `.env` file with any required database connection settings.
## Usage
- Start the Node.js backend server:
  ```bash
  node AuctionServer.js
  ```
- Open `AuctionDB.html` in a browser to view the auction frontend.
- Use the SQL scripts to create and query the auction database:
  - `createAuction.sql`
  - `Final.sql`
  - `Queries.sql`
- Run Python utilities and demos:
  ```bash
  python demo.py
  python stream.py
  ```
## Folder Structure
- `AuctionDB.html` - auction frontend HTML page
- `AuctionStyles.css` - styles for frontend auction UI
- `AuctionScript.js` - frontend JavaScript for client-side auction behavior
- `AuctionServer.js` - Node.js auction server backend
- `package.json` / `package-lock.json` - Node.js project metadata and dependencies
- `createAuction.sql`, `Final.sql`, `Queries.sql` - SQL database scripts
- `demo.ipynb` - Jupyter notebook demo
- `demo.py` - Python demo script
- `stream.py` - Python streaming/demo script
- `requirements.txt` - Python dependencies
- `myenv/` - local Python virtual environment (ignored)
- `node_modules/` - Node.js dependencies (ignored)
## Contributors
- Kanishka Gole <kanishkag2020@gmail.com>
## License
MIT
