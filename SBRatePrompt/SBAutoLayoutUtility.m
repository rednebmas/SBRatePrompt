//
//  SBAutoLayoutUtility.m
//  SBRatePrompt
//
//  Created by Sam Bender on 8/7/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBAutoLayoutUtility.h"

@implementation SBAutoLayoutUtility

+ (NSArray<NSLayoutConstraint*>*)centerView:(UIView*)view withWidth:(CGFloat)width inside:(UIView*)parent
{
    NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint
                              constraintWithItem:parent
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:view
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1.0
                              constant:0];
    NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint
                                             constraintWithItem:parent
                                             attribute:NSLayoutAttributeCenterY
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:view
                                             attribute:NSLayoutAttributeCenterY
                                             multiplier:1.0
                                             constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                           constraintWithItem:view
                                           attribute:NSLayoutAttributeWidth
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                           attribute:NSLayoutAttributeNotAnAttribute
                                           multiplier:1.0
                                           constant:width];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:widthConstraint];
    [parent addConstraint:xCenterConstraint];
    [parent addConstraint:yCenterConstraint];
    return @[xCenterConstraint, yCenterConstraint, widthConstraint];
}

@end
