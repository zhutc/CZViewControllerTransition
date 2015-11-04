//
//  CZBackScaleAnimator.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/4.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZBaseAnimator.h"

@interface CZBackScaleAnimator : CZBaseAnimator
@property(nonatomic , assign) CGFloat behindViewScale;
@property(nonatomic , assign) CGFloat behindViewAlpha;

@end


/*
 * fromVC 做缩小动画 ， toVC做spring frame 动画
 *
 */