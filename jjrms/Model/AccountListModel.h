//
//  AccountListModel.h
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountListModel : NSObject
@property(nonatomic,retain)NSString *amount_type;
@property(nonatomic,retain)NSString *meta_val;
@property(nonatomic,retain)NSString *amount;
@property(nonatomic,retain)NSString *create_time;
@property(nonatomic,retain)NSString *currency;

@end
