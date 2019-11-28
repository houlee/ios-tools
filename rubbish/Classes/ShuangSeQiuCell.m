//
//  ShuangSeQiuCell.m
//  caibo
//
//  Created by yao on 12-5-18.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "ShuangSeQiuCell.h"
#import "GC_LotteryUtil.h"

@implementation ShuangSeQiuCell
@synthesize shuangseqiuCellDelegate;
@synthesize modeType;
@synthesize lotteryType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
//        backImage = [[UIImageView alloc] initWithFrame:CGRectMake(47, 2, 240, 33)];
        backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
//---------------------------------------------bianpinghua by sichuanlin
//		backImage.image = [UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:20 topCapHeight:10];
        backImage.backgroundColor=[UIColor clearColor];
        
        [self.contentView addSubview:backImage];
        [backImage release];
        
        lineIma=[[UIImageView alloc]init];
        lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
        lineIma.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [backImage addSubview:lineIma];
        
        
//		jianBtn= [UIButton buttonWithType:UIButtonTypeCustom];
//		[self.contentView addSubview:jianBtn];
//		[jianBtn setImage:UIImageGetImageFromName(@"GC_dot15.png") forState:UIControlStateNormal];
//		[jianBtn setImage:UIImageGetImageFromName(@"GC_dot16.png") forState:UIControlStateSelected];
//		[jianBtn addTarget:self action:@selector(changeShanChu:) forControlEvents:UIControlEventTouchUpInside];
//		jianBtn.frame =CGRectMake(10, 7, 24, 24);
		
//		shanchuBtn= [CP_PTButton buttonWithType:UIButtonTypeCustom];
//		[self.contentView addSubview:shanchuBtn];
////----------------------------------------------bianpinghua by sichuanlin
////        [shanchuBtn loadButonImage:@"TYD960.png" LabelName:@"删除"];
//        [shanchuBtn loadButonImage:@"tongyongxuanzhong.png" LabelName:@"删除"];
//        
//		[shanchuBtn addTarget:self action:@selector(ShanChu) forControlEvents:UIControlEventTouchUpInside];
//		shanchuBtn.frame =CGRectMake(234, 3, 50, 27);
//		shanchuBtn.hidden = YES;
				
//		fuShiLabel = [[UILabel alloc] init];
//		[self.contentView addSubview:fuShiLabel];
//		fuShiLabel.text = @"复式";
//        fuShiLabel.textAlignment = NSTextAlignmentRight;
//        fuShiLabel.font = [UIFont systemFontOfSize:10];
//		fuShiLabel.frame =CGRectMake(175, 7, 60, 19);
//		fuShiLabel.backgroundColor = [UIColor clearColor];
//		[fuShiLabel release];
		
		zhuShuLabel = [[UILabel alloc] init];
		[self.contentView addSubview:zhuShuLabel];
//		zhuShuLabel.frame =CGRectMake(170, 7, 110, 19);
        zhuShuLabel.frame =CGRectMake(170+20-20, 7+5, 110+20, 19);
        
		zhuShuLabel.textAlignment = NSTextAlignmentRight;
		zhuShuLabel.backgroundColor = [UIColor clearColor];
        zhuShuLabel.font = [UIFont systemFontOfSize:12];
		[zhuShuLabel release];
		//[shanchuBtn addTarget:self action:@selector forControlEvents:UIControlEventTouchUpInside];
        // Initialization code.
        
//        shanchuButton=[CP_PTButton buttonWithType:UIButtonTypeCustom];
//        [self.contentView addSubview:shanchuButton];
//        [shanchuButton addTarget:self action:@selector(ShanChu) forControlEvents:UIControlEventTouchUpInside];
//        [shanchuButton loadButonImage:@"shanchuhong.png" LabelName:@"删除"];
//        shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
//        
//        UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//        [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//        [self.contentView addGestureRecognizer:recognizer1];
//        [recognizer1 release];
//        UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//        [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
//        [self.contentView addGestureRecognizer:recognizer2];
//        [recognizer2 release];
        UIButton *shanchu=[UIButton buttonWithType:UIButtonTypeCustom];
//        shanchu.frame=CGRectMake(10, 3, 28, 28);
        shanchu.frame=CGRectMake(4, 2, 40, 40);
        shanchu.backgroundColor=[UIColor clearColor];
        [shanchu addTarget:self action:@selector(ShanChu) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:shanchu];
        
        UIImageView *shanchuIma=[[UIImageView alloc]init];
        shanchuIma.frame=CGRectMake(11, 11, 18, 18);
        shanchuIma.backgroundColor=[UIColor clearColor];
        shanchuIma.image=[UIImage imageNamed:@"touzhushanchu.png"];
        [shanchu addSubview:shanchuIma];
        [shanchuIma release];
    }
    return self;
}
//-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
//{
//    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
//    {
//        zhuShuLabel.hidden=YES;
//        NSLog(@"左");
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:.2];
//        [UIView setAnimationDelegate:self];
//        shanchuButton.frame=CGRectMake(320-65, 0, 65, backImage.frame.size.height);
//        [UIView commitAnimations];
//    }
//    else if(recognizer.direction == UISwipeGestureRecognizerDirectionRight)
//    {
//        zhuShuLabel.hidden=NO;
//        NSLog(@"右");
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:.2];
//        [UIView setAnimationDelegate:self];
//        shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
//        [UIView commitAnimations];
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)ShanChu{
	[shuangseqiuCellDelegate deleteCell:self];
}

- (NSString *) changePuke:(NSString *)puke {
    NSArray *array = [puke componentsSeparatedByString:@","];
    NSMutableArray *ballArray = [NSMutableArray array];
    for (NSString *strBall in array) {
        NSInteger num = [strBall intValue];
        if (self.modeType == KuaiLePuKeTongHua || self.modeType == KuaiLePuKeTongHuaShun) {
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"黑桃"];
            }
            else if ([strBall isEqualToString:@"02"]) {
                [ballArray addObject:@"红桃"];
            }
            else if ([strBall isEqualToString:@"03"]) {
                [ballArray addObject:@"梅花"];
            }
            else if ([strBall isEqualToString:@"04"]) {
                [ballArray addObject:@"方块"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if (self.modeType >= KuaiLePuKeRen1 && self.modeType <= KuaiLePuKeRen6) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d",(int)num]];
            }
            else if (num == 1) {
                [ballArray addObject:@"A"];
            }
            else if (num == 11) {
                [ballArray addObject:@"J"];
            }
            else if (num == 12) {
                [ballArray addObject:@"Q"];
            }
            else if (num == 13) {
                [ballArray addObject:@"K"];
            }
        }
        else if (self.modeType == KuaiLePuKeDuiZi) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d",(int)num,(int)num]];
            }
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"AA"];
            }
            else if ([strBall isEqualToString:@"11"]) {
                [ballArray addObject:@"JJ"];
            }
            else if ([strBall isEqualToString:@"12"]) {
                [ballArray addObject:@"QQ"];
            }
            else if ([strBall isEqualToString:@"13"]) {
                [ballArray addObject:@"KK"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if (self.modeType == KuaiLePuKeBaoZi) {
            if (num > 1 && num < 11) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d%d",(int)num,(int)num,(int)num]];
            }
            if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"AAA"];
            }
            else if ([strBall isEqualToString:@"11"]) {
                [ballArray addObject:@"JJJ"];
            }
            else if ([strBall isEqualToString:@"12"]) {
                [ballArray addObject:@"QQQ"];
            }
            else if ([strBall isEqualToString:@"13"]) {
                [ballArray addObject:@"KKK"];
            }
            else if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
        }
        else if (self.modeType == KuaiLePuKeShunZi) {
            if ([strBall isEqualToString:@"00"]) {
                [ballArray addObject:@"包选"];
            }
            else if ([strBall isEqualToString:@"01"]) {
                [ballArray addObject:@"A23"];
            }
            else if (num >= 1 && num <= 8) {
                [ballArray addObject:[NSString stringWithFormat:@"%d%d%d",(int)num,(int)num + 1,(int)num + 2]];
            }
            else if (num == 9) {
                [ballArray addObject:@"910J"];
            }
            else if (num == 10) {
                [ballArray addObject:@"10JQ"];
            }
            else if (num == 11) {
                [ballArray addObject:@"JQK"];
            }
            else if (num == 12) {
                [ballArray addObject:@"QKA"];
            }
        }
    }
    if (self.modeType >= KuaiLePuKeRen1 && self.modeType <= KuaiLePuKeRen6) {
        return [ballArray componentsJoinedByString:@" "];
    }
    return [ballArray componentsJoinedByString:@" "];
}


//- (void)changeShanChu:(UIButton *)send {
//	send.selected = !send.selected;
//	shanchuBtn.hidden = !send.selected;
//	zhuShuLabel.hidden = send.selected;
//    fuShiLabel.hidden = send.selected;
//}

