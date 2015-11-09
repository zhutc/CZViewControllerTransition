//
//  CZTransitionManager.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/6.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CZTransitionManager : NSObject<UINavigationControllerDelegate , UIViewControllerTransitioningDelegate>

//获取动画管理器
-(instancetype)initWithAnimator:(id<UIViewControllerAnimatedTransitioning>)aimator
         interacetiveTransition:(UIPercentDrivenInteractiveTransition*)interaceTransition
                 viewController:(UIViewController*)viewController;

+(instancetype)transitionManagerWithAnimator:(id<UIViewControllerAnimatedTransitioning>)aimator
                      interacetiveTransition:(UIPercentDrivenInteractiveTransition*)interaceTransition
                              viewController:(UIViewController*)viewController;


+(instancetype)transitionManagerWithAnimator:(id<UIViewControllerAnimatedTransitioning>)aimator
                              viewController:(UIViewController*)viewController;
@end
