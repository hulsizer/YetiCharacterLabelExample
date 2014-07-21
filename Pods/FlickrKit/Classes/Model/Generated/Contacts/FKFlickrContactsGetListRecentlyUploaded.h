//
//  FKFlickrContactsGetListRecentlyUploaded.h
//  FlickrKit
//
//  Generated by FKAPIBuilder on 12 Jun, 2013 at 17:19.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrAPIMethod.h"

typedef enum {
	FKFlickrContactsGetListRecentlyUploadedError_InvalidSignature = 96,		 /* The passed signature was invalid. */
	FKFlickrContactsGetListRecentlyUploadedError_MissingSignature = 97,		 /* The call required signing but no signature was sent. */
	FKFlickrContactsGetListRecentlyUploadedError_LoginFailedOrInvalidAuthToken = 98,		 /* The login details or auth token passed were invalid. */
	FKFlickrContactsGetListRecentlyUploadedError_UserNotLoggedInOrInsufficientPermissions = 99,		 /* The method requires user authentication but the user was not logged in, or the authenticated method call did not have the required permissions. */
	FKFlickrContactsGetListRecentlyUploadedError_InvalidAPIKey = 100,		 /* The API key passed was not valid or has expired. */
	FKFlickrContactsGetListRecentlyUploadedError_ServiceCurrentlyUnavailable = 105,		 /* The requested service is temporarily unavailable. */
	FKFlickrContactsGetListRecentlyUploadedError_FormatXXXNotFound = 111,		 /* The requested response format was not found. */
	FKFlickrContactsGetListRecentlyUploadedError_MethodXXXNotFound = 112,		 /* The requested method was not found. */
	FKFlickrContactsGetListRecentlyUploadedError_InvalidSOAPEnvelope = 114,		 /* The SOAP envelope send in the request could not be parsed. */
	FKFlickrContactsGetListRecentlyUploadedError_InvalidXMLRPCMethodCall = 115,		 /* The XML-RPC request document could not be parsed. */
	FKFlickrContactsGetListRecentlyUploadedError_BadURLFound = 116,		 /* One or more arguments contained a URL that has been used for abuse on Flickr. */

} FKFlickrContactsGetListRecentlyUploadedError;

/*

Return a list of contacts for a user who have recently uploaded photos along with the total count of photos uploaded.<br /><br />

This method is still considered experimental. We don't plan for it to change or to go away but so long as this notice is present you should write your code accordingly.




*/
@interface FKFlickrContactsGetListRecentlyUploaded : NSObject <FKFlickrAPIMethod>

/* Limits the resultset to contacts that have uploaded photos since this date. The date should be in the form of a Unix timestamp.

The default offset is (1) hour and the maximum (24) hours.  */
@property (nonatomic, strong) NSString *date_lastupload;

/* Limit the result set to all contacts or only those who are friends or family. Valid options are:

<ul>
<li><strong>ff</strong> friends and family</li>
<li><strong>all</strong> all your contacts</li>
</ul>
Default value is "all". */
@property (nonatomic, strong) NSString *filter;


@end
