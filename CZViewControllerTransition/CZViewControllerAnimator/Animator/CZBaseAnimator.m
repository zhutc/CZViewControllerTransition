//
//  CZBaseAnimator.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/3.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZBaseAnimator.h"

/****  快速获取动画器，样例实现，这样写的目的是隐蔽 CZBaseAnimator.h 头文件暴露 ****/
/*
id <UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAnimatorCreate_CZBaseAnimator(CZBaseAnimatorTransitionType type)
{
    CZBaseAnimator* animator = [CZBaseAnimator new];
    animator.animatorType = type;
    return animator;
}
*/


@implementation CZBaseAnimator


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    return self;
}

//交互实现
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView* superView = [transitionContext containerView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    

    
    
    [self animateTransition:transitionContext
         fromViewController:fromVC
           toViewController:toVC
                containView:superView
                   duration:duration];


}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration ? self.duration : CZBaseAnimatorDuration;
}


#pragma mark - 子类实现具体的动画内容
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
      fromViewController:(UIViewController *)fromVC
        toViewController:(UIViewController *)toVC
             containView:(UIView *)containView
                duration:(NSTimeInterval)duration
{
    NSAssert(![self isMemberOfClass:[CZBaseAnimator class]],@"***********************************\n请使用CZBaseAnimator的子类，并重载|\nanimateTransition:\nfromViewController:\ntoViewController:\ncontainView:\nduration: |方法\n***********************************" );
}

@end








