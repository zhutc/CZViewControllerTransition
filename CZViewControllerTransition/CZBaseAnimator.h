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
typedef NS_ENUM(NSUInteger,CZBaseAnimatorTransitionType){
    CZBaseAnimatorTransitionTypeNone,
    CZBaseAnimatorTransitionTypePush,
    CZBaseAnimatorTransitionTypePop,
    CZBaseAnimatorTransitionTypePresent,
    CZBaseAnimatorTransitionTypeDismiss
};
@interface CZBaseAnimator : NSObject<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>
@property(nonatomic , assign , readwrite) CGFloat duration;
@property(nonatomic , assign ,readwrite) CZBaseAnimatorTransitionType animatorType;
@end




@protocol UIViewController_CZAnimator_Protocol <NSObject>
//入栈动画
-(id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning>) pushViewControllerTransitionAnimator;

//出栈动画
-(id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning>) popViewControllerTransitionAnimator;

@end

//扩展动画属性
@interface UIViewController (CZAnimator)<UIViewController_CZAnimator_Protocol>

@property(nonatomic , strong) id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> pushAnimator;
@property(nonatomic , strong) id<UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning> popAnimator;


//2015.11.4 摒弃这些方法,原因，开发都习惯使用self.navigationController push and pop 。。。。
/*
-(void)CZAnimator_showViewController:(UIViewController *)vc sender:(id)sender;
 */
 /*
  *hock UINavigationController 's popViewControllerAnimated: 
  *
  */
/*
-(UIViewController*)CZAnimator_popViewControllerAnimated:(BOOL)animate;
*/

@end


//2015.11.4 添加入栈出栈方法，替换掉ViewController分类中的入栈出栈方法
@interface UINavigationController (CZAnimator)
//hock POP and push
-(void)CZAnimator_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

-(UIViewController *)CZAnimator_popViewControllerAnimated:(BOOL)animated;

@end



