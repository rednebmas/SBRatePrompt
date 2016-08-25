//
//  SBRatePrompt.h
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for SBRatePrompt.
FOUNDATION_EXPORT double SBRatePromptVersionNumber;

//! Project version string for SBRatePrompt.
FOUNDATION_EXPORT const unsigned char SBRatePromptVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SBRatePrompt/PublicHeader.h>


@interface SBRatePrompt : NSObject

+ (void)debugShow;

// @default: @"example@mail.com"
// @discussion: when the user chooses to send feedback because the rating was below feedbackThreshold, this is the email
//              that will be used.
+ (NSString*)feedbackEmailAddress;
+ (void)setFeedbackEmailAddress:(NSString*)feedbackEmailAddress;

// @default: see github
// @discussion: when the user chooses to send feedback because the rating was below feedbackThreshold, this is the email
//              body that will be used. Must be in HTML format, i.e. newline characters will not be reflected.
//              important: setting this will cause the default content to not be displayed.
+ (NSString*)feedbackEmailBody;
+ (void)setFeedbackEmailBody:(NSString*)feedbackEmailBody;

// @default: @"AppName Feedback"
// @discussion: the subject for the feedback email
+ (NSString*)feedbackEmailSubject;
+ (void)setFeedbackEmailSubject:(NSString*)feedbackEmailSubject;

// @default: YES
// @discussion: if set to NO, will only prompt to rate in the app store if greater than feedback threshold
+ (BOOL)askForFeedback;
+ (void)setAskForFeedback:(BOOL)askForFeedback;

// @default: 4
// @discussion:
// if (rating > feedbackThreshold) {
//     show rate in app store prompt
// } else {
//     show feedback prompt
// }
+ (NSInteger)feedbackThreshold;
+ (void)setFeedbackThreshold:(NSInteger)feedbackThreshold;

// @default: your CFBundleDisplayName
// @discussion: if you want the app name to display something other than your bundle display name set this value
+ (NSString*)appName;
+ (void)setAppName:(NSString*)appName;

@end

