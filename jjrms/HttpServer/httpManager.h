//
//  httpManager.h
//  jjrms
//
//  Created by user on 16/9/1.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Commen.h"

typedef void(^JJRMSSuccessBlock)(NSDictionary *responseDic);
typedef void(^JJRMSFailureBlock)(NSError *error);



@interface httpManager : NSObject<UIAlertViewDelegate>
@property(nonatomic, retain)UIAlertView *alert;
+ (instancetype)sharedManager;


- (void)httpWithURL:(NSString *)url method:(NSString *)method param:(NSDictionary *)param timeString:(NSString *)timeString sign:(NSString *)sign  success:(JJRMSSuccessBlock)success failure:(JJRMSFailureBlock)failure;
- (void)CommentPicWithDic:(NSDictionary *)dic withImages:(NSDictionary *)imageDic success:(void (^)(NSDictionary *))success faile:(void (^)(NSError *))faile;

@end
