//
//  SBRatePromptStarsDialogViewController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#define viewWidth(view) view.frame.size.width
#import "SBRatePromptStarsDialogViewController.h"
#import "SBAutoLayoutUtility.h"
#import "SBRatePromptConstants.h"

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
        NSArray<NSLayoutConstraint*> *layoutConstraints = [SBAutoLayoutUtility
                                                           centerView:self.view
                                                           withWidth:[SBRatePromptConstants dialogWidth]
                                                           inside:self.view.superview];
        self.xCenterConstraint = layoutConstraints[0];
    }
    
    [super updateViewConstraints];
}

- (void)animateAwayWithDuration:(NSTimeInterval)animationDuration
{
    [self.view layoutIfNeeded];
    self.xCenterConstraint.constant = [self endAnimationPosition];
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}

- (CGFloat)endAnimationPosition
{
    CGFloat outOfView = viewWidth(self.view) / 2.0 + viewWidth(self.view.superview) / 2.0;
    return outOfView + [SBRatePromptConstants dialogAnimationDistanceOffset];
}

#pragma mark - Stars view delegate

- (void)starsViewSelectedStar:(NSInteger)star
{
    [self.delegate userSelectedRating:star];
}

@end
