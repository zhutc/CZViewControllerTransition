//
//  ViewController.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/3.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "ViewController.h"
#import "CZBaseAnimator.h"
@interface ViewController ()
@end

@implementation ViewController
//- (instancetype)initWithAnimator:(id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)animator
//{
//    self = [super init];
//    if (self) {
//        self.animator = animator;
//    }
//    return self;
//}
- (void)viewDidLoad {
    
    NSUInteger tmp = arc4random()%255;
    
    self.view.backgroundColor = [UIColor colorWithHue:tmp/255. saturation:tmp/255. brightness:tmp/255. alpha:1.f];
    [super viewDidLoad];
    
}
- (id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)pushViewControllerTransitionAnimator
{
    CZBaseAnimator* animator  =  [CZBaseAnimator new];
    animator.animatorType = CZBaseAnimatorTransitionTypePush;
    self.pushAnimator = animator;
    return self.pushAnimator;
}


-(id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)popViewControllerTransitionAnimator
{
    CZBaseAnimator* animator = [CZBaseAnimator new];
    animator.animatorType = CZBaseAnimatorTransitionTypePop;
    self.popAnimator = animator;
    
    return self.popAnimator;
}

-(IBAction)push:(id)sender
{
    ViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self.class)];

    [self CZAnimator_showViewController:vc sender:nil];
}


-(IBAction)pop:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
