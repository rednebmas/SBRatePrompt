//
//  SBRatePromptWindowController.h
//  SBRatePrompt
//
//  Created by Sam Bender on 8/9/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBRatePromptWindow;

@interface SBRatePromptWindowController : UIViewController

- (SBRatePromptWindow*)window;
- (void)dismissAndOnCompletion:(void (^)(void))competion;

@end