- (NSString *)changeModetypeToString:(ModeTYPE)mode ByLottroy:(LotteryTYPE)_lotteryType {
    if (_lotteryType == TYPE_HappyTen) {
        if (mode == HappyTen1Shu) {
            return @"选一数投";
        }
        else if (mode == HappyTen1Hong){
            return @"选一红投";
        }
        else if (mode == HappyTenRen2){
            return @"任选二";
        }
        else if (mode == HappyTenRen2Zhi){
            return @"选二连直";
        }
        else if (mode == HappyTenRen2Zu){
            return @"选二连组";
        }
        else if (mode == HappyTenRen3){
            return @"任选三";
        }
        else if (mode == HappyTenRen3Zhi){
            return @"选三前直";
        }
        else if (mode == HappyTenRen3Zu){
            return @"选三前组";
        }
        else if (mode == HappyTenRen4){
            return @"任选四";
        }
        else if (mode == HappyTenRen5){
            return @"任选五";
        }
        else if (mode == HappyTenDa){
            return @"猜大数";
        }
        else if (mode == HappyTenDan){
            return @"猜单数";
        }
        else if (mode == HappyTenQuan){
            return @"猜全数";
        }
        else if (mode == HappyTenRen2DanTuo) {
            return @"任选二胆拖";
        }
        else if (mode == HappyTenRen2ZuDanTuo) {
            return @"选二连组胆拖";
        }
        else if (mode == HappyTenRen3DanTuo) {
            return @"任选三胆拖";
        }
        else if (mode == HappyTenRen3ZuDanTuo) {
            return @"选三前组胆拖";
        }
        else if (mode ==  HappyTenRen4DanTuo) {
            return @"任选四胆拖";
        }
        else if (mode ==  HappyTenRen5DanTuo) {
            return @"任选五胆拖";
        }
    }
    else if (_lotteryType == TYPE_SHISHICAI){
        if (mode == SSCsanxingfushi) {
            return @"三星复式";
        }
        else if (mode == SSCdaxiaodanshuang){
            return @"大小单双";
        }
        else if (mode == SSCyixingfushi){
            return @"一星复式";
        }
        else if (mode == SSCerxingfushi){
            return @"二星复式";
        }
        else if (mode == SSCerxingzuxuan){
            return @"二星组选";
        }
        else if (mode == SSCerxingzuxuandantuo){
            return @"二星组选胆拖";
        }
        else if (mode == SSCsixingfushi){
            return @"四星复式";
        }
        else if (mode == SSCwuxingfushi){
            return @"五星复式";
        }
        else if (mode == SSCwuxingtongxuan){
            return @"五星通选";
        }
        else if (mode == SSCrenxuanyi){
            return @"任选一";
        }
        else if (mode == SSCrenxuaner){
            return @"任选二";
        }
        else if (mode == SSCrenxuansan){
            return @"任选三";
        }
    }
    else if (_lotteryType == TYPE_CQShiShi){
        if (mode == SSCsanxingfushi) {
            return @"三星直选";
        }
        else if (mode == SSCdaxiaodanshuang){
            return @"大小单双";
        }
        else if (mode == SSCyixingfushi){
            return @"一星直选";
        }
        else if (mode == SSCerxingfushi){
            return @"二星直选";
        }
        else if (mode == SSCerxingzuxuan){
            return @"二星组选";
        }
        else if (mode == SSCerxingzuxuandantuo){
            return @"二星组选胆拖";
        }
        else if (mode == SSCsixingfushi){
            return @"四星复式";
        }
        else if (mode == SSCwuxingfushi){
            return @"五星直选";
        }
        else if (mode == SSCwuxingtongxuan){
            return @"五星通选";
        }
        else if (mode == SSCrenxuanyi){
            return @"任选一";
        }
        else if (mode == SSCrenxuaner){
            return @"任选二";
        }
        else if (mode == SSCrenxuansan){
            return @"任选三";
        }
    }
    else if (_lotteryType == TYPE_KuaiSan || _lotteryType == TYPE_JSKuaiSan || _lotteryType == TYPE_HBKuaiSan || _lotteryType == TYPE_JLKuaiSan || _lotteryType == TYPE_AHKuaiSan) {
        if (mode == KuaiSanHezhi) {
            return @"和值";
        }
        else if (mode == KuaiSanSantongTong){
            return @"三同号通选";
        }
        else if (mode == KuaiSanSantongDan){
            return @"三同号单选";
        }
        else if (mode == KuaiSanErtongDan){
            return @"二同号单选";
        }
        else if (mode == KuaiSanErTongFu){
            return @"二同号复选";
        }
        else if (mode == KuaiSanSanBuTong){
            return @"三不同号";
        }
        else if (mode == KuaiSanErButong){
            return @"二不同号";
        }
        else if (mode == KuaiSanSanLianTong){
            return @"三连号通选";
        }
        else if (mode == KuaiSanSanBuTongDanTuo) {
            return @"三不同号胆拖";
        }
        else if (mode == KuaiSanErBuTongDanTuo) {
            return @"二不同号胆拖";
        }
    }
    else if (_lotteryType == TYPE_KuaiLePuKe) {
        if (mode == KuaiLePuKeRen1) {
            return @"任一";
        }
        else if (mode == KuaiLePuKeRen2){
            return @"任二";
        }
        else if (mode == KuaiLePuKeRen3){
            return @"任三";
        }
        else if (mode == KuaiLePuKeRen4){
            return @"任四";
        }
        else if (mode == KuaiLePuKeRen5){
            return @"任五";
        }
        else if (mode == KuaiLePuKeRen6){
            return @"任六";
        }
        else if (mode == KuaiLePuKeTongHua){
            return @"同花";
        }
        else if (mode == KuaiLePuKeTongHuaShun){
            return @"同花顺";
        }
        else if (mode == KuaiLePuKeShunZi){
            return @"顺子";
        }
        else if (mode == KuaiLePuKeBaoZi){
            return @"豹子";
        }
        else if (mode == KuaiLePuKeDuiZi){
            return @"对子";
        }
    }
    
    return nil;
}

