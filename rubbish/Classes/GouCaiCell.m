//
//  GouCaiCell.m
//  caibo
//
//  Created by yao on 12-5-15.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GouCaiCell.h"
#import "SharedDefine.h"

@implementation GouCaiCell
@synthesize nameLabel;
@synthesize iconImageView;
@synthesize myTimer;
@synthesize gouCaiCellDelegate;
@synthesize myrecord;
@synthesize isEnable;
@synthesize pianyitime;
@synthesize jieqidate;
@synthesize openImage;

@synthesize shaiziIma1,shaiziIma2,shaiziIma3,jinbiIma,jinrikaijiangLabel;

@synthesize cellbgImage;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GouCaiBack) name:@"GouCaiBack" object:nil];
        self.ypianyi = 2;
        
    
        cellbgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 87)];
        cellbgImage.image = UIImageGetImageFromName(@"goucai_cellbg.png");
        [self.contentView addSubview:cellbgImage];
        [cellbgImage release];
        
        //玩法icon
        iconImageView = [[DownLoadImageView alloc] init];
        iconImageView.frame = CGRectMake(8, 11, 62, 62);
		[cellbgImage addSubview:iconImageView];
        [iconImageView release];
        
        //玩法名称
        nameLabel = [[ColorView alloc] init];
		nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.frame = CGRectMake(62+8+15, 11, 120, 20);
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.changeColor = [UIColor blackColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        nameLabel.colorfont=[UIFont systemFontOfSize:18];
		[cellbgImage addSubview:nameLabel];
        [nameLabel release];
        
        //活动语
        HuoDongimage = [[UIImageView alloc] init];
        [cellbgImage addSubview:HuoDongimage];
        HuoDongimage.frame = CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+9, 14, 51, 17);
        HuoDongimage.image = [UIImageGetImageFromName(@"jiajiang_kuang.png") stretchableImageWithLeftCapWidth:15 topCapHeight:4];
        HuoDongimage.hidden = YES;
        [HuoDongimage release];
        
        huodongLabel = [[UILabel alloc] init];
        [HuoDongimage addSubview:huodongLabel];
        huodongLabel.textAlignment = NSTextAlignmentCenter;
        huodongLabel.backgroundColor = [UIColor clearColor];
        huodongLabel.textColor = [UIColor whiteColor];
        huodongLabel.font = [UIFont boldSystemFontOfSize:10];
        [huodongLabel release];
        
        //周期
        timeLabel = [[UILabel alloc] init];
		timeLabel.backgroundColor = [UIColor clearColor];
		timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.frame = CGRectMake(62+8+15, nameLabel.frame.origin.y+nameLabel.frame.size.height+15, 200, 12);
        timeLabel.textColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1.0];
		[cellbgImage addSubview:timeLabel];
        [timeLabel release];
        
        
        //已截期图
        jiezhiImage = [[UIImageView alloc] init];
        jiezhiImage.frame = CGRectMake(10, 42, 33, 32);
		jiezhiImage.hidden = YES;
		jiezhiImage.image = UIImageGetImageFromName(@"gc_jiezhi.png");
        [cellbgImage addSubview:jiezhiImage];
        [jiezhiImage release];
        
        //截期时间
        dajishiLabel = [[ColorView alloc] init];
		dajishiLabel.backgroundColor = [UIColor clearColor];
        dajishiLabel.changeColor=[UIColor redColor];
        dajishiLabel.frame = CGRectMake(62+8+15, timeLabel.frame.origin.y+timeLabel.frame.size.height+6, 200, 14);
		dajishiLabel.font = [UIFont systemFontOfSize:12];
        dajishiLabel.textColor = [UIColor colorWithRed:162/255.0 green:162/255.0 blue:162/255.0 alpha:1.0];
		[cellbgImage addSubview:dajishiLabel];
        
        
        //箭头
        jiantouImage = [[UIImageView alloc] initWithFrame:CGRectMake(280, 35, 8, 13)];
        jiantouImage.backgroundColor = [UIColor clearColor];
        jiantouImage.image = UIImageGetImageFromName(@"jiantou.png");
        [cellbgImage addSubview:jiantouImage];
        [jiantouImage release];
        
        
        //今日开奖
        jinrikaijiangLabel=[[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+9, 13, 60, 14)];
        jinrikaijiangLabel.backgroundColor=[UIColor clearColor];
        jinrikaijiangLabel.font=[UIFont systemFontOfSize:14];
        jinrikaijiangLabel.textColor=[UIColor redColor];
        jinrikaijiangLabel.hidden= YES;
        [cellbgImage addSubview:jinrikaijiangLabel];
        [jinrikaijiangLabel release];
        

        //快三骰子
        shaiziIma1=[[UIImageView alloc]initWithFrame:CGRectMake(155, 15, 18, 18)];
        shaiziIma1.backgroundColor=[UIColor clearColor];
        shaiziIma1.hidden = YES;
        [cellbgImage addSubview:shaiziIma1];
        [shaiziIma1 release];
        
        shaiziIma2=[[UIImageView alloc]initWithFrame:CGRectMake(shaiziIma1.frame.origin.x+shaiziIma1.frame.size.width+5, 15, 18, 18)];
        shaiziIma2.backgroundColor=[UIColor clearColor];
        [cellbgImage addSubview:shaiziIma2];
        shaiziIma2.hidden = YES;
        [shaiziIma2 release];
        
        shaiziIma3=[[UIImageView alloc]initWithFrame:CGRectMake(shaiziIma2.frame.origin.x+shaiziIma2.frame.size.width+5, 15, 18, 18)];
        shaiziIma3.backgroundColor=[UIColor clearColor];
        shaiziIma3.hidden = YES;
        [cellbgImage addSubview:shaiziIma3];
        [shaiziIma3 release];
        
        
        //大乐透双色球2、5亿
        jinbiIma=[[UIImageView alloc]initWithFrame:CGRectMake(235.5, 45.5, 52.5, 37.5)];
        jinbiIma.backgroundColor=[UIColor clearColor];
        [cellbgImage addSubview:jinbiIma];
  
        self.backImageView.frame = CGRectMake(10, 0, 300, 76);
        self.butonScrollView.frame = CGRectMake(10, 0, 300, normalHight);
        self.xzhi = 10;
   
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0+10, 0, 140, 76);
//        [self.contentView addSubview:btn];
        [btn addTarget:self action:@selector(openCellDegate) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)openCellDegate{
    if (self.cp_canopencelldelegate && [cp_canopencelldelegate respondsToSelector:@selector(openCell:)]) {
        [cp_canopencelldelegate openCell:self];
    }

}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{

    [super setHighlighted:highlighted animated:animated];
    if(highlighted){
    
        cellbgImage.image = UIImageGetImageFromName(@"goucaiHighLighted_cellbg.png");
    }
    else{
    
        cellbgImage.image = UIImageGetImageFromName(@"goucai_cellbg.png");

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    
    [super setSelected:selected animated:animated];
	if (selected) {
		if (self.isEnable) {
		}
	}
	else {
		if (self.isEnable) {
			[self performSelector:@selector(setBack) withObject:nil afterDelay:0.5];
		}
	}

    // Configure the view for the selected state.
}

- (void)setBack {
	if (self.isEnable) {
	}
}



- (void)LoadIconImage:(NSString *)imageName {
	if (self.isEnable == YES) {
		self.iconImageView.image = UIImageGetImageFromName(imageName);
	}
	else {
	}

}

- (NSInteger)jieQiShiJian:(NSString *)lottoryID {
    if ([lottoryID isEqualToString:@"001"]||[lottoryID isEqualToString:@"113"]||[lottoryID isEqualToString:@"003"]) {
        return 12*60*60;
    }
    else if ([lottoryID isEqualToString:LOTTERY_ID_JIANGXI_11]||[lottoryID isEqualToString:@"119"]||[lottoryID isEqualToString:@"006"]||[lottoryID isEqualToString:@"122"]||[lottoryID isEqualToString:@"012"] ||[lottoryID isEqualToString:@"121"] || [lottoryID isEqualToString:@"013"]||[lottoryID isEqualToString:@"014"] || [lottoryID isEqualToString:@"019"] || [lottoryID isEqualToString:LOTTERY_ID_JILIN]||[lottoryID isEqualToString:@"123"]||[lottoryID isEqualToString:LOTTERY_ID_SHANXI_11]||[lottoryID isEqualToString:LOTTERY_ID_ANHUI]){
        return 60*60*24*10;
    }
    else if ([lottoryID isEqualToString:@"201"]||[lottoryID isEqualToString:@"200"]||[lottoryID isEqualToString:@"400"]||[lottoryID isEqualToString:@"20106"] ||[lottoryID isEqualToString:@"20107"] || [lottoryID isEqualToString:@"201dg"] || [lottoryID isEqualToString:@"400sf"]|| [lottoryID isEqualToString:@"201bf"]){
        return 0;
    }
    return 6*60*60;
}

- (void)setButonImageArray:(NSArray *)imageArray TitileArray:(NSArray *)titleArray{
    for (UIView *v in butonScrollView.subviews) {
        if (v.tag != 1101 && v.tag != 1102) {
            [v removeFromSuperview];
        }
        
    }
    for (int i = 0; i < [imageArray count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(i * 60, 0, 60, selectHight - normalHight);
        
        
        btn.tag = i;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 60, 20)];
        lable.font = [UIFont systemFontOfSize:btnFontSize];
        lable.textColor = btnTitleColor;
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = [titleArray objectAtIndex:i];
        [btn addSubview:lable];
        [lable release];
        
        UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(17, 10, 26, 26)];
        [btn addSubview:btnImage];
        btnImage.tag = 10;
        btnImage.image = UIImageGetImageFromName([imageArray objectAtIndex:i]);
        [btnImage release];
        [btn addTarget:self action:@selector(btnClicle:) forControlEvents:UIControlEventTouchUpInside];
        [butonScrollView addSubview:btn];
    }
}

