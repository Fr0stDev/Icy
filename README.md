##Icy Installer by WeAmDev

This is Icy, the one and only. Originally written by RipDev and picked up by WeAmDev afterwards. 

Icy was the best alternative to Cydia in it's time, but has long been rendered obsolete as new versions of iOS are being released, and Cydia being continuously updated by Jay Freeman (saurian).

This project is now dead, I no longer have time on my hands to maintain it. I think it is time for Icy Installer to finally die. Here is my reasoning:

- It has stopped working on iOS 5.1+ (This needs fixing)
- It is now slower than Cydia (Used to be faster)
- The introduction of the Cydia Store (which Icy does not support)


##Compiling Icy Installer

Icy requires some special steps to compile/work correctly on Apple's latest firmwares:

In order to compile Icy 2.2, you MUST have a codesigning Identity. This may be obtained using keychain access on your Mac. Follow this guide if you have not already done so: http://ihackerpro.com/forum/index.php?topic=271.0

In order to ensure that Icy 2.2 works correctly, ensure the following steps are taken:

 1) Under Icy's Info.plist, "Executable" should be set to "Icy", NOT IcyInstaller*.

 2) Once Icy is compiled (BUILD FOR TESTING), open up the Icy.app folder and go into Icy's Info.plist. NOW you may change the "Executable" to say "IcyInstaller"*.

 3) Finally, package Icy into a deb file. Packaging Icy requires a special postinst script to be run.**


* Do not change the Executable name to "IcyInstaller" BEFORE compiling. If you do so, the "IcyInstaller" binary will be signed instead, which will do two things:
	a) Will NOT sign the main executable ("Icy")
	b) Will cause the complete application to crash on startup.

** Without this script, Icy will NOT be able to run as root, therefore Icy will be unable to Install any packages. This script is included within the source code files enclosed with this statement. 

##TODO

There is nothing to do anymore, but here is a list of things I had in mind:

- Rewrite package backups in a cleaner, less lazy manner.
- Fix iOS 5.1+ compatibility

##Licensing
The MIT License

Copyright © 2009 Ripdev
Copyright © 2012 WeAmDev 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

##Credits

The following RipDev members for the original Icy: 

- Slava "slavikus" Karpenko
- Cyril Murzin

The following iPhone Dev Team Members:

- Alexander "wizdaz" Maksimenko
- Ilya "gray" Popovyan


The following WeAmDev Members:

- Guillermo Moran (fr0st)
- Ben King (Sosumeh)
- Daniel Ferreira (theiostream)
