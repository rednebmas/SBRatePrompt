//
//  SBRatePromptFlowController.m
//  SBRatePrompt
//
//  Created by Sam Bender on 7/27/16.
//  Copyright © 2016 Sam Bender. All rights reserved.
//

@import MessageUI;
#import "SBRatePrompt.h"
#import "SBRatePromptConstants.h"
#import "SBRatePromptFlowController.h"
#import "SBRatePromptWindowController.h"
#import "SBRatePromptWindow.h"
#import "SBRatePromptStarsDialogViewController.h"
#import "SBDispatch.h"
#import "SBRatePromptActionDialogViewController.h"
#import "SBAnimation.h"

@interface SBRatePromptFlowController () <SBRatePromptStarsDialogDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, weak) SBRatePromptWindow *window;
@property (nonatomic, strong) SBRatePromptWindowController *windowController;
@property (nonatomic, strong) SBRatePromptStarsDialogViewController *starDialog;
@property (nonatomic, strong) SBRatePromptActionDialogViewController *actionDialog;

@end

@implementation SBRatePromptFlowController

- (void)begin
{
    [self displayWindow];
    [self displayStarRatingPrompt];
}

- (void)displayWindow {
    self.windowController = [[SBRatePromptWindowController alloc] init];
    self.window = self.windowController.window;
    [self.window makeKeyAndVisible];
    [self.window animateInWithDuration:.25];
}

- (void)displayStarRatingPrompt {
    self.starDialog = [[SBRatePromptStarsDialogViewController alloc]
                       initWithNibName:@"SBRatePromptStarsDialogView"
                       bundle:SBRatePromptBundle];
    self.starDialog.delegate = self;
    [self.starDialog animateInWithDuration:.25];
    [self.window addSubview:self.starDialog.view];
}

- (void)displayActionDialog {
    self.actionDialog = [[SBRatePromptActionDialogViewController alloc]
                         initWithNibName:@"SBRatePromptActionDialogView"
                         bundle:SBRatePromptBundle];
    [self.window addSubview:self.actionDialog.view];
}


- (void)configureActionDialogPrompt
{
    if (self.rating > 4) {
        [self configureActionDialogCallbacksForRateInStore];
        [self.actionDialog setText:[NSString stringWithFormat:@"We're glad to hear it! Help other users find %@ by rating it on the App Store.", [SBRatePromptConstants appName]]];
    } else {
        [self.actionDialog setText:[NSString stringWithFormat:@"Would you mind providing us with feedback so we can improve %@?", [SBRatePromptConstants appName]]];
        [self.actionDialog setRightButtonTitle:@"Sure!"];
        [self configureActionDialogCallbacksForFeedback];
    }
}
         
- (void)configureActionDialogCallbacksForRateInStore
{
    [self.actionDialog onLeftButtonTap:^{
        [self dismiss];
        if (self.ratedCallback) {
            self.ratedCallback(self.rating, SBRatePromptActionNoThanks);
        }
    } onRightButtonTap:^{
        [self openAppInAppStore];
        [self dismiss];
        if (self.ratedCallback) {
            self.ratedCallback(self.rating, SBRatePromptActionRateInAppStore);
        }
    }];
}
         
- (void)configureActionDialogCallbacksForFeedback
{
    [self.actionDialog onLeftButtonTap:^{
        [self dismiss];
        if (self.ratedCallback) {
            self.ratedCallback(self.rating, SBRatePromptActionNoThanks);
        }
    } onRightButtonTap:^{
        [self dismiss];
        [self displayEmailComposerIfRequested];
        if (self.ratedCallback) {
            self.ratedCallback(self.rating, SBRatePromptActionProvideFeedback);
        }
    }];
}

- (void)displayEmailComposerIfRequested {
    if (self.displayEmailFeedbackCallback) {
        if (self.displayEmailFeedbackCallback()) {
            [self displayEmailComposer];
        }
    }
}

#pragma mark - Action Dialog actions

- (void)displayEmailComposer
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:[SBRatePrompt feedbackEmailSubject]];
        [mail setMessageBody:[self feedbackEmailBody] isHTML:YES]; 
        [mail setToRecipients:@[[SBRatePrompt feedbackEmailAddress]]];
        
        UIWindow *mainWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        [[mainWindow rootViewController] presentViewController:mail animated:YES completion:nil];
    }
    else
    {
        NSString *urlString = [[NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@",
                               [SBRatePrompt feedbackEmailAddress],
                               [SBRatePrompt feedbackEmailSubject],
                               [self feedbackEmailBody]]
                                    stringByAddingPercentEncodingWithAllowedCharacters:
                                    [NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *mailTo = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:mailTo];
    }
}

