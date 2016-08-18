//
//  SBRatePromptFlowController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePrompt.h"
#import "SBRatePromptConstants.h"
#import "SBRatePromptFlowController.h"
#import "SBRatePromptWindowController.h"
#import "SBRatePromptWindow.h"
#import "SBRatePromptStarsDialogViewController.h"
#import "SBDispatch.h"
#import "SBRatePromptActionDialogViewController.h"
#import "SBAnimation.h"

@interface SBRatePromptFlowController () <SBRatePromptStarsDialogDelegate>

@property (nonatomic, weak) SBRatePromptWindow *window;
@property (nonatomic, strong) SBRatePromptWindowController *windowController;
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
    self.windowController = [[SBRatePromptWindowController alloc] init];
    self.window = self.windowController.window;
    [self.window makeKeyAndVisible];
    [self.window animateInWithDuration:.25];
}

- (void)displayStarRatingPrompt {
    self.starDialog = [[SBRatePromptStarsDialogViewController alloc]
                       initWithNibName:@"SBRatePromptStarsDialogView"
                       bundle:SBRatePromptBundle];
    self.starDialog.delegate = self;
    [self.starDialog animateInWithDuration:.25];
    [self.window addSubview:self.starDialog.view];
}

- (void)displayActionDialog {
    self.actionDialog = [[SBRatePromptActionDialogViewController alloc]
                         initWithNibName:@"SBRatePromptActionDialogView"
                         bundle:SBRatePromptBundle];
    [self.window addSubview:self.actionDialog.view];
}


- (void)configureActionDialogPromptForRating:(NSInteger)rating
{
    if (rating > 4) {
        [self configureActionDialogCallbacksForRateInStore];
        [self.actionDialog setText:[NSString stringWithFormat:@"We're glad to hear it! Help other users find %@ by rating it on the App Store.", [SBRatePromptConstants appName]]];
    } else {
        [self.actionDialog setText:[NSString stringWithFormat:@"Would you mind providing us with feedback so we can improve %@?", [SBRatePromptConstants appName]]];
        [self.actionDialog setRightButtonTitle:@"Sure!"];
        [self configureActionDialogCallbacksForFeedback];
    }
}
         
- (void)configureActionDialogCallbacksForRateInStore
{
    [self.actionDialog onLeftButtonTap:^{
        [self dismiss];
    } onRightButtonTap:^{
        [self openAppInAppStore];
        [self dismiss];
    }];
}
         
- (void)configureActionDialogCallbacksForFeedback
{
    [self.actionDialog onLeftButtonTap:^{
        [self dismiss];
    } onRightButtonTap:^{
        [self dismiss];
    }];
}

/**
 * http://stackoverflow.com/a/9510132/337934
 */
- (void)openAppInAppStore
{
    NSString *appName = [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleName"]];
    NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.com/app/%@",[appName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    [[UIApplication sharedApplication] openURL:appStoreURL];
}

#pragma mark - Hide/remove views

- (void)removeStarsDialog {
    [self.starDialog.view removeFromSuperview];
}

- (void)dismiss {
    NSTimeInterval animationDuration = .25;
    
    UIViewController *vcToShrink = self.actionDialog ? self.actionDialog : self.starDialog;
    [SBAnimation shrinkView:vcToShrink.view withDuration:animationDuration - .05 completion:nil];
    
    [self.windowController
     animateDismissWithDuration:animationDuration
     andOnCompletion:^{
         self.windowController = nil;
         self.actionDialog = nil;
         self.starDialog = nil;
     }];
}

#pragma mark - Star rating prompt dialog delegate

- (void)userSelectedRating:(NSInteger)rating {
    NSTimeInterval waitBeforeMovingAwayFromStarsDialog = 0.4;
    if (![SBRatePrompt askForFeedback] && rating <= [SBRatePrompt feedbackThreshold])
    {
        [SBDispatch dispatch:^{
            [self dismiss];
        } afterDuration:waitBeforeMovingAwayFromStarsDialog];
        return;
    }
    
    NSTimeInterval animationDuration = 0.65;
    [self displayActionDialog];
    [self configureActionDialogPromptForRating:rating];
    
    [SBDispatch dispatch:^{
        [self.starDialog animateAwayWithDuration:animationDuration];
        [self.actionDialog animateInWithDuration:animationDuration];
    } afterDuration:waitBeforeMovingAwayFromStarsDialog];
    
    [SBDispatch dispatch:^{
        [self removeStarsDialog];
    } afterDuration:waitBeforeMovingAwayFromStarsDialog + animationDuration];
}

@end
