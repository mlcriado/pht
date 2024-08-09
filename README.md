   # PHT Project

   ## Instructions

   ### Clone the Repository
   \`\`\`bash
   git clone https://github.com/mlcriado/pht.git
   cd pht
   \`\`\`

   ### Generate SSH Keys
   \`\`\`bash
   ssh-keygen -t rsa -b 4096 -f pht
   \`\`\`

   ### Build the Docker Image
   You can name the Docker image as you prefer. Replace \`your_image_name\` with your desired name.
   \`\`\`bash
   docker build -t your_image_name .
   \`\`\`

   ### Run the Docker Container
   Replace \`your_image_name\` with the name you used in the previous step.
   \`\`\`bash
   docker run -d -p 2222:22 --name armory_container your_image_name
   \`\`\`

   ### Connect to the Container via SSH
   \`\`\`bash
   ssh -X root@localhost -p 2222
   \`\`\`

   ### Start Armory Inside the Container
   \`\`\`bash
   python /root/.armory/Armory3/ArmoryQt.py
   \`\`\`

   ### X11 Server

   In order to see Armory, you're going to need an X11 server. Some popular ones:

   - **Windows:** [vcXsrv](https://sourceforge.net/projects/vcxsrv/)
   - **Mac:** [XQuartz](https://www.xquartz.org/)

