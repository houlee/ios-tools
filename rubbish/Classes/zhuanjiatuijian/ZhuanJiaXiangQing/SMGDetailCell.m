//
//  SMGDetailCell.m
//  Experts
//
//  Created by hudong yule on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SMGDetailCell.h"
#import "caiboAppDelegate.h"

@implementation SMGDetailCell

+(id)SMGDetailCellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index
{
    static NSString * SMGDetailCellId=@"SMGDetail";
    SMGDetailCell * cell=[tableView cellForRowAtIndexPath:index];
    if (cell==nil) {
        cell=[[SMGDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SMGDetailCellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 15, 40, 20)];
        timeLabel.font=FONTTWENTY_FOUR;
        timeLabel.textColor=[UIColor blackColor];
        timeLabel.alpha=0.87;
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UIImage * correctImage=[UIImage imageNamed:@"已发方案-英超-描边标签"];
        UIImageView * matchTypeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(timeLabel.frame.origin.x,CGRectGetMaxY(timeLabel.frame)+10,correctImage.size.width, correctImage.size.height)];
        matchTypeImageView.image=correctImage;
        self.matchTypeImageView=matchTypeImageView;
        [self.contentView addSubview:matchTypeImageView];
        
        UILabel * matchType=[[UILabel alloc]initWithFrame:CGRectMake(matchTypeImageView.frame.origin.x+5,matchTypeImageView.frame.origin.y, correctImage.size.width-10,correctImage.size.height-2)];
        matchType.font=FONTTWENTY_FOUR;
        matchType.textColor=[UIColor colorWithRed:0.1 green:0.64 blue:1 alpha:1];
        matchType.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        matchType.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:matchType];
        self.matchType=matchType;
        
        UILabel * sidesOne=[[UILabel alloc]init];
        sidesOne.font=FONTTHIRTY;
        sidesOne.textColor=[UIColor blackColor];
        sidesOne.alpha=0.87;
        [self.contentView addSubview:sidesOne];
        self.sidesOne=sidesOne;
        
        UILabel * VS=[[UILabel alloc]init];
        VS.text=@"VS";
        VS.font=FONTTHIRTY;
        VS.textColor=[UIColor blackColor];
        VS.alpha=0.87;
        [self.contentView addSubview:VS];
        self.VS=VS;
        
        UILabel * sidesTwo=[[UILabel alloc]init];
        sidesTwo.font=FONTTHIRTY;
        sidesTwo.textColor=[UIColor blackColor];
        sidesTwo.alpha=0.87;
        [self.contentView addSubview:sidesTwo];
        self.sidesTwo=sidesTwo;
        
        correctImage=[UIImage imageNamed:@"不中退款背景"];
        UIImageView * refundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(MyWidth-correctImage.size.width-15,timeLabel.frame.origin.y,correctImage.size.width, correctImage.size.height)];
        refundImageView.image=correctImage;
        self.refundImageView=refundImageView;
        [self.contentView addSubview:refundImageView];
        
        UILabel * refundLabel=[[UILabel alloc]initWithFrame:CGRectMake(refundImageView.frame.origin.x+5,refundImageView.frame.origin.y, correctImage.size.width-10,correctImage.size.height)];
        self.refundLabel=refundLabel;
        [self.contentView addSubview:refundLabel];
        refundLabel.text=@"不中退款";
        refundLabel.textAlignment=NSTextAlignmentCenter;
        refundLabel.font=FONTTWENTY_FOUR;
        refundLabel.textColor=RGB(255.,59.,48.);
        
        UILabel * time=[[UILabel alloc]init];
        time.font=FONTTWENTY_FOUR;
        time.textColor=BLACK_FIFITYFOUR;
        [self.contentView addSubview:time];
        self.time=time;
        
        UILabel *fangAnameLab=[[UILabel alloc] init];
        fangAnameLab.font=FONTTWENTY_FOUR;
        fangAnameLab.textColor=BLACK_EIGHTYSEVER;
        [self.contentView addSubview:fangAnameLab];
        _recNameLab=fangAnameLab;
        
        //查看方案详情按钮
        UIButton * planDetailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        planDetailBtn.frame=CGRectMake(15, CGRectGetMaxY(time.frame)+15, MyWidth-30, 35);
        [planDetailBtn setTitleColor:RGB(255., 255., 255.) forState:UIControlStateNormal];
        [planDetailBtn setTitleColor:RGB(255., 255., 255.) forState:UIControlStateSelected];
        [planDetailBtn setTitleColor:RGB(255., 255., 255.) forState:UIControlStateHighlighted];
        [planDetailBtn setBackgroundImage:[UIImage imageNamed:@"方案详情按钮"] forState:UIControlStateNormal];
        [planDetailBtn setBackgroundImage:[UIImage imageNamed:@"方案详情按钮"] forState:UIControlStateHighlighted];
        planDetailBtn.titleLabel.font=FONTTWENTY_EIGHT;
        self.planDetailBtn=planDetailBtn;
        [planDetailBtn addTarget:self action:@selector(planDetailBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:planDetailBtn];
        
        UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,184.32, MyWidth, 0.5)];
        Line.backgroundColor=SEPARATORCOLOR;
        [self.contentView addSubview:Line];
    }
    return self;
}

