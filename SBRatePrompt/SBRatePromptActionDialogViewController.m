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
#import "SBDispatch.h"

@interface SBRatePromptActionDialogViewController ()

@property (nonatomic, assign) BOOL hasAddedConstraints;
@property (nonatomic, retain) NSLayoutConstraint *xCenterConstraint;
@property (nonatomic, copy) SBDialogBlock onLeftButtonTap;
@property (nonatomic, copy) SBDialogBlock onRightButtonTap;
@property (nonatomic, retain) NSString *textLabelText;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation SBRatePromptActionDialogViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.textLabelText) {
        [self.textLabel setText:self.textLabelText];
    }
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

#pragma mark - Public

- (void)onLeftButtonTap:(SBDialogBlock)leftButtonBlock onRightButtonTap:(SBDialogBlock)rightButtonBlock;
{
    self.onLeftButtonTap = leftButtonBlock;
    self.onRightButtonTap = rightButtonBlock;
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

- (void)animateAwayWithDuration:(NSTimeInterval)animationDuration;
{
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.view.transform = CGAffineTransformMakeScale(0.001, 0.001);
                     }];
}

- (void)setText:(NSString*)text
{
    if (self.isViewLoaded) {
        [self.textLabel setText:text];
    }
    
    self.textLabelText = text;
}

- (void)setRightButtonTitle:(NSString*)title
{
    [self.rightButton setTitle:title forState:UIControlStateNormal];
}

- (void)setLeftButtonTitle:(NSString*)title
{
    [self.leftButton setTitle:title forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)rightButtonTouchUp:(UIButton *)sender
{
    self.view.userInteractionEnabled = NO;
    if (self.onRightButtonTap) {
        [SBDispatch dispatchAsyncOnMainQueue:^{
            self.onRightButtonTap();
        }];
    }
}

- (IBAction)leftButtonTouchUp:(UIButton *)sender
{
    self.view.userInteractionEnabled = NO;
    if (self.onLeftButtonTap) {
        [SBDispatch dispatchAsyncOnMainQueue:^{
            self.onLeftButtonTap();
        }];
    }
}

@end
