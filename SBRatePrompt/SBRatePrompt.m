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
#import "SBRatePromptEventCounter.h"

@interface SBRatePrompt()

//// publicly exposed
@property (nonatomic, assign) BOOL askForFeedback;
@property (nonatomic, assign) NSInteger feedbackThreshold;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *feedbackEmailAddress;
@property (nonatomic, strong) NSString *feedbackEmailBody;
@property (nonatomic, strong) NSString *feedbackEmailSubject;

//// private
@property (nonatomic, strong) SBRatePromptFlowController *flowController;
@property (nonatomic, strong) SBRatePromptEventCounter *eventCounter;

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
        [self configure];
    }
    return self;
}

- (void)configure
{
    self.flowController = [SBRatePromptFlowController new];
    
    __weak typeof(self) weakSelf = self;
    self.eventCounter = [[SBRatePromptEventCounter alloc] initWithTrigger:^{
        [weakSelf show];
    }];
    
    // default values
    _askForFeedback = YES;
    _feedbackThreshold = 4;
    _feedbackEmailAddress = @"example@mail.com";
}

#pragma mark - Public

+ (void)debugShow {
    [[SBRatePrompt sharedInstance] show];
}

#pragma mark - Events

+ (void)logEvent:(NSString*)eventName {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    [instance.eventCounter logEvent:eventName];
}

+ (void)setTriggerValue:(NSInteger)triggerValue forEvent:(NSString*)eventName {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    [instance.eventCounter setTriggerValue:triggerValue forEvent:eventName];
}

#pragma mark - Public properties

#pragma mark - Callbacks

+ (void)setRatedCallback:(void (^)(NSInteger rating, SBRatePromptAction action))callback {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.flowController.ratedCallback = callback;
}

+ (void)setDisplayEmailFeedbackCallback:(BOOL (^)(void))callback {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.flowController.displayEmailFeedbackCallback = callback;
}

#pragma mark - Other properties

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

+ (NSString*)feedbackEmailAddress {
    return [[SBRatePrompt sharedInstance] feedbackEmailAddress];
}

+ (void)setFeedbackEmailAddress:(NSString*)feedbackEmailAddress {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.feedbackEmailAddress = feedbackEmailAddress;
}

+ (NSString*)feedbackEmailBody {
    return [[SBRatePrompt sharedInstance] feedbackEmailBody];
}

+ (void)setFeedbackEmailBody:(NSString*)feedbackEmailBody {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.feedbackEmailBody = feedbackEmailBody;
}

+ (NSString*)feedbackEmailSubject {
    NSString *feedbackEmailSubject = [[SBRatePrompt sharedInstance] feedbackEmailSubject];
    if (feedbackEmailSubject) {
        return feedbackEmailSubject;
    }
    
    return [NSString stringWithFormat:@"%@ Feedback", [SBRatePromptConstants appName]];
}

+ (void)setFeedbackEmailSubject:(NSString*)feedbackEmailSubject {
    SBRatePrompt *instance = [SBRatePrompt sharedInstance];
    instance.feedbackEmailSubject = feedbackEmailSubject;
}

#pragma mark - Private
#pragma mark - Helper

- (void)show {
    [self.flowController begin];
}

@end