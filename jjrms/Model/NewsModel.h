//
//  NewsModel.h
//  jjrms
//
//  Created by user on 16/10/24.
//  Copyright © 2016年 supercity. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NewsModel : NSObject


@property(nonatomic,retain)NSString *content;
@property(nonatomic,retain)NSString *image;
@property(nonatomic,retain)NSString *create_time;
@property(nonatomic,retain)NSString *notice_title;
@property(nonatomic,retain)NSString *notice_sn;
@property(nonatomic,retain)NSString *summary;

@property (nonatomic, assign)CGFloat cellHeight;

@end
