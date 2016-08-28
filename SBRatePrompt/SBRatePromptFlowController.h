//
//  SBRatePromptFlowController.h
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBRatePromptFlowController : NSObject

@property (nonatomic, copy) void (^ratedCallback)(NSInteger rating, SBRatePromptAction action);
@property (nonatomic, copy) BOOL (^displayEmailFeedbackCallback)(void);

- (void)begin;

@end
