//
//  DataProcessing.m
//  jjrms
//
//  Created by user on 16/9/19.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "DataProcessing.h"

@implementation DataProcessing

static DataProcessing *sharedObject; //静态区内

//类方法
//1.以+开头的方法是类方法。Objc中的类方法类似Java中的static静态方法，它是属于类本身的方法，不属于类的某一个实例对象，所以不需要实例化类，用类名即可使用，是将消息发送给类：
//2.类方法不能使用任何实例变量：

//误区
//1.事实上，在加载时机和占用内存上，类方法和实例方法是一样的，在类第一次被使用时加载方法，所以在效率上没有什么区别。
//2.事实上，所有的方法都不可能分配在堆栈区，方法作为二进制代码是存储在内存的程序代码区，这个内存区域是不可写的。


+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(sharedObject == nil){
            sharedObject = [[DataProcessing alloc] init];
        }
    });
    return sharedObject;
}
/*
我们看到，该方法的作用就是执行且在整个程序的声明周期中，仅执行一次某一个block对象。简直就是为单例而生的嘛。而且，有些我们需要在程序开头初始化的动作，如果为了保证其，仅执行一次，也可以放到这个dispatch_once来执行。
然后我们看到它需要一个断言来确定这个代码块是否执行，这个断言的指针要保存起来，相对于第一种方法而言，还需要多保存一个指针。
方法简介中就说的很清楚了：对于在应用中创建一个初始化一个全局的数据对象（单例模式），这个函数很有用。
如果同时在多线程中调用它，这个函数将等待同步等待，直至该block调用结束。
这个断言的指针必须要全局化的保存，或者放在静态区内。使用存放在自动分配区域或者动态区域的断言，dispatch_once执行的结果是不可预知的。
*/

//生成签名
- (NSString *)dataSignWithParam:(NSDictionary *)param url:(NSString *)url timeString:(NSString *)timeString{
    
    NSArray *keys = [param allKeys];
    
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        //这里的代码可以参照上面compare:默认的排序方法，也可以把自定义的方法写在这里，给对象排序
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSString *paramStr=@"";
    
    for (int i=0; i<sortedArray.count; i++) {
        paramStr=[NSString stringWithFormat:@"%@|%@=%@",paramStr,sortedArray[i],[param objectForKey:sortedArray[i]]];
    }
    
    NSString *sign=[NSString stringWithFormat:@"%@|%@|%@%@",url,SECRETKEY,timeString,paramStr];
    sign=[sign MD5Digest];
    
    return sign;
}

//当前时间戳
- (NSString *)nowTimestamp {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval=[date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%0.f", timeInterval];//转为字符型
}



//利用正则表达式验证邮箱格式
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


@end
