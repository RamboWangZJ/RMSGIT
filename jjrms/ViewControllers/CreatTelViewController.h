//
//  CreatTelViewController.h
//  jjrms
//
//  Created by user on 2016/12/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "CreateTelCheckViewController.h"
#import "ContryCodeModel.h"
#import "CheckCodeViewController.h"
@interface CreatTelViewController : BaseViewController<UITextFieldDelegate>
@property(nonatomic,retain)UIButton *telZoneButton;
@property(nonatomic,retain)ContryCodeModel *contryModel;
@property(nonatomic,strong)CreateUserModel *usermodel;
@end
