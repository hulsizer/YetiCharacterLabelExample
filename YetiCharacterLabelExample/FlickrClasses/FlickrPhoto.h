//
//  FlickrPhoto.h
//  TextFadeTest
//
//  Created by Andrew Hulsizer on 6/22/14.
//  Copyright (c) 2014 Classy Monsters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject

@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSString *title;
@end
