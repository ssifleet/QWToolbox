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

#Step 1. Install the ODBC driver and establish the NWIS ODBC connection. Your database administrator or IT specialist  will need to assist for this step. Open notepad and paste the following text:

:: Set up DSN for access to NWIS database
odbcconf.exe /A {configsysdsn "Oracle in OraClient11g_home1" "DSN=NWISWY|SERVERNAME=NWISWY|DATABASE=nwismn"}

Replace all instances of "nwismn" with the name of your local NWIS server. Save the file as ODBC.bat on your desktop and double-click to run. You may delete ODBC.bat once the ODBC conncetion has been established.

