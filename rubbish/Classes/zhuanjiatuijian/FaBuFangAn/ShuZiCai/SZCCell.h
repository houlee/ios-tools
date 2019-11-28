//
//  SZCCell.h
//  Experts
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCCell : UITableViewCell

@property (nonatomic,strong)UIView *leftLine;//左线
@property (nonatomic,strong)UIView *rightLine;//右线
@property (nonatomic,strong)UIView *topLine;//上线
@property (nonatomic,strong)UIView *midLine;//中线
@property (nonatomic,strong)UIView *lowLine;//底线
@property (nonatomic,strong)UILabel *ballNameLab;//球名字
@property (nonatomic,strong)UITextView *countNameLab;//球数字名字
@property (nonatomic,strong)UIView *bigView;//白色背景图

@end
