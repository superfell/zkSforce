# samples/query-OSX

This is a simple OSX sample that shows how to call login, run SOQL queries and use the provided table binding to display the results in an NSTableView.

the project was created with XCode 3.2.2 (builds fine on 4.0 as well)
the zksforce folder contains a reference to all the zksforce source files.
the project was updated to add "/usr/include/libxml2" to the header search path.
the linked frameworks have libxml2.2.dylib added to them.


The bulk of the interesting code is in QueryController.