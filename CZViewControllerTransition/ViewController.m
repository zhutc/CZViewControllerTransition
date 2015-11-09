//
//  ViewController.m
//  CZViewControllerTransition
//
//  Created by wmichina_mac on 15/11/3.
//  Copyright © 2015年 CZ. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+CZAnimator.h"
#import "CZTransitionManager.h"
@interface ViewController ()
{
    CZTransitionManager* popManager;
    CZTransitionManager* pushManager;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSUInteger tmp = arc4random()%255;
    
    self.view.backgroundColor = [UIColor colorWithHue:tmp/255. saturation:tmp/255. brightness:tmp/255. alpha:1.f];
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"title = %@ %s %s",self.title,class_getName(self.class) , _cmd);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"title = %@ %s %s",self.title,class_getName(self.class) , _cmd);
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"title = %@ %s %s",self.title,class_getName(self.class) , _cmd);
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"title = %@ %s %s",self.title,class_getName(self.class) , _cmd);
}





- (id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)pushViewControllerTransitionAnimator
{
    
    if ([self.animatorClassName isEqualToString:@"CZCurlAnimator"]) {
        self.pushAnimator = CZAnimatorCreate_CZCurlAnimator(CZBaseAnimatorTransitionTypePush);
    }else if ([self.animatorClassName isEqualToString:@"CZBackScaleAnimator"])
    {
        self.pushAnimator = CZAnimatorCreate_CZBackScaleAnimator(CZBaseAnimatorTransitionTypePush);
    }
    else if ([self.animatorClassName isEqualToString:@"CZZoomAnimator"])
    {
        self.pushAnimator = CZAnimatorCreate_CZZoomAnimator(CZBaseAnimatorTransitionTypePush);
    }else if ([self.animatorClassName isEqualToString:@"CZMaskAnimator"])
    {
        self.pushAnimator = CZAnimatorCreate_CZMaskAnimator(CZBaseAnimatorTransitionTypePush);
    }

    
//    return self.pushAnimator;
    /* */
    pushManager =  [CZTransitionManager transitionManagerWithAnimator:self.pushAnimator
                                               viewController:self];
    return pushManager;
}


-(id<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>)popViewControllerTransitionAnimator
{
 
    if ([self.animatorClassName isEqualToString:@"CZCurlAnimator"]) {
        self.popAnimator = CZAnimatorCreate_CZCurlAnimator(CZBaseAnimatorTransitionTypePop);
        
    }else if ([self.animatorClassName isEqualToString:@"CZBackScaleAnimator"])
    {
        self.popAnimator = CZAnimatorCreate_CZBackScaleAnimator(CZBaseAnimatorTransitionTypePop);
    }
    else if ([self.animatorClassName isEqualToString:@"CZZoomAnimator"])
    {
        self.popAnimator = CZAnimatorCreate_CZZoomAnimator(CZBaseAnimatorTransitionTypePop);
    }else if ([self.animatorClassName isEqualToString:@"CZMaskAnimator"])
    {
        self.popAnimator = CZAnimatorCreate_CZMaskAnimator(CZBaseAnimatorTransitionTypePop);
    }
    
//    return self.popAnimator;
    popManager =  [CZTransitionManager transitionManagerWithAnimator:self.popAnimator
                                               viewController:self];
    return popManager;
}

-(IBAction)push:(id)sender
{
    static int title = 0;
    ViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self.class)];
    vc.title = @(++title).description;
    vc.animatorClassName = self.animatorClassName;
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
