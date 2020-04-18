#! /bin/bash
#
# Last Update: 18 April 2020
#
# Original Code is from: https://github.com/linuxdeploy/QtQuickApp TheAssassin
#
# This file is Open Source and I tried my best to make it cut and paste, so I am adding the Environment Variables here
# as well as the OS installer.
# I got some of my concepts and code from this project https://github.com/patrickelectric/mini-qml I use his upload.sh
#
# I run Shell Check, it requires strict Bash Standards, so the extra code is to pass the test. 
# replace the ? in shell check
# In my Environment I define DEV_CURRENT_PROJECT="path to root of this project"; 
# and I define Shell Check DEV_SHELL_CHECK="shell?check"; again remove the "?", 
# you can not use that word in any doc you check, it is a Key Word used only by it, you define exceptions to your code.
# cd "${DEV_CURRENT_PROJECT}/tools"; "$DEV_SHELL_CHECK" -x build-with-qmake.sh
# If you see no output, you have no warnings or errors.
# You can automate the checking of your scripts this way.
#
# I will not minimize this code, but if I did, you would understand why I put ";" to terminate all lines requiring them.
# 
# Debug Information, not always a good idea when not debugging, and thanks to the TheAssassin, this is now working.
# These are the setting you might want to change
declare -ix DEBUGGING; DEBUGGING=0;
declare -ix USE_CAP_DASH; USE_CAP_DASH=1;
# Below should be agnostic
if [ "${DEBUGGING}" -eq 1 ]; then
    set -x; 
fi
# Exit on error
set -e;
#
# Terminal Color Codes
export WARNING_COLOR='\e[33m';
export NC='\033[0m';
# Define GITHUB_TOKEN in your Travis Settings Environment Variable error if not set, its not safe to store it in plain text
if [ -z "${GITHUB_TOKEN}" ]; then
    echo -e "${WARNING_COLOR}Add GITHUB_TOKEN to your Travis Settings Environment Variable with a value from Github Settings Developer Personal access tolkens${NC}";
    exit 1;
fi
# Define GITHUB_EMAIL in your Travis Settings Environment Variable error if not set, its not safe to store it in plain text
if [ -z "${GITHUB_EMAIL}" ]; then
    echo -e "${WARNING_COLOR}Add GITHUB_EMAIL to your Travis Settings Environment Variable with your Github email address${NC}";
    exit 1;
fi
# TRAVIS_REPO_SLUG should always have your GITHUB_USERNAME as the first part / GITHUB_PROJECT, so I split them to use later.
if [ -z "${GITHUB_USERNAME}" ] || [ -z "${GITHUB_PROJECT}" ]; then
    OLD_IFS="$IFS"; IFS='/'; read -ra repo_parts <<< "$TRAVIS_REPO_SLUG"; IFS="$OLD_IFS";
    export GITHUB_USERNAME="${repo_parts[0]}";  export GITHUB_PROJECT="${repo_parts[1]}";
fi
# If not defined it will use this as a default
if [ -z "${BIN_PRO_RES_NAME}" ]; then
    if [ "${USE_CAP_DASH}" -eq 1 ]; then
        OLD_IFS="$IFS"; IFS='-'; read -ra bin_parts <<< "$GITHUB_PROJECT"; IFS="$OLD_IFS";
        for i in "${bin_parts[@]}"; do
            if [ -n "${BIN_PRO_RES_NAME}" ]; then BIN_PRO_RES_NAME="${BIN_PRO_RES_NAME}-"; fi
            BIN_PRO_RES_NAME="${BIN_PRO_RES_NAME}${i^}";
        done
    else
        BIN_PRO_RES_NAME="${GITHUB_PROJECT}";
    fi
    echo -e "${WARNING_COLOR}Add BIN_PRO_RES_NAME (BIN_PRO_RES_NAME=${BIN_PRO_RES_NAME}) to your Travis Settings Environment Variable with a value from Github value for Binary, pro, and resource Name ${NC}";
fi
# Qt Version to install based on travis.yml Environment Variable QT_BEINERI_VERSION
if [ -z "$QT_BEINERI_VERSION" ]; then 
    echo -e "${WARNING_COLOR}Add QT_BEINERI_VERSION to your travis.yml file to use from beineri repo, qt512${NC}";
    exit 1;
