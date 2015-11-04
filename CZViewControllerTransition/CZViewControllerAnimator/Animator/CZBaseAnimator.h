//
//  CZBaseAnimator.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/3.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CZAnimatorCreate.h"

@interface CZBaseAnimator : NSObject<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>
@property(nonatomic , assign , readwrite) CGFloat duration;
@property(nonatomic , assign , readwrite) CZBaseAnimatorTransitionType animatorType;

//subclass override this method
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
      fromViewController:(UIViewController*)fromVC
        toViewController:(UIViewController*)toVC
             containView:(UIView*)containView
                duration:(NSTimeInterval)duration;

@end



