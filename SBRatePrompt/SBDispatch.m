//
//  SBDispatch.m
//  SBRatePrompt
//
//  Created by Sam Bender on 8/4/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBDispatch.h"

@implementation SBDispatch

+ (void)dispatch:(void (^)(void))block afterDuration:(NSTimeInterval)duration {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@end
