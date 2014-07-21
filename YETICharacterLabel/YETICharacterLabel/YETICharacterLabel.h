//
//  CharacterLabel.h
//  TextFadeTest
//
//  Created by Andrew Hulsizer on 7/1/14.
//  Copyright (c) 2014 Classy Monsters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YETICharacterLabel : UILabel

@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, strong) NSLayoutManager *layoutManager;

@property (nonatomic, strong) NSMutableArray *oldCharacterTextLayers;
@property (nonatomic, strong) NSMutableArray *characterTextLayers;

- (void)initialTextLayerAttributes:(CATextLayer *)textLayer;
@end