fi
#
if [ -z "${QTV}" ]; then
    case "$QT_BEINERI_VERSION" in
      "5.12*")
            export QTV="qt512";
            ;;
      "5.14*")
            export QTV="qt514";
            ;;
      *)
        echo -n "unknown"
        ;;
    esac
    echo -e "${WARNING_COLOR}Add QTV to your Travis Settings Environment Variable with the version of Qt you want to use from beineri repo, qt512${NC}";
fi
# QT_WASM_VER Qt WASM Version
if [ -z "${QT_WASM_VER}" ]; then
    export QT_WASM_VER="5.13_latest";
    echo -e "${WARNING_COLOR}Add QT_WASM_VER to your Travis Settings Environment Variable with the version of Qt WASM, 5.13_latest${NC}";
fi
# Qt Installer Framework Package Folder
if [ -z "${QIF_PACKAGE_URI}" ]; then
   echo -e "${WARNING_COLOR}Add QIF_PACKAGE_URI to your Travis Settings Environment Variable with the URI for your Project.${NC}";
   exit 1;
fi
# Set the data path
if [ -z "${QIF_PACKAGE_DATA}" ]; then
   export QIF_PACKAGE_DATA="${QIF_PACKAGE_URI}/data";
fi
# I downloaded the version of Qt Installer I needed, and 7ziped the bin folder
# I put it in the tools folder, I will extract it later
if [ -z "${QIF_ARCHIVE}" ]; then
   echo -e "${WARNING_COLOR}Add QIF_ARCHIVE to your Travis Settings Environment Variable with the folder/file.7z that contains an Archive of the Qt Installer Framework bin folder${NC}";
   export QIF_ARCHIVE="tools/qtinstallerframework.7z";
fi
# 
# use RAM disk if possible (as in: not building on CI system like Travis, and RAM disk is available)
if [ "$CI" == "" ] && [ -d "/dev/shm" ]; then TEMP_BASE="/dev/shm"; else TEMP_BASE="/tmp"; fi
# 
echo "Install qt libraries for Linux";
sudo apt-get update --yes; sudo apt-get install --yes p7zip;
sudo apt-get install --yes "${QTV}base" "${QTV}quickcontrols" "${QTV}quickcontrols2" "${QTV}graphicaleffects" "${QTV}svg" "${QTV}scxml" "${QTV}script" "${QTV}tools" "${QTV}translations" "${QTV}x11extras" "${QTV}declarative" libgl1-mesa-dev;
sudo apt-get autoremove; sudo apt-get -f install; sudo apt-get autoclean;
# Source the Qt Environment
if [ -f "/opt/qt${QTV}/bin/qt${QTV}-env.sh" ]; then 
    # shellcheck disable=SC1090
    source "/opt/qt${QTV}/bin/qt${QTV}-env.sh";
else
    echo "${WARNING_COLOR}Error /opt/qt${QTV}/bin/qt${QTV}-env.sh Not found!${NC}"
    exit 1;
