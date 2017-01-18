//
//  EditView.h
//  jjrms
//
//  Created by user on 2016/11/22.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Helper.h"
#import "Commen.h"
#import "Masonry.h"
@interface EditView : UIView
@property(nonatomic, retain)UIButton *cancel;
@property(nonatomic, strong)UIButton *save;
@property(nonatomic, strong)UILabel *dateLab;
@property(nonatomic, strong)UIButton *kezuBtn;
@property(nonatomic, strong)UIButton *pingbiBtn;
@property(nonatomic, strong)UIButton *PriceBtn;
@property(nonatomic, strong)UILabel *uint;

@end
