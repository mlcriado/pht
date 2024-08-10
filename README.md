   # PHT Project

   ## Instructions

   ### Clone the Repository
   $ git clone https://github.com/mlcriado/pht.git
   $ cd pht
   
   ### Generate SSH Keys
   $ ssh-keygen -t rsa -b 4096 -f pht
   
   ### Build the Docker Image: You can name the Docker image as you prefer. Replace \`your_image_name\` with your desired name.
   $ docker build -t your_image_name .

   ### Run the Docker Container. Replace \`your_image_name\` with the name you used in the previous step.
   $ docker run -d -p 2222:22-e PUID=1000 -e PGID=1000 --name armory_container your_image_name

   ### If you already have the blockchain downloaded you can use the option -v \`path/to/your/blockchain/folder\`:/bitcoin 
   ### If you already have the armory wallets and configuration created you can use the option -v \`path/to/your/armory/\`:/armory
   $ docker run -d -p2222:22 -v /path/to/your/blockchain/folder:/bitcoin -v /path/to/your/armory:/armory -e PUID=1000 -e PGID=1000 --name armory_container your_image_name

   ### Connect to the Container via SSH
   $ ssh -X -i pht root@localhost -p 2222

   ### Start Armory Inside the Container
   $ python /root/.armory/Armory3/ArmoryQt.py

   ### X11 Server

   In order to see Armory, you're going to need an X11 server. Some popular ones:

   - **Windows:** [vcXsrv](https://sourceforge.net/projects/vcxsrv/)
   - **Mac:** [XQuartz](https://www.xquartz.org/)

