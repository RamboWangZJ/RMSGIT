//
//  LoginViewController.h
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "JPushSetModel.h"
#import "TelCheckViewController.h"
#import "LoginBarView.h"
#import "ContryCodeModel.h"
#import "CreateNameViewController.h"
#import "ForgrtPasswordViewController.h"
@interface LoginViewController : BaseViewController<UITextFieldDelegate>
//@property(nonatomic,retain)UITextField *nameTextField;
@property(nonatomic,retain)UIButton *telZoneButton;
@property(nonatomic,retain)ContryCodeModel *contryModel;

@end
