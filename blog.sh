#!/bin/bash

#echo '==============================='
#echo '|| Welocome to terminal Blog ||'
#echo '==============================='
DB_PATH="./db_data/bash_blog.db"

if [ $1 = 'post' ]
then
    if [ $2 = 'add' ]
    then
        if [ "$3" ] && [ "$4" ]
        then
            if [ -z $5 ] && [ -z $6 ]
            then
                # Insert post
                sqlite3 $DB_PATH "INSERT INTO post (title, content) VALUES('$3', '$4');"
                echo 'Post has been successfully Added:'
            elif [ $5 = '--category' ]
            then
                if [ $6 ]
                then
                    # Check if it has entered category
                    ifHas=$(sqlite3 $DB_PATH "SELECT category_id FROM category WHERE category_name = '$6';")
                    if [ -z $ifHas ]
                    then
                        # We don't have category so insert category and then post'
                        echo 'Category is not There Let me Add it!!'
                        sqlite3 $DB_PATH "INSERT INTO category (category_name) VALUES('"$6"');"
                        cat_id=$(sqlite3 $DB_PATH "SELECT category_id FROM category WHERE category_name = '$6';")
                        sqlite3 $DB_PATH "INSERT INTO post (title, content) VALUES ('$3', '$4');"
                        post_id=$(sqlite3 $DB_PATH "SELECT post_id FROM post WHERE title = '$3' AND content = '$4'")
                        sqlite3 $DB_PATH "INSERT INTO assign (post_id, category_id) VALUES('$post_id', '$cat_id')" 
                        echo "Post has been successfully added with category"                        
                    else
                        # We alredy have category so just insert into post
                        cat_id=$(sqlite3 $DB_PATH "SELECT category_id FROM category WHERE category_name = '$6';")
                        sqlite3 $DB_PATH "INSERT INTO post (title, content) VALUES ('$3', '$4');"
                        post_id=$(sqlite3 $DB_PATH "SELECT post_id FROM post WHERE title = '$3' AND content = '$4'")
                        sqlite3 $DB_PATH "INSERT INTO assign (post_id, category_id) VALUES('$post_id', '$cat_id')" 
                        echo "Post has been successfully added with category"
                    fi 
                else
                    printf "Invalid Argument For More detail run:\n"
                    printf "$ sh blog.sh post --help\n"
                fi
            else
                printf "Invalid Argument For More detail run:\n"
                printf "$ sh blog.sh post --help\n"    
            fi
            
        else
            # Error message
            printf "Invalid Argument For More detail run:\n"
            printf "$ sh blog.sh post --help\n" 
        fi

    elif [ $2 = 'list' ]
    then
        # Select Post List 
        sqlite3 $DB_PATH "SELECT post.post_id, post.title, post.content FROM post"  > temp.txt
        temp=0
        while IFS='|' read o1 o2 o3;do
                printf "\n"
                printf "{\n"
                printf "\n"
                printf "\tPost_id: $o1"
                printf "\n"
                printf "\tTitle: $o2"
                printf "\n"
                printf "\tContent: $o3"
                printf "\n"
                printf "\tCategory_name: "
                sqlite3 $DB_PATH "SELECT category.category_name FROM assign CROSS JOIN category ON assign.category_id = category.category_id AND assign.post_id = $o1"
                printf "\n},\n"
        done < temp.txt
   
    elif [ $2 = 'search' ]
    then
        if [ "$3" ]
        then
            # Search Query 
            sqlite3 $DB_PATH "SELECT post.post_id, post.title, post.content, category.category_name FROM post LEFT OUTER JOIN assign JOIN category ON post.post_id = assign.post_id AND assign.category_id = category.category_id  WHERE title LIKE '%$3%' OR content LIKE '%$3%' OR category_name LIKE '$3%'"  > temp.txt
            temp=0
            printf "\nSearch Result:\n"
            while IFS='|' read o1 o2 o3 o4;do
                if [ $temp -eq $o1 ]
                then
                    printf "\t\t\t,$o4\n"
                else
                    printf "\n"
                    printf "================================================\n"
                    printf "\n"
                    printf "\tPost_id: $o1"
                    printf "\n"
                    printf "\tTitle: $o2"
                    printf "\n"
                    printf "\tContent: $o3"
                    printf "\n"
                    printf "\tCategory_name: $o4\n"
                    temp=$o1
                fi
            done < temp.txt
            printf "\n==============================================\n"
        else
            printf "Invalid Argument For More detail run:\n"
            printf "$ sh blog.sh post --help" 
        fi
    
    
    
    
    elif [ $2 = '--help' ]
    then
        printf "\n\n"
        printf "Usage: $ sh blog.sh post [Command] [Args...]\n"
        printf "\n\n"
        printf "Commands:\n"
        printf "\tadd     : Create Post\n"
        printf "\tlist    : List all Post\n"
        printf "\tsearch  : Search Text in Post"
        printf "\n\nFor Detailed Use:\n\n"
        printf "Usage: $ sh blog.sh post add \"title\" \"content\"\n\n"
        printf "\tTo insert new post in post table \n\n"
        printf "Usage: $ sh blog.sh post add \"title\" \"content\" --category \"category_name\"\n\n"
        printf "\tTo insert new post with category\n\n"
        printf "Usage: $ sh blog.sh post list\n\n"
        printf "\tTo list all post\n\n"
        printf "Usage: $ sh blog.sh post search \"text\"\n\n"
        printf "\tTo search text in post\n\n"
    else
        printf "Invalid Argument For More detail run:\n"
        printf "$ sh blog.sh post --help" 
    fi

