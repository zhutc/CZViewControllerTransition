//
//  CZBaseAnimator.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/3.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZBaseAnimator.h"
#define CZBaseAnimatorDuration (0.35f)
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




static char* UIViewController_CZAnimator_PushKey = "UIViewController_CZAnimator_PushKey";
static char* UIViewController_CZAnimator_PopKey = "UIViewController_CZAnimator_PopKey";

#define CZ_Version [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation UIViewController (CZAnimator)
//2015.11.4 摒弃这些方法

//尝试跨类hock
/*
+(void)load
{
    SEL navPop = @selector(popViewControllerAnimated:);
    SEL minePop = @selector(CZAnimator_popViewControllerAnimated:);
    Method navPopMd = class_getInstanceMethod([UINavigationController class], navPop);
    Method minePopMd = class_getInstanceMethod([UIViewController class], minePop);
    
    method_exchangeImplementations(navPopMd, minePopMd);
}
 */

-(id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)pushAnimator
{
    return (id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>) (objc_getAssociatedObject(self, UIViewController_CZAnimator_PushKey));
}
- (void)setPushAnimator:(id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)animator
{
    objc_setAssociatedObject(self, UIViewController_CZAnimator_PushKey, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


-(id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)popAnimator
{
    return (id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>) (objc_getAssociatedObject(self, UIViewController_CZAnimator_PopKey));
}
- (void)setPopAnimator:(id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)animator
{
    objc_setAssociatedObject(self, UIViewController_CZAnimator_PopKey, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
//2015.11.4 摒弃这些方法

/*
-(void)CZAnimator_showViewController:(UIViewController *)vc sender:(id)sender
{
    CGFloat version = CZ_Version;
    if (version >= 8.0) {
        if (self.navigationController) {
            self.navigationController.delegate = vc.pushViewControllerTransitionAnimator;
        }
        [self showViewController:vc sender:sender];
        
    }else
    {
        if (self.navigationController) {
            self.navigationController.delegate = self.pushAnimator;
            [self.navigationController pushViewController:vc animated:YES];
            return;
            
        }
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}
 
 */

/**
 ** swillzing navigationController的POP，所以这里的self = vc.navigationController
 **/

//2015.11.4 摒弃这些方法

/*
-(UIViewController*)CZAnimator_popViewControllerAnimated:(BOOL)animate
{
    UINavigationController* mianSelf = (UINavigationController*)self;
    if ([mianSelf isKindOfClass:[UINavigationController class]]) {
        if (mianSelf.topViewController.popViewControllerTransitionAnimator) {
            mianSelf.delegate = mianSelf.topViewController.popViewControllerTransitionAnimator;
        }
        
        return [mianSelf CZAnimator_popViewControllerAnimated:animate];
    }else if([self isMemberOfClass:[UIViewController class]])
    {
        if (self.navigationController) {
            self.navigationController.delegate = self.popViewControllerTransitionAnimator;
            return [self.navigationController CZAnimator_popViewControllerAnimated:animate];
        }
    }
    return nil;
}
*/



@end





@implementation UINavigationController (CZAnimator)

+(void)load
{
    
    SEL selectors[] = {
        @selector(popViewControllerAnimated:),
        @selector(pushViewController:animated:)
    };
    
    for (int i = 0 ; i < sizeof(selectors)/sizeof(SEL); i++) {
        Class hockClass = [UINavigationController class];
        
        SEL orginalSEL = selectors[i];
        SEL newSEL =  NSSelectorFromString([@"CZAnimator_" stringByAppendingString:NSStringFromSelector(orginalSEL)]);
       
        Method orginalMd = class_getInstanceMethod(hockClass, orginalSEL);
        Method newMd = class_getInstanceMethod(hockClass, newSEL);
        
        BOOL isNewMdIsImp = class_addMethod(hockClass,
                                            orginalSEL,
                                            class_getMethodImplementation(hockClass, newSEL),
                                            method_getTypeEncoding(newMd));
        if (isNewMdIsImp) {
            
            class_replaceMethod(hockClass,
                                newSEL,
                                class_getMethodImplementation(hockClass, orginalSEL),
                                method_getTypeEncoding(orginalMd));
        }
        else
        {
            method_exchangeImplementations(orginalMd, newMd);
        }
        
       
    }
    
}

-(UIViewController *)CZAnimator_popViewControllerAnimated:(BOOL)animated
{
    id<UINavigationControllerDelegate> animator = self.topViewController.popViewControllerTransitionAnimator;
    if (animator) {
        self.delegate = animator;
    }
    return  [self CZAnimator_popViewControllerAnimated:animated];
}

-(void)CZAnimator_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    id<UINavigationControllerDelegate> animator = viewController.pushViewControllerTransitionAnimator;
    if (animator) {
        self.delegate = animator;
    }
    [self CZAnimator_pushViewController:viewController animated:animated];

}


@end



