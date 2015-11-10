//
//  CZPercentDrivenInteractiveTransition.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/6.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZPercentDrivenInteractiveTransition.h"

@interface CZPercentDrivenInteractiveTransition ()

@property(nonatomic , strong , nonnull) UIPanGestureRecognizer* panGestureRecognizer;
@property(nonatomic , weak , readonly ) UIViewController* viewController;

@end

@implementation CZPercentDrivenInteractiveTransition

- (void)dealloc
{
    //移除手势
    [_viewController.view removeGestureRecognizer:self.panGestureRecognizer];
}


-(instancetype)initWithTransitionType:(CZBaseAnimatorTransitionType)type
                       viewController:(UIViewController*)viewController
{
    self = [super init];
    if (self) {
        _viewController = viewController;
        _transitionType = type;
        //添加手势
        [self addPanGestureRecognizer:self.panGestureRecognizer
                    forViewController:_viewController];
        
    }
    return self;
}

+(instancetype)transitionWithTransitionType:(CZBaseAnimatorTransitionType)type
                                                       viewController:(UIViewController*)viewController
{
    return [[[self class] alloc] initWithTransitionType:type
                                         viewController:viewController];
}


#pragma mark - 添加手势
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




#pragma mark -  处理手势
#pragma mark - handlePanGestureRecognizer
-(void)handlePanGestureRecognizer:(UIPanGestureRecognizer*)pan
{
    CGFloat progress = 0.f;
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interactive = YES;
            
            if (self.transitionType & CZBaseAnimatorTransitionTypePop) {
//                [_viewController.navigationController performSelectorOnMainThread:NSSelectorFromString(@"CZAnimator_popViewControllerAnimated:")
//                                                                       withObject:@(YES)
//                                                                    waitUntilDone:YES];
                [_viewController.navigationController popViewControllerAnimated:YES];
            }else if (self.transitionType & CZBaseAnimatorTransitionTypeDismiss)
            {
                [_viewController performSelectorOnMainThread:@selector(dismissAnimated:)
                                                  withObject:@(YES)
                                               waitUntilDone:YES];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            progress = [self progressWithPanGesture:pan];
            [self updateInteractiveTransition:progress];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            if (self.percentComplete >= 0.5) {
                [self finishInteractiveTransition];
            }
            else
            {
                [self cancelInteractiveTransition];
            }
            self.interactive = NO;
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            [self cancelInteractiveTransition];
            self.interactive = NO;
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)progressWithPanGesture:(UIPanGestureRecognizer*)pan
{
    /*
     * 交给子类来实现
     */
    
    return 0.f;
}


-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}


@end
