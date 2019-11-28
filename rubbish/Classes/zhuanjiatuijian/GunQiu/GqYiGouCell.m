//
//  GqYiGouCell.m
//  caibo
//
//  Created by zhoujunwang on 16/5/28.
//
//

#import "GqYiGouCell.h"

@implementation GqYiGouCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 45, 45)];
        headImageView.layer.cornerRadius=22.5;
        headImageView.layer.masksToBounds=YES;
        self.headImgView=headImageView;
        [self.contentView addSubview:headImageView];
        
        UIImageView *markView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headImageView.frame)+30, CGRectGetMinY(headImageView.frame)+30, 15, 15)];
        markView.layer.cornerRadius=7.5;
        markView.layer.masksToBounds=YES;
        markView.image=[UIImage imageNamed:@"V_red"];
        [self.contentView addSubview:markView];
        
        UILabel *nickName=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, 15, 40, 20)];
        nickName.font=FONTTHIRTY;
        nickName.textColor=RGB(21., 136., 218.);
        [self.contentView addSubview:nickName];
        self.nikNamelab=nickName;
        
        UIImageView *rangImgV=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(nickName)+10, 17, 39, 14)];
        rangImgV.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:rangImgV];
        self.rkImgView=rangImgV;
        
        UILabel *rankLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 22, 14)];
        rankLab.backgroundColor=[UIColor clearColor];
        rankLab.font=[UIFont systemFontOfSize:8.0];
        rankLab.textColor=RGBColor(255.0, 96.0, 0.0);
        rankLab.textAlignment=NSTextAlignmentLeft;
        [rangImgV addSubview:rankLab];
        self.rankLab=rankLab;
        
        UIImageView *legImgView=[[UIImageView alloc] initWithFrame:CGRectMake(320-57.5, 17, 42.5, 15.5)];
        legImgView.image=[UIImage imageNamed:@"已发方案-英超-描边标签"];
        [self.contentView addSubview:legImgView];
        self.legTypeImgV=legImgView;
        
        CGSize wnSize=[PublicMethod setNameFontSize:@"英超" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *legNameLab=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, wnSize.width+10, wnSize.height)];
        legNameLab.textAlignment = NSTextAlignmentCenter;
        legNameLab.textColor=[UIColor colorWithRed:0.1 green:0.64 blue:1 alpha:1];
        legNameLab.font=FONTTWENTY_FOUR;
        [legImgView addSubview:legNameLab];
        self.legTypeLab=legNameLab;
        
        UILabel *twoSideLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, CGRectGetMaxY(nickName.frame)+8, 150, 20)];
        twoSideLab.font=FONTTHIRTY;
        twoSideLab.textColor=BLACK_EIGHTYSEVER;
        [self.contentView addSubview:twoSideLab];
        self.gameBothLab=twoSideLab;
        
        UILabel *priceLab=[[UILabel alloc] initWithFrame:CGRectMake(220, CGRectGetMinY(twoSideLab.frame), 85, 20)];
        priceLab.textColor=[UIColor colorWithHexString:@"#F0460E"];
        priceLab.font=FONTTWENTY_EIGHT;
        priceLab.textAlignment=NSTextAlignmentRight;
        priceLab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        [self.contentView addSubview:priceLab];
        self.priceLab=priceLab;
        
        UILabel *timelab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, CGRectGetMaxY(twoSideLab.frame)+8, 80, 20)];
        timelab.font=FONTTWENTY_FOUR;
        timelab.textColor=BLACK_FIFITYFOUR;
        [self.contentView addSubview:timelab];
        self.timeLab=timelab;
        
        UILabel *newStateLab=[[UILabel alloc] initWithFrame:CGRectMake(255, CGRectGetMinY(timelab.frame), 50, 15)];
        newStateLab.textAlignment=NSTextAlignmentCenter;
        newStateLab.textColor=TEXTWITER_COLOR;
        newStateLab.backgroundColor=[UIColor clearColor];
        newStateLab.font=[UIFont systemFontOfSize:9.0f];
        [self.contentView addSubview:newStateLab];
        _nowStateLab=newStateLab;
        
        UIView *sepView=[[UIView alloc] initWithFrame:CGRectMake(0, 99.5, 320, 0.5)];
        sepView.backgroundColor=SEPARATORCOLOR;
        [self.contentView addSubview:sepView];
        _sepView=sepView;
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //self.separatorInset=UIEdgeInsetsMake(0,0,0,0);
    }
    return self;
}

