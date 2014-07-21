//
//  YETILayerAnimation.m
//  TextFadeTest
//
//  Created by Andrew Hulsizer on 7/20/14.
//  Copyright (c) 2014 Classy Monsters. All rights reserved.
//

#import "YETILayerAnimation.h"
#import <QuartzCore/QuartzCore.h>

@interface YETILayerAnimation ()

@property (nonatomic, copy) YETICALayerCompletionBlock completionBlock;
@property (nonatomic, weak) CALayer *layer;
@end

@implementation YETILayerAnimation

+ (YETILayerAnimation *)animationForLayer:(CALayer *)layer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(YETICALayerAnimationBlock)animations completionBlock:(YETICALayerCompletionBlock)completionBlock
{
    YETILayerAnimation *animation = [[YETILayerAnimation alloc] init];
    animation.layer = layer;
    animation.completionBlock = completionBlock;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CAAnimationGroup *animationGroup = nil;
        CALayer *oldLayer = [animation animatableCopy];
        
        if (animations)
        {
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            animations();
            [CATransaction commit];
        }
        
        animationGroup = [animation groupAnimationForDifferences:oldLayer newLayer:layer];
        if (animationGroup)
        {
            [animationGroup setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [animationGroup setDuration:duration];
            animationGroup.delegate = animation;
            [animationGroup setBeginTime:CACurrentMediaTime()];
            [layer addAnimation:animationGroup forKey:nil];
        }else{
            if (animation.completionBlock) {
                animation.completionBlock(YES);
            }
        }
    });
    
    return animation;
}

- (CAAnimationGroup *)groupAnimationForDifferences:(CALayer *)oldLayer newLayer:(CALayer *)newLayer
{
    CAAnimationGroup *animationGroup = nil;
    NSMutableArray *animations = [[NSMutableArray alloc] init];
    
    
    if (!CATransform3DEqualToTransform(oldLayer.transform, newLayer.transform)) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:oldLayer.transform];
        animation.toValue = [NSValue valueWithCATransform3D:newLayer.transform];
        [animations addObject:animation];
    }
    
    if (!CGPointEqualToPoint(oldLayer.position, newLayer.position)) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:oldLayer.position];
        animation.toValue = [NSValue valueWithCGPoint:newLayer.position];
        [animations addObject:animation];
    }
    
    if (!CGRectEqualToRect(oldLayer.bounds, newLayer.bounds)) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        animation.fromValue = [NSValue valueWithCGRect:oldLayer.bounds];
        animation.toValue = [NSValue valueWithCGRect:newLayer.bounds];
        [animations addObject:animation];
    }
    
    if (oldLayer.opacity != newLayer.opacity) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = [NSNumber numberWithFloat:oldLayer.opacity];
        animation.toValue = [NSNumber numberWithFloat:newLayer.opacity];
        [animations addObject:animation];
    }
    
    if (animations.count > 0) {
        animationGroup = [CAAnimationGroup animation];
        [animationGroup setAnimations:animations];
    }
    
    return animationGroup;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completionBlock) {
        self.completionBlock(flag);
    }
}

- (id)animatableCopy
{
    CALayer *layer = [CALayer layer];
    layer.opacity = self.layer.opacity;
    layer.transform = self.layer.transform;
    layer.bounds = self.layer.bounds;
    layer.position = self.layer.position;
    return layer;
}
@end
