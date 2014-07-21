//
//  YETIMotionLabel.m
//  TextFadeTest
//
//  Created by Andrew Hulsizer on 7/20/14.
//  Copyright (c) 2014 Classy Monsters. All rights reserved.
//

#import "YETIMotionLabel.h"

//Categories
#import "YETILayerAnimation.h"

@interface YETIMotionLabel()

@property (nonatomic, strong) NSMutableDictionary *oldMatchingCharacters;
@property (nonatomic, strong) NSMutableDictionary *matchingCharacters;
@end

@implementation YETIMotionLabel

#pragma mark - Overrides

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if ([self.textStorage.string isEqualToString:attributedText.string]) {
        return;
    }
    
    super.attributedText = attributedText;
    [self matchingCharacterRanges:attributedText.string];
    
    [self animateOutWithCompletion:nil];
    [self animateInWithCompletion:nil];
}

- (void)initialTextLayerAttributes:(CATextLayer *)textLayer
{
    textLayer.opacity = 0;
}

#pragma mark - Matching Algorithm

- (void)matchingCharacterRanges:(NSString *)newString {
    
    NSMutableDictionary *oldMatches = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *newMatches = [[NSMutableDictionary alloc] init];
    
    NSInteger outerIndex = 0;
    NSInteger innerIndex = 0;
    NSInteger startingInnerIndex = 0;
    NSInteger buffer = 6;
    NSInteger characterTextLayersEndIndex = [self.characterTextLayers count]-1;
    
    
    for (CATextLayer *characterLayer in self.oldCharacterTextLayers) {
        if (startingInnerIndex >= characterTextLayersEndIndex) {
            break;
        }
        
        NSAttributedString *character = characterLayer.string;
        
        NSArray *subArray = [self.characterTextLayers subarrayWithRange:NSMakeRange(startingInnerIndex, characterTextLayersEndIndex-startingInnerIndex)];
        
        for (CATextLayer *newCharacterLayer in subArray) {
            if (innerIndex >= buffer) {
                break;
            }
            
            NSAttributedString *newCharacter = newCharacterLayer.string;
            if ([character isEqualToAttributedString:newCharacter]) {
                NSNumber *oldIndex = [NSNumber numberWithInteger:outerIndex];
                NSNumber *newIndex = [NSNumber numberWithInteger:startingInnerIndex+innerIndex];
                oldMatches[oldIndex] = newIndex;
                newMatches[newIndex] = oldIndex;
                startingInnerIndex += innerIndex;
                break;
            }
            ++innerIndex;
        }
        innerIndex = 0;
        ++startingInnerIndex;
        ++outerIndex;
    }
    
    self.oldMatchingCharacters = oldMatches;
    self.matchingCharacters = newMatches;
}

#pragma mark - Animations

- (void)animateInWithCompletion:(void(^)(BOOL finished))completionBlock
{
    NSInteger index = 0;
    for (CATextLayer *textLayer in self.characterTextLayers) {
        
        if (self.matchingCharacters[[NSNumber numberWithInteger:index]]) {
            textLayer.opacity = 0;
        }else{
            CATransform3D scaleTransform = CATransform3DMakeScale(0.2, 0.2, 1);
            textLayer.transform = scaleTransform;
            [YETILayerAnimation animationForLayer:textLayer duration:0.3 delay:index*0.01 animations:^{
                textLayer.transform = CATransform3DIdentity;
                textLayer.opacity = 1;
            } completionBlock:nil];
        }
        
        ++index;
    }
}

- (void)animateOutWithCompletion:(void(^)(BOOL finished))completionBlock
{
    CATransform3D scaleTransform = CATransform3DMakeScale(0.2, 0.2, 1);
    
    NSInteger index = 0;
    
    for (CATextLayer *textLayer in self.oldCharacterTextLayers) {
        
        NSNumber *possibleIndex = self.oldMatchingCharacters[[NSNumber numberWithInteger:index]];
        if (possibleIndex) {
            NSInteger newMatchingIndex = [possibleIndex integerValue];
            
            NSInteger glyphIndex = [self.layoutManager glyphIndexForCharacterAtIndex:newMatchingIndex];
            CATextLayer *matchingLayer = self.characterTextLayers[glyphIndex];
            CATransform3D startingTransform = CATransform3DMakeTranslation(matchingLayer.position.x-textLayer.position.x, matchingLayer.position.y-textLayer.position.y, 0);
            
            [YETILayerAnimation animationForLayer:textLayer duration:0.3 delay:0 animations:^{
                textLayer.transform = startingTransform;
            } completionBlock:^(BOOL finished) {
                [YETILayerAnimation animationForLayer:matchingLayer duration:0.01 delay:0 animations:^{
                    matchingLayer.opacity = 1;
                } completionBlock:^(BOOL finished) {
                    [textLayer removeFromSuperlayer];
                }];
                
                if (index == [self.oldCharacterTextLayers count]-1) {
                    if (completionBlock) {
                        completionBlock(finished);
                    }
                }
            }];
            
        }else{
            textLayer.transform = CATransform3DIdentity;
            
            [YETILayerAnimation animationForLayer:textLayer duration:0.3 delay:0 animations:^{
                textLayer.transform = scaleTransform;
                textLayer.opacity = 0;
            } completionBlock:^(BOOL finished) {
                
                [textLayer removeFromSuperlayer];
                
                if (index == [self.oldCharacterTextLayers count]-1) {
                    if (completionBlock) {
                        completionBlock(finished);
                    }
                }
            }];
        }
        
        ++index;
    }
}

@end