fi
# Set our Artifacts for later
export ARTIFACT_QIF="${BIN_PRO_RES_NAME}-Installer";
export LINUX_DEPLOY_APP_IMAGE_ARCH="-x86_64.AppImage";  export LINUX_DEPLOY_APP_ZSYNC_ARCH="-x86_64.AppImage.zsync";
export ARTIFACT_APPIMAGE="${BIN_PRO_RES_NAME}${LINUX_DEPLOY_APP_IMAGE_ARCH}";  export ARTIFACT_ZSYNC="${BIN_PRO_RES_NAME}${LINUX_DEPLOY_APP_ZSYNC_ARCH}";
#
# building in temporary directory to keep system clean
BUILD_DIR="$(mktemp -d -p "$TEMP_BASE" "${BIN_PRO_RES_NAME}-build-XXXXXX")";
# 
# make sure to clean up build dir, even if errors occur
function cleanup()
{
    if [ -d "$BUILD_DIR" ]; then
        rm -rf "$BUILD_DIR";
    fi
}
trap cleanup EXIT
# 
# store repo root as variable
REPO_ROOT="$(readlink -f "$(dirname "$(dirname "$0")")")";
OLD_CWD="$(readlink -f .)";
# 
# switch to build dir
pushd "$BUILD_DIR";
# 
# configure build files with qmake
qmake -makefile "${REPO_ROOT}";
# 
# build project and install files into AppDir
make -j"$(nproc)";
make install INSTALL_ROOT="AppDir";
# 
# now, build AppImage using linuxdeploy and linuxdeploy-plugin-qt
# download linuxdeploy and its Qt plugin
wget -c -nv "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage";
wget -c -nv "https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage";
# 
# make them executable
chmod +x linuxdeploy*.AppImage;
# 
# AppImage update informatoin
# Renamed -*x86_64.AppImage.zsync not sure what the * does, but if it does version numbers, I do not want it.
export UPDATE_INFORMATION="gh-releases-zsync|${GITHUB_USERNAME}|${GITHUB_PROJECT}|continuous|${BIN_PRO_RES_NAME}${LINUX_DEPLOY_APP_ZSYNC_ARCH}";
# 
# make sure Qt plugin finds QML sources so it can deploy the imported files
export QML_SOURCES_PATHS="${REPO_ROOT}/qml";
# 
# QtQuickApp does support "make install", but we don't use it because we want to show the manual packaging approach in this example
# initialize AppDir, bundle shared libraries, add desktop file and icon, use Qt plugin to bundle additional resources, and build AppImage, all in one command
./linuxdeploy-x86_64.AppImage --appdir "AppDir" -e "${BIN_PRO_RES_NAME}" -i "${REPO_ROOT}/resources/${BIN_PRO_RES_NAME}.png" -d "${REPO_ROOT}/resources/${BIN_PRO_RES_NAME}.desktop" --plugin qt --output appimage;
# 
# Move both AppImages
mv "${BIN_PRO_RES_NAME}"*.AppImage* "$OLD_CWD";
# Pop Directory for Qt Installer Framework
popd;
# 
echo "Running Qt Installer Framework";
# 
# Instead of trying to install Qt Installer Framework, I use 7zip to compress the bin folder
# I will use a relative path from TRAVIS_BUILD_DIR
# I hard code the path
mkdir -pv qtinstallerframework;
7z e "${QIF_ARCHIVE}" -o./qtinstallerframework;
chmod -R +x ./qtinstallerframework;
# 
# Copy all the files that Qt Installer Framework needs
cp -v "${TRAVIS_BUILD_DIR}/${BIN_PRO_RES_NAME}${LINUX_DEPLOY_APP_IMAGE_ARCH}" "${QIF_PACKAGE_DATA}";
cp -v "${TRAVIS_BUILD_DIR}/${BIN_PRO_RES_NAME}${LINUX_DEPLOY_APP_ZSYNC_ARCH}" "${QIF_PACKAGE_DATA}";
# The packages/${QIF_PACKAGE_URI}/meta/installscript.qs creates this: cp -v "resources/${BIN_PRO_RES_NAME}.desktop" "${QIF_PACKAGE_DATA}";
cp -v "${TRAVIS_BUILD_DIR}/resources/${BIN_PRO_RES_NAME}.png" "${QIF_PACKAGE_DATA}";
cp -v "${TRAVIS_BUILD_DIR}/resources/${BIN_PRO_RES_NAME}.svg" "${QIF_PACKAGE_DATA}";
cp -v "${TRAVIS_BUILD_DIR}/resources/${BIN_PRO_RES_NAME}.ico" "${QIF_PACKAGE_DATA}";
rsync -Ravr "${TRAVIS_BUILD_DIR}/usr/share/icons" "${QIF_PACKAGE_DATA}/icons";
ls "${QIF_PACKAGE_DATA}/icons";
# 
echo "Running Qt Installer Framework";
./qtinstallerframework/binarycreator -c "${TRAVIS_BUILD_DIR}/config/config.xml" -p "${TRAVIS_BUILD_DIR}/packages" "${ARTIFACT_QIF}";
ls;
echo "Completed build-with-qmake.sh";
