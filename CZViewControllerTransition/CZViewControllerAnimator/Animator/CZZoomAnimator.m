//
//  CZZoomAnimator.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/5.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZZoomAnimator.h"
id <UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAppend(CZZoomAnimator)(BOOL isOut)
{
    CZZoomAnimator* animator = [CZZoomAnimator new];
    animator.isOut = isOut;
    animator.transformScale = 0.3f;
    return animator;
}
@implementation CZZoomAnimator
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
      fromViewController:(UIViewController *)fromVC
        toViewController:(UIViewController *)toVC
           containerView:(UIView *)containView
                duration:(NSTimeInterval)duration
{
    //设置frame
    CGRect fromRect = fromVC.view.frame;
    toVC.view.frame = fromRect;
    
    //添加toVC
    
    CGAffineTransform fromVCBeginTransform;
    CGAffineTransform toVCBeginTransform;

    
    CGAffineTransform fromVCEndTransform;
    CGAffineTransform toVCEndTransform;
    
    CGFloat fromVCBeginAlpha = 1.f;
    CGFloat toVCBeginAlpha = 0.0f;
    
    CGFloat fromVCEndAlpha = 0.0f;
    CGFloat toVCEndAlpha = 1.0;
    
    
    if (self.isOut == NO) {
        
        fromVCBeginTransform = CGAffineTransformIdentity;
        fromVCEndTransform = CGAffineTransformMakeScale(1 - self.transformScale, 1 - self.transformScale);
        
        toVCBeginTransform = CGAffineTransformMakeScale(1 + self.transformScale,1 + self.transformScale);
        toVCEndTransform = CGAffineTransformIdentity;
        
        
        [containView addSubview:toVC.view];

    }
    else if (self.isOut == YES)
    {
        [containView insertSubview:toVC.view belowSubview:fromVC.view];
        
        fromVCBeginTransform = CGAffineTransformIdentity ;
        fromVCEndTransform =  CGAffineTransformMakeScale(1 + self.transformScale,1 + self.transformScale) ;
        
        toVCBeginTransform = CGAffineTransformMakeScale(1 - self.transformScale, 1 - self.transformScale);
        toVCEndTransform = CGAffineTransformIdentity;
    }
    
    
    
    toVC.view.transform = toVCBeginTransform;
    fromVC.view.transform = fromVCBeginTransform;
    
    toVC.view.alpha = toVCBeginAlpha;
    fromVC.view.alpha = fromVCBeginAlpha;
    
    
    [UIView animateWithDuration:duration
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toVC.view.alpha = toVCEndAlpha;
                         fromVC.view.alpha = fromVCEndAlpha;
                         
                         toVC.view.transform = toVCEndTransform;
                         fromVC.view.transform = fromVCEndTransform;
                     }
                     completion:^(BOOL finished) {
                         
                         toVC.view.transform = CGAffineTransformIdentity;
                         fromVC.view.transform = CGAffineTransformIdentity;
                         
                         fromVC.view.alpha  = 1.0f;
                         toVC.view.alpha = 1.0f;
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

                     }];
    
    
}
@end
