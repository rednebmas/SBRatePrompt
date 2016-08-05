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

@interface SBRatePromptFlowController () <SBRatePromptStarsDialogDelegate>

@property (nonatomic, strong) SBRatePromptWindow *window;
@property (nonatomic, strong) SBRatePromptStarsDialogViewController *starDialog;

@end

@implementation SBRatePromptFlowController

- (void)begin
{
    [self displayWindow];
    [self displayStarRatingPrompt];
}

#pragma mark - Display views

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

#pragma mark - Hide/remove views

- (void)removeStarsDialog {
    [self.starDialog.view removeFromSuperview];
}

#pragma mark - Star rating prompt dialog delegate

- (void)userSelectedRating:(NSInteger)rating {
    NSTimeInterval waitBeforeMovingAwayStarsDialog = 1.25;
    NSTimeInterval animateAwayDuration = 0.5;
    
    [SBDispatch dispatch:^{
        [self.starDialog animateAwayWithDuration:animateAwayDuration];
    } afterDuration:waitBeforeMovingAwayStarsDialog];
    
    [SBDispatch dispatch:^{
        [self removeStarsDialog];
    } afterDuration:waitBeforeMovingAwayStarsDialog + animateAwayDuration];
    
}

@end
