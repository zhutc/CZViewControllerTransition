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
#import "CZBaseAnimatedTransitioning.h"
@interface CZBaseAnimator : NSObject<UINavigationControllerDelegate,CZBaseAnimatedTransitioning>
@property(nonatomic , assign , readwrite) CGFloat duration;
@property(assign,nonatomic) BOOL isOut; //是否返回 push and dismiss  == YES


//subclass must override this method
// 
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
      fromViewController:(UIViewController*)fromVC
        toViewController:(UIViewController*)toVC
             containerView:(UIView*)containView
                duration:(NSTimeInterval)duration;

@end



