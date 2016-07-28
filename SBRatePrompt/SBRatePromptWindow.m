//
//  SBRatePromptWindow.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePromptWindow.h"

@implementation SBRatePromptWindow

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    super.frame = [self keyWindowFrame];
    super.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.35];
    super.windowLevel = UIWindowLevelAlert;
    super.alpha = 0.0;
}

- (CGRect)keyWindowFrame {
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    return mainWindow.frame;
}

#pragma mark - Public

- (void)animateInWithDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1.0;
    }];
}

@end
