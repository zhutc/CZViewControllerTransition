//
//  CZMaskAnimator.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/5.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZMaskAnimator.h"



id <UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAppend(CZMaskAnimator)(BOOL isOut)
{
    CZMaskAnimator* animator = [CZMaskAnimator new];
    animator.isOut = isOut;
    return animator;
}


#define CZMaskAnimatorPushKey @"push"
#define CZMaskAnimatorPopKey @"pop"


@implementation CZMaskAnimator
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
      fromViewController:(UIViewController *)fromVC
        toViewController:(UIViewController *)toVC
           containerView:(UIView *)containView
                duration:(NSTimeInterval)duration
{
    //设置中心
    if (CGPointEqualToPoint(self.maskPoint,CGPointZero)) {
        self.maskPoint = containView.center;
    }
    
    CGRect fromVCFrame = fromVC.view.frame;
    toVC.view.frame = fromVCFrame;
    
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    maskLayer.frame = fromVCFrame;
    
    CGPathRef path = [UIBezierPath bezierPathWithArcCenter:self.maskPoint
                                                    radius:MAX(CGRectGetWidth(containView.bounds), CGRectGetHeight(containView.bounds))
                                                startAngle:0
                                                  endAngle:M_PI*2
                                                 clockwise:YES].CGPath;
    
    maskLayer.path = path;
    
    
    CABasicAnimation* baseicAnimate = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseicAnimate.duration = duration;
    baseicAnimate.removedOnCompletion = NO;
    baseicAnimate.autoreverses = NO;
    baseicAnimate.repeatCount = 1;
    baseicAnimate.fillMode = kCAFillModeForwards;
    
    if (self.isOut == YES) {

        [containView addSubview:toVC.view];
        toVC.view.layer.mask = maskLayer;
        
        baseicAnimate.toValue = @(1.f);
        baseicAnimate.fromValue = @(0.f);
        baseicAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            toVC.view.layer.mask = nil;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        [maskLayer addAnimation:baseicAnimate forKey:CZMaskAnimatorPushKey];
        [CATransaction commit];
        
    }
    else if (self.isOut == NO)
    {
        
        [containView insertSubview:toVC.view belowSubview:fromVC.view];
        fromVC.view.layer.mask = maskLayer;
        
        baseicAnimate.toValue = @(0.f);
        baseicAnimate.fromValue = @(1.f);
        baseicAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            fromVC.view.layer.mask = nil;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        [maskLayer addAnimation:baseicAnimate forKey:CZMaskAnimatorPopKey];
        [CATransaction commit];
    }
    
}
@end
