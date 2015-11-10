//
//  CZTransitionManager.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/6.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZTransitionManager.h"
@interface CZTransitionManager ()


@end

@implementation CZTransitionManager


//获取动画管理器
-(instancetype)initWithAnimator:(id<CZBaseAnimatedTransitioning>)aimator
         interacetiveTransition:(CZPercentDrivenInteractiveTransition*)interaceTransition
{
    self = [super init];
    if (self) {
        _pushTransitionAnimator = aimator;
        _transitionInteractive = interaceTransition;
    }
    return self;
}

+(instancetype)transitionManagerWithAnimator:(id<CZBaseAnimatedTransitioning>)aimator
                      interacetiveTransition:(CZPercentDrivenInteractiveTransition*)interaceTransition
{
    return [[[self class] alloc] initWithAnimator:aimator
                           interacetiveTransition:interaceTransition];
}






#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    return (operation == UINavigationControllerOperationPop ? self.popTransitionAnimator : self.pushTransitionAnimator);
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController

                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    NSLog(@"out  = %d , in = %d",self.popTransitionAnimator.isOut , self.transitionInteractive.isInteractive);
    if (self.popTransitionAnimator.isOut & self.transitionInteractive.isInteractive) {
        return self.transitionInteractive;
    }
    return nil;
}


#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    return nil;
}
@end
