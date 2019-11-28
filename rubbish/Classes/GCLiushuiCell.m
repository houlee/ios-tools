//
//  GCLiushuiCell.m
//  caibo
//
//  Created by  on 12-5-23.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCLiushuiCell.h"

@implementation GCLiushuiCell

@synthesize yearLabel;
//@synthesize dateLabel;
//@synthesize timeLabel;
//@synthesize surplusLabel;
//@synthesize wjxImageView;
//@synthesize moneyImageView;
@synthesize arrowImageView;
@synthesize info;
// @synthesize rechinfo;
// @synthesize withinfo;
@synthesize freeinfo;
//@synthesize moneyLabel;
//@synthesize yuan;
//@synthesize typeLabel;
//@synthesize liuShuiDateMark;
//@synthesize verticalLine;
@synthesize xianView;
@synthesize xianView2;

@synthesize view;
@synthesize verticalLine2;

#define NOT_INCLUDED_TEXT @"奖励资金计入余额"

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self returnTableViewCellView]];
//        xianView = [[UIView alloc] initWithFrame:CGRectMake(95, 75, 320-95, 0.5)];
//        xianView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
//        [self addSubview:xianView];
        
//        xianView2 = [[UIView alloc] initWithFrame:CGRectMake(95, 75+50, 320-95, 0.5)];
//        xianView2.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1];
//        [self addSubview:xianView2];
        xianView2.hidden = YES;

        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (WithdrawalsInfor *)withinfo{
    return withinfo;
}

