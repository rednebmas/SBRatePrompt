//
//  SBRatePromptFlowController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePromptConstants.h"
#import "SBRatePromptFlowController.h"
#import "SBRatePromptWindow.h"
#import "SBRatePromptStarsDialogViewController.h"
#import "SBDispatch.h"
#import "SBRatePromptActionDialogViewController.h"

@interface SBRatePromptFlowController () <SBRatePromptStarsDialogDelegate>

@property (nonatomic, strong) SBRatePromptWindow *window;
@property (nonatomic, strong) SBRatePromptStarsDialogViewController *starDialog;
@property (nonatomic, strong) SBRatePromptActionDialogViewController *actionDialog;

@end

@implementation SBRatePromptFlowController

- (void)begin
{
    [self displayWindow];
    [self displayStarRatingPrompt];
}

- (void)displayWindow {
    self.window = [[SBRatePromptWindow alloc] init];
    [self.window makeKeyAndVisible];
    [self.window animateInWithDuration:.25];
}

- (void)displayStarRatingPrompt {
    self.starDialog = [[SBRatePromptStarsDialogViewController alloc]
                       initWithNibName:@"SBRatePromptStarsDialogViewController"
                       bundle:SBRatePromptBundle];
    self.starDialog.delegate = self;
    [self.window addSubview:self.starDialog.view];
}

- (void)loadActionDialog {
    self.actionDialog = [[SBRatePromptActionDialogViewController alloc]
                         initWithNibName:@"SBRatePromptActionDialogViewController"
                         bundle:SBRatePromptBundle];
    [self.window addSubview:self.actionDialog.view];
}

#pragma mark - Hide/remove views

- (void)removeStarsDialog {
    [self.starDialog.view removeFromSuperview];
}

#pragma mark - Star rating prompt dialog delegate

- (void)userSelectedRating:(NSInteger)rating {
    NSTimeInterval waitBeforeMovingAwayFromStarsDialog = 0.75;
    NSTimeInterval animationDuration = 1.0;
    
    [self loadActionDialog];
    
    [SBDispatch dispatch:^{
        [self.starDialog animateAwayWithDuration:animationDuration];
        [self.actionDialog animateInWithDuration:animationDuration];
    } afterDuration:waitBeforeMovingAwayFromStarsDialog];
    
    [SBDispatch dispatch:^{
        [self removeStarsDialog];
    } afterDuration:waitBeforeMovingAwayFromStarsDialog + animationDuration];
}

@end
