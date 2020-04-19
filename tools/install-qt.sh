#! /bin/bash
# I run Shell Check, it requires strict Bash Standards, so the extra code is to pass the test. 
# replace the ? in shell check
# In my Environment I define DEV_CURRENT_PROJECT="path to root of this project"; 
# and I define Shell Check DEV_SHELL_CHECK="shell?check"; again remove the "?", 
# you can not use that word in any doc you check, it is a Key Word used only by it, you define exceptions to your code.
# cd "${DEV_CURRENT_PROJECT}/tools"; "$DEV_SHELL_CHECK" -x install-qt.sh
# If you see no output, you have no warnings or errors.
# You can automate the checking of your scripts this way.
declare -ix DEBUGGING;         DEBUGGING=1;          # Set 1=True and 0=False
declare -ix EXIT_ON_UNDEFINED; EXIT_ON_UNDEFINED=0;  # Set 1=True and 0=False
# Below should be agnostic
if [ "${DEBUGGING}" -eq 1 ]; then set -x; fi
# Exit on error
set -e;
#
# Terminal Color Codes
declare WARNING_COLOR='\e[33m';
declare NC='\033[0m';
declare QT_BEINERI_VERSION; QT_BEINERI_VERSION="$1";
echo "QT_BEINERI_VERSION=$QT_BEINERI_VERSION";
# Qt Version to install based on travis.yml Environment Variable QT_BEINERI_VERSION
if [ -z "${QT_BEINERI_VERSION+x}" ]; then 
    echo -e "${WARNING_COLOR}Add QT_BEINERI_VERSION to call this script in your travis.yml file to use from beineri repo, qt512${NC}";
    QT_BEINERI_VERSION="qt514";
    if [ "${EXIT_ON_UNDEFINED}" -eq 1 ]; then exit 1; fi    
fi
# QTV You can set this in your Environment, so do not overwrite it
if [ -z "${QTV+x}" ]; then
    declare -x QTV; QTV="$QT_BEINERI_VERSION";
fi
# If not defined it will exit
if [ -z "${BIN_PRO_RES_NAME+x}" ]; then
    echo -e "${WARNING_COLOR}Add BIN_PRO_RES_NAME (BIN_PRO_RES_NAME=${BIN_PRO_RES_NAME}) to your Travis Settings Environment Variable with a value from Github value for Binary, pro, and resource Name ${NC}";
    if [ "${EXIT_ON_UNDEFINED}" -eq 1 ]; then exit 1; fi    
fi
# Qt Installer Framework Package Folder
if [ -z "${QIF_PACKAGE_URI+x}" ]; then
    echo -e "${WARNING_COLOR}Add QIF_PACKAGE_URI to your Travis Settings Environment Variable with the URI for your Project.${NC}";
    if [ "${EXIT_ON_UNDEFINED}" -eq 1 ]; then exit 1; fi    
fi
# Set the data path
if [ -z "${QIF_PACKAGE_DATA}" ]; then
    declare -x QIF_PACKAGE_DATA; QIF_PACKAGE_DATA="${QIF_PACKAGE_URI}/data";
fi
# I downloaded the version of Qt Installer I needed, and 7ziped the bin folder
# I put it in the tools folder, I will extract it later
if [ -z "${QIF_ARCHIVE+x}" ]; then
    echo -e "${WARNING_COLOR}Add QIF_ARCHIVE to your Travis Settings Environment Variable with the folder/file.7z that contains an Archive of the Qt Installer Framework bin folder${NC}";
    declare -x QIF_ARCHIVE; QIF_ARCHIVE="tools/qtinstallerframework.7z";
fi
# 
echo "Install qt libraries for Linux";
sudo apt-get update --yes -q; 
sudo apt-get install --yes -q "${QTV}base" "${QTV}quickcontrols" "${QTV}quickcontrols2" "${QTV}graphicaleffects" "${QTV}svg" "${QTV}scxml" "${QTV}script" "${QTV}tools" "${QTV}translations" "${QTV}x11extras" "${QTV}declarative";
#sudo apt-get autoremove; sudo apt-get -f install; sudo apt-get autoclean;
# Source the Qt Environment file
if [ "${DEBUGGING}" -eq 1 ]; then set +x; fi
if [ -f "/opt/${QTV}/bin/${QTV}-env.sh" ]; then 
    # shellcheck disable=SC1090
    source "/opt/${QTV}/bin/${QTV}-env.sh";
    echo "Done Sourcing";
else
    echo "${WARNING_COLOR}Error /opt/${QTV}/bin/${QTV}-env.sh Not found!${NC}"
    ls /opt/;
    if [ "${EXIT_ON_UNDEFINED}" -eq 1 ]; then exit 1; fi    
fi
echo "Done with Qt Installation and setting Environment"; 
echo "Completed install-qt.sh";
################################ End of File ##################################