- (void)setWithinfo:(WithdrawalsInfor *)_withinfo{
    NSArray * dateArray = [_withinfo.operDate componentsSeparatedByString:@" "];
    
    if (dateArray.count > 1) {
        //  日期时间
        dateLabel.text = [[dateArray objectAtIndex:0] substringFromIndex:5];
        yearLabel.text = [[dateArray objectAtIndex:0] substringToIndex:4];
        timeLabel.text = [dateArray objectAtIndex:1];
    }
    moneyLabel.text = _withinfo.award;

    moneyText = moneyLabel.text;
    moneyText = [NSString stringWithFormat:@"%@",moneyLabel.text];
    CGSize moneyTextSize =   [moneyText sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(180, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    
    yuan.frame = CGRectMake(96+moneyTextSize.width, 20, 15, 22);
    wjxImageView.image = nil;
    typeLabel.text = @"提现";
//    moneyLabel.textColor = [UIColor colorWithRed:25/255.0 green:122/255.0 blue:228/255.0 alpha:1];
    moneyLabel.textColor = [UIColor colorWithRed:19.0/255 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    yuan.textColor = [UIColor colorWithRed:19.0/255 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    surplusLabel.hidden = YES;
}

- (RechargeInfor *)rechinfo{
    return rechinfo;
}
- (void)setRechinfo:(RechargeInfor *)_rechinfo{
    
    NSArray * dateArray = [_rechinfo.rechargeTime componentsSeparatedByString:@" "];
    if (dateArray.count > 2) {
        dateLabel.text = [[dateArray objectAtIndex:0] substringFromIndex:5];
        timeLabel.text = [dateArray objectAtIndex:1];
    }
    moneyLabel.text = _rechinfo.amount;
    
    
    
    
    moneyText = moneyLabel.text;
    CGSize moneyTextSize =   [moneyText sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(180, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    yuan.frame = CGRectMake(96+moneyTextSize.width, 20, 15, 22);
    
    
    
    
    
    wjxImageView.image = nil;
    typeLabel.text = @"充值";
    if ([_rechinfo.amount doubleValue] > 0) {
        moneyLabel.textColor = [UIColor colorWithRed:243.0/255.0 green:60.0/255.0 blue:46.0/255.0 alpha:1];
        yuan.textColor = [UIColor colorWithRed:243.0/255.0 green:60.0/255.0 blue:46.0/255.0 alpha:1];
    }else{
        moneyLabel.textColor = [UIColor blackColor];
        yuan.textColor = [UIColor blackColor];
    }
    surplusLabel.hidden = YES;
}

- (FreezeDetailInfor *)freeinfo{
    return freeinfo;
}

- (void)setFreeinfo:(FreezeDetailInfor *)_freeinfo{
    
    
    NSArray * dateArray = [_freeinfo.freezeTime componentsSeparatedByString:@" "];
    if (dateArray.count > 2) {
        dateLabel.text = [[dateArray objectAtIndex:0] substringFromIndex:5];
        timeLabel.text = [dateArray objectAtIndex:1];
    }
    moneyLabel.text = _freeinfo.totolAmount;
    
    moneyText = moneyLabel.text;
    CGSize moneyTextSize =   [moneyText sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(180, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    yuan.frame = CGRectMake(96+moneyTextSize.width, 20, 15, 22);
    
    moneyLabel.textColor = [UIColor blackColor];
    yuan.textColor = [UIColor blackColor];
    wjxImageView.image = nil;
    typeLabel.text = @"冻结";
    surplusLabel.hidden = YES;
}

- (GCLiushuiDataInfo *)info{
    return info;
}

- (void)setInfo:(GCLiushuiDataInfo *)_info{
  
    NSArray * dateArray = [_info.caozuodate componentsSeparatedByString:@" "];
    if (dateArray.count > 2) {
        dateLabel.text = [[dateArray objectAtIndex:0] substringFromIndex:5];
        timeLabel.text = [dateArray objectAtIndex:1];
    }
    moneyLabel.text = _info.shoushumoney;
    
    moneyText = moneyLabel.text;
    CGSize moneyTextSize =   [moneyText sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(180, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    yuan.frame = CGRectMake(96+moneyTextSize.width, 20, 15, 22);
    
    
    
    surplusLabel.hidden = NO;
    if ([_info.bencijiang floatValue] == 0) {
        surplusLabel.text = [NSString stringWithFormat:@"余额%@元",_info.houyue];
    }else{
        surplusLabel.text = NOT_INCLUDED_TEXT;
    }
    
    
    if ([_info.ermingcheng isEqualToString:@"购买彩票"]) {
        typeLabel.text = @"购彩";
    }else if([_info.ermingcheng isEqualToString:@"奖金派送"]){
        typeLabel.text = @"中奖";
    }else if([_info.ermingcheng isEqualToString:@"账户充值"]){
        typeLabel.text = @"充值";
    }else{
        typeLabel.text = _info.ermingcheng;
    }
    
    if ([_info.ermingcheng isEqualToString:@"奖金派送"]) {
        wjxImageView.image = UIImageGetImageFromName(@"Heart.png");
    }else{
        wjxImageView.image = nil;
    }
    
    if ([_info.shoushumoney hasPrefix:@"+"]) {
        moneyLabel.textColor = [UIColor colorWithRed:243.0/255.0 green:60.0/255.0 blue:46.0/255.0 alpha:1];
        yuan.textColor = [UIColor colorWithRed:243.0/255.0 green:60.0/255.0 blue:46.0/255.0 alpha:1];
    }else if([_info.shoushumoney hasPrefix:@"-"]){
        moneyLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        yuan.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    }else{
        moneyLabel.textColor = [UIColor blackColor];
        yuan.textColor = [UIColor blackColor];
    }
    
}

- (UIView *)returnTableViewCellView{
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)] ;
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 300, 56)];
    bgimage.backgroundColor = [UIColor clearColor];
    //bgimage.image = [UIImageGetImageFromName(@"LBT960.png") stretchableImageWithLeftCapWidth:160 topCapHeight:6];
    [view addSubview:bgimage];
    [bgimage release];
    
    
    // JTD960
    arrowImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(290, 30, 8.5, 13)] autorelease];
    arrowImageView.image = UIImageGetImageFromName(@"jiantou_1.png");
    [view addSubview:arrowImageView];
    
    
    // 日期
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 78, 22)];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    dateLabel.textColor = [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.font = [UIFont systemFontOfSize:16];
    
    
    yearLabel = [[UILabel alloc] init];
    yearLabel.frame = CGRectMake(60, -30, 40, 20);
//    yearLabel.textColor = [UIColor colorWithRed:196.0/255.0 green:190.0/255.0 blue:168.0/255.0 alpha:1];
    yearLabel.textColor = [UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1];
    yearLabel.textAlignment = NSTextAlignmentLeft;
    yearLabel.backgroundColor = [UIColor clearColor];
    yearLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:yearLabel];
    
    
    
    
    // 时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 45, 35, 22)];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = [UIFont systemFontOfSize:12];
//    timeLabel.textColor = [UIColor colorWithRed:196.0/255.0 green:190.0/255.0 blue:168.0/255.0 alpha:1];
    timeLabel.textColor = [UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1];
    timeLabel.backgroundColor = [UIColor clearColor];
    
    
    // 余额
    surplusLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 45, 200, 22)];
    surplusLabel.backgroundColor = [UIColor clearColor];
//    surplusLabel.textColor = [UIColor colorWithRed:162.0/255.0 green:162.0/255.0 blue:162.0/255.0 alpha:1];
    surplusLabel.textColor = [UIColor colorWithRed:47.0/255.0 green:47.0/255.0 blue:47.0/255.0 alpha:1];
    surplusLabel.font = [UIFont systemFontOfSize:12];
    wjxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(234, 22, 9, 8.5)];
    wjxImageView.backgroundColor = [UIColor clearColor];
    



    moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 19, 65, 22)];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.font = [UIFont systemFontOfSize:20];
    moneyLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:moneyLabel];
    
    yuan = [[[UILabel alloc] initWithFrame:CGRectMake(138, 22, 15, 22)] autorelease];
    yuan.font = [UIFont systemFontOfSize:12];
    [view addSubview:yuan];
    yuan.text = @"元";
    yuan.textColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1];
    yuan.backgroundColor = [UIColor clearColor];
    //   修改元的位置跟随钱数长度变化
    yuan.frame = CGRectMake(95+moneyRW.width, 20, 15, 22);
    
    
    typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 16, 100, 22)];
    typeLabel.textAlignment = NSTextAlignmentRight;
    typeLabel.backgroundColor = [UIColor clearColor];
    typeLabel.font = [UIFont systemFontOfSize:16];
