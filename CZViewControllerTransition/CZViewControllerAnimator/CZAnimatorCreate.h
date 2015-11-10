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


#define CZBaseAnimatorDuration (0.35f)


//过度类型
typedef NS_ENUM(NSUInteger,CZBaseAnimatorTransitionType){
    CZBaseAnimatorTransitionTypeNone        = 1 << 0,
    CZBaseAnimatorTransitionTypePush        = 1 << 1,
    CZBaseAnimatorTransitionTypePop         = 1 << 2,
    CZBaseAnimatorTransitionTypePresent     = 1 << 3,
    CZBaseAnimatorTransitionTypeDismiss     = 1 << 4
};


//快速获取基本的动画效果器
/**************
 样例C函数，这样写可以隐蔽具体Animator的头文件
 
 extern id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAnimatorCreate_CZBaseAnimator(BOOL isOut);
 
 
 注意：CZAnimatorCreate_CZBaseAnimator需要在对应的.m中实现。
 
 *********************/


/***********************  快速获取动画器宏定义  *****************************/

#define CZAppend(ClassName) CZAnimatorCreate_##ClassName //动态生成函数名


#define CZAnimatorCreateInterfaceExtern(ClassName)  \
                extern \
                        id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning>  \
                                    CZAppend(ClassName) (BOOL isOut) \


/**
 **  定义具体的动画器获取C函数
 **/
#ifdef CZAnimatorCreateInterfaceExtern//(ClassName)


/*
 //翻页动画
 extern id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAnimatorCreate_CZCurlAnimator(BOOL isOut);
 */

//翻页动画
CZAnimatorCreateInterfaceExtern(CZCurlAnimator);
//一个做缩放，一个做spring frame
CZAnimatorCreateInterfaceExtern(CZBackScaleAnimator);

//同时做缩放动画 , 同大同小
CZAnimatorCreateInterfaceExtern(CZZoomAnimator);

//mask 动画 设置layer.mask  = shapeLayer
CZAnimatorCreateInterfaceExtern(CZMaskAnimator);

#endif






/****************  快速获取交互  *****************/

#define CZAppendInteracetive(ClassName) CZInteracetiveCreate_##ClassName //动态生成函数名

#define CZInteracetiveInterfaceExtern(ClassName) \
                                        id CZAppendInteracetive(CZHorizontalInteractiveTransition)(UIViewController* vc , CZBaseAnimatorTransitionType type)






#ifdef CZInteracetiveInterfaceExtern
CZInteracetiveInterfaceExtern(CZHorizontalInteractiveTransition);


#endif