-(void)setPortView:(NSString *)portImgView nickName:(NSString *)nickName levels:(NSInteger)level legName:(NSString *)legName bothSide:(NSString *)bothSide price:(NSInteger)price time:(NSString *)time npTag:(NSString *)npTag
{
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:portImgView] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    self.legTypeLab.text = @"";
    
    self.nikNamelab.text = nickName;
    CGSize gqsize=[PublicMethod setNameFontSize:nickName andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (gqsize.width>72.0) {
        self.nikNamelab.frame=CGRectMake(CGRectGetMaxX(self.headImgView.frame)+15, 15,72.0,gqsize.height);
    }else{
        self.nikNamelab.frame=CGRectMake(CGRectGetMaxX(self.headImgView.frame)+15, 15, gqsize.width,gqsize.height);
    }

    [self.rkImgView setFrame:CGRectMake(ORIGIN_X(self.nikNamelab)+10, 15+(gqsize.height-14)/2, 39, 14)];
    NSString *rankImg=@"";
    if (level<=5) {
        rankImg=@"ranklv1-5";
        self.rankLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (level>5&&level<=10){
        rankImg=@"ranklv6-10";
        self.rankLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (level>10&&level<=15){
        rankImg=@"ranklv11-15";
        self.rankLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (level>15&&level<=20){
        rankImg=@"ranklv16-20";
        self.rankLab.textColor=[UIColor whiteColor];
    }else if (level>20&&level<=25){
        rankImg=@"ranklv21-25";
        self.rankLab.textColor=[UIColor whiteColor];
    }
    self.rkImgView.image=[UIImage imageNamed:rankImg];
    
    self.rankLab.text=[NSString stringWithFormat:@"LV%ld",(long)level];
    CGSize reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)level] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [self.rankLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    self.legTypeLab.text=legName;
    gqsize=[PublicMethod setNameFontSize:legName andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [self.legTypeLab setFrame:CGRectMake(5, 0,gqsize.width+10, gqsize.height)];;
    
    CGRect rect=self.legTypeImgV.frame;
    rect.size.width=gqsize.width+20;
    rect.origin.x=285-gqsize.width;
    [self.legTypeImgV setFrame:rect];
    
    self.gameBothLab.text=bothSide;
    gqsize=[PublicMethod setNameFontSize:bothSide andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (gqsize.width>=MyWidth-75) {
        self.gameBothLab.frame=CGRectMake(self.nikNamelab.frame.origin.x, CGRectGetMaxY(self.nikNamelab.frame)+8, MyWidth-75, gqsize.height);
    }else{
        self.gameBothLab.frame=CGRectMake(self.nikNamelab.frame.origin.x, CGRectGetMaxY(self.nikNamelab.frame)+8, gqsize.width, gqsize.height);
    }
    
    self.priceLab.text=[NSString stringWithFormat:@"¥%ld元",(long)price];
    gqsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_EIGHT andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.priceLab.frame=CGRectMake(MyWidth-gqsize.width-15,CGRectGetMinY(self.gameBothLab.frame)+(self.gameBothLab.frame.size.height-gqsize.height)/2, gqsize.width, gqsize.height);
    
    self.timeLab.text=time;
    gqsize=[PublicMethod setNameFontSize:time andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (gqsize.width>=136) {
        self.timeLab.frame=CGRectMake(self.nikNamelab.frame.origin.x, CGRectGetMaxY(self.gameBothLab.frame)+8, 136, gqsize.height);
    }else{
        self.timeLab.frame=CGRectMake(self.nikNamelab.frame.origin.x, CGRectGetMaxY(self.gameBothLab.frame)+8, gqsize.width, gqsize.height);
    }
    
    if([npTag isEqualToString:@""]||npTag==nil){
        self.nowStateLab.hidden=YES;
    }
    if([npTag isEqualToString:@"有新方案"]){
        self.nowStateLab.backgroundColor=[UIColor colorWithHexString:@"62c303"];
        self.nowStateLab.textColor=TEXTWITER_COLOR;
        self.nowStateLab.hidden=NO;
    }
    if ([npTag isEqualToString:@"暂未开赛"]) {
        self.nowStateLab.backgroundColor=[UIColor clearColor];
        self.nowStateLab.textColor=[UIColor colorWithHexString:@"fdaf00"];
        self.nowStateLab.layer.masksToBounds=YES;
        self.nowStateLab.layer.borderWidth=0.5;
        self.nowStateLab.layer.cornerRadius=2;
        self.nowStateLab.layer.borderColor=[UIColor colorWithHexString:@"fdaf00"].CGColor;
        self.nowStateLab.hidden=NO;
    }
    if ([npTag isEqualToString:@"结束比赛"]) {
        self.nowStateLab.backgroundColor=[UIColor clearColor];
        self.nowStateLab.textColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.36];
        self.nowStateLab.layer.masksToBounds=YES;
        self.nowStateLab.layer.borderWidth=0.5;
        self.nowStateLab.layer.cornerRadius=2;
        self.nowStateLab.layer.borderColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.26].CGColor;
        self.nowStateLab.hidden=NO;
    }
    self.nowStateLab.text=npTag;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    