//
//  NewsDetailViewController.h
//  jjrms
//
//  Created by user on 16/10/24.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsModel.h"
#import "SVProgressHUD.h"

@interface NewsDetailViewController : BaseViewController<UIWebViewDelegate>
@property(nonatomic, retain)NewsModel *model;
@end
