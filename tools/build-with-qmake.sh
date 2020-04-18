#! /bin/bash
# Last Update: 18 April 2020
# Original Code is from: https://github.com/linuxdeploy/QtQuickApp TheAssassin
# I run Shell Check, it requires strict Bash Standards, so the extra code is to pass the test. 
# replace the ? in shell check
# cd /mnt/qnap-light-wizzard/workspace/GalaticCalculator/Galaxy-Calculator/tools; shell?check -x build-with-qmake.sh

# Debug Information
set -x; 
# Exit on error
set -e;

# use RAM disk if possible (as in: not building on CI system like Travis, and RAM disk is available)
if [ "$CI" == "" ] && [ -d "/dev/shm" ]; then TEMP_BASE="/dev/shm"; else TEMP_BASE="/tmp"; fi

# building in temporary directory to keep system clean
BUILD_DIR="$(mktemp -d -p "$TEMP_BASE" "${BIN_PRO_RES_NAME}-build-XXXXXX")";

# make sure to clean up build dir, even if errors occur
function cleanup()
{
    if [ -d "$BUILD_DIR" ]; then
        rm -rf "$BUILD_DIR";
    fi
}
trap cleanup EXIT

# store repo root as variable
REPO_ROOT="$(readlink -f "$(dirname "$(dirname "$0")")")";
OLD_CWD="$(readlink -f .)";

# switch to build dir
pushd "$BUILD_DIR";

# configure build files with qmake
qmake -makefile "${REPO_ROOT}";

# build project and install files into AppDir
make -j"$(nproc)";
make install INSTALL_ROOT="AppDir";

# now, build AppImage using linuxdeploy and linuxdeploy-plugin-qt
# download linuxdeploy and its Qt plugin
wget -c -nv "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage";
wget -c -nv "https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage";

# make them executable
chmod +x linuxdeploy*.AppImage;

# AppImage update informatoin
# Renamed -*x86_64.AppImage.zsync not sure what the * does, but if it does version numbers, I do not want it.
export UPDATE_INFORMATION="gh-releases-zsync|${GITHUB_USERNAME}|${GITHUB_PROJECT}|continuous|${BIN_PRO_RES_NAME}${LINUX_DEPLOY_APP_ZSYNC_ARCH}";

# make sure Qt plugin finds QML sources so it can deploy the imported files
export QML_SOURCES_PATHS="${REPO_ROOT}/qml";

# QtQuickApp does support "make install", but we don't use it because we want to show the manual packaging approach in this example
# initialize AppDir, bundle shared libraries, add desktop file and icon, use Qt plugin to bundle additional resources, and build AppImage, all in one command
./linuxdeploy-x86_64.AppImage --appdir "AppDir" -e "${BIN_PRO_RES_NAME}" -i "${REPO_ROOT}/resources/${BIN_PRO_RES_NAME}.png" -d "${REPO_ROOT}/resources/${BIN_PRO_RES_NAME}.desktop" --plugin qt --output appimage;

# Move both AppImages
mv "${BIN_PRO_RES_NAME}"*.AppImage* "$OLD_CWD";
# Pop Directory for Qt Installer Framework
popd;

echo "Running Qt Installer Framework";

# Instead of trying to install Qt Installer Framework, I use 7zip to compress the bin folder
# I will use a relative path from TRAVIS_BUILD_DIR
# I hard code the path
mkdir -pv qtinstallerframework;
7z e "${QIF_ARCHIVE}" -o./qtinstallerframework;
chmod -R +x ./qtinstallerframework;
# Copy all the files that Qt Installer Framework needs
cp -v "${TRAVIS_BUILD_DIR}/${BIN_PRO_RES_NAME}${LINUX_DEPLOY_APP_IMAGE_ARCH}" "${QIF_PACKAGE_DATA}";
cp -v "${TRAVIS_BUILD_DIR}/${BIN_PRO_RES_NAME}${LINUX_DEPLOY_APP_ZSYNC_ARCH}" "${QIF_PACKAGE_DATA}";
# The packages/${QIF_PACKAGE_URI}/meta/installscript.qs creates this: cp -v "resources/Galaxy-Calculator.desktop" "${QIF_PACKAGE_DATA}";
cp -v "${TRAVIS_BUILD_DIR}/resources/Galaxy-Calculator.png" "${QIF_PACKAGE_DATA}";
cp -v "${TRAVIS_BUILD_DIR}/resources/Galaxy-Calculator.svg" "${QIF_PACKAGE_DATA}";
cp -v "${TRAVIS_BUILD_DIR}/resources/Galaxy-Calculator.ico" "${QIF_PACKAGE_DATA}";
rsync -Ravr "${TRAVIS_BUILD_DIR}/usr/share/icons" "${QIF_PACKAGE_DATA}/icons";
ls "${QIF_PACKAGE_DATA}/icons";

echo "Running Qt Installer Framework";
./qtinstallerframework/binarycreator -c "${TRAVIS_BUILD_DIR}/config/config.xml" -p "${TRAVIS_BUILD_DIR}/packages" "${ARTIFACT_QIF}";
ls;
echo "Completed build-with-qmake.sh";
