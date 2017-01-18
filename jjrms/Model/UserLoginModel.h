//
//  UserLoginModel.h
//  jjrms
//
//  Created by user on 16/10/11.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLoginModel : NSObject
@property(nonatomic,retain)NSString *avatar;
@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString *family_name;
@property(nonatomic,retain)NSString *last_name;
@property(nonatomic,retain)NSString *phone;
@property(nonatomic,assign)NSInteger sex;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,retain)NSString *user_sn;
@end