- (void)LoadData:(NSString *)info {
//	jianBtn.selected = NO;
//	shanchuBtn.hidden = YES;
	zhuShuLabel.hidden = NO;
    NSInteger hightY = 6;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        hightY = 7;
//    }
    
    
	for (UILabel *v in self.contentView.subviews) {
		if ([v isKindOfClass:[UILabel class]]) {
			v.text = nil;
		}
        else if (v.tag == 99) {
            v.hidden = YES;
        }
        
	}

	if ([info length]>3) {
		info = [info substringFromIndex:3];
	}
    if (self.lotteryType == TYPE_DALETOU) {
        NSInteger num = [GC_LotteryUtil getBets:info LotteryType:TYPE_DALETOU ModeType:modeType];
        zhuShuLabel.text = [NSString stringWithFormat:@"%d注",(int)num];
        if (modeType == Daletoudantuo) {
            zhuShuLabel.text = [NSString stringWithFormat:@"胆拖%d注",(int)num];
            fuShiLabel.hidden =YES;
        }
        else if (num > 1) {
            zhuShuLabel.text = [NSString stringWithFormat:@"复式%d注",(int)num];
            fuShiLabel.hidden =YES;
        }
        else {
            zhuShuLabel.text = [NSString stringWithFormat:@"单式%d注",(int)num];
            fuShiLabel.hidden = YES;
        }
        NSArray *array = [info componentsSeparatedByString:@"_:_"];
        if ([array count] >1) {
            NSArray *redArray =nil,*blueArray=nil,*redTouArray=nil,*blueTouArray=nil;
            NSArray *array1 = [[array objectAtIndex:0] componentsSeparatedByString:@"_,_"] ;
            redArray = [[array1 objectAtIndex:0] componentsSeparatedByString:@"_"];
            if ([array1 count]>1) {
                NSString *num = [array1 objectAtIndex:1];
                //num = [NSString stringWithFormat:@",_%@",(int)num];
                redTouArray = [num componentsSeparatedByString:@"_"];
            }
            NSArray *array2 = [[array objectAtIndex:1] componentsSeparatedByString:@"_,_"] ;
            NSString *buleNum = [array2 objectAtIndex:0];
            blueArray = [buleNum componentsSeparatedByString:@"_"];
            if ([array2 count]>1) {
                NSString *num = [array2 objectAtIndex:1];
                //num = [NSString stringWithFormat:@",_%@",(int)num];
                blueTouArray = [num componentsSeparatedByString:@"_"];
            }
            
            for (int i = 0; i<[redArray count]; i++) {
                int a = i/7,b= i%7;
                UILabel *label;
                label = (UILabel *)[self.contentView viewWithTag:100+i];
                if (!label) {
                    label = [[UILabel alloc] init];
                    label.backgroundColor = [UIColor clearColor];
                    label.tag = 100+i;
//                    label.frame = CGRectMake(50+23*b,hightY+23*a, 23, 23);
//                    label.frame = CGRectMake(20+23*b,hightY+23*a, 23, 23);
                    label.frame = CGRectMake(40+23*b+5,hightY+23*a+5, 23, 23);
//                    label.font=[UIFont systemFontOfSize:14];
                    [self.contentView addSubview:label];
                    [label release];
                }
                label.textColor = [UIColor redColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = [redArray objectAtIndex:i];
                if (i == 0 && self.modeType ==Daletoudantuo) {
                    UILabel  *zuolabel = (UILabel *)[self.contentView viewWithTag:1000];
                    if (!zuolabel) {
                        zuolabel = [[UILabel alloc] init];
                        [self.contentView addSubview:zuolabel];
                        zuolabel.backgroundColor = [UIColor clearColor];
                        
                        zuolabel.tag = 1000;
                        zuolabel.textColor = [UIColor redColor];
                        zuolabel.textAlignment = NSTextAlignmentCenter;
                        [zuolabel release];
                    }
//                    zuolabel.frame = CGRectMake(45+23*b,hightY+23*a, 10, 23);
//                    zuolabel.frame = CGRectMake(15+23*b,hightY+23*a, 10, 23);
                    zuolabel.frame = CGRectMake(15+23*b+20+5,hightY+23*a+5, 10, 23);
//                    zuolabel.font=[UIFont systemFontOfSize:14];
                    if ([array1 count] == 2) {
                        zuolabel.text = @"[";
                    }
                    else {
                        zuolabel.text = @"";
                    }
                    
                    
                }
                
                if (i == [redArray count] -1 && self.modeType ==Daletoudantuo) {
                    UILabel  *youLabel = (UILabel *)[self.contentView viewWithTag:1001];
                    if (!youLabel) {
                        youLabel = [[UILabel alloc] init];
                        [self.contentView addSubview:youLabel];
                        youLabel.backgroundColor = [UIColor clearColor];
                        
                        youLabel.tag = 1001;
                        youLabel.textColor = [UIColor redColor];
                        youLabel.textAlignment = NSTextAlignmentCenter;
                        [youLabel release];
                    }
//                    youLabel.frame = CGRectMake(68+23*b,hightY+23*a, 10, 23);
//                    youLabel.frame = CGRectMake(38+23*b,hightY+23*a, 10, 23);
                    youLabel.frame = CGRectMake(38+23*b+20+5,hightY+23*a+5, 10, 23);
//                    youLabel.font=[UIFont systemFontOfSize:14];
                    
                    if ([array1 count] == 2) {
                        youLabel.text = @"]";
                    }
                    else {
                        youLabel.text = @"";
                    }
                    
                }
            }
            for (int i = 0; i<[redTouArray count]; i++) {
                int a = (i +(int)[redArray count])/7,b= (i +(int)[redArray count])%7;
                UILabel *label;
                label = (UILabel *)[self.contentView viewWithTag:100+i+[redArray count]];
                if (!label) {
                    label = [[UILabel alloc] init];
                    label.tag = 100+i+[redArray count];
                    label.backgroundColor = [UIColor clearColor];
                    
                    [self.contentView addSubview:label];
                    [label release];
                }
//                label.frame = CGRectMake(50+23*b,hightY+23*a, 23, 23);
//                label.frame = CGRectMake(20+23*b,hightY+23*a, 23, 23);
                label.frame = CGRectMake(20+23*b+20+5,hightY+23*a+5, 23, 23);
//                label.font=[UIFont systemFontOfSize:14];
                label.textColor = [UIColor redColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = [redTouArray objectAtIndex:i];
            }
            
            for (int i = 0; i<[blueArray count]; i++) {
                int a = (i +(int)[redArray count] +(int)[redTouArray count])/7,b= (i +(int)[redArray count]+(int)[redTouArray count])%7;
                UILabel *label;
                label = (UILabel *)[self.contentView viewWithTag:100+i+[redArray count]+[redTouArray count]];
                if (!label) {
                    label = [[UILabel alloc] init];
                    label.backgroundColor = [UIColor clearColor];
                    label.tag = 100+i+[redArray count]+[redTouArray count];
                    
                    [self.contentView addSubview:label];
                    [label release];
                }
//                label.frame = CGRectMake(50+23*b, hightY+23*a, 23, 23);
//                label.frame = CGRectMake(20+23*b, hightY+23*a, 23, 23);
                label.frame = CGRectMake(20+23*b+20+5, hightY+23*a+5, 23, 23);
//                label.font=[UIFont systemFontOfSize:14];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor blueColor];
                label.text = [blueArray objectAtIndex:i];
                
                if (i == 0&& self.modeType ==Daletoudantuo) {
                    UILabel  *zuolabel = (UILabel *)[self.contentView viewWithTag:1002];
                    if (!zuolabel) {
                        zuolabel = [[UILabel alloc] init];
                        [self.contentView addSubview:zuolabel];
                        zuolabel.tag = 1002;
                        zuolabel.backgroundColor = [UIColor clearColor];
                        
                        zuolabel.textColor = [UIColor blueColor];
                        zuolabel.textAlignment = NSTextAlignmentCenter;
                        [zuolabel release];
                    }
//                    zuolabel.frame = CGRectMake(45+23*b,hightY+23*a, 10, 23);
//                    zuolabel.frame = CGRectMake(15+23*b,hightY+23*a, 10, 23);
                    zuolabel.frame = CGRectMake(15+23*b+20+5,hightY+23*a+5, 10, 23);
//                    zuolabel.font=[UIFont systemFontOfSize:14];
                    if ([array2 count] == 2) {
                        zuolabel.text = @"[";
                    }
                    else {
                        zuolabel.text = @"";
                    }
                    
                    
                    
                }
                
                if (i == [blueArray count] -1&& self.modeType ==Daletoudantuo) {
                    UILabel  *youLabel = (UILabel *)[self.contentView viewWithTag:1003];
                    if (!youLabel) {
                        youLabel = [[UILabel alloc] init];
                        [self.contentView addSubview:youLabel];
                        youLabel.tag = 1003;
                        youLabel.backgroundColor = [UIColor clearColor];
                        
                        youLabel.textColor = [UIColor blueColor];
                        youLabel.textAlignment = NSTextAlignmentCenter;
                        [youLabel release];
                    }
//                    youLabel.frame = CGRectMake(68+23*b,hightY+23*a, 10, 23);
//                    youLabel.frame = CGRectMake(38+23*b,hightY+23*a, 10, 23);
                    youLabel.frame = CGRectMake(38+23*b+20+5,hightY+23*a+5, 10, 23);
//                    youLabel.font=[UIFont systemFontOfSize:14];
                    
                    if ([array2 count] == 2) {
                        youLabel.text = @"]";
                    }
                    else {
                        youLabel.text = @"";
                    }
                    
                }
            }
            
            for (int i = 0; i<[blueTouArray count]; i++) {
                int a = (i +(int)[redArray count]+(int)[redTouArray count]+(int)[blueArray count])/7,b= (i +(int)[redArray count] + (int)[redTouArray count]+(int)[blueArray count])%7;
                UILabel *label;
                label = (UILabel *)[self.contentView viewWithTag:100+i+[redArray count]+[redTouArray count]+[blueArray count]];
                if (!label) {
                    label = [[UILabel alloc] init];
                    label.backgroundColor = [UIColor clearColor];
                    label.tag = 100+i+[redArray count]+[redTouArray count]+[blueArray count];
//                    label.frame = CGRectMake(50+23*b, hightY+23*a, 23, 23);
//                    label.frame = CGRectMake(20+23*b, hightY+23*a, 23, 23);
                    label.frame = CGRectMake(20+23*b+20+5, hightY+23*a+5, 23, 23);
//                    label.font=[UIFont systemFontOfSize:14];
                    [self.contentView addSubview:label];
                    [label release];
                }
                label.textAlignment = NSTextAlignmentCenter;
                label.text = [blueTouArray objectAtIndex:i];
                label.textColor = [UIColor blueColor];
                
            }
//            backImage.frame = CGRectMake(47, 2, 240, 31+([redArray count]+[redTouArray count]+[blueArray count] + [blueTouArray count] -  1)/7 * 23);
            backImage.frame = CGRectMake(0, 0, 320, 31+([redArray count]+[redTouArray count]+[blueArray count] + [blueTouArray count] -  1)/7 * 23+4+10);
            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
        }
    }
    else if (self.lotteryType == TYPE_3D) {

        if ([info length] == 3 && (modeType == ThreeDzhixuanfushi || modeType == ThreeDzusandanshi)) {
            NSRange range1 = {0,1};
            NSRange range2 = {1,1};
            NSRange range3 = {2,1};
            
            info = [NSString stringWithFormat:@"%@,%@,%@",[info substringWithRange:range1],[info substringWithRange:range2],[info substringWithRange:range3]];
        }
        NSInteger num = [GC_LotteryUtil getBets:info LotteryType:lotteryType ModeType:modeType];
        zhuShuLabel.text = [NSString stringWithFormat:@"%d注",(int)num];
        fuShiLabel.hidden = NO;
        
        if (modeType == ThreeDzhixuanfushi) {
            NSArray *array = [info componentsSeparatedByString:@","];
            NSLog(@"%@",array);
//            if ([array count] == 1) {
            if (num == 1) {
                zhuShuLabel.text = @"直选 单式 1注";
            }
            else {
                zhuShuLabel.text = [NSString stringWithFormat:@"直选 复式 %d注",(int)num];
            }
            
        }
        else if (modeType == ThreeDzusandanshi) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组三 单式 %d注",(int)num];
        }
        else if (modeType == ThreeDzusanfushi) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组三 复式 %d注",(int)num];
        }
        else if (modeType == ThreeDzuliufushi) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组六 复式 %d注",(int)num];
            if(num == 1)
            {
                zhuShuLabel.text = [NSString stringWithFormat:@"组六 单式 %d注",(int)num];
            }
            else
            {
                zhuShuLabel.text = [NSString stringWithFormat:@"组六 复式 %d注",(int)num];
            }
        }
        else if (modeType == ThreeDzusanDantuo) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组三胆拖    %d注",(int)num];
            info = [info stringByReplacingOccurrencesOfString:@"%03#" withString:@","];
        }
        else if (modeType == ThreeDzuliuDantuo) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组六胆拖    %d注",(int)num];
            info = [info stringByReplacingOccurrencesOfString:@"%03#" withString:@","];
        }
        else if (modeType == ThreeDzhixuanhezhi || modeType == ThreeDzusanHezhi || modeType == ThreeDzuliuHezhi) {
            if (modeType == ThreeDzhixuanhezhi) {
                zhuShuLabel.text = [NSString stringWithFormat:@"直选和值    %d注",(int)num];
            }
            else if (modeType == ThreeDzusanHezhi) {
                zhuShuLabel.text = [NSString stringWithFormat:@"组三和值    %d注",(int)num];
            }
            else if (modeType == ThreeDzuliuHezhi) {
                zhuShuLabel.text = [NSString stringWithFormat:@"组六和值    %d注",(int)num];
            }
            
            fuShiLabel.text = @"";
            info = [info stringByReplacingOccurrencesOfString:@"%04#" withString:@","];
        }
        
        UILabel *label = (UILabel *)[self.contentView viewWithTag:101];
        if (!label) {
            label = [[UILabel alloc] init];
            label.tag = 101;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:14];
