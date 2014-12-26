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
##Use instructions

A comprehensive user mannual will be released with the final version 1.0, but for testing purposes a brief user guide is given below.

QWToolbox is a collection of R functions that are driven by a graphical user interface (GUI). Although the gui allows the user to run the various QWToolbox R functions with little or no command line input, it is still an R package at its core. The user must pay attention to the R console in R-studio for error messages and to know when R is working (e.g. downloading data) or is idle and ready for more user inputs. Future version will likely have built in error checking and messages in the GUI.

### Open the GUI

Open R-studio in 32-bit mode and type the following commands in the console:

```R
library(QWToolbox)
qwtoolbox()
```
The qwtoolbox() function call runs the GUI and a new window will appear containing hte QWToolbox GUI. You may now work mostly from this GUI window.

###Pull in data

For the data you need to supply R with the name of your local NWIS server, and the two database numbers containing your data. Most databases use database "01" for the environmental sample data and database "02" for replicate and blank sample data. 

An example for the Colorado server would be "NWIS Server name: NWISCO" "Environmental Database: 01" QA Database: 02"

Data can be brought in for a single site, site numbers from a csv file, or a list of favorites which you can save and load up. Parameters can be pulled by NWIS parameter group, a favorite list of pcodes, or from a list of pcodes in a csv file. Data can be subset to a user specified date range, or all data can be pulled if left blank.

###Plotting Data

The plotting tab will be populated with various plot types once data has been imported. Click the "Open plot device" button to open up a seperate plotting window that will contain all plots generate as well as options to save the plot.

In general, most plots will refresh with changing user input (e.g. changing a site or parameter). If the plot does not refresh for some user inputs, hit the "refresh plot" button. If the plot still does not refresh, look for error messages in the R console display. For example, if a site has no data for the chosen plot paremeter, no new plot will appear and an error message will be given in the R console.

Flagging a sample:
An outlier sample can be "flagged" with the sample record number by click "flag sample" and then clicking on the sample point in the plot. If the sample point lies very near another sample point, the user is advised to double check that the proper record number was placed for the point. In most instances, outliers will not be near other data points. The flagged sample information along with where it was flagged will be sent to a flagged sample report which can be viewed in the "Tables" tab.

###Table summaries
Currently there is a pseudo-interactive table tab that holds a table of all data, a table of blanks, and a table of charge balance results. The user can also generate a flagged sample report.

These tables take a long time to populate for large data sets and future versions may simply use the R-studio table viewer. This will require the user to have some knowledge of R to manipulate the tables.

###Non-NWQL data upload



