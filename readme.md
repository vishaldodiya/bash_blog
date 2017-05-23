# Bash Blog

Bash blog is Cli blog which enhance and speed up the process of testing and used to automate tedious process of data entry.   

## Getting Started

There are some few instructions that will help you to setup the project up and running on your local machine for development and testing purposes. Go through the below instructions.

### Prerequisites

For common devlopment environment we need docker. To install  Docker Follow Below Link

[Install Docker](https://docs.docker.com/get-started/)


### Installing

A step by step series of examples will help you to get a development env up & running

Build Project with docker 

```
Docker build -t "bash_blog" .
```

Run Project without persisting data

```
Docker run -it bash_blog /bin/sh
```

Run Project with persisting data
```
Docker run -v data:/db_data -it bash_blog /bin/sh
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Example Test run for this system

### Example test run

Insert Sample Data

```
$ sh sample.sh
```

Add Post

```
$ sh blog.sh post add "title" "content"
```
List Post
```
$ sh blog.sh post list
```
> Output
```
post title 1

{

        Post_id: 1
        Title: post title 1
        Content: post content 1
        Category_name: cat3
cat4
cat1

},
post title 2

{

        Post_id: 2
        Title: post title 2
        Content: post content 2
        Category_name: cat3
cat1

},
post title 3

{

        Post_id: 3
        Title: post title 3
        Content: post content 3
        Category_name: cat1
cat3

},
post title 4

{

        Post_id: 4
        Title: post title 4
        Content: post content 4
        Category_name: cat2
cat3

},
post title 5

{

        Post_id: 5
        Title: post title 5
        Content: post content 5
        Category_name: cat3
cat5

},
```

Search Post
```
$ sh blog.sh post search "title 4"
```
> Output

```

Search Result:

================================================

        Post_id: 4
        Title: post title 4
        Content: post content 4
        Category_name: cat2
                        ,cat3

==============================================
```
Add Category
```
$ sh blog.sh category add "category_name"
```

List Category
```
$ sh blog.sh category list
```

> Output

```
{
        Category_id: 1
        Category_name: cat1
},
{
        Category_id: 2
        Category_name: cat2
},
{
        Category_id: 3
        Category_name: cat3
},
{
        Category_id: 4
        Category_name: cat4
},
{
        Category_id: 5
        Category_name: cat5
},
{
        Category_id: 6
        Category_name: cat1
},
```

Assign Category to Post
```
$ sh blog.sh category assign <post-id> <cat-id>
```

Add Post With Category Name
```
$ sh blog.sh post add "title" "content" --category "cat_name"
```
## Built With

* [Docker](https://www.docker.com/) - Platform To build and ship project using container
* [SQLite](https://www.sqlite.org/  ) - Self-contained, Embeddable, Zero-configuration SQL database engine.
* [Alpine](https://alpinelinux.org/) - Simplest and Lightest linux Distro

## Authors

* **Vishal Dodiya** - [vishaldodiya](https://github.com/vishaldodiya)

## License

This project is licensed under the MIT License

