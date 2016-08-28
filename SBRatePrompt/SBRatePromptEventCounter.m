//
//  SBRatePromptEventCounter.m
//  SBRatePrompt
//
//  Created by Sam Bender on 8/25/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePromptEventCounter.h"

@interface SBRatePromptEventCounter()

@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, copy) SBRatePromptEventCounterTriggerBlock triggerBlock;

@end

@implementation SBRatePromptEventCounter

- (instancetype)initWithTrigger:(SBRatePromptEventCounterTriggerBlock)triggerBlock
{
    if (self = [self init]) {
        _triggerBlock = triggerBlock;
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)logEvent:(NSString*)eventName
{
    NSString *key = [NSString stringWithFormat:@"EVENT_COUNT:%@:%@", eventName, [self appVersion]];
    NSInteger value = [self incrementValueAtKey:key];
    if (value == [self triggerValueForEventName:eventName])
    {
        if (self.triggerBlock) {
            self.triggerBlock();
        }
    }
}

- (NSInteger)incrementValueAtKey:(NSString*)key
{
    NSInteger value = [_defaults integerForKey:key];
    value++;
    [_defaults setInteger:value forKey:key];
    return value;
}

- (void)setTriggerValue:(NSInteger)triggerValue forEvent:(NSString*)eventName
{
    NSString *key = [NSString stringWithFormat:@"EVENT_TRIGGER_VALUE:%@", eventName];
    [_defaults setInteger:triggerValue forKey:key];
}

- (NSInteger)triggerValueForEventName:(NSString*)eventName
{
    NSString *key = [NSString stringWithFormat:@"EVENT_TRIGGER_VALUE:%@", eventName];
    return [_defaults integerForKey:key];
}

- (NSString*)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end
