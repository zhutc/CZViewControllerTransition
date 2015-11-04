//
//  CZAnimatorCreate.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/4.
//  Copyright © 2015年 CZ. All rights reserved.
//

#ifndef CZAnimatorCreate_h
#define CZAnimatorCreate_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif /* CZAnimatorCreate_h */

typedef NS_ENUM(NSUInteger,CZBaseAnimatorTransitionType){
    CZBaseAnimatorTransitionTypeNone,
    CZBaseAnimatorTransitionTypePush,
    CZBaseAnimatorTransitionTypePop,
    CZBaseAnimatorTransitionTypePresent,
    CZBaseAnimatorTransitionTypeDismiss
};


//快速获取基本的动画效果器

extern id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAnimatorCreate_CZBaseAnimator(CZBaseAnimatorTransitionType type);