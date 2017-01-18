//
//  CheckCodeViewController.h
//  jjrms
//
//  Created by user on 2016/12/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "EmailViewController.h"
@interface CheckCodeViewController : BaseViewController<UITextFieldDelegate>
@property(nonatomic, strong)NSString *telStr;
@property(nonatomic,strong)NSString  *contrycode;

@end
