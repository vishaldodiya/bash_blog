# Create database
`sqlite3 bash_blog.db`

# To print datbases
`.databases`

# Create table
`CREATE TABLE post(`
`post_id INT PRIMARY KEY NOT NULL,`
`title TEXT NOT NULL,`
`content CHAR(200),`
`category_id INT);`

# To print tables
`.tables`

# To check schema
`.schema table_name`

# sqlite with bash 
` rlwrap sqlite3`