//            label.frame = CGRectMake(50, hightY, 130, 100);
//            label.frame = CGRectMake(20, hightY, 160, 100);
            label.frame = CGRectMake(20+20+5, hightY+5, 170, 100);
            label.numberOfLines = 0;
            [self.contentView addSubview:label];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor redColor];
            [label release];
            
            
        }
        NSLog(@"%@",info);
        
//        if(hezhi)
        if(modeType == ThreeDzhixuanhezhi || modeType == ThreeDzusanHezhi || modeType == ThreeDzuliuHezhi)
        {
            label.text = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
        else
        {
            NSString *s1=[info substringToIndex:1];
            for(NSInteger i=1 ;i<info.length;i++)
            {
                NSRange r1={i,1};
                s1 = [NSString stringWithFormat:@"%@^%@",s1,[info substringWithRange:r1]];
                NSLog(@"%@",s1);
            }
            info = s1;
            
            info = [info stringByReplacingOccurrencesOfString:@"^,^" withString:@","];
            //
            NSRange asd=[info rangeOfString:@"^"];
            if(asd.length)
            {
                info = [info stringByReplacingOccurrencesOfString:@"^" withString:@" "];
                info = [info stringByReplacingOccurrencesOfString:@"," withString:@" | "];
            }
            else
            {
                info = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
            }
            label.text = info;
        }
        
//        NSString *s1=[info substringToIndex:1];
//        for(NSInteger i=1 ;i<info.length;i++)
//        {
//            NSRange r1={i,1};
//            s1 = [NSString stringWithFormat:@"%@^%@",s1,[info substringWithRange:r1]];
//            NSLog(@"%@",s1);
//        }
//        info = s1;
//        
//        info = [info stringByReplacingOccurrencesOfString:@"^,^" withString:@","];
//        //
//        NSRange asd=[info rangeOfString:@"^"];
//        if(asd.length)
//        {
//            info = [info stringByReplacingOccurrencesOfString:@"^" withString:@" "];
//            info = [info stringByReplacingOccurrencesOfString:@"," withString:@"|"];
//        }
//        else
//        {
//            info = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
//        }
//        label.text = info;
        
        
//        label.text = [info stringByReplacingOccurrencesOfString:@"," withString:@"|"];
        
        label.textAlignment = NSTextAlignmentLeft;
        CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
        NSLog(@"%f",size.height);
//        if (size.height >35) {
        if (size.height >30) {
//            label.frame = CGRectMake(50, 5, 130, size.height);
//            label.frame = CGRectMake(20, 5, 160, size.height);
            label.frame = CGRectMake(20+20+5, 5, 170, size.height);
//            backImage.frame = CGRectMake(47, 2, 240, size.height + 8);
            backImage.frame = CGRectMake(0, 0, 320, size.height + 8+4);
            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
        }
//        else if(size.height>20)
//        {
//            label.frame = CGRectMake(20+20+5, 5+5, 190, size.height);
//            backImage.frame = CGRectMake(0, 0, 320, (NSInteger)size.height + 8+4+9);
//            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//        }
        else {
//            label.frame = CGRectMake(50, 5, 130, 20);
//            label.frame = CGRectMake(20, 5, 160, 20);
            label.frame = CGRectMake(20+20+5, 5+5, 170, 20);
//            backImage.frame = CGRectMake(47, 2, 240, 30);
            backImage.frame = CGRectMake(0, 0, 320, 30+4+11);
            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
        }
        
    }else if (self.lotteryType == TYPE_PAILIE3) {
        NSInteger num = [GC_LotteryUtil getBets:info LotteryType:lotteryType ModeType:modeType];
        
        zhuShuLabel.text = [NSString stringWithFormat:@"%d注",(int)num];
        fuShiLabel.hidden = YES;
        
        NSString *s1=[info substringToIndex:1];
        NSRange asds=[info rangeOfString:@"%04#"];
        if(asds.length || info.length == 2)
        {
            info = [info stringByReplacingOccurrencesOfString:@"%04#" withString:@" "];
        }
        else
        {
            for(NSInteger i=1 ;i<info.length;i++)
            {
                NSRange r1={i,1};
                s1 = [NSString stringWithFormat:@"%@^%@",s1,[info substringWithRange:r1]];
                NSLog(@"%@",s1);
            }
            info = s1;
        }
        
        info = [info stringByReplacingOccurrencesOfString:@"^*^" withString:@"*"];
        
        info = [info stringByReplacingOccurrencesOfString:@"*" withString:@","];
//        
        NSRange asd=[info rangeOfString:@"^"];
        if(asd.length)
        {
            info = [info stringByReplacingOccurrencesOfString:@"^" withString:@" "];
        }
        else
        {
            info = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
        
        NSLog(@"%@",info);
        
//        info = [info stringByReplacingOccurrencesOfString:@"*" withString:@","];
        
        UILabel *label = (UILabel *)[self.contentView viewWithTag:101];
        if (!label) {
            label = [[UILabel alloc] init];
            label.tag = 101;
            label.backgroundColor = [UIColor clearColor];
//            label.frame = CGRectMake(50, hightY, 130, 100);
//            label.frame = CGRectMake(20, hightY, 160, 100);
            label.frame = CGRectMake(20+20+5, hightY+5, 170, 100);
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:label];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor redColor];
            [label release];
            
            
        }
        NSLog(@"%@",info);
        if (modeType == Array3zhixuanfushi) {
            NSArray *array = [info componentsSeparatedByString:@","];
            if ([array count] == 1) {
                zhuShuLabel.text = @"直选1注";
            }
            else {
                zhuShuLabel.text = [NSString stringWithFormat:@"直选%d注",(int)num];
            }
            label.text = [info stringByReplacingOccurrencesOfString:@"," withString:@" | "];
        }
        else if (modeType == Array3zusanfushi) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组三复式%d注",(int)num];
            label.text = info;
        }
        else if (modeType == Array3zuliufushi) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组六复式%d注",(int)num];
            label.text = info;
        }
        else if (modeType == Array3zuxuandanshi) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组选单式%d注",(int)num];
            label.text = [info stringByReplacingOccurrencesOfString:@"," withString:@" | "];
        }
        else if (modeType == Array3zusandantuo) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组三胆拖    %d注",(int)num];
            label.text = [info stringByReplacingOccurrencesOfString:@"%03#" withString:@"|"];
        }
        else if (modeType == Array3zuliudantuo) {
            zhuShuLabel.text = [NSString stringWithFormat:@"组六胆拖    %d注",(int)num];
            label.text = [info stringByReplacingOccurrencesOfString:@"%03#" withString:@"|"];
        }
        
        else if (modeType == Array3zhixuanHezhi || modeType == Array3zusanHezhi || modeType == Array3zuliuHezhi) {
            if (modeType == Array3zhixuanHezhi) {
                zhuShuLabel.text = [NSString stringWithFormat:@"直选和值    %d注",(int)num];
            }
            else if (modeType == Array3zusanHezhi) {
                zhuShuLabel.text = [NSString stringWithFormat:@"组三和值    %d注",(int)num];
            }
            else if (modeType == Array3zuliuHezhi) {
                zhuShuLabel.text = [NSString stringWithFormat:@"组六和值    %d注",(int)num];
            }
            label.text = [info stringByReplacingOccurrencesOfString:@"%04#" withString:@"|"];
        }

        
        label.textAlignment = NSTextAlignmentLeft;
