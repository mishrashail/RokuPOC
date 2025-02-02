# 📺 **Marvel Comics Roku App**
A simple Roku application demonstrating API usage, Scene Graph components, video playback, and app navigation.
 
📹 **Demo Video:**  

https://github.com/user-attachments/assets/0e5e3920-6822-49ac-bf2d-139fdf2a0122
 
---
 
## 📝 **Table of Contents**
- Overview
- Features
- Requirements
- Setup & Installation
- Marvel API Integration
- Project Structure
- Usage
- Future Enhancements
 
---
 
## 📖 **Overview**
This project is a **Roku application** that fetches data from the **Marvel Comics API** and displays a **scrollable grid** of comic book covers. Upon selection, it navigates to a **details screen** showing the characters from that comic. Selecting a character plays a **video using Roku's native player**.
 
This project is designed to highlight:
- API usage & data representation
- Scene Graph component usage
- Video playback
- App navigation
 
---
 
## ✨ **Features**
✅ Fetches and displays **Marvel Comics** in a scrollable grid  
✅ Opens a **details page** with characters from the selected comic  
✅ Displays **character details** with images and descriptions  
✅ Plays a **sample video** using Roku's native video player  
✅ **Smooth navigation** between screens  
 
---
 
## 🛠 **Requirements**
Before you begin, ensure you have the following installed:
 
- [Roku Developer Environment](https://developer.roku.com/docs/developer-program/getting-started/setup.md)
- A Roku device (or Roku Emulator)
- A **Marvel API Key** (get it from [Marvel Developer Portal](https://developer.marvel.com/))
 
---
 
## ⚡ **Setup & Installation**
 
1. **Get Marvel API Key**  
   - Register at [Marvel Developer Portal](https://developer.marvel.com/)
   - Generate **public & private API keys**
 
2. **Install Roku Developer Tools**  
   Follow Roku's [Developer Setup](https://developer.roku.com/docs/developer-program/getting-started/setup.md).
 
3. **Deploy the App to Roku**
   - Zip the project and upload it via Roku Developer Mode  
   - Or use the Roku Development Server:
     ```sh
     curl -d '' http://YOUR_ROKU_IP:8060/install
     ```
 
---
 
## 🔗 **Marvel API Integration**
This app interacts with the **Marvel Comics API** to fetch data:
 
- **Get Comics** (Grid view)
  ```sh
  GET https://gateway.marvel.com/v1/public/comics?apikey=YOUR_PUBLIC_KEY
  ```
 
- **Get Characters for a Comic** (Details Page)
  ```sh
  GET https://gateway.marvel.com/v1/public/comics/{comicId}/characters?apikey=YOUR_PUBLIC_KEY
  ```
 
---
 
## 🎥 **Video Playback**
This app uses Roku's native video player to play a sample video when a character is selected.


## 📂 **Project Structure**
```
📦 marvel-roku-app
┣ 📂 components
┃ ┣ 📜 MainScene.xml          # Main Scene for comic grid
┃ ┣ 📜 ComicDetails.xml       # Details view for selected comic
┃ ┣ 📜 CharacterDetails.xml   # Character details and video playback
┣ 📂 assets
┃ ┣ 📜 images/                # Static assets
┣ 📂 source
┃ ┣ 📜 utils.brs          # API calls to Marvel
┃ ┣ 📜 main.brs           # Main application logic
┣ 📜 manifest                 # Roku app metadata
┣ 📜 README.md                # Documentation
```
 
---
 
## 🚀 **Usage**
1. **Launch the app** on your Roku device.  
2. **Browse Comics**: Scroll through the available comics.  
3. **View Details**: Select a comic to see the characters.  
4. **Play Video**: Choose a character to play the sample video.  
 
---
