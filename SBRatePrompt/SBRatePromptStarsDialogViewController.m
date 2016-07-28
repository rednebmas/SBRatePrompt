//
//  SBRatePromptStarsDialogViewController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePromptStarsDialogViewController.h"

@interface SBRatePromptStarsDialogViewController ()

@property (nonatomic, assign) BOOL hasAddedConstraints;

@end

@implementation SBRatePromptStarsDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateViewConstraints {
    if (self.hasAddedConstraints == NO && self.view.superview != nil)
    {
        self.hasAddedConstraints = YES;
        [self addConstraints];
    }
    
    [super updateViewConstraints];
}

- (void)addConstraints
{
    NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.view.superview
                                             attribute:NSLayoutAttributeCenterX
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.view
                                             attribute:NSLayoutAttributeCenterX
                                             multiplier:1.0
                                             constant:0];
    NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.view.superview
                                             attribute:NSLayoutAttributeCenterY
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.view
                                             attribute:NSLayoutAttributeCenterY
                                             multiplier:1.0
                                             constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.view
                                           attribute:NSLayoutAttributeWidth
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                           attribute:NSLayoutAttributeNotAnAttribute
                                           multiplier:1.0
                                           constant:self.view.frame.size.width];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:widthConstraint];
    [self.view.superview addConstraint:xCenterConstraint];
    [self.view.superview addConstraint:yCenterConstraint];
}

@end
