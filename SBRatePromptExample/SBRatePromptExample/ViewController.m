//
//  ViewController.m
//  SBRatePromptExample
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import <SBRatePrompt/SBRatePrompt.h>
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *eventName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    // Configure SBRatePrompt
    //
    
    [SBRatePrompt setRatedCallback:^(NSInteger rating, SBRatePromptAction action){
        NSLog(@"User rated us %ld", (long)rating);
    }];
    
    [SBRatePrompt setDisplayEmailFeedbackCallback:^{
        return YES;
    }];
    
    self.eventName = [NSString stringWithFormat:@"%@", [NSDate date]];
    [SBRatePrompt setTriggerValue:3 forEvent:self.eventName];
    
    // [SBRatePrompt setAskForFeedback:NO];
    // [SBRatePrompt setAppName:@"Tunerval"];
}

- (IBAction)show:(id)sender {
    [SBRatePrompt debugShow];
}

- (IBAction)logEvent:(UIButton *)sender {
    [SBRatePrompt logEvent:self.eventName];
    
    CGFloat animationDuration = .2;
    [UIView animateWithDuration:animationDuration animations:^{
        sender.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationDuration animations:^{
            sender.transform = CGAffineTransformIdentity;
        }];
    }];
}

@end
