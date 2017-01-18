//
//  CheckTypeView.h
//  jjrms
//
//  Created by user on 16/10/20.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "UIColor+Helper.h"
@interface CheckTypeView : UIView
@property(nonatomic, retain)UIImageView *PaypalImage;
@property(nonatomic, retain)UILabel *PaypalName;
@property(nonatomic, retain)UIImageView *zhifubaoImage;
@property(nonatomic, retain)UILabel *zhifubaoName;
@property(nonatomic, retain)UIView *paypalView;
@property(nonatomic, retain)UIView *zhifubaoView;

@end
