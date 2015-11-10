//
//  CZTransitionManager.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/6.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CZPercentDrivenInteractiveTransition.h"
#import "CZBaseAnimatedTransitioning.h"
NS_ASSUME_NONNULL_BEGIN
@interface CZTransitionManager : NSObject<UINavigationControllerDelegate , UIViewControllerTransitioningDelegate>

@property(nonatomic , strong , readwrite , nullable) id<CZBaseAnimatedTransitioning> pushTransitionAnimator;
@property(nonatomic , strong , readwrite , nullable) id<CZBaseAnimatedTransitioning> popTransitionAnimator;
@property(nonatomic , strong , readwrite , nullable) id<CZBaseAnimatedTransitioning> presentTransitionAnimator;
@property(nonatomic , strong , readwrite , nullable) id<CZBaseAnimatedTransitioning> dismissTransitionAnimator;
@property(nonatomic , strong , readwrite , nullable) CZPercentDrivenInteractiveTransition* transitionInteractive;



//获取动画管理器
-(instancetype)initWithAnimator:(nullable id<CZBaseAnimatedTransitioning>)aimator
         interacetiveTransition:(nullable CZPercentDrivenInteractiveTransition*)interaceTransition;

+(instancetype)transitionManagerWithAnimator:(nullable id<CZBaseAnimatedTransitioning>)aimator
                      interacetiveTransition:(nullable CZPercentDrivenInteractiveTransition*)interaceTransition;





@end
NS_ASSUME_NONNULL_END