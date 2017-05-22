sh blog.sh post add "post title 1" "post content 1"
sh blog.sh post add "post title 2" "post content 2"
sh blog.sh post add "post title 3" "post content 3"
sh blog.sh post add "post title 4" "post content 4"
sh blog.sh post add "post title 5" "post content 5"

sh blog.sh category add "cat1"
sh blog.sh category add "cat2"
sh blog.sh category add "cat3"
sh blog.sh category add "cat4"
sh blog.sh category add "cat5"
sh blog.sh category add "cat1"

sh blog.sh category assign 1 3
sh blog.sh category assign 2 6
sh blog.sh category assign 3 1
sh blog.sh category assign 4 2
sh blog.sh category assign 5 5
sh blog.sh category assign 1 4
sh blog.sh category assign 2 3
sh blog.sh category assign 3 3
sh blog.sh category assign 1 6
sh blog.sh category assign 4 3
sh blog.sh category assign 5 3

