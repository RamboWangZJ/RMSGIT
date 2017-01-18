//
//  ForgetSMSViewController.h
//  jjrms
//
//  Created by user on 2016/12/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "ForgetSetPasswordViewController.h"
@interface ForgetSMSViewController : BaseViewController<UITextFieldDelegate>
@property(nonatomic, strong)NSString *telStr;
@property(nonatomic,strong)NSString  *contrycode;
@end
