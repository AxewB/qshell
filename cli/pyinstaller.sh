pyinstaller --onefile --name=axewbshell --distpath=./dist main.py
sudo rm /bin/axewbshell
sudo mv ./dist/axewbshell /bin/
