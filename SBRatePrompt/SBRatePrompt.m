//
//  SBRatePrompt.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePrompt.h"
#import "SBRatePromptFlowController.h"
#import "SBRatePromptConstants.h"

@interface SBRatePrompt()

// publicly exposed
@property (nonatomic, assign) BOOL askForFeedback;
@property (nonatomic, assign) NSInteger feedbackThreshold;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *feedbackEmailAddress;
@property (nonatomic, strong) NSString *feedbackEmailBody;
@property (nonatomic, strong) NSString *feedbackEmailSubject;

// private
@property (nonatomic, strong) SBRatePromptFlowController *flowController;


@end

@implementation SBRatePrompt

#pragma mark - Initialization

+ (instancetype)sharedInstance
{
    static SBRatePrompt *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SBRatePrompt alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureDefaults];
    }
    return self;
}

- (void)configureDefaults
{
    _askForFeedback = YES;
    _feedbackThreshold = 4;
    _feedbackEmailAddress = @"example@mail.com";
}

#pragma mark - Public
#pragma mark - Public methods

+ (void)debugShow {
    [[SBRatePrompt sharedInstance] debugShow];
}

#pragma mark - Public properties

+ (BOOL)askForFeedback {
    return [[SBRatePrompt sharedInstance] askForFeedback];
}

+ (void)setAskForFeedback:(BOOL)askForFeedback {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.askForFeedback = askForFeedback;
}

+ (NSInteger)feedbackThreshold {
    return [[SBRatePrompt sharedInstance] feedbackThreshold];
}

+ (void)setFeedbackThreshold:(NSInteger)feedbackThreshold {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.feedbackThreshold = feedbackThreshold;
}

+ (NSString*)appName {
    return [[SBRatePrompt sharedInstance] appName];
}

+ (void)setAppName:(NSString*)appName {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.appName = appName;
}

+ (NSString*)feedbackEmailAddress
{
    return [[SBRatePrompt sharedInstance] feedbackEmailAddress];
}

+ (void)setFeedbackEmailAddress:(NSString*)feedbackEmailAddress
{
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.feedbackEmailAddress = feedbackEmailAddress;
}

+ (NSString*)feedbackEmailBody
{
    return [[SBRatePrompt sharedInstance] feedbackEmailBody];
}

+ (void)setFeedbackEmailBody:(NSString*)feedbackEmailBody
{
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.feedbackEmailBody = feedbackEmailBody;
}

+ (NSString*)feedbackEmailSubject
{
    NSString *feedbackEmailSubject = [[SBRatePrompt sharedInstance] feedbackEmailSubject];
    if (feedbackEmailSubject) {
        return feedbackEmailSubject;
    }
    
    return [NSString stringWithFormat:@"%@ Feedback", [SBRatePromptConstants appName]];
}

+ (void)setFeedbackEmailSubject:(NSString*)feedbackEmailSubject
{
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.feedbackEmailSubject = feedbackEmailSubject;
}

#pragma mark - Private
#pragma mark - Helper

- (void)debugShow {
    self.flowController = [SBRatePromptFlowController new];
    [self.flowController begin];
}

@end