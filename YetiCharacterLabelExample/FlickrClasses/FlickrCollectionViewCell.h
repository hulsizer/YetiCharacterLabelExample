//
//  FlickrView.h
//  TextFadeTest
//
//  Created by Andrew Hulsizer on 6/22/14.
//  Copyright (c) 2014 Classy Monsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickrPhoto;

@interface FlickrCollectionViewCell : UICollectionViewCell

- (void)configureWithFlickrPhoto:(FlickrPhoto *)flickrPhoto;
@end
