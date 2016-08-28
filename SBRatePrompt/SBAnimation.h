//
//  SBAnimation.h
//  Pods
//
//  Created by Sam Bender on 7/23/16.
//
//

#import <UIKit/UIKit.h>

typedef void (^voidBlock)(void);

@interface SBAnimation : NSObject

+ (void)rotateOverYAxis:(UIView*)view duration:(NSTimeInterval)duration;
+ (void)shrinkView:(UIView*)view withDuration:(NSTimeInterval)duration completion:(voidBlock)completion;

@end
