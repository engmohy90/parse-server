# #!/bin/bash
sudo rm -rf ourapp
mkdir ourapp
cd ourapp
sudo apt-get install build-essential git python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs
sudo npm install -g parse-dashboard 
sudo docker images | grep 'engmohy90/m-parse' &> /dev/null
if [ $? == 0 ]; then
	echo "you have our image"
else 
	sudo docker pull engmohy90/m-parse
fi
read -e -p "Enter you machine puplic ip like 192.168.1.1:  " myip
echo "{
  \"apps\": [
    {
      \"serverURL\": \"http://$myip:1337/parse\",
      \"appId\": \"app\",
      \"masterKey\": \"app\",
      \"appName\": \"App_Name\"
    }
  ],
  \"users\": [
      {
           \"user\":\"user\",
           \"pass\":\"pass\"
      }
  ]
}
" >> parse-dashboard-config.json

parse-dashboard  --config parse-dashboard-config.json --allowInsecureHTTP true &
sudo docker run -p 1337:1337 engmohy90/m-parse

