//
//  BaseService.h
//  jjrms
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"
#import "FirstViewController.h"

@interface BaseService : NSObject

+ (instancetype)shareBase;
- (void)initRootViewControllerWithWindow:(UIWindow *)window;
- (void)showTabBarController:(UIWindow *)window;
-(void)showLogin:(UIWindow *)window;

@end