//        CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
        CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
        NSLog(@"%f",size.height);
        
        
        
        
//        if (size.height >30) {
        if (size.height >30) {
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//                label.frame = CGRectMake(50, 6, 130, size.height);
//            label.frame = CGRectMake(20, 6, 160, size.height);
            label.frame = CGRectMake(20+20+5, 6, 170, size.height);
//            }else{
//                label.frame = CGRectMake(50, 5, 130, size.height);
//            }
//            backImage.frame = CGRectMake(47, 2, 240, size.height + 8);
            backImage.frame = CGRectMake(0, 0, 320, size.height + 8+4);
            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
            
        }
        else {
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//                label.frame = CGRectMake(50, 6, 130, 20);
//            label.frame = CGRectMake(20, 6, 160, 20);
            label.frame = CGRectMake(20+20+5, 6+5, 170, 20);
//            }else{
//               label.frame = CGRectMake(50, 5, 130, 20);
//            }
            
//            backImage.frame = CGRectMake(47, 2, 240, 30);
            backImage.frame = CGRectMake(0, 0, 320, 30+4+11);
            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
            
        }
        
    }else if(self.lotteryType == TYPE_PAILIE5||self.lotteryType == TYPE_QIXINGCAI){
        NSInteger num = [GC_LotteryUtil getBets:info LotteryType:lotteryType ModeType:modeType];
        
        zhuShuLabel.text = [NSString stringWithFormat:@"%d注",(int)num];
        fuShiLabel.hidden = YES;
        
        NSLog(@"%@",info);
        NSString *s1=[info substringToIndex:1];
        for(NSInteger i=1 ;i<info.length;i++)
        {
            NSRange r1={i,1};
            s1 = [NSString stringWithFormat:@"%@^%@",s1,[info substringWithRange:r1]];
            NSLog(@"%@",s1);
        }
        info = s1;
        info = [info stringByReplacingOccurrencesOfString:@"^*^" withString:@"*"];
        info = [info stringByReplacingOccurrencesOfString:@"*" withString:@","];
        
        NSRange asd=[info rangeOfString:@"^"];
        if(asd.length)
        {
            info = [info stringByReplacingOccurrencesOfString:@"^" withString:@" "];
            info = [info stringByReplacingOccurrencesOfString:@"," withString:@" | "];
        }
        else
        {
            info = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
        
        
        if (self.lotteryType == TYPE_PAILIE5) {
            
            if ([info length] == 9) {
                zhuShuLabel.text = [NSString stringWithFormat:@"单式%d注",(int)num];
            }else{
                zhuShuLabel.text = [NSString stringWithFormat:@"复式%d注",(int)num];
            }
        }else if(self.lotteryType== TYPE_QIXINGCAI){
            if ([info length] == 13) {
                zhuShuLabel.text = [NSString stringWithFormat:@"单式%d注",(int)num];
            }else{
                zhuShuLabel.text = [NSString stringWithFormat:@"复式%d注",(int)num];
            }
        }
        
        info = [info stringByReplacingOccurrencesOfString:@"*" withString:@","];
        
        UILabel *label = (UILabel *)[self.contentView viewWithTag:101];
        if (!label) {
            label = [[UILabel alloc] init];
            label.tag = 101;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:14];
//            label.frame = CGRectMake(50, hightY, 130, 200);
//            label.frame = CGRectMake(20, hightY, 160, 200);
            label.frame = CGRectMake(20+20+5, hightY+5, 190, 200);
            label.numberOfLines = 0;
            [self.contentView addSubview:label];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor redColor];
            [label release];
            
            
        }
//        label.text = [info stringByReplacingOccurrencesOfString:@"," withString:@"|"];
        label.text = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
        label.textAlignment = NSTextAlignmentLeft;
    
        CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
