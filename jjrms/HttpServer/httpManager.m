//
//  httpManager.m
//  jjrms
//
//  Created by user on 16/9/1.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "httpManager.h"
#import "LoginViewController.h"
@implementation httpManager

static httpManager *sharedObject;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(sharedObject == nil){
            sharedObject = [[httpManager alloc] init];
        }
    });
    return sharedObject;
}

//设置请求header（签名和时间戳）
- (void)httpWithURL:(NSString *)url method:(NSString *)method param:(NSDictionary *)param timeString:(NSString *)timeString sign:(NSString *)sign  success:(JJRMSSuccessBlock)success failure:(JJRMSFailureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:timeString forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setValue:@"1.0.1" forHTTPHeaderField:@"app_version"];
    [manager.requestSerializer setValue:@"1.0.1" forHTTPHeaderField:@"api_version"];
    [manager.requestSerializer setValue:@"130" forHTTPHeaderField:@"platform_type"];

    NSString *lang=[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE];
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hans-CN"]) {
        [manager.requestSerializer setValue:@"zh" forHTTPHeaderField:@"lang"];
    }else{
        [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"lang"];
    }
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] forHTTPHeaderField:@"access_token"];
    
    if ([method isEqualToString:@"GET"]) {
        [manager GET:[HOSTAPI stringByAppendingString:url] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //token错误
            NSInteger code=[[responseObject objectForKey:@"code"] integerValue];
            if (code==1001 || code==1511) {//token错误
                [self toLogin];
            }
            
            
            NSLog(@"\n\n\nurl = %@;\nparam = %@;\nsign = %@\ndata = %@\n\n\n;", [HOSTAPI stringByAppendingString:url],param, sign, responseObject);
            success(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"**********\n%@", error);
            failure(error);
        }];
    }else{
        [manager POST:[HOSTAPI stringByAppendingString:url] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //token错误
            NSInteger code=[[responseObject objectForKey:@"code"] integerValue];
            if (code==1001 || code==1511) {//token错误
                [self toLogin];
            }
            
            NSLog(@"\n\n\nurl = %@;\nparam = %@;\nsign = %@\ndata = %@\n\n\n;", [HOSTAPI stringByAppendingString:url],param, sign, responseObject);
            success(responseObject);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"**********\n%@", error);
            failure(error);
        }];
    }
}

#pragma 重新登录
-(void)toLogin{
    NSLog(@"toLogin");
    //防止并发提示
    if ([[NSUserDefaults standardUserDefaults]boolForKey:FORCIBLY_LOGIN]) {
        
            _alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"tokenerror_alert",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
            [_alert show];
        
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:FORCIBLY_LOGIN];

    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == _alert) {
        if (buttonIndex==0) {
            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:USER_SN];
            
            
            LoginViewController *login=[[LoginViewController alloc]init];
            UINavigationController *NaVC1=[[UINavigationController alloc]initWithRootViewController:login];
            UIWindow *window = [[UIApplication sharedApplication].delegate window];
            window.rootViewController=NaVC1;
            [window makeKeyAndVisible];
        }
    }

}

//图片上传


- (void)CommentPicWithDic:(NSDictionary *)dic//上传图片时可能有的附加条件如userid;
               withImages:(NSDictionary *)imageDic//存图片的字典
                  success:(void (^)(NSDictionary *))success
                    faile:(void (^)(NSError *))faile
{
    NSString *urlStr = [HOSTAPI stringByAppendingString:@"util/upload"];
    AFHTTPSessionManager *Manager = [AFHTTPSessionManager manager];
    
    //Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html",@"",nil];
    NSSet *set = [[NSSet alloc] initWithObjects:@"text/html",@"application/json", nil];
    Manager.responseSerializer.acceptableContentTypes = set;
    
    [Manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (id key in imageDic) {
            UIImage *image = [imageDic objectForKey:key];
            //FileData:图片压缩后的data类型
            //name: 后台规定的key
            //fileName:自己给文件起名
            //mimeType :图片类型
            [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:[NSString stringWithFormat:@"%@",key] fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/png"];
        }
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faile(error);
        
    }];
    
    /*
     [Manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
     for (id key in imageDic) {
     UIImage *image = [imageDic objectForKey:key];
     //FileData:图片压缩后的data类型
     //name: 后台规定的key
     //fileName:自己给文件起名
     //mimeType :图片类型
     [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:[NSString stringWithFormat:@"%@",key] fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/png"];
     }
     }success:^(NSURLSessionDataTask * _Nonnull task, id responseObject){
     
     success(responseObject);
     }failure:^(NSURLSessionDataTask * _Nonnull task, NSError *error){
     
     faile(error);
     }];
     */
}




@end
