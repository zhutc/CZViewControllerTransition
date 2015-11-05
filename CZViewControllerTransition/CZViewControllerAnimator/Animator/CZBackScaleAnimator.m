//
//  CZBackScaleAnimator.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/4.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZBackScaleAnimator.h"


id <UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAppend(CZBackScaleAnimator)(CZBaseAnimatorTransitionType type)
{
    CZBackScaleAnimator* animator = [CZBackScaleAnimator new];
    animator.animatorType = type;
    animator.backViewAlpha = 0.5f;
    animator.backViewScale = 0.5f;
    
    
    return animator;
}



@implementation CZBackScaleAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
       fromViewController:(UIViewController *)fromVC
         toViewController:(UIViewController *)toVC
              containerView:(UIView *)containView
                 duration:(NSTimeInterval)duration
{

    
    
    if (self.animatorType == CZBaseAnimatorTransitionTypePush) {
        
        CGRect startRect;
        
        [containView addSubview:toVC.view];
        
        startRect = CGRectMake(CGRectGetWidth(containView.frame),
                               0,
                               CGRectGetWidth(containView.bounds),
                               CGRectGetHeight(containView.bounds));
        
        
        
        CGPoint transformedPoint = CGPointApplyAffineTransform(startRect.origin, toVC.view.transform);
        toVC.view.frame = CGRectMake(transformedPoint.x, transformedPoint.y, startRect.size.width, startRect.size.height);
        

        
        [UIView animateWithDuration:duration
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             fromVC.view.transform = CGAffineTransformScale(fromVC.view.transform, self.backViewScale, self.backViewScale);
                             fromVC.view.alpha = self.backViewAlpha;
                             
                             toVC.view.frame = CGRectMake(0,
                                                          0,
                                                          CGRectGetWidth(toVC.view.frame),
                                                          CGRectGetHeight(toVC.view.frame));
                         } completion:^(BOOL finished) {
                             fromVC.view.alpha = 1.0f;
                             fromVC.view.transform = CGAffineTransformIdentity;

                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    } else {
        
        
        [containView addSubview:toVC.view];        
        [containView bringSubviewToFront:fromVC.view];
        
        toVC.view.layer.transform = CATransform3DScale(toVC.view.layer.transform, self.backViewScale, self.backViewScale, 1);
        
        
        toVC.view.alpha = self.backViewAlpha;
        
        CGRect endRect;
        
        endRect = CGRectMake(CGRectGetWidth(fromVC.view.bounds),
                             0,
                             CGRectGetWidth(fromVC.view.frame),
                             CGRectGetHeight(fromVC.view.frame));

        
        CGPoint transformedPoint = CGPointApplyAffineTransform(endRect.origin, fromVC.view.transform);
        endRect = CGRectMake(transformedPoint.x, transformedPoint.y, endRect.size.width, endRect.size.height);
        
        
        
        
        [UIView animateWithDuration:duration
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                         
                             toVC.view.alpha = 1.0f;
                             fromVC.view.frame = endRect;
                             toVC.view.layer.transform = CATransform3DIdentity;

                         } completion:^(BOOL finished) {

                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}



@end