//        if (size.height >30) {
        if (size.height >30) {
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//                label.frame = CGRectMake(50, 6, 130, size.height);
//            label.frame = CGRectMake(20, 6, 160, size.height);
            label.frame = CGRectMake(20+20+5, 6+5, 190, size.height);
//            }else{
//                label.frame = CGRectMake(50, 5, 130, size.height);
//            }
            
//            backImage.frame = CGRectMake(47, 2, 240, size.height + 8);
            backImage.frame = CGRectMake(0, 0, 320, size.height + 8+4+8);
            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
            
        }
        else {
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//                label.frame = CGRectMake(50, 6, 130, 20);
//            label.frame = CGRectMake(20, 6, 160, 20);
            label.frame = CGRectMake(20+20+5, 6+5, 190, 20);
//            }else{
//                    label.frame = CGRectMake(50, 5, 130, 20);
//            }
            
//            backImage.frame = CGRectMake(47, 2, 240, 30);
            backImage.frame = CGRectMake(0, 0, 320, 30+4+11);
            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
            
        }
        
        
    }
    else if(self.lotteryType == TYPE_22XUAN5) {
        NSInteger num = [GC_LotteryUtil getBets:info LotteryType:lotteryType ModeType:modeType];
        zhuShuLabel.text = [NSString stringWithFormat:@"%d注",(int)num];
        if (num > 1) {
            zhuShuLabel.text = [NSString stringWithFormat:@"复式%d注",(int)num];
            fuShiLabel.hidden =NO;
        }
        else {
            zhuShuLabel.text = [NSString stringWithFormat:@"单式%d注",(int)num];
            fuShiLabel.hidden = YES;
        }
        
        NSArray *array = [info componentsSeparatedByString:@"+"];
        if ([array count]==1) {
            NSArray *redArray = [[array objectAtIndex:0] componentsSeparatedByString:@"*"];
            
            for (int i = 0; i<[redArray count]; i++) {
                int a = i/7,b= i%7;
                UILabel *label;
                label = (UILabel *)[self.contentView viewWithTag:100+i];
                if (!label) {
                    label = [[UILabel alloc] init];
                    label.tag = 100 + i;
                    label.backgroundColor = [UIColor clearColor];
//                    label.frame = CGRectMake(50+23*b,hightY+23*a, 23, 23);
                    label.frame = CGRectMake(40+23*b,hightY+23*a, 23, 23);
                    [self.contentView addSubview:label];
                    [label release];
                }
                label.textColor = [UIColor redColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = [redArray objectAtIndex:i];
            }
//            backImage.frame = CGRectMake(47, 2, 240, 31+([redArray count]-  1)/7 * 23);
            backImage.frame = CGRectMake(0, 0, 320, 31+([redArray count]-  1)/7 * 23+4);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
            
        }
        // label.frame = CGRectMake(30, 4, 180, [label.text sizeWithFont:label.font].height);
        
    }
   else if (self.lotteryType == TYPE_7LECAI) {
       fuShiLabel.hidden = YES;
        NSInteger num = [GC_LotteryUtil getBets:info LotteryType:self.lotteryType ModeType:self.modeType];
        zhuShuLabel.text = [NSString stringWithFormat:@"%d注",(int)num];
        if (modeType == Qilecaidantuo) {
            zhuShuLabel.text = [NSString stringWithFormat:@"胆拖%d注",(int)num];
        }
        else if (num > 1) {
            zhuShuLabel.text = [NSString stringWithFormat:@"复式%d注",(int)num];
        }
        else {
            zhuShuLabel.text = [NSString stringWithFormat:@"单式%d注",(int)num];
        }
        NSArray *array = [info componentsSeparatedByString:@"_,_"];
        NSArray *redArray =nil,*redTouArray=nil;
       if ([array count] >= 1) {
           redArray = [[array objectAtIndex:0] componentsSeparatedByString:@"_"];
       }
       
        if ([array count]>1) {
            NSString *num = [array objectAtIndex:1];
            //num = [NSString stringWithFormat:@",_%@",(int)num];
            redTouArray = [num componentsSeparatedByString:@"_"];
        }
        for (int i = 0; i<[redArray count]; i++) {
            int a = i/7,b= i%7;
            UILabel *label;
            label = (UILabel *)[self.contentView viewWithTag:100+i];
            if (!label) {
                label = [[UILabel alloc] init];
                label.backgroundColor = [UIColor clearColor];
                label.tag = 100+i;
//                label.frame = CGRectMake(50+23*b,hightY+23*a, 23, 23);
//                label.frame = CGRectMake(20+23*b,hightY+23*a, 23, 23);
                label.frame = CGRectMake(20+23*b+20+5,hightY+23*a+5, 23, 23);
                label.font = [UIFont systemFontOfSize:14];
                [self.contentView addSubview:label];
                [label release];
            }
            label.textColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [redArray objectAtIndex:i];
            if (i == 0 && self.modeType ==Qilecaidantuo) {
                UILabel  *zuolabel = (UILabel *)[self.contentView viewWithTag:1000];
                if (!zuolabel) {
                    zuolabel = [[UILabel alloc] init];
                    [self.contentView addSubview:zuolabel];
                    zuolabel.backgroundColor = [UIColor clearColor];
//                    zuolabel.frame = CGRectMake(45+23*b,hightY+23*a, 10, 23);
//                    zuolabel.frame = CGRectMake(15+23*b,hightY+23*a, 10, 23);
                    zuolabel.frame = CGRectMake(15+23*b+20+5,hightY+23*a+5, 10, 23);
                    zuolabel.font = [UIFont systemFontOfSize:14];
                    zuolabel.tag = 1000;
                    zuolabel.textColor = [UIColor redColor];
                    zuolabel.textAlignment = NSTextAlignmentCenter;
                    [zuolabel release];
                }
                zuolabel.text = @"[ ";
                
            }
            
            if (i == [redArray count] -1 && self.modeType ==Qilecaidantuo) {
                UILabel  *youLabel = (UILabel *)[self.contentView viewWithTag:1001];
                if (!youLabel) {
                    youLabel = [[UILabel alloc] init];
                    [self.contentView addSubview:youLabel];
                    youLabel.backgroundColor = [UIColor clearColor];
//                    youLabel.frame = CGRectMake(68+23*b,hightY+23*a, 10, 23);
//                    youLabel.frame = CGRectMake(38+23*b,hightY+23*a, 10, 23);
                    youLabel.frame = CGRectMake(38+23*b+20+5,hightY+23*a+5, 10, 23);
                    youLabel.font = [UIFont systemFontOfSize:14];
                    youLabel.tag = 1001;
                    youLabel.textColor = [UIColor redColor];
                    youLabel.textAlignment = NSTextAlignmentCenter;
                    [youLabel release];
                }
                youLabel.text = @" ]";
                
            }
        }
        for (int i = 0; i<[redTouArray count]; i++) {
            int a = (i +(int)[redArray count])/7,b= (i +(int)[redArray count])%7;
            UILabel *label;
            label = (UILabel *)[self.contentView viewWithTag:100+i+[redArray count]];
            if (!label) {
                label = [[UILabel alloc] init];
                label.tag = 100+i+[redArray count];
                label.backgroundColor = [UIColor clearColor];
//                label.frame = CGRectMake(50+23*b,hightY+23*a, 23, 23);
//                label.frame = CGRectMake(20+23*b,hightY+23*a, 23, 23);
                label.frame = CGRectMake(20+23*b+20+5,hightY+23*a+5, 23, 23);
                label.font = [UIFont systemFontOfSize:14];
                [self.contentView addSubview:label];
                [label release];
            }
            label.textColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [redTouArray objectAtIndex:i];
        }
//        backImage.frame = CGRectMake(47, 2, 240, 31+([redArray count]+[redTouArray count] -  1)/7 * 23);
       backImage.frame = CGRectMake(0, 0, 320, 31+([redArray count]+[redTouArray count] -  1)/7 * 23+4+10);
       lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//       shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
       
    }
   else if (self.lotteryType == TYPE_SHISHICAI){
       NSInteger num = [GC_LotteryUtil getBets:[[info stringByReplacingOccurrencesOfString:@"^" withString:@""] stringByReplacingOccurrencesOfString:@"_" withString:@""] LotteryType:lotteryType ModeType:modeType];
       if (self.modeType == SSCdaxiaodanshuang) {
           info = [info stringByReplacingOccurrencesOfString:@"9" withString:@"大"];
           info = [info stringByReplacingOccurrencesOfString:@"0" withString:@"小"];
           info = [info stringByReplacingOccurrencesOfString:@"1" withString:@"单"];
           info = [info stringByReplacingOccurrencesOfString:@"2" withString:@"双"];
       }
       NSString *fushi = @"";
       if (num > 1) {
           fushi = @"复式";
       }
       else {
           fushi = @"单式";
       }
       zhuShuLabel.text = [NSString stringWithFormat:@"%@ %@%d注",[self changeModetypeToString:modeType ByLottroy:lotteryType],fushi,(int)num];

       
       UILabel *label = (UILabel *)[self.contentView viewWithTag:101];
       if (!label) {
           label = [[UILabel alloc] init];
           label.tag = 101;
           label.backgroundColor = [UIColor clearColor];
           label.numberOfLines = 0;
           label.font = [UIFont systemFontOfSize:14];
//           label.frame = CGRectMake(50, hightY, 130, 1000);
           label.frame = CGRectMake(40+5, hightY+5, 190, 1000);
           [self.contentView addSubview:label];
           label.textAlignment = NSTextAlignmentCenter;
           label.textColor = [UIColor redColor];
           [label release];
           
           
       }
       NSLog(@"%@",info);
//       label.text = [[info stringByReplacingOccurrencesOfString:@"^" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@"|"];
       
       NSRange asd=[info rangeOfString:@"^"];
       if(asd.length)
       {
           label.text = [[info stringByReplacingOccurrencesOfString:@"," withString:@" | "] stringByReplacingOccurrencesOfString:@"^" withString:@" "];
       }
       else
       {
           label.text = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
       }
       
       
       label.textAlignment = NSTextAlignmentLeft;
       if (modeType == SSCerxingzuxuandantuo) {
           label.text = [NSString stringWithFormat:@"[ %@",[label.text stringByReplacingOccurrencesOfString:@"|" withString:@"]"]];
       }
//       CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
       CGSize  size = [info sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
       if (size.height >35) {
//           label.frame = CGRectMake(50, 5, 130, size.height);
//           label.frame = CGRectMake(20, 5, 160, size.height);
           label.frame = CGRectMake(20+20+5, 5, 190, size.height);
//           backImage.frame = CGRectMake(47, 2, 240, size.height + 8);
           backImage.frame = CGRectMake(0, 0, 320, size.height + 8+4);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
       else {
//           label.frame = CGRectMake(50, 5, 130, 20);
//           label.frame = CGRectMake(20, 5, 160, 20);
           label.frame = CGRectMake(20+20+5, 5+5, 190, 20);
//           backImage.frame = CGRectMake(47, 2, 240, 30);
           backImage.frame = CGRectMake(0, 0, 320, 30+4+11);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
       
       
   }
   else if (self.lotteryType == TYPE_CQShiShi){
       NSInteger num = [GC_LotteryUtil getBets:[[info stringByReplacingOccurrencesOfString:@"^" withString:@""] stringByReplacingOccurrencesOfString:@"_" withString:@""] LotteryType:lotteryType ModeType:modeType];
       if (self.modeType == SSCdaxiaodanshuang) {
           info = [info stringByReplacingOccurrencesOfString:@"9" withString:@"大"];
           info = [info stringByReplacingOccurrencesOfString:@"0" withString:@"小"];
           info = [info stringByReplacingOccurrencesOfString:@"1" withString:@"单"];
           info = [info stringByReplacingOccurrencesOfString:@"2" withString:@"双"];
       }
       NSString *fushi = @"";
       if (num > 1) {
           fushi = @"复式";
       }
       else {
           fushi = @"单式";
       }
       zhuShuLabel.text = [NSString stringWithFormat:@"%@ %@%d注",[self changeModetypeToString:modeType ByLottroy:lotteryType],fushi,(int)num];
       
       
       UILabel *label = (UILabel *)[self.contentView viewWithTag:101];
       if (!label) {
           label = [[UILabel alloc] init];
           label.tag = 101;
           label.backgroundColor = [UIColor clearColor];
           label.numberOfLines = 0;
           label.font = [UIFont systemFontOfSize:14];
//           label.frame = CGRectMake(50, hightY, 130, 1000);
           label.frame = CGRectMake(40+5, hightY+5, 190, 1000);
           [self.contentView addSubview:label];
           label.textAlignment = NSTextAlignmentCenter;
           label.textColor = [UIColor redColor];
           [label release];
           
           
       }
//       label.text = [[info stringByReplacingOccurrencesOfString:@"^" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@"|"];
       
       NSRange asd=[info rangeOfString:@"^"];
       if(asd.length)
       {
           label.text = [[info stringByReplacingOccurrencesOfString:@"," withString:@" | "] stringByReplacingOccurrencesOfString:@"^" withString:@" "];
       }
       else
       {
           label.text = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
       }
       
       label.textAlignment = NSTextAlignmentLeft;
       if (modeType == SSCerxingzuxuandantuo) {
           label.text = [NSString stringWithFormat:@"[ %@",[label.text stringByReplacingOccurrencesOfString:@"|" withString:@"]"]];
       }
//       CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
       CGSize  size = [info sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
       if (size.height >35) {
//           label.frame = CGRectMake(50, 5, 130, size.height);
//           label.frame = CGRectMake(20, 5, 160, size.height);
           label.frame = CGRectMake(20+20+5, 5, 190, size.height);
//           backImage.frame = CGRectMake(47, 2, 240, size.height + 8);
           backImage.frame = CGRectMake(0, 0, 320, size.height + 8+4);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
       else {
//           label.frame = CGRectMake(50, 5, 130, 20);
//           label.frame = CGRectMake(20, 5, 160, 20);
           label.frame = CGRectMake(20+20+5, 5+5, 190, 20);
//           backImage.frame = CGRectMake(47, 2, 240, 30);
           backImage.frame = CGRectMake(0, 0, 320, 30+4+11);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
       
       
   }
   else if (self.lotteryType == TYPE_HappyTen){
       NSInteger num = [GC_LotteryUtil getBets:info LotteryType:lotteryType ModeType:modeType];
       NSString *fushi = @"";
       if (modeType >= HappyTenRen2DanTuo) {
           info = [NSString stringWithFormat:@"[%@",[info stringByReplacingOccurrencesOfString:@"|" withString:@"] "]];
       }
       else if (num > 1) {
           if (self.modeType == HappyTenDa || self.modeType == HappyTenDan) {
               fushi = @"";
           }else{
               fushi = @"复式";
           }
       }
       else {
           fushi = @"单式";
       }
       zhuShuLabel.text = [NSString stringWithFormat:@"%@ %@%d注",[self changeModetypeToString:modeType ByLottroy:lotteryType],fushi,(int)num];
       
       UILabel *label = (UILabel *)[self.contentView viewWithTag:101];
       if (!label) {
           label = [[UILabel alloc] init];
           label.tag = 101;
           label.backgroundColor = [UIColor clearColor];
           label.numberOfLines = 0;
           label.font = [UIFont systemFontOfSize:14];
//           label.frame = CGRectMake(50, hightY, 130, 1000);
//           label.frame = CGRectMake(20, hightY, 160, 1000);
           label.frame = CGRectMake(20+20, hightY+5, 150, 1000);
           [self.contentView addSubview:label];
           label.textAlignment = NSTextAlignmentCenter;
           label.textColor = [UIColor redColor];
           [label release];
       }
       NSLog(@"%@",info);
//       NSString *info1=info;
       NSRange asd=[info rangeOfString:@","];
       if(asd.length)
       {
           info = [info stringByReplacingOccurrencesOfString:@"," withString:@" "];
       }
       else
       {
           info = [info stringByReplacingOccurrencesOfString:@"|" withString:@" "];
       }
       if (modeType == HappyTenRen2Zhi || modeType == HappyTenRen3Zhi)
       {
           if(num == 1)
           {
               info = [info stringByReplacingOccurrencesOfString:@" |" withString:@" "];
           }
           else
           {
               info = [info stringByReplacingOccurrencesOfString:@" |" withString:@"|"];
           }
       }
       if (modeType == HappyTenDa || modeType == HappyTenDan) {

           info = [info stringByReplacingOccurrencesOfString:@";" withString:@"个 "];
           info = [info stringByReplacingOccurrencesOfString:@"⑽" withString:@""];
           info = [info stringByAppendingString:@"个"];
       }
       if (modeType == HappyTenQuan) {
           info = @"全";
       }
       NSLog(@"%@",info);
       label.text = info;
       label.textAlignment = NSTextAlignmentLeft;
       CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
//       CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
       NSLog(@"%f",size.height);
       if (size.height >30) {
//       if (size.height >35) {
//           label.frame = CGRectMake(50, 5, 130, size.height);
//           label.frame = CGRectMake(20, 5, 160, size.height);
           label.frame = CGRectMake(20+20, 5, 160, size.height);
//           backImage.frame = CGRectMake(47, 2, 240, size.height + 8);
           backImage.frame = CGRectMake(0, 0, 320, size.height + 8+4);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
       else {
//           label.frame = CGRectMake(50, 5, 130, 20);
//           label.frame = CGRectMake(20, 5, 160, 20);
           label.frame = CGRectMake(20+20, 5+5, 160, 20);
//           backImage.frame = CGRectMake(47, 2, 240, 30);
           backImage.frame = CGRectMake(0, 0, 320, 30+4+11);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
       
       
   }
   else if (self.lotteryType == TYPE_KuaiSan || self.lotteryType == TYPE_JSKuaiSan || self.lotteryType == TYPE_HBKuaiSan || self.lotteryType == TYPE_JLKuaiSan || self.lotteryType == TYPE_AHKuaiSan){ //内蒙古快三和江苏快三共用
       NSInteger num = [GC_LotteryUtil getBets:info LotteryType:lotteryType ModeType:modeType];
       zhuShuLabel.text = [NSString stringWithFormat:@"%@ %d注",[self changeModetypeToString:modeType ByLottroy:lotteryType],(int)num];
       
       UILabel *label = (UILabel *)[self.contentView viewWithTag:101];
       if (!label) {
           label = [[UILabel alloc] init];
           label.tag = 101;
           label.backgroundColor = [UIColor clearColor];
           label.numberOfLines = 0;
           label.font = [UIFont systemFontOfSize:14];
//           label.frame = CGRectMake(50, hightY, 135, 1000);
           label.frame = CGRectMake(40+5, hightY+5, 135, 1000);
           [self.contentView addSubview:label];
           label.textAlignment = NSTextAlignmentCenter;
           label.textColor = [UIColor redColor];
           [label release];
           
           
       }
       label.text = info;
       NSLog(@"%@",info);
       if (modeType == KuaiSanSantongTong) {
           label.text = @"三同号通选";
       }
       else if (modeType == KuaiSanSanLianTong) {
           label.text = @"三连号通选";
       }
       else if (modeType > KuaiSanSanLianTong) {
           label.textAlignment = NSTextAlignmentLeft;
           label.text = [NSString stringWithFormat:@"[ %@",[label.text stringByReplacingOccurrencesOfString:@"|" withString:@"]"]];
       }
       label.textAlignment = NSTextAlignmentLeft;
       if (modeType == KuaiSanSantongDan) {
           label.text = [[label.text stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@";" withString:@" "];
       }
       else {
           label.text = [label.text stringByReplacingOccurrencesOfString:@"," withString:@" "];
       }
       
       
       
       CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
       if (size.height >30) {
//           label.frame = CGRectMake(50, 6, 135, size.height);
           label.frame = CGRectMake(40+5, 6+5, 135, size.height);
           
//           backImage.frame = CGRectMake(47, 2, 240, size.height + 8);
           backImage.frame = CGRectMake(0, 0, 320, size.height + 8+4+8);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
       }
       else {
//           label.frame = CGRectMake(50, 6, 135, 20);
           label.frame = CGRectMake(40+5, 6+5, 135, 20);
//           backImage.frame = CGRectMake(47, 2, 240, 30);
           backImage.frame = CGRectMake(0, 0, 320, 30+4+11);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
   }
   else if (self.lotteryType == TYPE_KuaiLePuKe) {
       
       UILabel *label = (UILabel *)[self.contentView viewWithTag:101];
       if (!label) {
           label = [[UILabel alloc] init];
           label.tag = 101;
           label.backgroundColor = [UIColor clearColor];
           label.numberOfLines = 0;
           label.font = [UIFont systemFontOfSize:14];
//           label.frame = CGRectMake(50, hightY, 135, 1000);
           label.frame = CGRectMake(40+5, hightY+5, 135, 1000);
           [self.contentView addSubview:label];
           label.textAlignment = NSTextAlignmentLeft;
           label.textColor = [UIColor redColor];
           [label release];
           
           
       }
       label.text = info;
       NSLog(@"%@",info);
       label.text = [self changePuke:label.text];
       NSInteger num = [GC_LotteryUtil getBets:info LotteryType:lotteryType ModeType:modeType];
       if ([label.text rangeOfString:@"包选"].location != NSNotFound) {
           zhuShuLabel.text = [NSString stringWithFormat:@"%@ 包选%d注",[self changeModetypeToString:modeType ByLottroy:lotteryType],(int)num];
       }
       else if (num == 1) {
           zhuShuLabel.text = [NSString stringWithFormat:@"%@ 单式%d注",[self changeModetypeToString:modeType ByLottroy:lotteryType],(int)num];
       }
       else {
           zhuShuLabel.text = [NSString stringWithFormat:@"%@ 复式%d注",[self changeModetypeToString:modeType ByLottroy:lotteryType],(int)num];
       }
       
//       CGSize  size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 2000)];
       CGSize  size = [info sizeWithFont:label.font constrainedToSize:CGSizeMake(135, 2000)];

       NSLog(@"%f,%f",size.width,size.height);
       if (size.height >30) {
//           label.frame = CGRectMake(50, 6, 135, size.height);
           label.frame = CGRectMake(40+5, 6+5, 135, size.height);
//           backImage.frame = CGRectMake(47, 2, 240, size.height + 8);
           backImage.frame = CGRectMake(0, 0, 320, size.height + 8+4+8);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
       else {
//           label.frame = CGRectMake(50, 6, 135, 20);
           label.frame = CGRectMake(40+5, 6+5, 135, 20);
//           backImage.frame = CGRectMake(47, 2, 240, 30);
           backImage.frame = CGRectMake(0, 0, 320, 30+4+11);
           lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//           shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
           
       }
       label.textColor = [UIColor redColor];
       if (self.modeType == KuaiLePuKeTongHua || self.modeType == KuaiLePuKeTongHuaShun) {
//           label.frame = CGRectMake(75, 6, 135, size.height);
           label.frame = CGRectMake(75, 8+5, 135, size.height);
           UIImageView *imageV = (UIImageView *)[self.contentView viewWithTag:99];
           if (!imageV) {
//               imageV = [[UIImageView alloc] initWithFrame:CGRectMake(50, 6, 20, 20)];
               imageV = [[UIImageView alloc] initWithFrame:CGRectMake(50, 6+5, 20, 20)];
               [self.contentView addSubview:imageV];
               imageV.tag = 99;
               [imageV release];
           }
           imageV.hidden = NO;
           NSString *st = @"";
           if ([label.text rangeOfString:@"黑桃"].location != NSNotFound) {
               st  = @"pukexq_1.png";
               label.textColor = [UIColor blackColor];
           }
           else if ([label.text rangeOfString:@"红桃"].location != NSNotFound) {
               st  = @"pukexq_2.png";
           }
           else if ([label.text rangeOfString:@"梅花"].location != NSNotFound) {
               st  = @"pukexq_3.png";
               label.textColor = [UIColor blackColor];
           }
           else if ([label.text rangeOfString:@"方块"].location != NSNotFound) {
               st  = @"pukexq_4.png";
           }
           if ([st length]) {
               imageV.image = UIImageGetImageFromName(st);
           }
           else {
               imageV.image = nil;
           }
           
       }
       
   }
    else if (self.lotteryType == TYPE_SHUANGSEQIU){
        NSInteger num = [GC_LotteryUtil getBets:info LotteryType:TYPE_SHUANGSEQIU ModeType:modeType];
        
        if (num > 1) {
            zhuShuLabel.text = [NSString stringWithFormat:@"复式%d注",(int)num];
        }
        else {
            zhuShuLabel.text = [NSString stringWithFormat:@"单式%d注",(int)num];
        }
        if (modeType == Shuangseqiudantuo) {
            zhuShuLabel.text = [NSString stringWithFormat:@"胆拖%d注",(int)num];
        }
        NSArray *array = [info componentsSeparatedByString:@"+"];
        if ([array count]>1) {
            NSArray *redArray = [[[array objectAtIndex:0] stringByReplacingOccurrencesOfString:@"@" withString:@","] componentsSeparatedByString:@","];
            NSArray *array1 = [[array objectAtIndex:0] componentsSeparatedByString:@"@"];
            NSArray *redDanArray = [[array1 objectAtIndex:0] componentsSeparatedByString:@","];
            
            NSArray *blueArray = [[array objectAtIndex:1] componentsSeparatedByString:@","];
            
            for (int i = 0; i<[redArray count]; i++) {
                int a = i/7,b= i%7;
                UILabel *label;
                label = (UILabel *)[self.contentView viewWithTag:100+i];
                if (!label) {
                    label = [[UILabel alloc] init];
                    label.tag = 100 + i;
                    label.backgroundColor = [UIColor clearColor];
//                    label.frame = CGRectMake(50+23*b,hightY+23*a, 23, 23);
//                    label.frame = CGRectMake(20+23*b,hightY+23*a, 23, 23);
                    label.frame = CGRectMake(20+23*b+20+5,hightY+23*a+5, 23, 23);
                    [self.contentView addSubview:label];
                    [label release];
                }
                label.textColor = [UIColor redColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = [redArray objectAtIndex:i];
                if (i == 0 && self.modeType ==Shuangseqiudantuo) {
                    UILabel  *zuolabel = (UILabel *)[self.contentView viewWithTag:1000];
                    if (!zuolabel) {
                        zuolabel = [[UILabel alloc] init];
                        [self.contentView addSubview:zuolabel];
                        zuolabel.backgroundColor = [UIColor clearColor];
//                        zuolabel.frame = CGRectMake(45+23*b,hightY+23*a, 10, 23);
//                        zuolabel.frame = CGRectMake(15+23*b,hightY+23*a, 10, 23);
                        zuolabel.frame = CGRectMake(15+23*b+20+5,hightY+23*a+5, 10, 23);
                        zuolabel.tag = 1000;
                        zuolabel.textColor = [UIColor redColor];
                        zuolabel.textAlignment = NSTextAlignmentCenter;
                        [zuolabel release];
                    }
                    zuolabel.text = @"[";
                    
                }
                
                if (i == [redDanArray count] -1 && self.modeType ==Shuangseqiudantuo) {
                    UILabel  *youLabel = (UILabel *)[self.contentView viewWithTag:1001];
                    if (!youLabel) {
                        youLabel = [[UILabel alloc] init];
                        [self.contentView addSubview:youLabel];
                        youLabel.backgroundColor = [UIColor clearColor];
                        
                        youLabel.tag = 1001;
                        youLabel.textColor = [UIColor redColor];
                        youLabel.textAlignment = NSTextAlignmentCenter;
                        [youLabel release];
                    }
//                    youLabel.frame = CGRectMake(68+23*b,hightY+23*a, 10, 23);
//                    youLabel.frame = CGRectMake(38+23*b,hightY+23*a, 10, 23);
                    youLabel.frame = CGRectMake(38+23*b+20+5,hightY+23*a+5, 10, 23);
                    youLabel.text = @"]";
                    
                }

            }
            for (int i = 0; i<[blueArray count]; i++) {
                int a = (i +(int)[redArray count])/7,b= (i +(int)[redArray count])%7;
                UILabel *label;
                label = (UILabel *)[self.contentView viewWithTag:100+i +[redArray count]];
                if (!label) {
                    label = [[UILabel alloc] init];
                    label.backgroundColor = [UIColor clearColor];
                    label.tag = 100 + i +[redArray count];
//                    label.frame = CGRectMake(50+23*b, hightY+23*a, 23, 23);
//                    label.frame = CGRectMake(20+23*b, hightY+23*a, 23, 23);
                    label.frame = CGRectMake(20+23*b+20+5, hightY+23*a+5, 23, 23);
                    [self.contentView addSubview:label];
                    [label release];
                }
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor blueColor];
                label.text = [blueArray objectAtIndex:i];
            }
//            backImage.frame = CGRectMake(47, 2, 240, 31+([blueArray count]+[redArray count] -  1)/7 * 23);
            backImage.frame = CGRectMake(0, 0, 320, 31+([blueArray count]+[redArray count] -  1)/7 * 23+4+10);
            lineIma.frame=CGRectMake(15, backImage.frame.size.height-0.5, 320, 0.5);
//            shanchuButton.frame=CGRectMake(320, 0, 65, backImage.frame.size.height);
            
        }
    }
}

- (void)dealloc {
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    