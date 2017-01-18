//
//  main.m
//  jjrms
//
//  Created by user on 16/8/29.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//参数说明：
//
//argc和argv是ISO C标准的main函数的参数，直接传递给UIApplicationMain进行相关处理。
//
//principalClassName是应用程序类的名字，该类必须继承自UIApplication类。
//
//delegateClassName是应用程序类的代理类，该函数跟据delegateClassName创建一个delegate对象，并将UIApplication对象中的delegate属性设置为delegate对象
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
