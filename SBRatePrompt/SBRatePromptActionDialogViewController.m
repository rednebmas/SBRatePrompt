//
//  SBRatePromptActionDialogViewController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 8/4/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#define viewWidth(view) view.frame.size.width
#import "SBRatePromptActionDialogViewController.h"
#import "SBAutoLayoutUtility.h"
#import "SBRatePromptConstants.h"

@interface SBRatePromptActionDialogViewController ()

@property (nonatomic, assign) BOOL hasAddedConstraints;
@property (nonatomic, retain) NSLayoutConstraint *xCenterConstraint;

@end

@implementation SBRatePromptActionDialogViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

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
        self.xCenterConstraint.constant = [self startPosition];
    }
    
    [super updateViewConstraints];
}

- (CGFloat)startPosition
{
    CGFloat outOfView = viewWidth(self.view) / 2.0 + viewWidth(self.view.superview) / 2.0;
    return -outOfView - [SBRatePromptConstants dialogAnimationDistanceOffset];
}

- (void)animateInWithDuration:(NSTimeInterval)animationDuration
{
    [self.view layoutIfNeeded];
    self.xCenterConstraint.constant = 0.0;
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}

#pragma mark - Actions

- (IBAction)rightButtonTouchUp:(UIButton *)sender {
    
}

- (IBAction)leftButtonTouchUp:(UIButton *)sender {
}

@end
