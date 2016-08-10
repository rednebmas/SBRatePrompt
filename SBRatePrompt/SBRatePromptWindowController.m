//
//  SBRatePromptWindowController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 8/9/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePromptWindowController.h"
#import "SBRatePromptWindow.h"

@interface SBRatePromptWindowController ()

@property (nonatomic, retain) SBRatePromptWindow *window;

@end

@implementation SBRatePromptWindowController

@dynamic view;

#pragma mark - View lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _window = [[SBRatePromptWindow alloc] init];
        [_window setRootViewController:self];
    }
    return self;
}

- (SBRatePromptWindow*)window
{
    return _window;
}

- (void)dismissAndOnCompletion:(void (^)(void))competion
{
    self.window.rootViewController = nil;
    [self.window removeFromSuperview];
    self.window.hidden = YES;
    self.window = nil;
    
    if (competion) {
        competion();
    }
}



@end
