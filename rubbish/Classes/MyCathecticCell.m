//
//  MyCathecticCell.m
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "MyCathecticCell.h"

@implementation MyCathecticCell
@synthesize timeLabel;
@synthesize moneyLabel;
@synthesize timeNumLabel;
@synthesize numberLabel;
@synthesize rightFieldLabel;
@synthesize rightLabel;
@synthesize allNumLabel;
@synthesize view;
@synthesize useLabel;
@synthesize pkmatch;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:[self tabelCellView]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//get
- (StatisticsData *)statisticsData{
    return statisticsData;
}

//set
-(void)setStatisticsData:(StatisticsData *)_statisticsData{
    if (statisticsData != _statisticsData) {
        [statisticsData release];
        statisticsData = [_statisticsData retain];
    }
    
    if (pkmatch == PKMatchTypeBettingMecell) {
        timeLabel.text = _statisticsData.time;
        timeNumLabel.text = _statisticsData.timeNum;
        useLabel.text = _statisticsData.use;
        numberLabel.text = _statisticsData.number;
        moneyLabel.text = _statisticsData.money;
        rightLabel.text = _statisticsData.right;
        rightFieldLabel.text = _statisticsData.rightField;
        allNumLabel.text = _statisticsData.allNum;
        timeNumLabel.frame = CGRectZero;
        useLabel.frame = CGRectMake(0, 0, 61, 40);
        timeLabel.frame = CGRectMake(0, 31, 61, 12);
        
    }else if (pkmatch == PKMatchTypeBettingRecordscell){
        timeNumLabel.text = _statisticsData.timeNum;
        numberLabel.text = _statisticsData.number;
        moneyLabel.text = _statisticsData.money;
        rightLabel.text = _statisticsData.right;
        rightFieldLabel.text = _statisticsData.rightField;
        allNumLabel.text = _statisticsData.allNum;
		
        useLabel.text = _statisticsData.use;
                
        
    }else if (pkmatch == PKMatchTypeCrosscell){
        timeNumLabel.text = _statisticsData.timeNum;
        numberLabel.text = _statisticsData.number;
        moneyLabel.text = _statisticsData.money;
        rightLabel.text = _statisticsData.right;
        rightFieldLabel.text = _statisticsData.rightField;
		allNumLabel.text =_statisticsData.allNum;
        useLabel.text = _statisticsData.use;
        
    }
    
    
}


- (UIView *)tabelCellView{
    
    
    
    CGRect rect = CGRectMake(0, 0, 320, 50);
    //要返回的view
    view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 61, 53)];
    [view addSubview:backV];
    backV.backgroundColor = [UIColor colorWithRed:224/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    [backV release];
    
    //期号
    timeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 54, 20)];
    timeNumLabel.textAlignment = NSTextAlignmentCenter;
    timeNumLabel.backgroundColor = [UIColor clearColor];
    timeNumLabel.font = [UIFont systemFontOfSize:10];
    
    //用户名
    useLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 20, 54, 20)];
    useLabel.textAlignment = NSTextAlignmentCenter;
    useLabel.font = [UIFont systemFontOfSize:10];
    useLabel.backgroundColor = [UIColor clearColor];
    
    
        
    //横线
    line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, 300, 2)];
    line1.image = [UIImageGetImageFromName(@"PKHengLine.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    
    //横线 
    line2 = [[UIImageView alloc] initWithFrame:CGRectMake(62, 28, 238, 1)];
    line2.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    
    //奖金
    moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 50, 20)];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.backgroundColor = [UIColor whiteColor];
    moneyLabel.font = [UIFont systemFontOfSize:10];
    moneyLabel.textColor = [UIColor redColor];
    
    //竖线
    line3 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 0, 1, 41)];
    line3.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    line4 = [[UIImageView alloc] initWithFrame:CGRectMake(108, 0, 1, 28)];
    line4.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    line5 = [[UIImageView alloc] initWithFrame:CGRectMake(155, 0, 1, 28)];
    line5.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    line6 = [[UIImageView alloc] initWithFrame:CGRectMake(227, 0, 1, 28)];
    line6.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    //注数
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 45, 20)];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.backgroundColor = [UIColor whiteColor];
    numberLabel.font = [UIFont systemFontOfSize:10];
    
    
    //全对注数
    rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 50, 20)];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.backgroundColor = [UIColor whiteColor];
    rightLabel.font = [UIFont systemFontOfSize:10];
        
    //正确场次
    rightFieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 50, 28)];
    rightFieldLabel.textAlignment = NSTextAlignmentCenter;
    rightFieldLabel.backgroundColor = [UIColor whiteColor];
    rightFieldLabel.font = [UIFont systemFontOfSize:10];
        
    //投注时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 65, 20)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.font = [UIFont systemFontOfSize:9];
    timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    
    //全部数字
    allNumLabel = [[ColorView alloc] initWithFrame:CGRectMake(60, 20, 255, 20)];
    //allNumLabel.textAlignment = NSTextAlignmentCenter;
    allNumLabel.backgroundColor = [UIColor whiteColor];
    allNumLabel.font = [UIFont systemFontOfSize:12];
	allNumLabel.textColor = [UIColor blackColor];
    allNumLabel.changeColor = [UIColor redColor];
    
    view.frame = CGRectMake(10, 0, 300, 53);
    timeNumLabel.frame = CGRectMake(0, 0, 0, 0);//
    useLabel.frame = CGRectMake(0, 0, 61, 53);//
    moneyLabel.frame = CGRectMake(61, 0, 47, 28);
    numberLabel.frame = CGRectMake(108, 0, 47, 28);
    rightLabel.frame = CGRectMake(155, 0, 72, 28);
    rightFieldLabel.frame = CGRectMake(227, 0, 73, 28);
    timeLabel.frame = CGRectMake(0, 0, 0, 0);
    allNumLabel.frame = CGRectMake(61, 35, 238, 18);
    
    
    [view addSubview:timeNumLabel];
    [view addSubview:useLabel];
    [view addSubview:moneyLabel];
    [view addSubview:numberLabel];
    [view addSubview:rightLabel];
    [view addSubview:rightFieldLabel];
    [view addSubview:timeLabel];
    [view addSubview:allNumLabel];
    
    

    [view addSubview:line3];
    [view addSubview:line4];
    [view addSubview:line5];
    [view addSubview:line6];
    [view addSubview:line1];
    [view addSubview:line2];
    
    
    
    return view;
    
}

- (void)dealloc{
    [line1 release];
    [line2 release];
    [line3 release];
    [line4 release];
    [line5 release];
    [line6 release];

    [useLabel release];
    [statisticsData release];
    [timeNumLabel release];
    [timeLabel release];
    [moneyLabel release];
    [numberLabel release];
    [rightLabel release];
    [rightFieldLabel release];
    [allNumLabel release];
    [view release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    