- (void)btnClicle:(UIButton *)sender {
    if (cp_canopencelldelegate && [cp_canopencelldelegate respondsToSelector:@selector(CP_CanOpenSelect:WithSelectButonIndex:)]) {
        [cp_canopencelldelegate CP_CanOpenSelect:self WithSelectButonIndex:sender.tag];
    }
}

- (void)LoadData:(IssueRecord *)record Type:(NSInteger)type {
	if (myTimer) {
        [myTimer invalidate];
        self.myTimer = nil;
    }
	self.myrecord = record;
	mycellType = type;    
    timeLabel.text = nil;
    dajishiLabel.text = nil;
//	iconImageView.image = nil;
	jiezhiImage.hidden = YES;
    HuoDongimage.hidden = YES;
    jinrikaijiangLabel.hidden = YES;
    
    nameLabel.text = [NSString stringWithFormat:@"<%@>", record.lotteryName];
    if ([record.lotteryName rangeOfString:@"|"].location != NSNotFound) {
        
        NSArray * nameArray = [record.lotteryName componentsSeparatedByString:@"|"];
        if ([nameArray count] > 1) {
            nameLabel.text = [NSString stringWithFormat:@"<%@> %@", [nameArray objectAtIndex:0], [nameArray objectAtIndex:1]];
        }
        
    }
    
//    iconImageView.image = UIImageGetImageFromName(@"wwlicon.png");
    [iconImageView setImageWithURL:record.iconUrl DefautImage:UIImageGetImageFromName(@"wwlicon.png")];
    UIFont * font = [UIFont systemFontOfSize:15];
    CGSize  size = CGSizeMake(120, 20);
    CGSize labelSize = [nameLabel.text sizeWithFont:font constrainedToSize:size];
    
    
	if (record) {
		//iconImageView.image = UIImageGetImageFromName(record.lotteryName);
		timeLabel.text = record.zhouqi;//[NSString stringWithFormat:@"距离%@期截止",record.curIssue];
        NSLog(@"周期: %@ , 开奖时间: %@ , 期次: %@",record.zhouqi,record.lotteryTime,record.curIssue);
		seconds = 0;
        

        //今日开奖
        if(record.lotteryTime && record.lotteryTime.length){
        
            jinrikaijiangLabel.hidden = NO;
            jinrikaijiangLabel.text = record.lotteryTime;
            jinrikaijiangLabel.frame = CGRectMake(85-10+labelSize.width+9, jinrikaijiangLabel.frame.origin.y, jinrikaijiangLabel.frame.size.width, 14);

        }
        else{
            jinrikaijiangLabel.hidden = YES;

        }

        if([record.lotteryId isEqualToString:@"013"] || [record.lotteryId isEqualToString:@"012"] || [record.lotteryId isEqualToString:@"019"] || [record.lotteryId isEqualToString:LOTTERY_ID_JILIN] || [record.lotteryId isEqualToString:LOTTERY_ID_ANHUI]){
            
            shaiziIma1.hidden = NO;
            shaiziIma2.hidden = NO;
            shaiziIma3.hidden = NO;
            
            shaiziIma1.frame = CGRectMake(85-10+labelSize.width+9, shaiziIma1.frame.origin.y, shaiziIma1.frame.size.width, shaiziIma1.frame.size.height);
            shaiziIma2.frame = CGRectMake(shaiziIma1.frame.origin.x+shaiziIma1.frame.size.width+5, 15, 18, 18);
            shaiziIma3.frame =CGRectMake(shaiziIma2.frame.origin.x+shaiziIma2.frame.size.width+5, 15, 18, 18);


        }
        //加奖活动语
        if ([record.activity length] > 0) {
            

            huodongLabel.text = record.activity;
            HuoDongimage.frame = CGRectMake(85-10+labelSize.width+9, HuoDongimage.frame.origin.y, [huodongLabel.text sizeWithFont:huodongLabel.font].width + 18, 17);
            huodongLabel.frame = CGRectMake(8, 0, HuoDongimage.frame.size.width-8, HuoDongimage.frame.size.height);
            HuoDongimage.hidden = NO;
            
            //快三（带有骰子图）
            if([record.lotteryId isEqualToString:@"013"]){
                
                if(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+5+HuoDongimage.frame.size.width>300){
                    
                    shaiziIma1.hidden = YES;
                    shaiziIma2.hidden = YES;
                    shaiziIma3.hidden = YES;
                    
                    HuoDongimage.frame = CGRectMake(85-10+labelSize.width+9, HuoDongimage.frame.origin.y, [huodongLabel.text sizeWithFont:huodongLabel.font].width + 18, 17);
                    
                }
                else{
                    HuoDongimage.frame = CGRectMake(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+6,15,HuoDongimage.frame.size.width,17);
                }
            
            }
            if([record.lotteryId isEqualToString:@"012"]){
            
                if(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+5+HuoDongimage.frame.size.width>300){
                    
                    shaiziIma1.hidden = YES;
                    shaiziIma2.hidden = YES;
                    shaiziIma3.hidden = YES;
                    
                    HuoDongimage.frame = CGRectMake(85-10+labelSize.width+9, HuoDongimage.frame.origin.y, [huodongLabel.text sizeWithFont:huodongLabel.font].width + 18, 17);
                    
                }
                else{
                    HuoDongimage.frame = CGRectMake(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+6,15,HuoDongimage.frame.size.width,17);
                }
            }
            if([record.lotteryId isEqualToString:@"019"]){
                
                if(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+5+HuoDongimage.frame.size.width>300){
                    
                    shaiziIma1.hidden = YES;
                    shaiziIma2.hidden = YES;
                    shaiziIma3.hidden = YES;
                    
                    HuoDongimage.frame = CGRectMake(85-10+labelSize.width+9, HuoDongimage.frame.origin.y, [huodongLabel.text sizeWithFont:huodongLabel.font].width + 18, 17);
                    
                }
                else{
                    HuoDongimage.frame = CGRectMake(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+6,15,HuoDongimage.frame.size.width,17);
                }
            }
            if([record.lotteryId isEqualToString:LOTTERY_ID_JILIN]){
                
                if(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+5+HuoDongimage.frame.size.width>300){
                    
                    shaiziIma1.hidden = YES;
                    shaiziIma2.hidden = YES;
                    shaiziIma3.hidden = YES;
                    
                    HuoDongimage.frame = CGRectMake(85-10+labelSize.width+9, HuoDongimage.frame.origin.y, [huodongLabel.text sizeWithFont:huodongLabel.font].width + 18, 17);
                    
                }
                else{
                    HuoDongimage.frame = CGRectMake(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+6,15,HuoDongimage.frame.size.width,17);
                }
            }
            if([record.lotteryId isEqualToString:LOTTERY_ID_ANHUI]){
                
                if(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+5+HuoDongimage.frame.size.width>300){
                    
                    shaiziIma1.hidden = YES;
                    shaiziIma2.hidden = YES;
                    shaiziIma3.hidden = YES;
                    
                    HuoDongimage.frame = CGRectMake(85-10+labelSize.width+9, HuoDongimage.frame.origin.y, [huodongLabel.text sizeWithFont:huodongLabel.font].width + 18, 17);
                    
                }
                else{
                    HuoDongimage.frame = CGRectMake(shaiziIma3.frame.origin.x+shaiziIma3.frame.size.width+6,15,HuoDongimage.frame.size.width,17);
                }
            }
            
            
            if(record.lotteryTime && record.lotteryTime.length){
                
                
                if(jinrikaijiangLabel.frame.origin.x+jinrikaijiangLabel.frame.size.width+5 + HuoDongimage.frame.size.width >300){
                    jinrikaijiangLabel.hidden= YES;

                }
                else{
                    jinrikaijiangLabel.hidden= NO;
                    HuoDongimage.frame = CGRectMake(jinrikaijiangLabel.frame.origin.x+jinrikaijiangLabel.frame.size.width+5,13,HuoDongimage.frame.size.width,17);

                }

            }

            
            HuoDongimage.hidden = NO;
        }
		NSArray *array = [record.remainingTime componentsSeparatedByString:@":"];
		for (int i = 0; i < [array count]; i++) {
			seconds = seconds * 60 +[[array objectAtIndex:i] intValue];
		}
        seconds = seconds -pianyitime;
		dajishiLabel.text = record.remainingTime;
        NSLog(@"%@",record.remainingTime);
        self.jieqidate = record.content;
        if ([self jieQiShiJian:record.lotteryId] == 0) {
            
            dajishiLabel.text = record.content;
            NSLog(@"%@",record.content);
        }
        else if (seconds <= 0) {
            jiezhiImage.hidden = NO;
            dajishiLabel.text = @"本期已停售";
            [self.myTimer invalidate];
            self.myTimer = nil;
            [self performSelector:@selector(timeEnd) withObject:nil afterDelay:10];
        }
		else if (0 < seconds&& seconds<= [self jieQiShiJian:record.lotteryId]) {
            if ([record.lotteryId isEqualToString:@"119"] || [record.lotteryId isEqualToString:@"122"] || [record.lotteryId isEqualToString:@"012"] || [record.lotteryId isEqualToString:@"121"] || [record.lotteryId isEqualToString:@"013"] || [record.lotteryId isEqualToString:@"019"] || [record.lotteryId isEqualToString:LOTTERY_ID_JILIN] || [record.lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [record.lotteryId isEqualToString:@"123"] || [record.lotteryId isEqualToString:LOTTERY_ID_SHANXI_11] || [record.lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
                if ([record.curIssue length] > 2) {
                    if (seconds > 3600) {
                        if (seconds > 60*60*8) {
                            dajishiLabel.text = [NSString stringWithFormat:@"预售%@期 投注截止<%ld>小时<%ld>分<%ld>秒",[record.curIssue substringFromIndex:[record.curIssue length] - 2],seconds/3600,seconds%3600/60,seconds%60];
                        }
                        else {
                            dajishiLabel.text = [NSString stringWithFormat:@"今日%@期 投注截止<%ld>小时<%ld>分<%ld>秒",[record.curIssue substringFromIndex:[record.curIssue length] - 2],seconds/3600,seconds%3600/60,seconds%60];
                        }
                        
                    }
                    else {
                        dajishiLabel.text = [NSString stringWithFormat:@"今日%@期 投注截止<%ld>分<%ld>秒",[record.curIssue substringFromIndex:[record.curIssue length] - 2],seconds%3600/60,seconds%60];
                    }
                    
                }
                NSLog(@"%@",dajishiLabel.text);
            }
            else if ([record.lotteryId isEqualToString:@"011"] || [record.lotteryId isEqualToString:@"006"] || [record.lotteryId isEqualToString:@"014"]) {
                if ([record.curIssue length] > 3) {
                    if (seconds > 3600) {
                        if (seconds > 60*60*8) {
                            dajishiLabel.text = [NSString stringWithFormat:@"预售%@期 截止<%ld>小时<%ld>分<%ld>秒",[record.curIssue substringFromIndex:[record.curIssue length] - 3],seconds/3600,seconds%3600/60,seconds%60];
                        }
                        else {
                            dajishiLabel.text = [NSString stringWithFormat:@"今日%@期 截止<%ld>小时<%ld>分<%ld>秒",[record.curIssue substringFromIndex:[record.curIssue length] - 3],seconds/3600,seconds%3600/60,seconds%60];
                        }
                        
                    }
                    else {
                        dajishiLabel.text = [NSString stringWithFormat:@"今日%@期 截止<%ld>分<%ld>秒",[record.curIssue substringFromIndex:[record.curIssue length] - 3],seconds%3600/60,seconds%60];
                    }
                }
            }
            else {
                if ([record.curIssue length] >= 5) {
                    dajishiLabel.text = [NSString stringWithFormat:@"距%@期投注截止<%ld>小时<%ld>分",[record.curIssue substringFromIndex:[record.curIssue length] - 5],seconds/3600,seconds%3600/60];
                }
            }
			self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
													   target:self
													 selector:@selector(onTimer:) // 回调函数
													 userInfo:nil
													  repeats:YES];
		}
		else if (seconds > [self jieQiShiJian:record.lotteryId]){
            if ([record.content rangeOfString:@"null"].location != NSNotFound) {
                dajishiLabel.text = nil;
            }
            else {
                dajishiLabel.text = record.content;
            }
		}
	}
	else {
		dajishiLabel.text = nil;
		timeLabel.text = nil;
	}
}
- (void)LoadData:(IssueRecord *)record {
	[self LoadData:record Type:mycellType];
}

- (void)onTimer:(id)sender {
	seconds = seconds -1;
    if ([myrecord.lotteryId isEqualToString:@"119"] || [myrecord.lotteryId isEqualToString:@"122"] || [myrecord.lotteryId isEqualToString:@"012"] || [myrecord.lotteryId isEqualToString:@"121"] || [myrecord.lotteryId isEqualToString:@"013"] || [myrecord.lotteryId isEqualToString:@"019"] || [myrecord.lotteryId isEqualToString:LOTTERY_ID_JILIN] || [myrecord.lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11] || [myrecord.lotteryId isEqualToString:@"123"] || [myrecord.lotteryId isEqualToString:LOTTERY_ID_SHANXI_11] || [myrecord.lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
        if ([myrecord.curIssue length] > 2) {
            if (seconds > 3600) {
                if (seconds > 60*60*8) {
                    dajishiLabel.text = [NSString stringWithFormat:@"预售%@期 投注截止<%ld>小时<%ld>分<%ld>秒",[myrecord.curIssue substringFromIndex:[myrecord.curIssue length] - 2],seconds/3600,seconds%3600/60,seconds%60];
                }
                else {
                    dajishiLabel.text = [NSString stringWithFormat:@"今日%@期 投注截止<%ld>小时<%ld>分<%ld>秒",[myrecord.curIssue substringFromIndex:[myrecord.curIssue length] - 2],seconds/3600,seconds%3600/60,seconds%60];
                }
                
            }
            else {
                dajishiLabel.text = [NSString stringWithFormat:@"今日%@期 投注截止<%ld>分<%ld>秒",[myrecord.curIssue substringFromIndex:[myrecord.curIssue length] - 2],seconds%3600/60,seconds%60];
            }
            
        }
    }
    else if ([myrecord.lotteryId isEqualToString:@"011"] || [myrecord.lotteryId isEqualToString:@"006"] || [myrecord.lotteryId isEqualToString:@"014"]) {
        if ([myrecord.curIssue length] > 3) {
            if (seconds > 3600) {
                if (seconds > 60*60*8) {
                    dajishiLabel.text = [NSString stringWithFormat:@"预售%@期 截止<%ld>小时<%ld>分<%ld>秒",[myrecord.curIssue substringFromIndex:[myrecord.curIssue length] - 3],seconds/3600,seconds%3600/60,seconds%60];
                }
                else {
                    dajishiLabel.text = [NSString stringWithFormat:@"今日%@期 截止<%ld>小时<%ld>分<%ld>秒",[myrecord.curIssue substringFromIndex:[myrecord.curIssue length] - 3],seconds/3600,seconds%3600/60,seconds%60];
                }
                
            }
            else {
                dajishiLabel.text = [NSString stringWithFormat:@"今日%@期 截止<%ld>分<%ld>秒",[myrecord.curIssue substringFromIndex:[myrecord.curIssue length] - 3],seconds%3600/60,seconds%60];
            }
            
        }
    }
    else {
        if ([myrecord.curIssue length] > 5) {
            dajishiLabel.text = [NSString stringWithFormat:@"距%@期投注截止<%ld>小时<%ld>分",[myrecord.curIssue substringFromIndex:[myrecord.curIssue length] - 5],seconds/3600,seconds%3600/60];
        }
    }
	if (seconds <= 0) {
		jiezhiImage.hidden = NO;
		dajishiLabel.text = @"本期已停售";
		[self.myTimer invalidate];
        self.myTimer = nil;
		[self performSelector:@selector(timeEnd) withObject:nil afterDelay:10];
	}
}

- (void)GouCaiBack {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GouCaiBack" object:nil];
    [self.myTimer invalidate];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeEnd) object:nil];
	self.myTimer = nil;
}

- (void)timeEnd {
	if (gouCaiCellDelegate && [gouCaiCellDelegate respondsToSelector:@selector(isTimeEnd:lottery:)]) {
		[gouCaiCellDelegate isTimeEnd:mycellType lottery:myrecord.lotteryId];
	}
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GouCaiBack" object:nil];
    [self.myTimer invalidate];
	self.myrecord = nil;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeEnd) object:nil];
	[myTimer invalidate];
	[dajishiLabel release];
    self.jieqidate = nil;
	self.gouCaiCellDelegate = nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    