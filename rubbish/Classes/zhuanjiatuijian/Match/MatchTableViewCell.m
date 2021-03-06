//
//  MatchTableViewCell.m
//  Experts
//
//  Created by hudong yule on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "MatchTableViewCell.h"

@implementation MatchTableViewCell

+(id)matchTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString * matchCellId=@"match";
    MatchTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:matchCellId];
    if (cell==nil) {
        cell=[[MatchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:matchCellId];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //期号
        UIImage * image=[UIImage imageNamed:@"期号-描边色调"];
        UIImageView * noImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15,15,image.size.width, image.size.height)];
        noImageView.image=image;
        self.noImageView=noImageView;
        [self.contentView addSubview:noImageView];
        
        UILabel * number=[[UILabel alloc]initWithFrame:CGRectMake(noImageView.frame.origin.x+5,noImageView.frame.origin.y, image.size.width-10,image.size.height-2)];
        number.text=@"001";
        number.textAlignment=NSTextAlignmentCenter;
        number.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        number.font=FONTTWENTY_FOUR;
        number.textColor=RGB(17.0,163.0,255.0);
        number.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:number];
        self.number=number;
        //赛名：日联杯
        UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noImageView.frame)+8, number.frame.origin.y, 80, 20)];
        name.text=@"日联杯";
        name.font=FONTTWENTY_FOUR;
        name.textColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.87];
        [self.contentView addSubview:name];
        self.name=name;
        
        UILabel * time=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), 20, 150, 20)];
        time.text=@"8月8日 21:00";
        time.font=FONTTWENTY_FOUR;
        time.textColor=[UIColor blackColor];
        time.alpha=0.54;
        [self.contentView addSubview:time];
        self.time=time;
        
        //对决
        UILabel * dueOfTwoSides=[[UILabel alloc]initWithFrame:CGRectMake(number.frame.origin.x, CGRectGetMaxY(number.frame)+20, 200, 20)];
        dueOfTwoSides.text=@"鹿岛鹿角 VS 神户胜利船";
        dueOfTwoSides.font=FONTTHIRTY;
        dueOfTwoSides.textColor=[UIColor blackColor];
        dueOfTwoSides.alpha=0.87;
        [self.contentView addSubview:dueOfTwoSides];
        self.dueOfTwoSides=dueOfTwoSides;
        
        //人数
        UIImageView *recommandCountImageView=[[UIImageView alloc]initWithFrame:CGRectMake(MyWidth-69, 22.5, 54, 24)];
        self.recommandCountImageView=recommandCountImageView;
        recommandCountImageView.image=[UIImage imageNamed:@"推荐圆角"];
        [self.contentView addSubview:recommandCountImageView];
        
        UILabel * recommandCount=[[UILabel alloc]initWithFrame:CGRectMake(MyWidth-69, 22.5,54,24)];
        [self.contentView addSubview:recommandCount];
        self.recommandCount=recommandCount;
        recommandCount.text=@"99+";
        recommandCount.font=FONTTWENTY_FOUR;
        recommandCount.textColor=RGB(255., 59., 48.);
        recommandCount.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

-(void)setDataWithMatchMdl:(MatchVCModel *)matchModel
{
    self.number.text=[matchModel.ccId substringWithRange:NSMakeRange(matchModel.ccId.length-3, 3)];
    if([matchModel.source isEqualToString:@"1"]){
        self.noImageView.hidden=NO;
        self.number.hidden=NO;
    }else if ([matchModel.source isEqualToString:@"2"]){
        self.noImageView.hidden=YES;
        self.number.hidden=YES;
    }
    
    //赛名
    self.name.text=matchModel.leagueNameSimply;
    CGSize nameSize=[PublicMethod setNameFontSize:self.name.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if([matchModel.source isEqualToString:@"1"]){
        self.name.frame=CGRectMake(CGRectGetMaxX(self.noImageView.frame)+8, 15, nameSize.width,nameSize.height);
    }
    
    //时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式
    NSDate *date=[dateFormatter dateFromString:matchModel.matchTime];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM月dd日 HH:mm"];
    
    NSString * compTime=[NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:date]];
    
    self.time.text=compTime;
    CGSize timeSize=[PublicMethod setNameFontSize:self.time.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if([matchModel.source isEqualToString:@"1"]){
        self.time.frame=CGRectMake(CGRectGetMaxX(self.name.frame)+28, 15, timeSize.width,timeSize.height);
        CGFloat outOfBorder=CGRectGetMaxX(self.time.frame)-(MyWidth-69);
        if (CGRectGetMaxX(self.time.frame)>MyWidth-69) {
            self.time.frame=CGRectMake(CGRectGetMaxX(self.name.frame)+28, 15, timeSize.width-outOfBorder,timeSize.height);
        }
    }
    
    if ([matchModel.source isEqualToString:@"2"]){
        self.time.frame=CGRectMake(15, 15, timeSize.width,timeSize.height);
        self.name.frame=CGRectMake(CGRectGetMaxX(self.time.frame)+28, 15, nameSize.width,nameSize.height);
    }
    
    self.dueOfTwoSides.text=[NSString stringWithFormat:@"%@  VS  %@",matchModel.hostNameSimply,matchModel.guestNameSimply];
    CGSize twoSidesSize=[PublicMethod setNameFontSize:self.dueOfTwoSides.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (twoSidesSize.width>=MyWidth-84) {
        self.dueOfTwoSides.frame=CGRectMake(self.noImageView.frame.origin.x,CGRectGetMaxY(self.noImageView.frame)+9,MyWidth-84,twoSidesSize.height);
    }else{
        self.dueOfTwoSides.frame=CGRectMake(self.noImageView.frame.origin.x,CGRectGetMaxY(self.noImageView.frame)+9, twoSidesSize.width,twoSidesSize.height);
    }
    
    NSInteger planCount=[matchModel.planCount integerValue];
    if (planCount>99) {
        self.recommandCount.text=@"荐    99+";
    }else{
        self.recommandCount.text=[NSString stringWithFormat:@"荐    %@",matchModel.planCount];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    