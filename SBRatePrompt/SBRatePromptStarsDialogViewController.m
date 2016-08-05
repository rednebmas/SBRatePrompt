//
//  SBRatePromptStarsDialogViewController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#define viewWidth(view) view.frame.size.width

#import "SBRatePromptStarsDialogViewController.h"

@interface SBRatePromptStarsDialogViewController () <SBRateStarsViewDelegate>

@property (nonatomic, assign) BOOL hasAddedConstraints;
@property (nonatomic, retain) NSLayoutConstraint *xCenterConstraint;

@end

@implementation SBRatePromptStarsDialogViewController

@dynamic view;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.delegate = self;
}

#pragma mark - Constraints

- (void)updateViewConstraints
{
    if (self.hasAddedConstraints == NO && self.view.superview != nil)
    {
        self.hasAddedConstraints = YES;
        [self addConstraints];
    }
    
    [super updateViewConstraints];
}

- (void)addConstraints
{
    self.xCenterConstraint = [NSLayoutConstraint
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
    [self.view.superview addConstraint:self.xCenterConstraint];
    [self.view.superview addConstraint:yCenterConstraint];
}

- (void)animateAwayWithDuration:(NSTimeInterval)animationDuration
{
    CGFloat distance = viewWidth(self.view) / 2.0 + viewWidth(self.view.superview) / 2.0;
    
    [self.view layoutIfNeeded];
    self.xCenterConstraint.constant = distance;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Stars view delegate

- (void)starsViewSelectedStar:(NSInteger)star
{
    [self.delegate userSelectedRating:star];
}

@end
