📺 Marvel Comics Roku App
A simple Roku application demonstrating API usage, Scene Graph components, video playback, and app navigation.
📹 **Demo Video:**  
[![Watch the Video]](https://jmp.sh/s/eGnt8wiKwDdOSTlf9rLR)
📝 Table of Contents
Overview
Features
Setup & Installation
Marvel API Integration
Project Structure
Usage
Future Enhancements
License
📖 Overview
This project is a Roku application that fetches data from the Marvel Comics API and displays a scrollable grid of comic book covers. Upon selection, it navigates to a details screen showing the characters from that comic. Selecting a character plays a video using Roku's native video player.
This project is designed to highlight:
API usage & data representation
Scene Graph component usage
Video playback
App navigation
✨ Features
✅ Fetches and displays Marvel Comics in a scrollable grid
✅ Opens a details page with characters from the selected comic
✅ Displays character details with images and descriptions
✅ Plays a sample video using Roku's native video player
✅ Smooth navigation between screens
 
⚡ Setup & Installation
Clone the Repository
Get Marvel API Key
Register at Marvel Developer Portal
Generate public & private API keys
Add them in the config.json file:
Install Roku Developer Tools
Follow Roku's Developer Setup.
Deploy the App to Roku
Zip the project and upload it via Roku Developer Mode
Or use the Roku Development Server:
🔗 Marvel API Integration
This app interacts with the Marvel Comics API to fetch data:
Get Comics (Grid view)
Get Characters for a Comic (Details Page)
📂 Project Structure
📦 marvel-roku-app
 ┣ 📂 components
 ┃ ┣ 📜 MainScene.xml          # Main Scene for comic grid
 ┃ ┣ 📜 ComicDetails.xml       # Details view for selected comic
 ┃ ┣ 📜 CharacterDetails.xml   # Character details and video playback
 ┣ 📂 assets
 ┃ ┣ 📜 images/                # Static assets
 ┣ 📂 source
 ┃ ┣ 📜 util.brs          # API calls to Marvel
 ┃ ┣ 📜 main.brs           # Main application logic
 ┣ 📜 manifest                 # Roku app metadata
 ┣ 📜 config.json              # API keys configuration
 ┣ 📜 README.md                # Documentation
🚀 Usage
Launch the app on your Roku device.
Browse Comics: Scroll through the available comics.
View Details: Select a comic to see the characters.
Play Video: Choose a character to play the sample video.

 
