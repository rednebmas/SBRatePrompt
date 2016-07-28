//
//  SBRatePrompt.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePrompt.h"
#import "SBRatePromptFlowController.h"

@interface SBRatePrompt()

@property (nonatomic, strong) SBRatePromptFlowController *flowController;

@end

@implementation SBRatePrompt

+ (instancetype)sharedInstance
{
    static SBRatePrompt *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SBRatePrompt alloc] init];
    });
    return sharedInstance;
}

+ (void)debugShow {
    [[SBRatePrompt sharedInstance] debugShow];
}

- (void)debugShow {
    self.flowController = [SBRatePromptFlowController new];
    [self.flowController begin];
}

@end