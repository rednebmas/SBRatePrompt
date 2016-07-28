//
//  SBRateStarsSuperView.h
//  Pods
//
//  Created by Sam Bender on 7/23/16.
//
//

#import <UIKit/UIKit.h>

@protocol SBRateStarsViewDelegate <NSObject>

- (void)touchEndedInStar:(NSInteger)star;

@end

@interface SBRatePromptStarsView : UIView

@property (nonatomic, strong) id<SBRateStarsViewDelegate>delegate;

@end
