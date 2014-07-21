//
//  FlickrView.m
//  TextFadeTest
//
//  Created by Andrew Hulsizer on 6/22/14.
//  Copyright (c) 2014 Classy Monsters. All rights reserved.
//

#import "FlickrCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FlickrPhoto.h"

@interface FlickrCollectionViewCell ()

@property (nonatomic, strong) UIImageView *photoImageView;
@end

@implementation FlickrCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    // Initialization code
    _photoImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_photoImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:_photoImageView];
    
    self.clipsToBounds = YES;
}

- (void)configureWithFlickrPhoto:(FlickrPhoto *)flickrPhoto
{
        self.photoImageView.alpha = 0;
        __weak typeof(self)weakSelf = self;
        [self.photoImageView sd_setImageWithURL:flickrPhoto.photoURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (cacheType == SDImageCacheTypeMemory) {
                weakSelf.photoImageView.alpha = 1;
            }else{
                [UIView animateWithDuration:.3 animations:^{
                    weakSelf.photoImageView.alpha = 1;
                }];
            }
        }];
}
@end
