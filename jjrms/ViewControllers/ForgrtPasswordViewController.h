//
//  ForgrtPasswordViewController.h
//  jjrms
//
//  Created by user on 2016/12/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "ContryCodeModel.h"
#import "ForgetTelCheckViewController.h"
#import "ForgetSMSViewController.h"
@interface ForgrtPasswordViewController : BaseViewController<UITextFieldDelegate>
@property(nonatomic,retain)UIButton *telZoneButton;
@property(nonatomic,retain)ContryCodeModel *contryModel;
@end
