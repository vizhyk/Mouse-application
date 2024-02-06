## Qt application environment setup guide.

1. Download any C++ compiler that allows C++ 14/17 standard. I would recommend just install [Visual studio](https://visualstudio.microsoft.com/ru/).
2. Download Qt framework and IDE online installer [Qt](https://www.qt.io/product/development-tools).
3. Make a Qt account if you don't have it yet and log in.
4. Choose custom installation and mark  Qt->Qt 6.5.3, Qt design studio -> Qt design studio 4.3.1 and Developer and designer tools(you can left only most modent MinGW compiler) as necessary components.

[Video guide](https://www.youtube.com/watch?v=yIv0vO8B7tQ)

---

## Build guide.

1. Start Qt creator and open project by clicking Open Project button in Qt creator main menu. You have to choose CMakeLists.txt file in mouse_app directory to open project correctly.
2. Go to the Projects tab on the left side menu and check Current Configuration window. Ensure the qt found the compiler, check status of CMAKE_C_COMPILER and CMAKE_PREFIX_PATH flags.
3. Configure project kits. **You can build project only with MSVC2019 64bit kit. Other kits are not able to work with BLE libraries**. So make sure you are using Desktop Qt 6.5.3 MSVC2019 64bit kit.
4. Build the project



---

## Deployment.

## Windows

1. Open your terminal and move to directory with deployment tool **cd /Path/to/QtInstalltion/Qt/6.5.3/msvc2019_64/bin**.
2. Use this command to begin the deployment **./windeployqt.exe /Path/to/directory/with/applicationExeFile/mouse-app.exe**.
3. Manually move shape_predictor_68_face_landmarks.dat to build_mouse_app-Desktop_Qt_6_5_3_MSVC2019_64bit-Debug directory.
4. Manually move eye_detector directory to build_mouse_app-Desktop_Qt_6_5_3_MSVC2019_64bit-Debug/HeartRateGame directory.
5. Manually move video3 to build_mouse_app-Desktop_Qt_6_5_3_MSVC2019_64bit-Debug/HeartRateGame/images directory.

**Only for MacOS**: Ensure that before build there is a directory shared with .plist file in the same directory with mouse-app-mac. If you can't find this file in mouse-app-mac/mouse-app.app/Contents, just add it manually.

MacOS deployment tool [windeployqt](https://doc.qt.io/qt-6/windows-deployment.html)

## MacOs

1. Open your terminal and move to directory with deployment tool **cd /Path/to/QtInstalltion/Qt6.5/6.5.3/macos/bin**
2. Use this command to begin the deployment **./macdeployqt /Path/to/directory/with/applicationAppFile/mouse-app.app -qmldir=/Path/to/directory/after/Deploy -dmg -verbose=3 -always-overwrite**.
3. Manually add video3, eye_detector and shape_predictor_68_face_landmarks.dat to mouse-app-mac/mouse-app.app/Contents/MacOS

MacOS deployment tool [macdeployqt](https://doc.qt.io/qt-6/macos-deployment.html)

---

## Eye detecor environment setup guide.

1. Download and install [Anaconda Navigator](https://docs.anaconda.com/free/navigator/index.html)
2. Install Visual Studio code from Anaconda or manually.
3. Open Environments tab and import opencv_env
4. Activate environment and open Visual Studio Code.
5. Install python [plugin] (https://marketplace.visualstudio.com/items?itemName=ms-python.python) for Visual Studio code.
6. Try to compile script by command python eye_detector.py 0 1 3

---

# Eye detector deployment

1. Install [pyinstaller](https://pypi.org/project/pyinstaller/) by pip or manually using command **pip install pyinstaller**
2. deploy by command **pyinstaller --onefile eye_detector.py**

---
## Links

Project based on [Bluetooth Low Energy Heart Rate Game](https://doc.qt.io/qt-6/qtbluetooth-heartrate-game-example.html)
