//
//  SechExpIntroCell.m
//  Experts
//
//  Created by v1pin on 15/11/12.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SechExpIntroCell.h"

@implementation SechExpIntroCell

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+(id)SechExpCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * superiorCellId=@"searchCell";
    SechExpIntroCell * cell=(SechExpIntroCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[SechExpIntroCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:superiorCellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    if (IS_IOS7) {
        cell.separatorInset=UIEdgeInsetsMake(0,0,0,0);
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //创建cell上的子控件
        UIImageView * schHeadView=[[UIImageView alloc]initWithFrame:CGRectMake(15*MyWidth/320, 21.5, 45*MyWidth/320, 45*MyWidth/320)];
        [self.contentView addSubview:schHeadView];
        schHeadView.layer.cornerRadius=22.5*MyWidth/320;
        schHeadView.layer.masksToBounds=YES;
        self.schHeadView=schHeadView;
        
        UIImageView *markView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(schHeadView.frame)+35*MyWidth/320, CGRectGetMinY(schHeadView.frame)+35*MyWidth/320, 10*MyWidth/320, 10*MyWidth/320)];
        markView.layer.cornerRadius=5*MyWidth/320;
        markView.layer.masksToBounds=YES;
        markView.image=[UIImage imageNamed:@"V_red"];
        [self.contentView addSubview:markView];
        _markView=markView;
        
        UILabel *nickNameLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(schHeadView.frame)+15*MyWidth/320, 15, 40, 20)];
        nickNameLab.font=[UIFont systemFontOfSize:18.0f];
        nickNameLab.textColor=[UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:1.0];
        nickNameLab.backgroundColor=[UIColor clearColor];
        [self addSubview:nickNameLab];
        self.nicNmlab=nickNameLab;
        
        UIImageView *djImgView=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(_nicNmlab)+10, _nicNmlab.frame.size.height/2-7, 39, 14)];
        djImgView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:djImgView];
        _djImgV=djImgView;
        
        UILabel *djLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 22, 14)];
        djLabel.backgroundColor=[UIColor clearColor];
        djLabel.font=[UIFont systemFontOfSize:8.0];
        djLabel.textColor=RGBColor(255.0, 96.0, 0.0);
        djLabel.textAlignment=NSTextAlignmentLeft;
        [_djImgV addSubview:djLabel];
        _djLab=djLabel;
        
        //对决
        UILabel * exTypeLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(schHeadView.frame)+15*MyWidth/320, CGRectGetMaxY(nickNameLab.frame)+8, 150, 20)];
        exTypeLab.font=[UIFont systemFontOfSize:15.f];
        exTypeLab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.87];
        [self addSubview:exTypeLab];
        self.exTypeLab=exTypeLab;
        
        UILabel * exIntroLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(schHeadView.frame)+15*MyWidth/320, CGRectGetMaxY(exTypeLab.frame)+8, MyWidth-CGRectGetMaxX(schHeadView.frame)-25*MyWidth/320, 20)];
        exIntroLab.font=[UIFont systemFontOfSize:12.0f];
        exIntroLab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.54];
        exIntroLab.backgroundColor=[UIColor clearColor];
        exIntroLab.numberOfLines=0;
        exIntroLab.alpha=0.87;
        [self addSubview:exIntroLab];
        self.exIntroLab=exIntroLab;
    }
    return self;
}

- (void)expertHead:(NSString *)head name:(NSString *)name exRank:(NSInteger)exRank starNo:(NSInteger)starNo exType:(NSString *)exType exIntro:(NSString *)exIntro{
    
    NSURL *url=[NSURL URLWithString:head];
    [_schHeadView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    
    _nicNmlab.text=name;
    [_nicNmlab sizeToFit];
        
    [_djImgV setFrame:CGRectMake(ORIGIN_X(_nicNmlab)+10, _nicNmlab.frame.origin.y+(_nicNmlab.frame.size.height-14)/2, 39, 14)];
    NSString *rankImg=@"";
    if (starNo<=5) {
        rankImg=@"ranklv1-5";
        _djLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (starNo>5&&starNo<=10){
        rankImg=@"ranklv6-10";
        _djLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (starNo>10&&starNo<=15){
        rankImg=@"ranklv11-15";
        _djLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (starNo>15&&starNo<=20){
        rankImg=@"ranklv16-20";
        _djLab.textColor=[UIColor whiteColor];
    }else if (starNo>20&&starNo<=25){
        rankImg=@"ranklv21-25";
        _djLab.textColor=[UIColor whiteColor];
    }
    _djImgV.image=[UIImage imageNamed:rankImg];
    _djLab.text=[NSString stringWithFormat:@"LV%ld",(long)starNo];
    CGSize reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)starNo] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_djLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    NSString *type=@"";
    if ([exType isEqualToString:@"001"]) {
        type=@"竞彩专家";
    }else if ([exType isEqualToString:@"002"]){
        type=@"数字彩专家";
    }
    _exTypeLab.text=type;
    
    _exIntroLab.text=exIntro;
    
    if (exRank==0) {
        _markView.hidden=NO;
    }else{
        _markView.hidden=YES;
    }
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    