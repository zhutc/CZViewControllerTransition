//
//  CZBaseAnimatedTransitioning.h
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/9.
//  Copyright © 2015年 CZ. All rights reserved.
//

#ifndef CZBaseAnimatedTransitioning_h
#define CZBaseAnimatedTransitioning_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif /* CZBaseAnimatedTransitioning_h */

@protocol CZBaseAnimatedTransitioning <UIViewControllerAnimatedTransitioning>

@property(assign,nonatomic) BOOL isOut; //是否返回 push and dismiss  == YES

@end