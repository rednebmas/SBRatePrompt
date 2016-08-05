//
//  SBDispatch.h
//  SBRatePrompt
//
//  Created by Sam Bender on 8/4/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBDispatch : NSObject

+ (void)dispatch:(void (^)(void))block afterDuration:(NSTimeInterval)duration;

@end
