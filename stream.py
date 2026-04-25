import streamlit as st
import mysql.connector
import pandas as pd
import os

# Database connection
def create_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='root',
        database='AuctionDB'
    )

# Function to execute a query and return results
def execute_query(query):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute(query)
    if query.strip().upper().startswith("SELECT"):
        result = cursor.fetchall()
        columns = [i[0] for i in cursor.description]
        df = pd.DataFrame(result, columns=columns)
        cursor.close()
        conn.close()
        return df
    else:
        conn.commit()
        cursor.close()
        conn.close()
        return None

# Streamlit UI
st.title("AuctionDB Management")

# Step 1: Update Data
if st.button("Update Product Price"):
    execute_query("UPDATE Products SET Starting_Price = 175.00 WHERE Product_ID = 'P001';")
    st.success("Product price updated.")
    st.write(execute_query("SELECT * FROM Products WHERE Product_ID = 'P001';"))

# Step 2: Delete Data
if st.button("Delete Bid"):
    execute_query("DELETE FROM Bids WHERE Bid_ID = 'B000001';")
    st.success("Bid deleted.")
    st.write(execute_query("SELECT * FROM Bids;"))

# Step 3: Filtering Table Data
if st.button("Filter Users in NY"):
    st.write(execute_query("SELECT * FROM Users WHERE Address LIKE '%NY%';"))

if st.button("Filter Products Starting Price > 100"):
    st.write(execute_query("SELECT * FROM Products WHERE Starting_Price > 100;"))

# Step 4: Sorting Data
if st.button("Sort Products by Starting Price"):
    st.write(execute_query("SELECT * FROM Products ORDER BY Starting_Price DESC;"))

# Step 5: Distinct Command
if st.button("Get Distinct Categories"):
    st.write(execute_query("SELECT DISTINCT Category FROM Products;"))

# Step 6: Modify NOT NULL Constraint
if st.button("Set Phone NOT NULL"):
    execute_query("ALTER TABLE Users MODIFY Phone VARCHAR(15) NOT NULL;")
    st.success("Phone set to NOT NULL.")
    st.write(execute_query("DESCRIBE Users;"))

# Step 7: Add CHECK Constraint
if st.button("Add CHECK Constraint"):
    execute_query("ALTER TABLE Products ADD CHECK (Starting_Price >= 50);")
    st.success("CHECK constraint added.")
    st.write(execute_query("SHOW CREATE TABLE Products;"))

# Step 8: Default Constraint
if st.button("Set Default Payment Method"):
    execute_query("ALTER TABLE Users MODIFY Payment_Method VARCHAR(255) DEFAULT 'Credit Card';")
    st.success("Default payment method set.")
    st.write(execute_query("SHOW CREATE TABLE Users;"))

# Step 9: Logical Operators
if st.button("Filter Users with Phone in NY"):
    st.write(execute_query("SELECT * FROM Users WHERE Address = 'NY' AND Phone IS NOT NULL;"))

if st.button("Filter Users in NY or LA"):
    st.write(execute_query("SELECT * FROM Users WHERE Address = 'NY' OR Address = 'LA';"))

# Step 10: Arithmetic Operators
if st.button("Calculate Final Price"):
    st.write(execute_query("SELECT Product_Name, Starting_Price, Starting_Price * 1.2 AS Final_Price FROM Products;"))

# Step 11: Range Searching
if st.button("Products Between 100 and 500"):
    st.write(execute_query("SELECT * FROM Products WHERE Starting_Price BETWEEN 100 AND 500;"))

# Step 12: IN Operator
if st.button("Filter Users by Username"):
    st.write(execute_query("SELECT * FROM Users WHERE Username IN ('JohnDoe', 'JaneSmith');"))

# Step 13: Set Operations
if st.button("Union of Users"):
    st.write(execute_query("SELECT Username FROM Users UNION SELECT Username FROM Users WHERE Address = 'NY';"))

# Step 14: GROUP BY Clause
if st.button("User  Count by Address"):
    st.write(execute_query("SELECT Address, COUNT(*) AS User_Count