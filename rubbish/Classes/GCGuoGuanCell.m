//
//  GCGuoGuanCell.m
//  caibo
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCGuoGuanCell.h"
#import "Info.h"
#import "UserInfo.h"
@implementation GCGuoGuanCell
@synthesize delegate;
@synthesize panduanme;
@synthesize rowcount;
@synthesize cellLine,cellLine2;
@synthesize userName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:[self returnTabelViewCell]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (GCGuoGuanDataDetail *)guoGuanData{
    return guoGuanData;
}

- (void)setGuoGuanData:(GCGuoGuanDataDetail *)_guoGuanData{
    if (guoGuanData != _guoGuanData) {
        [guoGuanData release];
        guoGuanData = [_guoGuanData retain];
    }
    
    nageiamge.image= [UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    userName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    //判断是否保密 隐藏
    if ([_guoGuanData.baomi isEqualToString:@"1"]) {//||[_guoGuanData.baomi isEqualToString:@"3"]
        lockImage.image = UIImageGetImageFromName(@"ILS-960.png");
        //用户名
        userName.text = _guoGuanData.nickName;
        jiantou.hidden = YES;
    }else if([_guoGuanData.baomi isEqualToString:@"4"] ){
        //用户名
        userName.text = @"********";
        lockImage.image = nil;
        jiantou.hidden = NO;
        nageiamge.image= [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:3 topCapHeight:3];
        userName.textColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];

    }else {
        lockImage.image = nil;
        //用户名
        userName.text = _guoGuanData.nickName;
        jiantou.hidden = NO;
    }

    if ([_guoGuanData.username isEqualToString:[[[Info getInstance] mUserInfo] user_name]]) {
        lockImage.image = nil;
        //用户名
        userName.text = _guoGuanData.nickName;
        jiantou.hidden = NO;
        userName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];

    }else{
        userName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    }

    if (panduanme) {
        nageiamge.hidden = YES;
        userName.frame = CGRectMake(15, 16, 65, 30);
        userName.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
        
    }else{
        nageiamge.hidden = NO;
    }
    
    
    if([_guoGuanData.baomi isEqualToString:@"4"] ){
        //用户名
       
        nageiamge.image= [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:3 topCapHeight:3];
        userName.textColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
        
    }
    //中几场判断 
//    if (_guoGuanData.mzchangci == 0) {
//        zhongImage.image = UIImageGetImageFromName(@"gc_zhongbaomi.png");
//    }else{
//        zhongImage.image = UIImageGetImageFromName(@"gc_zhongjichang.png");
//    }
    zhongLabel.text = [NSString stringWithFormat:@"中<%d>场", (int)_guoGuanData.mzchangci];
    
    //方案注数 @"全对268/512注"
    allrightLab.text = [NSString stringWithFormat:@"全对<%d/%d>注", (int)_guoGuanData.allright,(int) _guoGuanData.fazzs];
    
    //错一
    wrongLabel.text = [NSString stringWithFormat:@"错一<%d>注",(int) _guoGuanData.cyzs];
    
    NSArray * dengjiarr = [_guoGuanData.zhanji componentsSeparatedByString:@"#"];
    if (dengjiarr.count < 5) {
        dengjiarr = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
    }
    levLabel1.text = [dengjiarr objectAtIndex:0];
    levLabel2.text = [dengjiarr objectAtIndex:1];
    levLabel3.text = [dengjiarr objectAtIndex:2];
    levLabel4.text = [dengjiarr objectAtIndex:3];
    levLabel5.text = [dengjiarr objectAtIndex:4];
    levLabel6.text = [dengjiarr objectAtIndex:5];

    
    
    
    //6个等级图标显示
//    NSArray * levalarr = [NSArray arrayWithObjects:levLabel1, levLabel2, levLabel3, levLabel4, levLabel5, levLabel6, nil];
//    NSArray * levaimage  = [NSArray arrayWithObjects:level1, level2, level3, level4, level5, level6, nil];
//    NSInteger count = 0;
//    for (int i = 0; i < 6; i++) {
//        UILabel * le = [levalarr objectAtIndex:i];
//        UIImageView * ima = [levaimage objectAtIndex:i];
//
//            if ([le.text isEqualToString:@"0"]) {
//                ima.hidden = YES;
//            }else{
//                ima.frame = CGRectMake(14 + (count*18), 29, 11, 11);
//                ima.hidden = NO;
//                count++;
//            }
//   
//    }
   
    

}



