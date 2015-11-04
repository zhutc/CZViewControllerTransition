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
    CZBaseAnimatorTransitionTypeNone,
    CZBaseAnimatorTransitionTypePush,
    CZBaseAnimatorTransitionTypePop,
    CZBaseAnimatorTransitionTypePresent,
    CZBaseAnimatorTransitionTypeDismiss
};


//快速获取基本的动画效果器
/**************
 样例C函数，这样写可以隐蔽具体Animator的头文件
 
 extern id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAnimatorCreate_CZBaseAnimator(CZBaseAnimatorTransitionType type);
 
 
 注意：CZAnimatorCreate_CZBaseAnimator需要在对应的.m中实现。
 
 *********************/


/***********************  快速获取动画器宏定义  *****************************/

#define CZAppend(ClassName) CZAnimatorCreate_##ClassName //动态生成函数名

#define CZAnimatorCreateInterface(ClassName)  \
                                            extern \
                        id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning>  \
                                    CZAppend(ClassName) (CZBaseAnimatorTransitionType type) \





/**
 **  定义具体的动画器获取C函数
 **/
#ifdef CZAnimatorCreateInterface//(ClassName)
//翻页动画
CZAnimatorCreateInterface(CZCurlAnimator);
CZAnimatorCreateInterface(CZBackScaleAnimator);

/*
 //翻页动画
 extern id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> CZAnimatorCreate_CZCurlAnimator(CZBaseAnimatorTransitionType type);
 */


#endif


