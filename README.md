QWToolbox
===

Toolbox for discrete water-quality data review and exploration. 
This is an itial beta version for testing purposes with limited documentation or support.
User are incouraged to post any bugs or comments for additional functionality on the issues page at:

[QWToolbox](https://github.com/USGS-R/QWToolbox/issues)

## Package overview
This package facilitates data review and exploration of discrete water-quality data 
through rapid and easy-to-use plotting functions and tabular data summaries.
Data is imported with user-specified options for single or multiple sites and parameter codes using
an ODBC connection to the user's local NWIS server. A graphical user interface allows the user to easily 
explore their data through a variety of graphical and tabular outputs. Because this packages uses an ODBC
connection and graphical user interface, it requires special installation procedures beyond a typical R package.
Please see the section on installation instructions for further information.

##Installation instructions
There are a number of special considerations for installation of QWToolbox beyond those of a typical R package:
1) This package must be run in 32-bit R for the ODBC driver to function properly,
2) This package requires that the gtk graphical user interface libraries be installed on the user's machine, and
3) The beta-test version of the QWToolbox package must be installed form Github using the R package developement functions in the "devtools" package.

Below is a step-by-step installation procedur, please complete the steps in the order listed below.

###Step 1. Install the ODBC driver and establish the NWIS ODBC connection. 

Your database administrator or IT specialist  will need to assist for this step. Open notepad and paste the following text:

:: Set up DSN for access to NWIS database
odbcconf.exe /A {configsysdsn "Oracle in OraClient11g_home1" "DSN=NWISWY|SERVERNAME=NWISWY|DATABASE=nwismn"}

Replace all instances of "nwismn" with the name of your local NWIS server. Save the file as ODBC.bat on your desktop and double-click to run. You may delete ODBC.bat once the ODBC conncetion has been established.

###Step 2. Switch over to 32-bit R.

R must be run in 32-bit mode to use the ODBC driver. 
Open R-studio and click Tools-Global Options on the top toolbar.
Under "General" in the global options dialog, you will see "R version:" at the top. 
Click "Change" next to the R version and select "Use your machine's default version of R (32 bit)" to change to 32-bit R. R-studio will need to restart after doing this.

###Step 3. Install gtk gui libraries

Open R-studio in 32-bit mode and type the following command in the console:
```R
install.packages("RGtk2")
```
This will download and install the RGtk2 GUI package on your machine. If you do not have Gtk libraries installed on your machine, the package installer for RGtk2 will prompt you to download and install them. Select "install Gtk" in the popup dialog box and click OK. There is a bug on some machines where RGtk2 does no install the libraries correctly. If the RGtk2 installer fails, re-type  the "install.packages" command above but when the prompt appears for downloading the Gtk libraries, click "cancel". It will reappear and this time click "OK". 

This is a bug in the Gtk library isntaller, and is not maintained by the author of QWToolbox. Hopefully, this will be resolved for the first QWToolbox version.

###Step 4. Install the "devtools" package for installing QWToolbox directly from Github.

Open R-studio in 32-bit mode if it is not already open and type the following command in the console:
```R
install.packages("devtools")
```
This will install the devtools package on your machine. If an error appears about "Rtools not installed", ignore this message, Rtools is not required for the devtools functions you will use.

###Step 5. Install the QWToolbox package from Github.

Open R-studio in 32-bit mode if it is not already open and type the following commands in the console:

```R
library(devtools)
install_github("USGS-R/QWToolbox",args = "--no-multiarch")
```

This will install the QWToolbox pacakge as well as all other packages that QWToolbox relies on. It may take a minute to download and install the supporting packages durign the first installation.

###Step 6. Run QWToolbox.

Once QWToolbox has been successfully installed type the following commands to load the package and open the gui

```R
library(QWToolbox)
qwtoolbox()
```
