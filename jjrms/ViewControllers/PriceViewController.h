//
//  PriceViewController.h
//  jjrms
//
//  Created by user on 2016/11/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^returnCALTextBlock)(NSString *text);

@interface PriceViewController : BaseViewController

@property (nonatomic, copy) returnCALTextBlock returnTextBlock;
@property (nonatomic, strong)UILabel  *dateLab;
@property (nonatomic, strong)NSString   *datetext;
@property (nonatomic, strong)NSString   *unit;

- (void)returnCALText:(returnCALTextBlock)textBlock;

@end