# Category statement
elif [ $1 = 'category' ]
then

    if [ $2 = 'add' ]
    then
        if [ "$3" ]
        then
            # Insert Query
            sqlite3 $DB_PATH "INSERT INTO category (category_name) VALUES('$3');"
            echo 'Category Inserted Successfully'
        else
            printf "Invalid Argument For More detail run:\n"
            printf "$ sh blog.sh category --help\n"
        fi
    elif [ $2 = 'list' ]
    then
        # Select Category List
        sqlite3 $DB_PATH "SELECT category_id, category_name FROM category" | awk -F'|' '
        {
            printf "{\n"
            printf "\tCategory_id: "$1"\n"
            printf "\tCategory_name: "$2"\n"
            printf "},\n"
        }'
    elif [ $2 = 'assign' ]
    then
        if [ $3 ] && [ $4 ]
        then
            if [ $3 -eq $3 2> /dev/null ] && [ $4 -eq $4 2> /dev/null ]
            then
                # Update query  ON post.post_id = assign.post_id AND assign.category_id = category.category_id

                sqlite3 $DB_PATH "PRAGMA foreign_keys = ON;INSERT INTO assign (post_id, category_id) VALUES("$3", "$4");"
                if [ $? -eq 0 ]
                then
                    echo 'Category Assigned to Post'
                else
                    echo "Violated the Table Constrains. Either Inserted non unique value or Post-Category may not exist."
                fi
            else
                printf "Required Argument should be Integer\n"
            fi
        else
            printf "Invalid Argument For More detail run:\n"
            printf "$ sh blog.sh category --help"
        fi
    elif [ $2 = '--help' ]
    then
        printf "\n\n"
        printf "Usage: $ sh blog.sh category [Command] [Args...]\n"
        printf "\n\n"
        printf "Commands:\n"
        printf "\tadd       : Create Category\n"
        printf "\tlist      : List all Category\n"
        printf "\tassign    : Assign Category to Post\n"
        printf "\n\nFor Detailed Use:\n\n"
        printf "Usage: $ sh blog.sh category add \"category_name\"\n\n"
        printf "\tTo insert new category in category table \n\n"
        printf "Usage: $ sh blog.sh category list\n\n"
        printf "\tTo list all category\n\n"
        printf "Usage: $ sh blog.sh category assign <post-id> <cat-id>\n\n"
        printf "\tTo list all category\n\n"
    else
        printf "Invalid Argument For More detail run:\n"
        printf "$ sh blog.sh category --help"
    fi

# Help statement
elif [ $1 = '--help' ]
then
    printf "\n\n"
    printf "Usage: $ sh blog.sh [command]\n"
    printf "\n\n"
    printf "Commands:\n"
    printf "\tpost        : Create, Search or Manupulate Post\n"
    printf "\tcategory    : Create, Assign or list Category\n"
    printf "\nFor Detailed Information about commands Use,\n\n"
    printf "$ sh blog.sh [Command] --help\n\n"
else
    printf "Invalid Argument For More detail run:\n"
    printf "$ sh blog.sh --help"
fi