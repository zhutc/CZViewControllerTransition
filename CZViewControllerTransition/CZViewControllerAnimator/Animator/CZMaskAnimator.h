//
//  CZMaskAnimator.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/5.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "CZBaseAnimator.h"

@interface CZMaskAnimator : CZBaseAnimator
//mask动画开启点,默认为container的中心
@property(nonatomic , assign) CGPoint maskPoint;
@end
