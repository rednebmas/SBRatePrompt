//
//  SBAnimation.m
//  Pods
//
//  Created by Sam Bender on 7/23/16.
//
//

#import "SBAnimation.h"

@implementation SBAnimation

/**
 * http://stackoverflow.com/questions/11571420/catransform3drotate-rotate-for-360-degrees
 */
+ (void) rotateOverYAxis:(UIView*)view duration:(NSTimeInterval)duration
{
    CALayer *layer = view.layer;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -50;
    layer.transform = transform;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 0 * M_PI / 2, 0, 1, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 1 * M_PI / 2, 0, 1, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 2 * M_PI / 2, 0, 1, 0)],
                        nil];
    
    [layer addAnimation:animation forKey:animation.keyPath];
}

+ (void)shrinkView:(UIView*)view withDuration:(NSTimeInterval)duration completion:(voidBlock)completion {
    [UIView animateWithDuration:duration
                     animations:^
    {
        view.transform = CGAffineTransformMakeScale(0.001, 0.001);
    }
                     completion:^(BOOL finished)
    {
        if (completion) {
            completion();
        }
    }];
}

@end
