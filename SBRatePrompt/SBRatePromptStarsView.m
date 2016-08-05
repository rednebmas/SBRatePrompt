//
//  SBRateStarsSuperView.m
//  Pods
//
//  Created by Sam Bender on 7/23/16.
//
//

#import "SBRatePromptStarsView.h"
#import "SBAnimation.h"
#import "SBRatePromptConstants.h"

static CGFloat const touchingAlpha = 0.5;
static CGFloat const notTouchingAlpha = 1.0;

@interface SBRatePromptStarsView()

@property (nonatomic, assign) BOOL recognizing;
@property (nonatomic, strong) NSArray<UIButton*> *stars;
@property (nonatomic, weak) UIView *currentlyTouching;
@property (weak, nonatomic) IBOutlet UIButton *star1;
@property (weak, nonatomic) IBOutlet UIButton *star2;
@property (weak, nonatomic) IBOutlet UIButton *star3;
@property (weak, nonatomic) IBOutlet UIButton *star4;
@property (weak, nonatomic) IBOutlet UIButton *star5;

@end

@implementation SBRatePromptStarsView

#pragma mark - Config

- (void)awakeFromNib
{
    self.stars = @[_star1, _star2, _star3, _star4, _star5];
    for (int i = 0; i < self.stars.count; i++)
    {
        UIView *star = self.stars[i];
        star.userInteractionEnabled = NO;
        star.tag = i;
    }
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.currentlyTouching == nil && touches.count == 1)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        UIView *star = [self starForTouchPoint:touchPoint];
        if (star != nil)
        {
            self.recognizing = YES;
            [self touchBeganInStar:star];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (self.recognizing == NO) return;
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    UIView *star = [self starForTouchPoint:touchPoint];
    if (star != nil
        && star != self.currentlyTouching)
    {
        [self touchBeganInStar:star];
    }
    else if (star == nil
               && !(touchPoint.y < CGRectGetMaxY(self.stars[0].frame)
               && touchPoint.y > CGRectGetMinY(self.stars[0].frame)))
    {
        [self touchLeftStar:star];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.recognizing == NO) return;
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    UIButton *star = [self starForTouchPoint:touchPoint];
    BOOL tochEndedInStar = star != nil;
    if (tochEndedInStar)
    {
        [self flipStarsToStar:star];
        [self.delegate starsViewSelectedStar:star.tag + 1];
    }
    
    [self clearTouchesAnimated:tochEndedInStar == NO];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (self.recognizing == NO) return;
    [self clearTouchesAnimated:YES];
}

#pragma mark - Touches helper

- (void)touchBeganInStar:(UIView*)star
{
    self.currentlyTouching = star;
    [self animateAlpha:touchingAlpha forStarUpToIndex:star.tag + 1];
}

- (void)touchLeftStar:(UIView*)star
{
    self.currentlyTouching = nil;
    [self animateAlpha:notTouchingAlpha forStarUpToIndex:star.tag + 1];
}

/**
 * Returns first view found
 */
- (nullable UIButton*)starForTouchPoint:(CGPoint)point
{
    for (UIButton *view in self.stars)
    {
        if (CGRectContainsPoint(view.frame, point))
        {
            return view;
        }
    }
    return nil;
}

- (void)clearTouchesAnimated:(BOOL)animated
{
    self.recognizing = NO;
    if (self.currentlyTouching != nil)
    {
        if (animated)
        {
            [self animateAlpha:notTouchingAlpha forStarUpToIndex:self.stars.count];
        }
        self.currentlyTouching = nil;
    }
}

#pragma mark - Animations

- (void)animateAlpha:(CGFloat)alpha forStarUpToIndex:(NSInteger)index
{
    [UIView animateWithDuration:.25 animations:^
     {
         int i;
         for (i = 0; i < index; i++)
         {
             [self.stars[i] setAlpha:alpha];
         }
         for (; i < self.stars.count; i++)
         {
             [self.stars[i] setAlpha:notTouchingAlpha];
         }
     }];
}

- (void)flipStarsToStar:(UIButton*)tappedStar
{
    UIImage *starred = [UIImage imageNamed:@"star"
                                  inBundle:SBRatePromptBundle
             compatibleWithTraitCollection:nil];
    
    CGFloat flipDuration = .25;
    CGFloat nextStarDelay = .04;
    for (int i = 0; i < tappedStar.tag + 1; i++)
    {
        UIButton *star = self.stars[i];
        CGFloat delay = (CGFloat)i * nextStarDelay;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^
        {
           [self flipStar:star withAnimationDuration:flipDuration andBackgroundImage:starred];
        });
    }
}

- (void)flipStar:(UIButton*)star withAnimationDuration:(CGFloat)animationDuration andBackgroundImage:(UIImage*)image
{
    [SBAnimation rotateOverYAxis:star duration:animationDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration / 2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        [star setBackgroundImage:image forState:UIControlStateNormal];
        star.alpha = 1.0;
    });
}

@end
