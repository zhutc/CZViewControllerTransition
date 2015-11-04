//
//  CZBaseAnimator.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/3.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CZAnimatorCreate.h"

@interface CZBaseAnimator : NSObject<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>
@property(nonatomic , assign , readwrite) CGFloat duration;
@property(nonatomic , assign ,readwrite) CZBaseAnimatorTransitionType animatorType;

@end



