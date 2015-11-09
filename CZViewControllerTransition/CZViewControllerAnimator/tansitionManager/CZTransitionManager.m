//
//  CZTransitionManager.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/6.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZTransitionManager.h"
@interface CZTransitionManager ()
@property(nonatomic , strong , readonly , nonnull) id<UIViewControllerAnimatedTransitioning> transitionAnimator;
@property(nonatomic , strong , readonly , nonnull) UIPercentDrivenInteractiveTransition* transitionInteractive;
@property(nonatomic , weak , readonly ) UIViewController* viewController;
@property(nonatomic , strong , nonnull) UIPanGestureRecognizer* panGestureRecognizer;

@end

@implementation CZTransitionManager

- (void)dealloc
{
    [_viewController.view removeGestureRecognizer:self.panGestureRecognizer];
}

//获取动画管理器
-(instancetype)initWithAnimator:(id<UIViewControllerAnimatedTransitioning>)aimator
         interacetiveTransition:(UIPercentDrivenInteractiveTransition*)interaceTransition
                 viewController:(UIViewController*)viewController
{
    self = [super init];
    if (self) {
        _transitionAnimator = aimator;
        _transitionInteractive = interaceTransition;
        _viewController = viewController;
        
        [self addPanGestureRecognizer:self.panGestureRecognizer
                    forViewController:_viewController];
    }
    return self;
}

+(instancetype)transitionManagerWithAnimator:(id<UIViewControllerAnimatedTransitioning>)aimator
                      interacetiveTransition:(UIPercentDrivenInteractiveTransition*)interaceTransition
                              viewController:(UIViewController*)viewController
{
    return [[[self class] alloc] initWithAnimator:aimator
                           interacetiveTransition:interaceTransition
                                   viewController:viewController];
}


+(instancetype)transitionManagerWithAnimator:(id<UIViewControllerAnimatedTransitioning>)aimator
                              viewController:(UIViewController*)viewController
{
    return [[self class] transitionManagerWithAnimator:aimator
                                interacetiveTransition:nil
                                        viewController:viewController];
}



#pragma mark - 针对viewController添加手势

-(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    }
    return _panGestureRecognizer;
}

-(void)addPanGestureRecognizer:(UIPanGestureRecognizer*)pan forViewController:(UIViewController*)viewController
{
    if (![viewController.view.gestureRecognizers containsObject:pan]) {
        [viewController.view addGestureRecognizer:pan];
    }
}



#pragma mark - handlePanGestureRecognizer
-(void)handlePanGestureRecognizer:(UIPanGestureRecognizer*)pan
{
    CGFloat progress = 0.f;
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _transitionInteractive = [[UIPercentDrivenInteractiveTransition alloc] init];
            progress = 0.f;
            [_viewController.navigationController performSelector:@selector(CZAnimator_popViewControllerAnimated:) withObject:@(YES)];
            NSLog(@"pop");
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint trasslate = [pan translationInView:pan.view];
            progress = trasslate.x / pan.view.bounds.size.width;
            progress = MAX(0, MIN(0.99, progress));
            NSLog(@"pro = %lf",progress);
            [self.transitionInteractive updateInteractiveTransition:progress];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            if (self.transitionInteractive.percentComplete >= 0.5) {
                [self.transitionInteractive finishInteractiveTransition];
            }
            else
            {
                [self.transitionInteractive cancelInteractiveTransition];
            }
            _transitionInteractive = nil;

        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        {
            [self.transitionInteractive cancelInteractiveTransition];
            _transitionInteractive = nil;

        }
            break;
            
        case UIGestureRecognizerStateFailed:
        {
            [self.transitionInteractive cancelInteractiveTransition];
            _transitionInteractive = nil;

        }
            break;
            
        default:
            break;
    }
}



#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    return self.transitionAnimator;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController

                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return self.transitionInteractive;
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