- (UIView *)returnTabelViewCell{
    //返回的view
    UIView * viewcell = [[[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 60)] autorelease];
    viewcell.backgroundColor = [UIColor clearColor];
    

    
    // line
    cellLine = [[[UIView alloc] init] autorelease];
    cellLine.frame = CGRectMake(15, 59.5, 290, 0.5);
    cellLine.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [viewcell addSubview:cellLine];
    
    
    cellLine2 = [[[UIView alloc] init] autorelease];
    cellLine2.frame = CGRectMake(0, 59.5, 320, 0.5);
    cellLine2.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [viewcell addSubview:cellLine2];
    
    
    //背景图片
    nageiamge = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 85, 30)];
    nageiamge.backgroundColor = [UIColor clearColor];
    nageiamge.image= [UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    
    //用户名
    userName = [[UILabel alloc] initWithFrame:CGRectMake(24, 16, 65, 30)];
    userName.font = [UIFont systemFontOfSize:16];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.backgroundColor = [UIColor clearColor];
//    userName.text = @"用户名1111";//假
    userName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    
    
    
    //等级背景
//    UIImageView * levelbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(27, 25, 83, 18)];
//    levelbgimage.backgroundColor = [UIColor clearColor];
//    levelbgimage.image = UIImageGetImageFromName(@"gc_dengjibg.png");
//    [viewcell addSubview:levelbgimage];
    
    
    //等级
//    level1 = [[UIImageView alloc] initWithFrame:CGRectMake(41, 29, 11, 11)];
//    level1.backgroundColor = [UIColor clearColor];
//    level1.image = UIImageGetImageFromName(@"gc_jg.png");
//    
//    
//    level2 = [[UIImageView alloc] initWithFrame:CGRectMake(61, 29, 11, 11)];
//    level2.backgroundColor = [UIColor clearColor];
//    level2.image = UIImageGetImageFromName(@"gc_zs.png");
//    
//    level3 = [[UIImageView alloc] initWithFrame:CGRectMake(81, 29, 11, 11)];
//    level3.backgroundColor = [UIColor clearColor];
//    level3.image = UIImageGetImageFromName(@"gc_jx.png");
    
    
//    level4 = [[UIImageView alloc] initWithFrame:CGRectMake(101, 29, 11, 11)];
//    level4.backgroundColor = [UIColor clearColor];
//    level4.image = UIImageGetImageFromName(@"gc_lg.png");
//    
//    level5 = [[UIImageView alloc] initWithFrame:CGRectMake(121, 29, 11, 11)];
//    level5.backgroundColor = [UIColor clearColor];
//    level5.image = UIImageGetImageFromName(@"gc_ls.png");
//    
//    level6 = [[UIImageView alloc] initWithFrame:CGRectMake(141, 29, 11, 11)];
//    level6.backgroundColor = [UIColor clearColor];
//    level6.image = UIImageGetImageFromName(@"gc_lx.png");
    
    //等级数
    levLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel1.textAlignment = NSTextAlignmentRight;
    levLabel1.backgroundColor = [UIColor clearColor];
    levLabel1.font = [UIFont boldSystemFontOfSize:6];
    levLabel1.textColor = [UIColor colorWithRed:252/255.0 green:255/255.0 blue:160/255.0 alpha:1];
    //levLabel1.text = @"1";//假
    
    levLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel2.textAlignment = NSTextAlignmentRight;
    levLabel2.backgroundColor = [UIColor clearColor];
    levLabel2.font = [UIFont boldSystemFontOfSize:6];
    levLabel2.textColor = [UIColor colorWithRed:252/255.0 green:255/255.0 blue:160/255.0 alpha:1];
    //levLabel2.text = @"1";//假
    
    levLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel3.textAlignment = NSTextAlignmentRight;
    levLabel3.backgroundColor = [UIColor clearColor];
    levLabel3.font = [UIFont boldSystemFontOfSize:6];
    levLabel3.textColor = [UIColor colorWithRed:252/255.0 green:255/255.0 blue:160/255.0 alpha:1];
    //levLabel3.text = @"1";//假
    
    levLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel4.textAlignment = NSTextAlignmentRight;
    levLabel4.backgroundColor = [UIColor clearColor];
    levLabel4.font = [UIFont boldSystemFontOfSize:6];
    levLabel4.textColor = [UIColor colorWithRed:138/255.0 green:223/255.0 blue:255/255.0 alpha:1];
   // levLabel4.text = @"1";//假
    
    levLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel5.textAlignment = NSTextAlignmentRight;
    levLabel5.backgroundColor = [UIColor clearColor];
    levLabel5.font = [UIFont boldSystemFontOfSize:6];
    levLabel5.textColor = [UIColor colorWithRed:138/255.0 green:223/255.0 blue:255/255.0 alpha:1];
    //levLabel5.text = @"1";//假
    
    levLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    levLabel6.textAlignment = NSTextAlignmentRight;
    levLabel6.backgroundColor = [UIColor clearColor];
    levLabel6.font = [UIFont boldSystemFontOfSize:6];
    levLabel6.textColor = [UIColor colorWithRed:138/255.0 green:223/255.0 blue:255/255.0 alpha:1];
    //levLabel6.text = @"1";//假
    
//    [level1 addSubview:levLabel1];
//    [level2 addSubview:levLabel2];
//    [level3 addSubview:levLabel3];
//    [level4 addSubview:levLabel4];
//    [level5 addSubview:levLabel5];
//    [level6 addSubview:levLabel6];
    //中几场
 
    zhongLabel = [[ColorView alloc] initWithFrame:CGRectMake(110, 12, 48, 16)];
    zhongLabel.textAlignment = NSTextAlignmentCenter;
    zhongLabel.font = [UIFont systemFontOfSize:14];
    zhongLabel.backgroundColor = [UIColor clearColor];
//    zhongLabel.text = @"中14场";
    zhongLabel.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    zhongLabel.changeColor = [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1];
    
    lockImage = [[UIImageView alloc] initWithFrame:CGRectMake(280, 22, 15, 16)];
    lockImage.backgroundColor = [UIColor clearColor];
    lockImage.image = UIImageGetImageFromName(@"ILS-960.png");
    
    
    
    allrightLab = [[ColorView alloc] initWithFrame:CGRectMake(110, 38, 100, 20)];
    allrightLab.textAlignment = NSTextAlignmentLeft;
    allrightLab.backgroundColor = [UIColor clearColor];
    allrightLab.font = [UIFont systemFontOfSize:12];
//    allrightLab.text = @"全对268/512注";
    allrightLab.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];;
    allrightLab.changeColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    allrightLab.colorfont = [UIFont systemFontOfSize:14];
    
    wrongLabel = [[ColorView alloc] initWithFrame:CGRectMake(230, 38, 100, 20)];
    wrongLabel.textAlignment = NSTextAlignmentLeft;
    wrongLabel.backgroundColor = [UIColor clearColor];
    wrongLabel.font = [UIFont systemFontOfSize:12];
    wrongLabel.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    // wrongLabel.text = @"错一100注";
    wrongLabel.changeColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    wrongLabel.colorfont = [UIFont systemFontOfSize:14];
    
    [viewcell addSubview:userName];
    [viewcell addSubview:nageiamge];
    [viewcell addSubview:userName];
    [viewcell addSubview:zhongLabel];
    [viewcell addSubview:lockImage];
    
