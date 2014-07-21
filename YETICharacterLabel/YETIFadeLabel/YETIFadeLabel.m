//
//  FadeTextView.m
//  TextFadeTest
//
//  Created by Andrew Hulsizer on 7/1/14.
//  Copyright (c) 2014 Classy Monsters. All rights reserved.
//

#import "YETIFadeLabel.h"

//Categories
#import "YETILayerAnimation.h"

@interface YETIFadeLabel ()

@property (nonatomic, assign) CGPoint matchingIndexes;
@end

@implementation YETIFadeLabel

#pragma mark - Overrides

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self animateOutWithCompletion:^(BOOL finished) {
        [self animateInWithCompletion:nil];
    }];
}

- (void)initialTextLayerAttributes:(CATextLayer *)textLayer
{
    textLayer.opacity = 0;
}

#pragma mark - Animations

- (void)animateInWithCompletion:(void(^)(void))completionBlock
{
    for (CALayer *textLayer in self.characterTextLayers) {
        
        NSTimeInterval duration = ((arc4random()%100)/200.0)+0.25;
        NSTimeInterval delay = (arc4random()%100)/500.0;
        
        [YETILayerAnimation animationForLayer:textLayer duration:duration delay:delay animations:^{
            textLayer.opacity = 1;
        } completionBlock:nil];
    }
}

- (void)animateOutWithCompletion:(void(^)(BOOL finished))completionBlock
{
    if (self.oldCharacterTextLayers.count == 0) {
        if (completionBlock) {
            completionBlock(YES);
        }
        return;
    }
    
    CGFloat longestAnimation = 0.0;
    NSInteger longestAnimationIndex = -1;
    NSInteger index = 0;
    
    for (CALayer *textLayer in self.oldCharacterTextLayers) {
        
        NSTimeInterval duration = ((arc4random()%100)/200.0)+0.25;
        NSTimeInterval delay = (arc4random()%100)/500.0;
        
        if (duration+delay > longestAnimation) {
            longestAnimation = duration+delay;
            longestAnimationIndex = index;
        }
        
        [YETILayerAnimation animationForLayer:textLayer duration:duration delay:delay animations:^{
            textLayer.opacity = 0;
        } completionBlock:^(BOOL finished) {
            [textLayer removeFromSuperlayer];
            if (textLayer == self.oldCharacterTextLayers[longestAnimationIndex]) {
                if (completionBlock) {
                    completionBlock(finished);
                }
            }
        }];
        
        ++index;
    }
}

@end
