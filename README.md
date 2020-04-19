# Galaxy Calculator

Galaxy Calculator has 4 Calculators built into it:
1. :milky_way: Galatic Calculator
2. :confounded: Madness Calculator
3. :earth_americas: Planet Calculator
4. :computer: Calculator

All use [BigNumber.js](https://github.com/MikeMcl/bignumber.js) https://github.com/MikeMcl/bignumber.js

The Galaxy, Madness and Planet Calculators are based on Sir Isaac Newtons Calculations, and was updated to include the Math Nikola Tesla, 
thus inventing a new type of Math I call Trinary Mathematics, that is used to Calculate the Galaxy.

This Project is Open Source, with No License required, this is a Qt Quick QML App, that will run on Desktop and other devices, the bash script I used to port to this app is included.

This App can be compiled for any OS that Qt supports: Linux, Windows, MAC, Android and iOS, as well as every OS that Qt supports, so this should run on most if not all popular OS's.

I will try to make installers and executable for all supported Qt OS's, currently I have:

If the badges are Green, you should be able to download the apps, if they are not, it might be that I am working on it, but it only takes a few minutes to update.

This project is in work, so files might break, but source code should run if compiled on any machine.

The Qt Installer Framework is working for Linux and Windows, but Linux is still broken, in work, and the Windows Installer will not download.

## Status
Unix: [![Travis Build Status](https://travis-ci.org/Light-Wizzard/galaxy-calculator.svg?branch=master)](https://travis-ci.org/Light-Wizzard/galaxy-calculator)
Windows: [![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/galaxy-calculator)

## :package: **Downloads:**
 - :penguin: [Linux](https://github.com/Light-Wizzard/galaxy-calculator/releases/download/continuous/Galaxy-Calculator-x86_64.AppImage)
 - :penguin: :inbox_tray: [Linux ZSync](https://github.com/Light-Wizzard/galaxy-calculator/releases/download/continuous/Galaxy-Calculator-x86_64.AppImage.zsync)
 - :penguin: :outbox_tray: [Linux Installer in work](https://github.com/Light-Wizzard/galaxy-calculator/releases/download/continuous/Galaxy-Calculator-Installer)
 - :office: [Windows](https://github.com/Light-Wizzard/galaxy-calculator/releases/download/continuous/galaxy-calculator_release.zip)
 - :apple: [Apple](https://github.com/Light-Wizzard/galaxy-calculator/releases/download/continuous/Galaxy-Calculator.dmg)

The builds are here:
* [Travis Builds](https://travis-ci.org/github/Light-Wizzard/galaxy-calculator) [![Travis Build Status](https://travis-ci.org/Light-Wizzard/galaxy-calculator.svg?branch=master)](https://travis-ci.org/Light-Wizzard/galaxy-calculator)
* [AppVeyor Builds](https://ci.appveyor.com/project/Light-Wizzard/galaxy-calculator) [![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/galaxy-calculator)

Windows (Tested on 7 and 10 let me know if 8 works): Download zip and extract it, and run the file galaxy-calculator.exe inside of the deploy folder.

Windows 10 built on my machine, the ones above are created on AppVeyor, but the download is not working.
* Installer: http://LightWizzard.com/installers/windows/GalaxyCalculatorInstaller.exe
* Executable Standalone: http://LightWizzard.com/installers/windows/GalaxyCalculator.exe

These are other versions of the program that I made by hand:

Linux: to use zsync you must have it installed. 
Note, I need to update to version 2 for the Internet, doing that now.

```
# Arch Linux or Manjaro
sudo pacman --noconfirm --needed -S zsync
# Ubunto, LMDE, Debian...
sudo apt install zsync
```

I plan to support as much as I can, once my Book or ePubs start to sell, I will save up for a Mac, and iOS device, so I can make Installers for them.

All my books are free online at http://LightWizzard.com, but it cost money to print them or push ePubs to your device.

I am not publicizing my books here, you can read them for free on my 
[Github account Light-Wizzard/The-Principles-Of-The-Trinary-Universe](https://github.com/Light-Wizzard/The-Principles-Of-The-Trinary-Universe),
but you have to pay for printed books, or the easy of having an ePub delivered through your devices ePub Reader, without having to download it.

Printed Book and ePub Available at:

Lulu
* :book: :computer: http://www.lulu.com/spotlight/LightWizzard

Amazon
* :book: Book https://www.amazon.com/Principles-Trinary-Universe-according-Johannes/dp/1795429186/
* :computer: ePub https://www.amazon.com/Principles-Trinary-Universe-according-Johannes-ebook/dp/B086D24HX9

You can also get it at any major book store, but I would recommend reading it, if you want to know all the details about the Math, you will not find them in the code as much.

If you do not see your OS, just download, extract to a folder, and open with Qt Creator, which must be installed, and compile or run it.

## Development Progress

TableView for Qt version greater than or equal to 5.12, still has a lot of work, as a result, it does not like a few things, like changing themes on the fly, 
or even having a theme, and I cannot seem to get the text alignment to work, as such, the table looks ugly, but will improve with each Qt release.

Stephan Binner made a Qt 5.13.2 version for Xenial for me, and I am using it, so the TableView is looking much better.
https://launchpad.net/~beineri/+archive/ubuntu/opt-qt-5.13.2-xenial

Currently I am working on learning Qt 3D Studio so I can add a Graphical Simulator, that will have two views, 
one of an view of the Galaxy with a sample of Tracks, since screen space is a limiting factor, and the second view is of one Track, for closer inspection.
My goal is to create a 3D Studio scene using on its built in features, so I can change the size of the Galaxy, Sun, Planet and Moon, 
and number of Tracks displayed, so that all variables can be adjusted.

You would have to understand Trinary Science and the Trinary Universe to understand the Galaxy Calculator, 
but basically Trinary has the same meaning as Trinity did to Sir Isaac Newton, it describes and Alternating Current or AC, 
the Father is the +1, the Son is the -1, and the Holy Ghost or Spirit of Mother Nature is 0, so it is Trinary Logic with: +1, -1 and 0 as Logic Levels, 
I use the name Trinary because Newton hated the Teaching of Christ.

There is a configuration screen is where you configure the Galaxy, you can Name the Galaxy, set its Sun Size in Miles in Diameter, 
set its Living Planets Size in Miles in Diameter, set the number of Trinary Engines, see Help for more details, 
and the Radius of of the Galaxy in Miles in Diameter, and how many Tracks you want to print.

I removed the Local Storage Feature due to permissions on some devices.

## Background
The Galaxy Calculator is a one button click to calculate, it records the Track Number, how many Trinary Engines it takes to be on that track, 
its Suns minimum and maximum Speed in Miles an Hour, the Livable Planets Frequency, the Suns Orbital Distance in Miles, and the Tracks Frequency, 
which Sir Isaac Newton used to determine when the End of Civilization will happen, and according to his and my calculation, 
that will happen in the year 2060 under the Julian Calendar still used by the Military, or 2061 under the Gregorian Calendar in use today, 
this was the same calculation given to the Public, but few know how he calculated it, I wrote a new formula, because I could not find his original equation.

Sir Isaac Newton burned his copy of his 2060 Calculation, he wrote that it weights heavy on his SOUL, so he had to let it go, 
and wrote that anyone that wants to know, can figure it out, all the formulas are in the Bible, 36 years later I did find them all.

This Galaxy Calculator was written for use, after I thought about the bash script that created this page:

http://LightWizzard.com/books/trinary.universe/appendix.a.html

The bash script not only crated the page, but calculated the table values.

I hope this helps everyone visualize what the Application needs to do, which is only to graph and plot the path of Stars around the Galaxy.

This is not a Galaxy Simulator, only a Graph and Plot, and that is very important to understand, 
I would like to write a Galaxy Simulator built using only the Laws and Rules or Electronics, 
and that project will be called a Galaxy Simulator, and why this Project is only called a Galaxy Calculator,
but I am looking into using Qt 3D Studio to simulate a simulator.

For more information see: [Wiki](https://github.com/Light-Wizzard/galaxy-calculator/wiki)

This is a work in progress, please report any bugs, and comments.

## Screen Shots

![Galaxy Configuration](/doc/images/screenshot-config.png?raw=true "Galaxy Configuration")

![Galaxy Calculator](/doc/images/screenshot-galaxy.png?raw=true "Galaxy Calculator")

![Energy Calculator](/doc/images/screenshot-energy.png?raw=true "Energy Calculator")

![Madness Calculator](/doc/images/screenshot-madness.png?raw=true "Madness Calculator")

![World Calculator](/doc/images/screenshot-world.png?raw=true "World Calculator")

![Calculator](/doc/images/screenshot-calc.png?raw=true "Calculator")

End of README.md
