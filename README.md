# ZKSforce  [![Build Status](https://travis-ci.org/superfell/zkSforce.svg?branch=master)](https://travis-ci.org/superfell/zkSforce)

ZKSforce is a cocoa library for calling the [Salesforce.com Web Services APIs](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_quickstart_intro.htm), easily integrate Salesforce into your OSX and iOS projects. (supports OSX 10.9+, iOS 9+)

ZKSforce supports all of the partner web services API, including

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


Usage is really straight forward, create an instance of the [ZKSforceClient](https://github.com/superfell/zkSforce/blob/master/zkSforce/client/ZKSforceClient.h)
class, call login, then call the other operations as needed. All calls that might result in a HTTP request use an async blocks
based methods. e.g.


        ZKSforceClient *sforce = [[ZKSforceClient alloc] init];
        [sforce login:username password:password
			failBlock:^(NSError *err) {
				[[NSAlert alertWithError:err] runModal];
			}
			CompleteBlock:^(ZKLoginResult *result) {
				NSLog(@"Hello %@", result.userInfo.userFullName);
		}]

All the callback block run on the main thread/queue. If you'd like the callbacks to run on a specific queue, there's version
of each API call that takes an additional queue parameter to set the callback queue.

Once logged in, you can use the other methods, e.g. create a new Contact, by construct a ZKSObject instance, populating the
field values, and then calling create.

        ZKSObject *contact = [ZKSObject withType:@"Contact"];
        [contact setFieldValue:@"Fell" field:@"LastName"];
        [contact setFieldValue:@"Simon" field:@"FirstName"];
        [sforce create:@[contact]
			failBlock:^(NSError *err) {
				[[NSAlert alertWithError:err] runModal];
			}
			CompleteBlock:^(NSArray *result) {
		        ZKSaveResult *sr = result[0];
				if ([sr success])
					NSLog(@"new contact id %@", [sr id]);
				else
					NSLog(@"error creating contact %@ %@", [sr statusCode], [sr message]);
			}
		];



As well as the traditional username and password login, there's also support for working with OAuth based authentication, you can pass it the finalized callbackURL you receive at the end of the oauth login flow, and it'll automatically extract all the parameters it needs from that URL.

		ZKSforceClient *sforce = [[ZKSforceClient alloc] init];
		NSError *err = [sforce loginFromOAuthCallbackUrl:callbackUrl oAuthConsumerKey:OAUTH_CLIENTID];
        if (err != nill) {
            [[NSAlert alertWithError:err] runModal];
            return;
        }
		// use as normal


You'll need to store the refresh_token and authHost somewhere safe, like the keychain. Then when you restart, you can pass these to ZKSforceClient to initialize it. It'll automatically use the refresh token service to get a new sessionId.

	ZKSforceClient *sforce = [[ZKSforceClient alloc] init];
	[sforce loginWithRefreshToken:refreshToken authUrl:authHost oAuthConsumerKey:OAUTH_CLIENTID
			failBlock:^(NSError *err) {
				[[NSAlert alertWithError:err] runModal];
			}
            completeBlock:^{
				NSLog(@"Successfully initialized from refresh token");
	}];
	// See the OAuthDemo sample for more info.

# Date/Time formats
The way date/times are serialized changed in v35.0.2. The timestamp sent over the wire is now in UTC, whereas before the timestamp was sent in the users local timezone (with the correct offset applied). The exact same logical timestamp is sent, so there's no change in behavior in terms of how NSDates are mapped to dateTimes in salesforce, just a difference in the offset in the serialized dateTime. If for
some reason you are calling the ZKSoapDate asString methods yourself, the resulting string is different. [Although i can't imagine why you're doing this].

# Unit Tests
The zkSforceTests directory contains a project with a number of tests in it, these tests are focused on the hand coded supporting classes, and generally don't test the classes that get code gen'd from the WSDL.
 
# Updating from older versions
In general ZKSforce is updated when the Salesforce API is updated, usually 2 or 3 times a year. Most of the time changes are limited
to those that mirror the changes in the Salesforce API. Sometimes larger structural changes are made as well. Salesforce has a strong
versioning policy for APIs, so if your App is working fine, there's no need to continually upgrade, upgrade when you need to take
advantage of some API addition.

## Major changes at v47
v47 is a major change that cleans up some OS API deprecations, as well as completely modernizing the Objective-C API to ZKSforce to
use async methods with block for all requests that can result in network requests. If you're migrating from an earlier version and
had already adopted the async/block based methods, then you have some minor changes to deal with

 * The async methods names have change from performXXXX to XXXX, e.g. performDescribeGlobal is now describeGlobal.
 * The failBlock now uses NSError instead of NSException.

If you're migrating from an earlier version and are still using the synchronous API calls, then you have more work ahead of you.

 * All the synchronous methods that resulted in network requests are gone, replaced by async versions that use callback blocks.
   By default these callbacks are executed on the main thread/queue, so should be straight forward to move to.
 * Error conditions that were reported via throwing exceptions are now all reported via the failBlock callback, which is passed
   an NSError containing the failure reason.

Regardless of which API styles you were using, there's also a few other changes.

 * The result type from search now matches the WSDL exactly.
 * The ZKBaseClient delegate has both success and error cases folded into a single call.
 * ZKSforceClient no longer implements copyWithZone: and is now safe to use from multiple threads/queues concurrently.
 * Filenames & types are now have their ZK prefix consistently capitalized.
 * The files have been rearranged into a set of directories.

## Major changes at v44
v44 includes changes to adopt the use of ARC and modern objective-c features.

## Major changes at v29
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
 * on ZKDecribeGlobalSObject defaultOnCreate is now defaultedOnCreate, undeleteable is now undeletable, deleteable is now deletable
 * on OSX you need to add Security framework to the list of frameworks to link against.


## Project setup (via CocoaPods)

The easiest way to get ZKSforce integrated into your app is to use [CocoaPods](http://cocoapods.org/), the Cocoa dependency manager framework, simply create a Podfile, e.g.

    platform :osx
	pod 'ZKSforce', '~> 47.0.0'
	
and run  `pod install myApp.xcodeproj`


## Project setup (manual)

In order to support usage on both OSX & iOS, the library uses libxml as its XML parser rather than NSXML, which isn't fully implemented on iOS. 
Once you've added all the .h & .m files to your project, you'll need to goto the build settings and add /usr/include/libxml2 to the Header Search Paths, 
and add libxml2.dylib to the linked frameworks section. Then you should be good to go. For OSX you'll also need to add Security framework to the list of 
linked Frameworks. The [Wiki](https://github.com/superfell/zkSforce/wiki/Creating-a-new-project-that-uses-zkSforce) has a detailed write up on these steps.