- (NSString*)feedbackEmailBody
{
    NSString *feedbackEmailBody = [SBRatePrompt feedbackEmailBody];
    if (feedbackEmailBody != nil) {
        return feedbackEmailBody;
    }
    
    return [NSString stringWithFormat:@"&lt;your feedback here&gt;<br/><br/>"
                                       "<span style='display: inline-block; text-align: center; border: 1px solid lightgray; background-color: #F8F8F8; padding: 15px; border-radius: 3pt;'/>"
                                       "I rated %@ %ld stars."
                                       "<br/>%@</span>",
            [SBRatePromptConstants appName],
            (long)self.rating,
            [self starImagesHTML]];
}

- (NSString*)starImagesHTML {
    UIImage *starImage = [UIImage imageNamed:@"star"
                               inBundle:SBRatePromptBundle
          compatibleWithTraitCollection:nil];
    UIImage *starGrayImage = [UIImage imageNamed:@"star-gray"
                                   inBundle:SBRatePromptBundle
              compatibleWithTraitCollection:nil];
    
    NSString *starBase64String = [self base64EncodedImage:starImage];
    NSString *starGrayBase64String = [self base64EncodedImage:starGrayImage];
    NSMutableString *html = [[NSMutableString alloc] init];
    
    static NSString *format = @"<img src='data:image/png;base64,%@' style='margin: 4pt 4pt; margin-top: 9pt;' width='42pt' height='42pt'>";
    for (NSInteger i = 0; i < self.rating; i++) {
        [html appendFormat:format, starBase64String];
    }
    for (NSInteger i = self.rating; i < 5; i++) {
        [html appendFormat:format, starGrayBase64String];
    }
    
    return [NSString stringWithString:html];
}

- (NSString*)base64EncodedImage:(UIImage*)image
{
    NSData *imgData = UIImagePNGRepresentation(image);
    return [imgData base64EncodedStringWithOptions:0];
}


/**
 * http://stackoverflow.com/a/9510132/337934
 */
- (void)openAppInAppStore
{
    NSString *appName = [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleName"]];
    NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.com/app/%@",[appName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    [[UIApplication sharedApplication] openURL:appStoreURL];
}

#pragma mark - Mail delegate 

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Hide/remove views

- (void)removeStarsDialog {
    [self.starDialog.view removeFromSuperview];
}

- (void)dismiss {
    NSTimeInterval animationDuration = .25;
    
    UIViewController *vcToShrink = self.actionDialog ? self.actionDialog : self.starDialog;
    [SBAnimation shrinkView:vcToShrink.view withDuration:animationDuration - .05 completion:nil];
    
    [self.windowController
     animateDismissWithDuration:animationDuration
     andOnCompletion:^{
         self.windowController = nil;
         self.actionDialog = nil;
         self.starDialog = nil;
     }];
}

#pragma mark - Star rating prompt dialog delegate

- (void)userSelectedRating:(NSInteger)rating
{
    self.rating = rating;
    NSTimeInterval waitBeforeMovingAwayFromStarsDialog = 0.4;
    if (![SBRatePrompt askForFeedback] && rating <= [SBRatePrompt feedbackThreshold])
    {
        if (self.ratedCallback) {
            self.ratedCallback(self.rating, SBRatePromptActionAskForFeedbackNotShown);
        }

        [SBDispatch dispatch:^{
            [self dismiss];
        } afterDuration:waitBeforeMovingAwayFromStarsDialog];
        return;
    }
    
    NSTimeInterval animationDuration = 0.65;
    [self displayActionDialog];
    [self configureActionDialogPrompt];
    
    [SBDispatch dispatch:^{
        [self.starDialog animateAwayWithDuration:animationDuration];
        [self.actionDialog animateInWithDuration:animationDuration];
    } afterDuration:waitBeforeMovingAwayFromStarsDialog];
    
    [SBDispatch dispatch:^{
        [self removeStarsDialog];
    } afterDuration:waitBeforeMovingAwayFromStarsDialog + animationDuration];
}

@end
