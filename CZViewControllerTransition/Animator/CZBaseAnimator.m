//
//  CZBaseAnimator.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/3.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZBaseAnimator.h"
#define CZBaseAnimatorDuration (0.35f)


id <UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAnimatorCreate_CZBaseAnimator(CZBaseAnimatorTransitionType type)
{
    CZBaseAnimator* animator = [CZBaseAnimator new];
    animator.animatorType = type;
    return animator;
}


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
    
    //添加ToVC View
    if (!toVC.view.superview) {
        [superView insertSubview:toVC.view belowSubview:fromVC.view];
    }else if ([toVC.view.superview isEqual:superView])
    {
        [toVC.view removeFromSuperview];
        [superView insertSubview:toVC.view belowSubview:fromVC.view];
    }
    
    //设置frame
    CGRect toBeginFrame = fromVC.view.frame;
    CGRect toEndFrame = fromVC.view.frame;
    CGRect fromBeginFrame = fromVC.view.frame;
    CGRect fromEndFrame = fromVC.view.frame;
    
    
    toVC.view.frame = toEndFrame;

    UIViewAnimationTransition type = UIViewAnimationTransitionCurlDown;
    switch (self.animatorType) {
        case CZBaseAnimatorTransitionTypePush:
        {
            type = UIViewAnimationTransitionCurlDown;
        }
            break;
        case CZBaseAnimatorTransitionTypePop:
            type = UIViewAnimationTransitionCurlUp;
            break;
        default:
            break;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:type forView:superView cache:NO];
    [superView bringSubviewToFront:toVC.view];
    [CATransaction setCompletionBlock:^{
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    [UIView commitAnimations];
    

}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration ? self.duration : CZBaseAnimatorDuration;
}

@end








