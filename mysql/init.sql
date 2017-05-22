.print 'Welcome to bash_blog database'

.print 'Creating post table'

CREATE TABLE post(
    post_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content varchar(200)
);

.print 'Creating category table'

CREATE TABLE category(
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name varchar(50) NOT NULL
);

CREATE TABLE assign(
    post_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY(post_id, category_id),
    FOREIGN KEY(category_id) REFERENCES category(category_id),
    FOREIGN KEY(post_id) REFERENCES post(post_id)
);

.print 'Log file'

.log outlog.log

.print 'List of table:'

.tables