//    typeLabel.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1];
    typeLabel.textColor = [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1];

    // 竖线
    verticalLine = [[UIView alloc] initWithFrame:CGRectMake(75, 33, 0.5, 75-33)];
    verticalLine.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    [view addSubview:verticalLine];
    
    liuShuiDateMark = [[UIImageView alloc] initWithFrame:CGRectMake(75-13.5/2, 33-13.5, 13.5, 13.5)];
    liuShuiDateMark.image = [UIImage imageNamed:@"liushuijiemianbiaozhi_1.png"];
    [view addSubview:liuShuiDateMark];
    
    verticalLine2 = [[UIView alloc] initWithFrame:CGRectMake(75, 0, 0.5, 19)];
    verticalLine2.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    [view addSubview:verticalLine2];
    
    
    
    
    [view addSubview:dateLabel];
    [view addSubview:wjxImageView];
    [view addSubview:surplusLabel];
    [view addSubview:timeLabel];
    [view addSubview:typeLabel];
    return view;

}

- (void)dealloc{
    
//    [xianView release];
//    [xianView2 release];

    [view release];
    [typeLabel release];
//  [moneyImageView release];
    [moneyLabel release];
    [wjxImageView release];
    [dateLabel release];
    [timeLabel release];
    [surplusLabel release];
    [liuShuiDateMark release];
    [verticalLine release];
    [yearLabel release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    