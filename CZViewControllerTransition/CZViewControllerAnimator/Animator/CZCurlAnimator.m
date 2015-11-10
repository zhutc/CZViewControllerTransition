//
//  CZCurlAnimator.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/4.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZCurlAnimator.h"


id <UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAppend(CZCurlAnimator)(BOOL isOut)
{
    CZCurlAnimator* animator = [CZCurlAnimator new];
    animator.isOut = isOut;
    return animator;
}


@implementation CZCurlAnimator

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
      fromViewController:(UIViewController *)fromVC
        toViewController:(UIViewController *)toVC
             containerView:(UIView *)containView
                duration:(NSTimeInterval)duration
{
    
    //添加ToVC View
    if (!toVC.view.superview) {
        [containView insertSubview:toVC.view belowSubview:fromVC.view];
    }else if ([toVC.view.superview isEqual:containView])
    {
        [toVC.view removeFromSuperview];
        [containView insertSubview:toVC.view belowSubview:fromVC.view];
    }
    
    //设置frame
    CGRect toEndFrame = fromVC.view.frame;
    toVC.view.frame = toEndFrame;
    
    //显示周期
    
    
    
    UIViewAnimationTransition type = UIViewAnimationTransitionCurlDown;
    switch (self.isOut) {
        case NO:
        {
            type = UIViewAnimationTransitionCurlDown;
        }
            break;
        case YES:
        {
            type = UIViewAnimationTransitionCurlUp;

        }
            break;
        default:
            break;
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:type forView:containView cache:NO];
    [containView bringSubviewToFront:toVC.view];
    [CATransaction setCompletionBlock:^{
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    [UIView commitAnimations];

}
@end
