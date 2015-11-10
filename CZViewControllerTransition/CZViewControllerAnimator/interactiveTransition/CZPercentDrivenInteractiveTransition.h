//
//  CZPercentDrivenInteractiveTransition.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/6.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZAnimatorCreate.h"
@interface CZPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

//过度类型
@property(nonatomic , assign) CZBaseAnimatorTransitionType transitionType;
//是否启用手滑返回
@property(nonatomic , assign, getter=isInteractive) BOOL interactive;


-(instancetype)initWithTransitionType:(CZBaseAnimatorTransitionType)type
                       viewController:(UIViewController*)viewController;

+(instancetype)transitionWithTransitionType:(CZBaseAnimatorTransitionType)type
                                                       viewController:(UIViewController*)viewController;




#pragma mark - 子类重载手势更新交互进度
-(CGFloat)progressWithPanGesture:(UIPanGestureRecognizer*)pan;


@end
