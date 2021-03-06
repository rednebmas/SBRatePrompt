//
//  SBRatePromptConstants.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import "SBRatePromptConstants.h"
#import "SBRatePrompt.h"

@implementation SBRatePromptConstants

+ (CGFloat)dialogWidth
{
    return 320.0f;
}

+ (CGFloat)dialogAnimationDistanceOffset
{
    return 600.0f;
}

+ (NSString*)appName
{
    if ([SBRatePrompt appName] == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSDictionary *info = [bundle infoDictionary];
        NSString *name = [info objectForKey:@"CFBundleDisplayName"];
        if (name == nil) {
            name = [info objectForKey:@"CFBundleName"];
        }
        return name;
    } else {
        return [SBRatePrompt appName];
    }
}

@end
