//
//  ViewController.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/3.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+CZAnimator.h"
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

    self.pushAnimator = CZAnimatorCreate_CZCurlAnimator(CZBaseAnimatorTransitionTypePush);
    return self.pushAnimator;
}


-(id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)popViewControllerTransitionAnimator
{
 
    self.popAnimator = CZAnimatorCreate_CZCurlAnimator(CZBaseAnimatorTransitionTypePop);
    
    return self.popAnimator;
}

-(IBAction)push:(id)sender
{
    ViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self.class)];

    [self.navigationController pushViewController:vc animated:YES];
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
