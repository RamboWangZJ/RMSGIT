//
//  Commen.h
//  jjrms
//
//  Created by user on 16/9/1.
//  Copyright © 2016年 supercity. All rights reserved.
//

#ifndef Commen_h
#define Commen_h



//版本密钥
static NSString *SECRETKEY=@"47e2dc3cc5729f91ade5f337c1d67057";

//API
//开发环境接口地址
//static NSString * HOSTAPI=@"http://api.dev.jjrms.jjhw.com/";
//开发环境接h5口地址：
//static NSString * HOSTAPI_H5=@"http://host.dev.jjrms.jjhw.com/";

//正式环境接口地址
static NSString *HOSTAPI=@"https://api.rms.jjhw.com/";
//正式环境接h5口地址：
static NSString *HOSTAPI_H5=@"http://host.rms.jjhw.com/";

#pragma 常用参数
static NSString * GET=@"GET";
static NSString * POST=@"POST";
static NSString * USER_SN=@"USER_SN";//用户id
static NSString * ACCESS_TOKEN=@"ACCESS_TOKEN";//用户TOKEN
static NSString *LANGUAGE = @"LANGUAGE";//本机系统语言
#pragma 字体
static NSString *CUTI = @"Helvetica-Bold";//
#pragma 币种
static NSString *  RENTAL_UNIT = @"RENTAL_UNIT";//
#pragma 强制登录判断
static NSString *FORCIBLY_LOGIN=@"FORCIBLY_LOGIN";
#pragma registrationID
static NSString *REGISTRATIONID=@"REGISTRATIONID";
#pragma 极光推送
static NSString *JPush_appKey = @"8b0f5532c5b7344a7934923a";
static NSString *channel = @"Publish channel";
static BOOL isProduction = YES;//极光环境

#pragma 用户注册//静态变量的值程序中不能修改？？？！！！！
#pragma 倒计时
static NSString *CREATSECOND = @"CREATSECOND";
static NSString *FORGETSECOND = @"FORGETSECOND";


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//适配比例
#define WSCALE (SCREEN_WIDTH/640)
#define HSCALE (SCREEN_HEIGHT/1136)
#define LINEW  2





#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)


#endif /* Commen_h */
