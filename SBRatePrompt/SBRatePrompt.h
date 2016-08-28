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

typedef NS_ENUM(NSUInteger, SBRatePromptAction) {
    SBRatePromptActionNoThanks,
    SBRatePromptActionAskForFeedbackNotShown,
    SBRatePromptActionRateInAppStore,
    SBRatePromptActionProvideFeedback
};

@interface SBRatePrompt : NSObject

+ (void)debugShow;

#pragma mark - Events

+ (void)logEvent:(NSString*)eventName;
+ (void)setTriggerValue:(NSInteger)triggerValue forEvent:(NSString*)eventName;

#pragma mark - Callbacks

// @discussion: called when the user rates the app
// @param rating: 1-5 value that the user rated the app
// @param action: the action the user chose on the second dialog
+ (void)setRatedCallback:(void (^)(NSInteger rating, SBRatePromptAction action))callback;

// @discussion: called when the user decides to provide feedback.
//              return YES to display the email composer. if NO is returned, the email composer will not be displayed.
//              this is where you can override the feedback mechanism with whatever you'd like. for example, you might
//              want to open a URL to the feedback page on your website instead.
+ (void)setDisplayEmailFeedbackCallback:(BOOL (^)(void))callback;

#pragma mark - Properties

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

