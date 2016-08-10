//
//  SBAutoLayoutUtility.h
//  SBRatePrompt
//
//  Created by Sam Bender on 8/7/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBAutoLayoutUtility : NSObject

// @return: @[xCenterConstraint, yCenterConstraint, widthConstraint]
+ (NSArray<NSLayoutConstraint*>*)centerView:(UIView*)view withWidth:(CGFloat)width inside:(UIView*)parent;

@end
