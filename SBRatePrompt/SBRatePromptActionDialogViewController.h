//
//  SBRatePromptActionDialogViewController.h
//  SBRatePrompt
//
//  Created by Sam Bender on 8/4/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SBDialogBlock)(void);

@interface SBRatePromptActionDialogViewController : UIViewController

- (void)animateInWithDuration:(NSTimeInterval)animationDuration;
- (void)animateAwayWithDuration:(NSTimeInterval)animationDuration;
- (void)onLeftButtonTap:(SBDialogBlock)leftButtonBlock onRightButtonTap:(SBDialogBlock)rightButtonBlock;
- (void)setText:(NSString*)text;
- (void)setRightButtonTitle:(NSString*)title;
- (void)setLeftButtonTitle:(NSString*)title;

@end
