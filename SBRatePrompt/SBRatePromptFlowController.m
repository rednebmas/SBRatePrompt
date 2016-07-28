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

@interface SBRatePromptFlowController()

@property (nonatomic, strong) SBRatePromptWindow *window;
@property (nonatomic, strong) SBRatePromptStarsDialogViewController *starDialog;

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
    [self.window addSubview:self.starDialog.view];
}

@end
