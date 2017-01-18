//
//  UIColor+Helper.h
//  STCommon
//
//  Created by wanghaohao on 14/11/26.
//  Copyright (c) 2014年 wanghaohao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR_BG_NAVIGATIONBAR      []

@interface UIColor (Helper)

/**
 * 从十六进制数值获取颜色
 **/
+ (UIColor *)colorWithHexString:(NSString *)hexString;

//- (UIColor *)colorWithHexString:(NSString *)hexString;

@end
