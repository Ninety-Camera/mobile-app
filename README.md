# Ninety Camera - Smart Monitoring Platform for Security Cameras

Ninety Camera is a smart monitoring platform for security cameras which can detect human intrusions from camera footage and notify users about the intruder. The whole system is come up with a desktop application, mobile applicatin and a web application(only for the system developer). This is the mobile application. By this
application user can receive notifications about the human intrsions from the desktop application. As well as 
users can view the images of the intrusion and the short video of the human intrusion.

![GitHub language count](https://img.shields.io/github/languages/count/Ninety-Camera/mobile-app-new)
![GitHub top language](https://img.shields.io/github/languages/top/Ninety-Camera/mobile-app-new)
![GitHub repo size](https://img.shields.io/github/repo-size/Ninety-Camera/mobile-app-new)

## Technologies used
 - Flutter
 - Firebase
 
## Download the builded apk and appbundle
You can download the builded releases of the application by following this [link](https://drive.google.com/drive/folders/1DyCxkVg88vhtqmSoLFGr0rkOJWZ-iGVd?usp=sharing)

## Functionalities
 - Register for the system
 - Sign in to the system
 - Scan QR code of the system and subscribe for intrusion notifications
 - Receive intrusion notifications
 - View system status
 - Stop intrusion detection (Only for the owner of the system)
 - View images and videos of recent intrusions.

## Setup for the development

### Install flutter SDK
You can download the flutter sdk and install it by following this [link](https://docs.flutter.dev/get-started/install)

### Fork the repository
Fork this repository to your account and then clone it to your pc. 

### Install flutter dependencies
To start the application and run you need to execute ```flutter pub get``` command. Then flutter sdk collects the required packages and install them.

### Setup firebase project and add the configurations.
You can create a firebase project in the firebase console. And then create an android, ios apps inside the project. After that you can configure the mobile app with firebase configurations. Otherwise you can use firebase cli to configure the settings. [firebase Cli](https://firebase.flutter.dev/docs/cli/)

### Then you are good to go for the development.


You can find the backend of this application in [here](https://github.com/Ninety-Camera/web-backend)




