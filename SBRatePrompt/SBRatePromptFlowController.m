//
//  SBRatePromptFlowController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePromptFlowController.h"
#import "SBRatePromptStarsDialogViewController.h"

#define SBRatePromptBundle [NSBundle bundleForClass:[SBRatePromptStarsDialogViewController class]]

@interface SBRatePromptFlowController()

@property (nonatomic, strong) SBRatePromptStarsDialogViewController *starDialog;

@end

@implementation SBRatePromptFlowController

- (void)begin
{
    [self displayStarRatingPrompt];
    
}

- (void)displayStarRatingPrompt {
    self.starDialog = [SBRatePromptBundle loadNibNamed:NSStringFromClass([SBRatePromptStarsDialogViewController class]) owner:self options:nil];
    self.starDialog.view.backgroundColor = [UIColor redColor];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:self.starDialog animated:YES completion:nil];
}

@end
