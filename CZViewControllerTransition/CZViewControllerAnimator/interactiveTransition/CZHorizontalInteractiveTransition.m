//
//  CZHorizontalInteractiveTransition.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/9.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZHorizontalInteractiveTransition.h"

id CZAppendInteracetive(CZHorizontalInteractiveTransition) (UIViewController* vc , CZBaseAnimatorTransitionType type)
{
    CZHorizontalInteractiveTransition* interacetive = [CZHorizontalInteractiveTransition transitionWithTransitionType:type
                                                                                                       viewController:vc];
    return interacetive;
}


@implementation CZHorizontalInteractiveTransition

- (CGFloat)progressWithPanGesture:(UIPanGestureRecognizer *)pan
{
    CGFloat progress = 0.f;
    CGFloat width = pan.view.bounds.size.width;
    CGPoint trasslate = [pan translationInView:pan.view];
    progress = trasslate.x / width;
    progress = MAX(0, MIN(0.99, progress));
    NSLog(@"pro = %lf wi = %lf",progress,width);
    return progress;
}

@end