-(void)setCellMatchTime:(NSString *)matchTime homeTeam:(NSString *)homeTeam visiTeam:(NSString *)visiTeam starTime:(NSString *)starTime price:(NSString *)price matchType:(NSString *)matchType exsource:(NSInteger)source titName:(NSString *)titName isSd:(BOOL)isSd
{
    CGSize cellUIsize=[PublicMethod setNameFontSize:matchTime andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.timeLabel.text=matchTime;
    self.timeLabel.frame=CGRectMake(15, 15, cellUIsize.width,cellUIsize.height);
    
    cellUIsize=[PublicMethod setNameFontSize:matchType andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rect=_matchTypeImageView.frame;
    rect.origin.y=CGRectGetMaxY(self.timeLabel.frame)+10;
    rect.size.width=cellUIsize.width+20;
    [self.matchTypeImageView setFrame:rect];
    
    rect=self.matchType.frame;
    rect.origin.x=self.matchTypeImageView.frame.origin.x+5;
    rect.origin.y=CGRectGetMaxY(self.timeLabel.frame)+10;
    rect.size.width=cellUIsize.width+10;
    [self.matchType setFrame:rect];
    self.matchType.text=matchType;
    
    UIImage *correctImage=[UIImage imageNamed:@"已发方案-英超-描边标签"];
    self.sidesOne.text=homeTeam;
    cellUIsize=[PublicMethod setNameFontSize:self.sidesOne.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.sidesOne.frame=CGRectMake(CGRectGetMaxX(self.matchTypeImageView.frame)+15,self.matchTypeImageView.frame.origin.y-cellUIsize.height/2+correctImage.size.height/2, cellUIsize.width, cellUIsize.height);
    
    cellUIsize=[PublicMethod setNameFontSize:@"VS" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.VS.text=@"VS";
    self.VS.frame=CGRectMake(CGRectGetMaxX(self.sidesOne.frame)+28,self.matchTypeImageView.frame.origin.y, cellUIsize.width, cellUIsize.height);
    
    self.sidesTwo.text=visiTeam;
    cellUIsize=[PublicMethod setNameFontSize:self.sidesTwo.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.sidesTwo.frame=CGRectMake(CGRectGetMaxX(self.VS.frame)+28,self.matchTypeImageView.frame.origin.y-cellUIsize.height/2+correctImage.size.height/2, cellUIsize.width, cellUIsize.height);
    
    if (source==0) {
        self.refundImageView.hidden=YES;
        self.refundLabel.hidden=YES;
    }else{
        self.refundImageView.hidden=NO;
        self.refundLabel.hidden=NO;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date=[dateFormatter dateFromString:starTime];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM月dd日 HH:mm"];
    
    starTime=[NSString stringWithFormat:@"比赛时间 %@",[dateFormatter2 stringFromDate:date]];
    
    cellUIsize=[PublicMethod setNameFontSize:starTime andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.time.text=starTime;
    self.time.frame=CGRectMake(self.timeLabel.frame.origin.x, CGRectGetMaxY(self.matchTypeImageView.frame)+10, cellUIsize.width, cellUIsize.height);
    
    cellUIsize=[PublicMethod setNameFontSize:titName andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.recNameLab.text=titName;
    self.recNameLab.frame=CGRectMake(self.timeLabel.frame.origin.x, CGRectGetMaxY(self.time.frame)+20, cellUIsize.width, cellUIsize.height);
    
    NSString *depictPrcie=@"";
    if([price floatValue]==0.00){
#if defined YUCEDI || defined DONGGEQIU
        if ([[caiboAppDelegate getAppDelegate] isShenhe]) {
            depictPrcie=@"查看方案详情";
        }
        else {
            depictPrcie=@"查看方案详情(免费)";
        }
#else
        depictPrcie=@"查看方案详情(免费)";
#endif
    }else {
        depictPrcie=[NSString stringWithFormat:@"查看方案详情(%@元)",price];
#ifdef CRAZYSPORTS
        int jinbibeishu = 10;//金币和钱比例
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
            jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
        }
        depictPrcie=[NSString stringWithFormat:@"查看方案详情(%.0f金币)",[price floatValue] * jinbibeishu];
#endif
    }

    if(isSd){
        depictPrcie=@"查看方案详情";
    }
    
    [self.planDetailBtn setTitle:depictPrcie forState:UIControlStateNormal];
    self.planDetailBtn.frame=CGRectMake(15, CGRectGetMaxY(self.recNameLab.frame)+15, MyWidth-30, 35);
    
    NSLog(@"planDetailBtn高度：%f",CGRectGetMaxY(self.planDetailBtn.frame)+15);
}

/**
 *  查看方案详情按钮
 *
 *  @param btn 按钮
 */
-(void)planDetailBtnOnClick:(UIButton *)btn
{
    NSLog(@"查看方案详情");
    [_delegateSMG SMGDetailCellPlanDetail:btn SMGDetailCell:self];
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    