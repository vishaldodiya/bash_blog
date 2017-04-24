.print 'Welcome to bash_blog database'

.print 'Creating post table'

CREATE TABLE post(
    post_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content varchar(200),
    category_id INT,
    FOREIGN KEY(category_id) REFERENCES category(category_id)
);

.print 'Creating category table'

CREATE TABLE category(
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name varchar(50)
);

.print 'Log file'

.log outlog.log

.print 'List of table:'

.tables

