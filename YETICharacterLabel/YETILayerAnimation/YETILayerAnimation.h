//
//  YETILayerAnimation.h
//  TextFadeTest
//
//  Created by Andrew Hulsizer on 7/20/14.
//  Copyright (c) 2014 Classy Monsters. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CALayer;

typedef void (^YETICALayerAnimationBlock)();
typedef void (^YETICALayerCompletionBlock)(BOOL finished);

@interface YETILayerAnimation : NSObject

+ (YETILayerAnimation *)animationForLayer:(CALayer *)layer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(YETICALayerAnimationBlock)animations completionBlock:(YETICALayerCompletionBlock)completionBlock;
@end
