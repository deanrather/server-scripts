
#Change to working git repository to pull changes from bare repository
cd /home/ubuntu/www/gamehub || exit
unset GIT_DIR
git pull origin master
