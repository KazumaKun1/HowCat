# HowCat
A delightful app that offers random cat images and fun facts about cats with just a tap, perfect for feline enthusiasts!

## Appendix

This project is using:
- Swift 6.0
- SwiftUI
- MVVM Architecture
- Unit Tests/UI Tests
- 3rd party library (Kingfisher)

In order to run this you need to have:
- Xcode 16 but you can try to use Xcode 15.xx.
    - This is to avoid issues when running this project on lower versions of xcode and macOS.
- macOS Sonoma 14.5+ since this is the version where the Xcode 15 & 16 series will run.
- iOS 18 for the simulator since it's the minimum deployment
- __(Optional)__ Sourcetree for easier cloning but you can clone this using Git terminal.

After cloning the project, make sure that you select __main__ as the main branch.
After selecting the branch, you can open the project by:
- Opening xcode 16
- Selecting "Open a project or file"
- Browse using the path that you save during cloning
- Find the __.HowCat.xcodeproj__ file then open it
Then in order to run the project you can simply press __ctrl + R__ on your keyboard to build and run.

## Apple Framework used
- SwiftUI
- Combine
- XCTest

## 3rd-Party Packages Used via Swift Package Manager
- Kingfisher

## Folder Structure
- HowCat
  - Constants
  - Enums
  - Loaders
  - Main
    - Model
    - View
    - ViewModel
  - Services
- HowCatTests
  - Services
  - ViewModel
- HowCatUITests

## Features/Functionality

- Tap anywhere on the screen to get a new fact of cats with image
- Semi-localization on the cat facts depending on your preferred language that has been set on your device's settings
- Share feature to share with anyone
- Accessibility support
- Dark mode support
- Supported iPhone and iPad screens

## Video (IPhone)
https://github.com/user-attachments/assets/30e49bf5-2790-4c65-bb69-916a4fa28faf

## Video (IPad)
https://github.com/user-attachments/assets/d8135ef8-6aaa-44ac-8026-4e3fa82244d6

## Screenshots (IPhone - Portrait)
![HowCat App Screenshots](https://i.ibb.co/sJkNPNH/Intro-Portrait.png)
![HowCat App Screenshots](https://i.ibb.co/2t0ZP26/Fact-Portrait.png)
![HowCat App Screenshots](https://i.ibb.co/xSd6htM/Fact-Loading-Portrait.png)

## Semi-localization
![HowCat App Screenshots](https://i.ibb.co/jHnJ49S/Semi-localization-Settings.png)
![HowCat App Screenshots](https://i.ibb.co/YBJ5kBW/Semi-localization-in-action.png)

## Screenshots (IPhone - Landscape)
![HowCat App Screenshots](https://i.ibb.co/ck79HT8/Intro-Landscape.png)
![HowCat App Screenshots](https://i.ibb.co/SXdB5BR/Fact-Landscape.png)
![HowCat App Screenshots](https://i.ibb.co/yPMMk6f/Fact-Loading-Landscape.png)

## Screenshots (IPad - Portrait)
![HowCat App Screenshots](https://i.ibb.co/CKKrPHK/Intro-Portrait.png)
![HowCat App Screenshots](https://i.ibb.co/p3Ckvr3/Fact-Portrait.png)
![HowCat App Screenshots](https://i.ibb.co/JKp935g/Fact-Loading-Portrait.png)

## Screenshots (IPad - Landscape)
![HowCat App Screenshots](https://i.ibb.co/7zkp9Gp/Intro-Landscape.png)
![HowCat App Screenshots](https://i.ibb.co/NjLcLbc/Fact-Landscape.png)
![HowCat App Screenshots](https://i.ibb.co/DzJZ3T4/Fact-Loading-Landspace.png)