//    [viewcell addSubview:level1];
//    [viewcell addSubview:level2];
//    [viewcell addSubview:level3];
//    [viewcell addSubview:level4];
//    [viewcell addSubview:level5];
//    [viewcell addSubview:level6];
    
   
    [viewcell addSubview:allrightLab];
    [viewcell addSubview:wrongLabel];
    
    
    UIButton * ziliaobut = [UIButton buttonWithType:UIButtonTypeCustom];
    ziliaobut.frame = CGRectMake(0, 0, 140, 50);
    [ziliaobut addTarget:self action:@selector(pressZiLiaoButton:) forControlEvents:UIControlEventTouchUpInside];
    [viewcell addSubview:ziliaobut];
    
    jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(290, 24, 8, 13)];
    jiantou.backgroundColor = [UIColor clearColor];
    jiantou.image = UIImageGetImageFromName(@"jiantou_1.png");
    [viewcell addSubview:jiantou];
    [jiantou release];
    
    return viewcell;
}

- (void)pressZiLiaoButton:(UIButton *)sender{
    NSLog(@"111111111111111");
   
    if([guoGuanData.baomi isEqualToString:@"4"] ){
        return;
    }
    [self returnGuoGanInfo:guoGuanData indexr:rowcount];
    
}

- (void)returnGuoGanInfo:(GCGuoGuanDataDetail *)ggdata indexr:(NSIndexPath *)indexrow{
    if ([delegate respondsToSelector:@selector(returnGuoGanInfo: indexr:)]) {
        [delegate returnGuoGanInfo:ggdata indexr:rowcount];
    }
}

- (void)dealloc{
    [nageiamge release];
  //  [ release];
    [wrongLabel release];
    [allrightLab release];
//    [level1 release];
//    [level2 release];
//    [level3 release];
//    [level4 release];
//    [level5 release];
//    [level6 release];
    [levLabel1 release];
    [levLabel2 release];
    [levLabel3 release];
    [levLabel4 release];
    [levLabel5 release];
    [levLabel6 release];
    [lockImage release];
    [userName release];
  
    [zhongLabel release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    