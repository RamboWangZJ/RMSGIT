//
//  DataProcessing.h
//  jjrms
//
//  Created by user on 16/9/19.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Commen.h"
#import "NSString+MD5.h"
@interface DataProcessing : NSObject
#pragma  全局参数
#pragma 创建用户
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *family_name;
@property(nonatomic,strong)NSString *last_name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *sms_code;

@property(nonatomic,strong)NSString *phone_before;
@property(nonatomic,strong)NSString *sms_code_before;

#pragma 修改密码
@property(nonatomic,strong)NSString *contry_reset;
@property(nonatomic,strong)NSString *phone_reset;

+ (instancetype)sharedManager;
#pragma  生成签名
- (NSString *)dataSignWithParam:(NSDictionary *)param url:(NSString *)url timeString:(NSString *)timeString;
#pragma  生成时间戳
- (NSString *)nowTimestamp;

#pragma 正则判断邮箱格式
-(BOOL)isValidateEmail:(NSString *)email;

@end
