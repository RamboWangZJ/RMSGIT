//
//  CreateUserModel.h
//  jjrms
//
//  Created by user on 2016/12/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateUserModel : NSObject
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *family_name;
@property(nonatomic,strong)NSString *last_name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *sms_code;

@end
