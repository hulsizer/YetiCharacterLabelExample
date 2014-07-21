//
//  FKFlickrGroupsPoolsGetPhotos.h
//  FlickrKit
//
//  Generated by FKAPIBuilder on 12 Jun, 2013 at 17:19.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrAPIMethod.h"

typedef enum {
	FKFlickrGroupsPoolsGetPhotosError_GroupNotFound = 1,		 /* The group id passed was not a valid group id. */
	FKFlickrGroupsPoolsGetPhotosError_YouDontHavePermissionToViewThisPool = 2,		 /* The logged in user (if any) does not have permission to view the pool for this group. */
	FKFlickrGroupsPoolsGetPhotosError_UnknownUser = 3,		 /* The user specified by user_id does not exist. */
	FKFlickrGroupsPoolsGetPhotosError_InvalidAPIKey = 100,		 /* The API key passed was not valid or has expired. */
	FKFlickrGroupsPoolsGetPhotosError_ServiceCurrentlyUnavailable = 105,		 /* The requested service is temporarily unavailable. */
	FKFlickrGroupsPoolsGetPhotosError_FormatXXXNotFound = 111,		 /* The requested response format was not found. */
	FKFlickrGroupsPoolsGetPhotosError_MethodXXXNotFound = 112,		 /* The requested method was not found. */
	FKFlickrGroupsPoolsGetPhotosError_InvalidSOAPEnvelope = 114,		 /* The SOAP envelope send in the request could not be parsed. */
	FKFlickrGroupsPoolsGetPhotosError_InvalidXMLRPCMethodCall = 115,		 /* The XML-RPC request document could not be parsed. */
	FKFlickrGroupsPoolsGetPhotosError_BadURLFound = 116,		 /* One or more arguments contained a URL that has been used for abuse on Flickr. */

} FKFlickrGroupsPoolsGetPhotosError;

/*

Returns a list of pool photos for a given group, based on the permissions of the group and the user logged in (if any).


Response:

<photos page="1" pages="1" perpage="1" total="1">
	<photo id="2645" owner="12037949754@N01" title="36679_o"
	secret="a9f4a06091" server="2"
	ispublic="1" isfriend="0" isfamily="0"
	ownername="Bees / ?" dateadded="1089918707" /> 
</photos>

*/
@interface FKFlickrGroupsPoolsGetPhotos : NSObject <FKFlickrAPIMethod>

/* The id of the group who's pool you which to get the photo list for. */
@property (nonatomic, strong) NSString *group_id; /* (Required) */

/* A tag to filter the pool with. At the moment only one tag at a time is supported. */
@property (nonatomic, strong) NSString *tags;

/* The nsid of a user. Specifiying this parameter will retrieve for you only those photos that the user has contributed to the group pool. */
@property (nonatomic, strong) NSString *user_id;

/*  */
@property (nonatomic, strong) NSString *jump_to;

/* A comma-delimited list of extra information to fetch for each returned record. Currently supported fields are: <code>description</code>, <code>license</code>, <code>date_upload</code>, <code>date_taken</code>, <code>owner_name</code>, <code>icon_server</code>, <code>original_format</code>, <code>last_update</code>, <code>geo</code>, <code>tags</code>, <code>machine_tags</code>, <code>o_dims</code>, <code>views</code>, <code>media</code>, <code>path_alias</code>, <code>url_sq</code>, <code>url_t</code>, <code>url_s</code>, <code>url_q</code>, <code>url_m</code>, <code>url_n</code>, <code>url_z</code>, <code>url_c</code>, <code>url_l</code>, <code>url_o</code> */
@property (nonatomic, strong) NSString *extras;

/* Number of photos to return per page. If this argument is omitted, it defaults to 100. The maximum allowed value is 500. */
@property (nonatomic, strong) NSString *per_page;

/* The page of results to return. If this argument is omitted, it defaults to 1. */
@property (nonatomic, strong) NSString *page;


@end
