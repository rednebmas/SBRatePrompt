//
//  SBRatePromptStarsDialogViewController.h
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBRatePromptStarsView.h"

@protocol SBRatePromptStarsDialogDelegate <NSObject>

- (void)userSelectedRating:(NSInteger)rating;

@end

@interface SBRatePromptStarsDialogViewController : UIViewController

@property (strong, nonatomic) SBRatePromptStarsView *view;
@property (weak, nonatomic) id<SBRatePromptStarsDialogDelegate> delegate;

- (void)animateAwayWithDuration:(NSTimeInterval)animationDuration;

@end
