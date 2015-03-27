# Introduction #

There are two recommended methods for exporting 'shared data' from BioloMICS. Both use features from within the application, so there is no need to access the backend database MySQL.

  1. [Method 1 - Export without Template](#Export_without_Template.md). Recommended if you are sharing minimal data from every record (for example a list of strain numbers and species names held in the collection).
  1. [Method 2 - Amend VB.NET script](#Amend_VB.NET_script.md). Recommended if you want to hold back reference to particular records, or provide more detailed information (for example, images and bibliographic records).

# Export without Template #
Log in to BioloMICS, and the database you want to share. Select menu item `Import-Export -> Export all records -> To file without template`:

![http://ala.googlecode.com/files/wiki-biolomics-export.png](http://ala.googlecode.com/files/wiki-biolomics-export.png)

At the `Export file without template` window, click fields in the left pane and the right-pointing arrow. Fields for sharing will then show in the right pane. Use the left-pointing arrow to remove fields if you make a mistake.

![http://ala.googlecode.com/files/wiki-biolomics-export2.png](http://ala.googlecode.com/files/wiki-biolomics-export2.png)

Click the `Export and close` button and save the output file as CSV or tab-delimited. You can check the file contents with an application like Excel or Notepad. It will show the column headers, and a single row for every record, similar to:

|ID	|Name	|E394: Species name	|H410: Sample date|
|:--|:----|:------------------|:----------------|
|2	|TT 1	|Arxiozyma telluris	|Feb-03|
|3	|TT 2	|Candida albicans	|Feb-00|
|4	|TT 3	|Candida albicans	|28/04/2000|
|5	|TT 4	|Candida albicans (stellatoidea)	|19/05/2000|



# Amend VB.NET script #
There is a script that builds a Darwin Core Archive, with some extra fields that are described at http://www.ala.org.au/about-the-atlas/atlas-data/microorganism-data-schema/.


The Darwin Core Archive is a zip file containing:
  * 'comma separated variable' files that hold the specimen data
  * an xml file that describes the collection
  * another xml file that describes the structure of the csv files.

There is a sample Darwin Core Archive at https://docs.google.com/open?id=0B9LsWywhlwyMNDA0YzFhZWQtN2QwZS00ZjJjLWEyNTktOTY2NWRiMzk5YTEw

The script:
  * creates the csv files from data in BioloMICS
  * reads eml.xml and meta.xml files from a c: drive
  * writes all the file to a user-defined directory.

## Step 1 - Import the script ##
Download the default script [export2ala\_v1.07.vb](http://ala.googlecode.com/files/export2ala_v1.07.vb)

Log in to BioloMICS and the database you want to share.

Select menu item `Tools -> BioloMICS programming manager`:
![http://ala.googlecode.com/files/wiki-biolomics-script.png](http://ala.googlecode.com/files/wiki-biolomics-script.png)

Select menu item `File -> Import script file`:
![http://ala.googlecode.com/files/wiki-biolomics-script2.png](http://ala.googlecode.com/files/wiki-biolomics-script2.png)

Choose the local copy of the .vb file. The script will now show in the `Scripts` folder in the `Code Explorer` pane.

Click on the script to show contents in the `BioloMICS Code Editor` pane.

If the database has been customised from the 'ALA Template' (for example, fields for shared data have been changed), you will need to update the script. From about line 777 (depending on the script version), change the field names to reflect the data being shared:
![http://ala.googlecode.com/files/wiki-biolomics-script3.png](http://ala.googlecode.com/files/wiki-biolomics-script3.png)

Save the script.

## Step 2 - Amend the eml.xml and meta.xml files. ##
  1. Update the eml.xml file to reflect the source organisation, collection and purpose of the archive.
  1. Update the meta.xml file to reflect field changes made to the hardcoded section of the script.
  1. Save the updated files to the c:/ directory. If you save them elsewhere, update the path in the script.

## Step 3 - Run the script. ##
Make sure the script is selected so the `BioloMICS Code Editor` shows content.

Click the green arrow, or menu item `Build -> Compile and run`.

The script will prompt for a directory to write the output to. Select or create a folder:

![http://ala.googlecode.com/files/wiki-biolomics-script4.png](http://ala.googlecode.com/files/wiki-biolomics-script4.png)

Trace statements show progress through the file writing process in the `Compilation results and errors` pane.

The script is successful if the last statement is `End Main()`.

Zip the output folder, and send to ALA.