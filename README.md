# ZKSforce  [![Build Status](https://travis-ci.org/superfell/zkSforce.svg?branch=master)](https://travis-ci.org/superfell/zkSforce)

zkSforce is a cocoa library for calling the [Salesforce.com Web Services APIs](http://www.salesforce.com/us/developer/docs/api/index.htm), easily integrate Salesforce into your OSX and iOS projects. (supports OSX 10.9+, iOS 7+)

zkSforce supports all of the partner web services API, including

 * login, getUserInfo, serverTimestamp, setPassword, resetPassword
 * describeGlobal, describeSObject, describeLayout, describeTabs and other describes.
 * create, update, delete, undelete, merge, upsert, convertLead
 * search, query, queryAll, queryMore, retrieve, process.
 * everything else in the parter API.
 * OAuth support for refresh tokens


In general the client acts just like the Web Services API, however in a few places it has some smarts to make your life easier.

 * it'll track the duration of the session and re-login as required, so just keep calling methods as needed and don't worry about the session expiring away from under you.
 * in ZKDescribeSObject there's a helper method to get the ZKDescribeField given the field name.
 * In ZKSObject the fieldsToNull collection is managed for you, if you add a field to the fieldsToNull collection (via setFieldToNull) it'll automatically remove any field value, also you can just set the field value directly to nil (aka null) in setFieldValue:field: and it'll automatically translate that into a fieldsToNull call for you.
 * ZKQueryResult implements the NSTableView informal data source interface, so you can easily show a queries results in a table view (just like SoqlX does)
 * You can ask the ZKSforceClient object to automatically cache describeGlobal/describeSObject results for you by calling setCacheDescribes


Usage is really straight forward, create an instance of the [ZKSforceClient](https://github.com/superfell/zkSforce/blob/master/zkSforce/zkSforceClient.h) class, call login, then call the other operations as needed, e.g.

Login and find the URL to the new Task UI Page.

        ZKSforceClient *sforce = [[ZKSforceClient alloc] init];
        [sforce login:username password:password];
        ZKDescribeSObject *taskDescribe = [sforce describeSObject:@"Task"];
        NSLog(@"url for the new Task page is %@", [taskDescribe urlNew]);	
        [sforce release];


Login and create a new contact for Simon Fell, and check the result

        ZKSforceClient *sforce = [[ZKSforceClient alloc] init];
        [sforce login:username password:password];
        ZKSObject *contact = [ZKSObject withType:@"Contact"];
        [contact setFieldValue:@"Fell" field:@"LastName"];
        [contact setFieldValue:@"Simon" field:@"FirstName"];
        NSArray *results = [sforce create:[NSArray arrayWithObject:contact]];
        ZKSaveResult *sr = [results objectAtIndex:0];
        if ([sr success])
	        NSLog(@"new contact id %@", [sr id]);
        else
	        NSLog(@"error creating contact %@ %@", [sr statusCode], [sr message]);
        [sforce release];

Calls are made synchronously on the thread making the call (and therefore you shouldn't really call it directly from the UI thread), zkSforceClient+zkAsyncQuery.h has a version of all the calls that are asynchronous and use blocks to get completion/error callbacks. 

		[client performQuery:query 
        	failBlock:^(NSException *ex) {
				[self showError:ex];
        	} 
        	completeBlock:^(ZKQueryResult *qr) {
				[self setResult:qr];
				[table setDataSource:qr];
				[table reloadData];
        	}];

As well as the traditional username and password login, there's also support for working with OAuth based authentication, you can pass it the finalized callbackURL you receive at the end of the oauth login flow, and it'll automatically extract all the parameters it needs from that URL.

		ZKSforceClient *sforce = [[ZKSforceClient alloc] init];
		[sforce loginFromOAuthCallbackUrl:callbackUrl oAuthConsumerKey:OAUTH_CLIENTID];
		// use as normal


You'll need to store the refresh_token and authHost somewhere safe, like the keychain, then when you restart, you can pass these to ZKSforceClient to initialize it, it'll automatically use the refresh token service to get a new sessionId.

	ZKSforceClient *sforce = [[ZKSforceClient alloc] init];
	[sforce loginWithRefreshToken:refreshToken authUrl:authHost oAuthConsumerKey:OAUTH_CLIENTID];
	// use as normal
	// See the OAuthDemo sample for more info.

Instances are ZKSforceClient are not safe to be called on multiple threads concurrently. If you want to use ZKSforceClient concurrently, you should use the -copyWithZone: method to create per thread instances. [or use the async/callback based API]	

# Application Transport Security

If you're targeting ios9+ or OSX 10.11+ you'll need to setup [ATS configuration](https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW33) in your applications Info.plist in order to be able to successfully communicate with Salesforce.com. Add the following to your Info.plist. 

	<key>NSAppTransportSecurity</key>
		<dict>
			<key>NSExceptionDomains</key>
			<dict>
				<key>salesforce.com</key>
				<dict>
					<key>NSIncludesSubdomains</key>
					<true/>
					<key>NSExceptionRequiresForwardSecrecy</key>
					<false/>
				</dict>
			</dict>
		</dict>

# Date/Time formats
The way date/times are serialized changed in v35.0.2. The timestamp sent over the wire is now in UTC, whereas before the timestamp was sent in the users local timezone (with the correct offset applied). The exact same logical timestamp is sent, so there's no change in behavior in terms of how NSDates are mapped to dateTimes in salesforce, just a difference in the offset in the serialized dateTime. If for
some reason you are calling the ZKSoapDate asString methods yourself, the resulting string is different. [Although i can't imagine why you're doing this].

# Unit Tests
The zkSforceTests directory contains a project with a number of tests in it, these tests are focused on the hand coded supporting classes, and generally don't test the classes that get code gen'd from the WSDL.
 
# Updating from older versions
v29 is a major update where a significant amount of the code is now code-generated from the partner WSDL, because of this there are a number of API changes that might affect an existing project that you're trying to update to this version of zkSforce.

 * some files have had the casing of their filename fixed to match the classname (e.g. zkChildRelationship.h is now ZKChildRelationship.h)
 * The Id property on ZKDescribeLayout is now called id
 * message & statusCode properties on ZKSaveResult have been moved to an Extras category/file
 * describe & fieldsColumnNames properties on ZKRelatedList have been moved to an Extras category/file
 * many properties on ZKUserInfo are now in an Extras category/file
 * licenceType from ZKUserInfo was removed (its not longer in the API)
 * validFor on ZKPicklistEntry now returns an NSData rather than an NSString
 * the signature for setPassword has changed from setPassword:forUserId: to setPassword:userId:
 * delete now returns an NSArray of ZKDeleteResult rather than an NSArray of ZKSaveResult (note that these 2 types both have the same properties though)
 * the serverTimestamp method is replaced by getServerTimestamp, and now returns a ZKGetServerTimestampResult class with a timestamp member (of type NSDate) instead of returning a string.
 * the componentType enum was removed from ZKDescribeLayoutComponent
 * on ZKDecribeGlobalSObject defaultOnCreate is now defaultedOnCreate, undeleteable is now deletable, deleteable is now deletable
 * on OSX you need to add Security framework to the list of frameworks to link against.



## Project setup (via CocoaPods)

The easiest way to get ZKSforce integrated into your app is to use [CocoaPods](http://cocoapods.org/), the Cocoa dependency manager framework, simply create a Podfile, e.g.

    platform :osx
	pod 'ZKSforce', '~> 37.0.0'
	
and run  `pod install myApp.xcodeproj`


## Project setup (manual)

In order to support usage on both OSX & iOS, the library uses libxml as its XML parser rather than NSXML, which isn't fully implemented on iOS. Once you've added all the .h & .m files to your project, you'll need to goto the build settings and add /usr/include/libxml2 to the Header Search Paths, and add libxml2.dylib to the linked frameworks section, and then you should be good to go. For OSX you'll also need to add Security framework to the list of linked Frameworks. The [Wiki](https://github.com/superfell/zkSforce/wiki/Creating-a-new-project-that-uses-zkSforce) has a detailed write up on these steps.
