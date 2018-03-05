//
//  UIWindow+XWExt.m
//  YCSteel
//
//  Created by serein on 2017/12/7.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "UIWindow+XWExt.h"

@implementation UIWindow (XWExt)

-(void)transitionRootViewController:(UIViewController *)rootViewController{

    [UIView transitionWithView:self
                      duration:0.8f
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        self.rootViewController = rootViewController;
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:nil];
}

@end
