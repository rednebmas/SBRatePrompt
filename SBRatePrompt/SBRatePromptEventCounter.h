//
//  SBRatePromptEventCounter.h
//  SBRatePrompt
//
//  Created by Sam Bender on 8/25/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

typedef void(^SBRatePromptEventCounterTriggerBlock)(void);

#import <Foundation/Foundation.h>

@interface SBRatePromptEventCounter : NSObject

- (instancetype)initWithTrigger:(SBRatePromptEventCounterTriggerBlock)triggerBlock;
- (void)logEvent:(NSString*)eventName;
- (void)setTriggerValue:(NSInteger)triggerValue forEvent:(NSString*)eventName;

@end
