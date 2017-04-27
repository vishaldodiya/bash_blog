#!/bin/bash

#echo '==============================='
#echo '|| Welocome to terminal Blog ||'
#echo '==============================='


if [ $1 = 'post' ]
then
    if [ $2 = 'add' ]
    then
        if [ "$3" ] && [ "$4" ]
        then
            if [ -z $5 ] && [ -z $6 ]
            then
                # Insert post
                sqlite3 ./db_data/bash_blog.db "INSERT INTO post (title, content) VALUES('$3', '$4');"
                echo 'Post has been successfully Added:'
            elif [ $5 = '--category' ]
            then
                if [ $6 ]
                then
                    ifHas=$(sqlite3 ./db_data/bash_blog.db "SELECT category_id FROM category WHERE category_name = '$6';")
                    if [ -z $ifHas ]
                    then
                        echo 'Category is not There Let me Add it!!'
                        sqlite3 ./db_data/bash_blog.db "INSERT INTO category (category_name) VALUES('"$6"');"
                        
                    else
                        echo 'I will Add post'
                    fi 
                    # insert query with post and category table
                    echo 'insert query with post and category table'
                else
                    echo 'error'
                fi
            else
                echo 'Please Use the convention Or there may be typo error'
                echo '[[ sh blog.sh post add "title" "content" ]]'    
            fi
            
        else
            # Erro message
            echo 'Please Enter required arguments.'
        fi

    elif [ $2 = 'list' ]
    then
        # Select Post List
        printf "{\n"
        sqlite3 ./db_data/bash_blog.db "SELECT post_id, title, content FROM post" | awk -F'|' '
            {   
                printf "\t{\n"
                printf "\t\tPost_id: "$1"\n"
                printf "\t\tTitle: "$2"\n"
                printf "\t\tContent: "$3"\n"
                printf "\t},\n"
             }'
       printf "}\n"      
    elif [ $2 = 'search' ]
    then
        if [ $3 ]
        then
            # Search Query
            echo 'search query'
        else
            echo 'error'
        fi
    else
        echo 'error'
    fi

# Category statement
elif [ $1 = 'category' ]
then

    if [ $2 = 'add' ]
    then
        if [ $3 ]
        then
            # Insert Query
            sqlite3 ./db_data/bash_blog.db "INSERT INTO category (category_name) VALUES('"$3"');"
            echo 'Category Inserted Successfully'
            exit 0
        else
            echo 'error'
        fi
    elif [ $2 = 'list' ]
    then
        # Select Category List
        sqlite3 ./db_data/bash_blog.db "SELECT category_id, category_name FROM category" | awk -F'|' '
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
            # Update query
            echo 'update query'
        else
            echo 'error'
        fi
    fi

# Help statement
elif [ $1 = '--help' ]
then
    echo "this is help page"
fi










