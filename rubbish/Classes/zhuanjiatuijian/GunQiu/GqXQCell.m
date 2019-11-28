//
//  GqXQCell.m
//  caibo
//
//  Created by zhoujunwang on 16/5/27.
//
//

#import "GqXQCell.h"

@interface GqXQCell()

@property(nonatomic,strong) GqXQMdl *gqXQMdl;

@end

@implementation GqXQCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithHexString:@"ecedf1"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatCell];
    }
    return self;
}

-(void)creatCell
{
    topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 86.0)];
    topView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:topView];
    
    //头像
    headImage=[[UIImageView alloc] initWithFrame:CGRectZero];
    headImage.frame=CGRectMake(16.0, topView.frame.size.height/2-27.5, 55.0, 55.0);
    headImage.clipsToBounds=YES;
    headImage.layer.cornerRadius=55.0/2;
    headImage.backgroundColor=[UIColor clearColor];
    [topView addSubview:headImage];
    
    rvImgv=[[UIImageView alloc]initWithFrame:CGRectMake(headImage.frame.size.width+32./4-6, (headImage.frame.size.height-15.0/4+3), 14.0, 14.0)];
    rvImgv.image = [UIImage imageNamed:@"V_red"];
    [topView addSubview:rvImgv];
    
    //名字
    labName=[[UILabel alloc] initWithFrame:CGRectMake(15.0+CGRectGetMaxX(headImage.frame), 33,100.0, 20.0)];
    labName.font = FONTTHIRTY_TWO;
    labName.textColor=BLACK_EIGHTYSEVER;
    labName.backgroundColor=[UIColor clearColor];
    labName.text=@"";
    [topView addSubview:labName];
    
    djImgV=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(labName)+10, labName.frame.origin.y+labName.frame.size.height/2-7, 39, 14)];
    djImgV.backgroundColor=[UIColor clearColor];
    [topView addSubview:djImgV];
    
    djLab=[[UILabel alloc] initWithFrame:CGRectMake(17, 0, 22, 14)];
    djLab.backgroundColor=[UIColor clearColor];
    djLab.font=[UIFont systemFontOfSize:8.0];
    djLab.textColor=RGBColor(255.0, 96.0, 0.0);
    djLab.textAlignment=NSTextAlignmentLeft;
    djLab.text=@"";
    [djImgV addSubview:djLab];
    
    topViewLine=[[UIView alloc]initWithFrame:CGRectMake(0, topView.frame.size.height-0.5, MyWidth, 0.5)];
    topViewLine.backgroundColor = SEPARATORCOLOR;
    [topView addSubview:topViewLine];
    
    gamePlanView=[[UIView alloc] initWithFrame:CGRectMake(0.0, ORIGIN_Y(topView)+8, MyWidth, 200)];
    gamePlanView.backgroundColor=[UIColor whiteColor];
    gamePlanView.layer.masksToBounds=YES;
    gamePlanView.layer.borderWidth=0.5;
    gamePlanView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [self.contentView addSubview:gamePlanView];
    
    //时间
    NSString *str=@"周四 009";
    CGSize cgSize=[PublicMethod setNameFontSize:str andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    gameNolab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, cgSize.width, cgSize.height)];
    gameNolab.textColor=BLACK_EIGHTYSEVER;
    gameNolab.font=FONTTWENTY_FOUR;
    [gamePlanView addSubview:gameNolab];
    
    //英超
    legImgView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(gameNolab.frame)+10, 10, 42.5, 15.5)];
    legImgView.image=[UIImage imageNamed:@"已发方案-英超-描边标签"];
    [gamePlanView addSubview:legImgView];
    
    CGSize wnSize=[PublicMethod setNameFontSize:@"英超" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //联赛名称
    workNameLab=[[UILabel alloc] initWithFrame:CGRectMake(5, 0,wnSize.width+10, wnSize.height)];
    workNameLab.textAlignment = NSTextAlignmentCenter;
    workNameLab.textColor=[UIColor colorWithRed:0.1 green:0.64 blue:1 alpha:1];
    workNameLab.font=FONTTWENTY_FOUR;
    [legImgView addSubview:workNameLab];
    
    //比赛时间
    gameTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(MyWidth-130, 10, 130, 15)];
    gameTimeLab.font = FONTTWENTY_FOUR;
    gameTimeLab.textColor = BLACK_FIFITYFOUR;
    [gamePlanView addSubview:gameTimeLab];
    
    firSecLine=[[UIView alloc] initWithFrame:CGRectMake(0, 35, MyWidth, 0.5)];
    firSecLine.backgroundColor = SEPARATORCOLOR;
    [gamePlanView addSubview:firSecLine];
    
    cgSize=[PublicMethod setNameFontSize:@"10:20" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    scrlab = [[UILabel alloc]initWithFrame:CGRectMake(160-cgSize.width/2, 50, cgSize.width, cgSize.height)];
    scrlab.textAlignment=NSTextAlignmentCenter;
    scrlab.font=FONTTHIRTY;
    scrlab.textColor=BLACK_EIGHTYSEVER;
    [gamePlanView addSubview:scrlab];
    
    cgSize=[PublicMethod setNameFontSize:@"伯明翰" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //比赛双方
    startNameLab=[[UILabel alloc] initWithFrame:CGRectMake(120-cgSize.width, 50, cgSize.width, cgSize.height)];
    startNameLab.font=FONTTHIRTY;
    startNameLab.textColor=BLACK_EIGHTYSEVER;
    startNameLab.textAlignment = NSTextAlignmentRight;
    [gamePlanView addSubview:startNameLab];
    
    endNameLab=[[UILabel alloc] initWithFrame:CGRectMake(200, 50, cgSize.width, cgSize.height)];
    endNameLab.font=FONTTHIRTY;
    endNameLab.textColor=BLACK_EIGHTYSEVER;
    endNameLab.textAlignment = NSTextAlignmentLeft;
    [gamePlanView addSubview:endNameLab];
    
    cgSize=[PublicMethod setNameFontSize:@"42'" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    timeLab=[[UILabel alloc] initWithFrame:CGRectMake(160-cgSize.width/2, ORIGIN_Y(scrlab)+8, cgSize.width, cgSize.height)];
    timeLab.font=FONTTWENTY_FOUR;
    timeLab.textColor=BLACK_FIFITYFOUR;
    timeLab.textAlignment = NSTextAlignmentCenter;
    [gamePlanView addSubview:timeLab];
    
    secSecLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeLab.frame)+15, MyWidth, 0.5)];
    secSecLine.backgroundColor = SEPARATORCOLOR;
    [gamePlanView addSubview:secSecLine];
    
    gqBgView=[[UIView alloc] initWithFrame:CGRectMake(0, 208, 320, 217)];
    gqBgView.backgroundColor=[UIColor whiteColor];
    gqBgView.hidden=NO;
    [self.contentView addSubview:gqBgView];
    
    for (int i=0; i<3; i++) {
        if (i==0) {
            str = @"赛前赔率";
        }else if (i==1){
            str = @"最新赔率";
        }else if (i==2){
            str = @"发布时赔率";
        }
        cgSize = [PublicMethod setNameFontSize:str andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        gqplab=[[UILabel alloc] initWithFrame:CGRectMake(15, 15+(cgSize.height+53)*i, cgSize.width, cgSize.height)];
        gqplab.text=str;
        gqplab.textColor=BLACK_EIGHTYSEVER;
        gqplab.font=FONTTWENTY_FOUR;
        gqplab.backgroundColor=[UIColor clearColor];
        gqplab.tag=100*i+701;
        [gqBgView addSubview:gqplab];
        
        gqCharView=[[ChartFormView alloc] initWithFrame:CGRectMake(15, 23+cgSize.height+(cgSize.height+53)*i, 290, 30)];
        gqCharView.backgroundColor=[UIColor clearColor];
        gqCharView.tag=100*i+702;
        [gqBgView addSubview:gqCharView];
        
        gqzlab=[[UILabel alloc] initWithFrame:CGRectMake(0.5, 0.5, 290/3-1, 29)];
        gqzlab.textColor=BLACK_FIFITYFOUR;
        gqzlab.font=[UIFont systemFontOfSize:11];
        gqzlab.textAlignment=NSTextAlignmentCenter;
        gqzlab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        gqzlab.tag=100*i+703;
        [gqCharView addSubview:gqzlab];
        
        gqsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        gqsBtn.frame = CGRectMake(290/3+(290/3-50)/2, 7.5, 50, 15);
        [gqsBtn setBackgroundImage:[UIImage imageNamed:@"gqNewRec"] forState:UIControlStateNormal];
        [gqsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [gqsBtn setTitle:@"" forState:UIControlStateNormal];
        gqsBtn.titleLabel.font=FONTTWENTY_FOUR;
        gqsBtn.tag=100*i+704;
        [gqCharView addSubview:gqsBtn];
        
        gqklab=[[UILabel alloc] initWithFrame:CGRectMake(580/3+0.5, 0.5, 290/3-1, 29)];
        gqklab.textColor=BLACK_FIFITYFOUR;
        gqklab.font=[UIFont systemFontOfSize:11];
        gqklab.textAlignment=NSTextAlignmentCenter;
        gqklab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        gqklab.tag=100*i+705;
        [gqCharView addSubview:gqklab];
        if (i==2) {
            CGRect rect=gqBgView.frame;
            rect.size.height=ORIGIN_Y(gqCharView)+15;
            [gqBgView setFrame:rect];
        }
    }
    
    recResnView = [[UIView alloc]initWithFrame:CGRectMake(0, 433, MyWidth, 100)];
    recResnView.backgroundColor = [UIColor whiteColor];
    recResnView.layer.masksToBounds=YES;
    recResnView.layer.borderWidth=0.5;
    recResnView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [self.contentView addSubview:recResnView];
    
    str = @"推荐理由";
    cgSize = [PublicMethod setNameFontSize:str andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    recLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, cgSize.width, cgSize.height)];
    if (IS_IOS7) {
        recLab.tintColor = BLACK_EIGHTYSEVER;
    }
    recLab.textColor=BLACK_EIGHTYSEVER;
    recLab.font = FONTTWENTY_FOUR;
    recLab.text = str;
    [recResnView addSubview:recLab];
    
    contentLab = [[UILabel alloc]initWithFrame:CGRectMake(15, ORIGIN_Y(recLab)+15, MyWidth-30, 40)];
    if (IS_IOS7) {
        contentLab.tintColor = BLACK_TWENTYSIX;
    }
    contentLab.textColor = BLACK_FIFITYFOUR;
    contentLab.numberOfLines = 0;
    contentLab.font = FONTTWENTY_SIX;
    [recResnView addSubview:contentLab];
    
    planCTlab=[[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(recResnView)+8, 290, 15)];
    planCTlab.backgroundColor=[UIColor clearColor];
    planCTlab.textColor=BLACK_FIFITYFOUR;
    planCTlab.font=FONTTWENTY_FOUR;
    planCTlab.hidden=YES;
    [self.contentView addSubview:planCTlab];
}

- (void)setGqMdl:(GqXQMdl *)gqXQMdl
{
    [headImage sd_setImageWithURL:[NSURL URLWithString:gqXQMdl.headPortrait] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    
    NSString *str = gqXQMdl.expertNickName;
    CGSize cgSize=[PublicMethod setNameFontSize:str andFont:FONTTHIRTY_TWO andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    labName.text = str;
    labName.frame = CGRectMake(15.0+CGRectGetMaxX(headImage.frame), 43-cgSize.height/2,cgSize.width, cgSize.height);
    
    int level=[[gqXQMdl.dicNo objectForKey:@"star"] intValue];
    [djImgV setFrame:CGRectMake(ORIGIN_X(labName)+10, labName.frame.origin.y+(labName.frame.size.height-14)/2, 39, 14)];
    NSString *rankImg=@"";
    if (level<=5) {
        rankImg=@"ranklv1-5";
        djLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (level>5&&level<=10){
        rankImg=@"ranklv6-10";
        djLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (level>10&&level<=15){
        rankImg=@"ranklv11-15";
        djLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (level>15&&level<=20){
        rankImg=@"ranklv16-20";
        djLab.textColor=[UIColor whiteColor];
    }else if (level>20&&level<=25){
        rankImg=@"ranklv21-25";
        djLab.textColor=[UIColor whiteColor];
    }
    djImgV.image=[UIImage imageNamed:rankImg];
    djLab.text=[NSString stringWithFormat:@"LV%ld",(long)level];
    CGSize reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)level] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [djLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    gameNolab.text = gqXQMdl.dayOfWeek;
    cgSize=[PublicMethod setNameFontSize:gqXQMdl.dayOfWeek andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rect=gameNolab.frame;
    rect.size.width=cgSize.width;
    rect.size.height=cgSize.height;
    [gameNolab setFrame:rect];
    
    cgSize=[PublicMethod setNameFontSize:gqXQMdl.leagueName andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=legImgView.frame;
    rect.origin.x=CGRectGetMaxX(gameNolab.frame)+10;
    rect.size.width=cgSize.width+20;
    [legImgView setFrame:rect];
    
    workNameLab.frame =  CGRectMake(5, 0,cgSize.width+10, cgSize.height);
    workNameLab.text = gqXQMdl.leagueName;
    
    gameTimeLab.text = gqXQMdl.matchTime;
    cgSize=[PublicMethod setNameFontSize:gqXQMdl.matchTime andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [gameTimeLab setFrame:CGRectMake(320-15-cgSize.width, 17.5-cgSize.height/2, cgSize.width, cgSize.height)];
    
    rect= scrlab.frame;
    rect.origin.y=ORIGIN_Y(firSecLine)+15;
    scrlab.frame = rect;
    if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==0){
        scrlab.text=@"VS";
    }else
        scrlab.text=[NSString stringWithFormat:@"%d:%d",[[gqXQMdl.dicNo valueForKey:@"homeScore"] intValue],[[gqXQMdl.dicNo valueForKey:@"awayScore"] intValue]];
    
    startNameLab.text = gqXQMdl.homeName;
    cgSize=[PublicMethod setNameFontSize:startNameLab.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    startNameLab.frame = CGRectMake(CGRectGetMinX(scrlab.frame)-cgSize.width-28, ORIGIN_Y(firSecLine)+15, cgSize.width, cgSize.height);
    
    endNameLab.text = gqXQMdl.awayName;
    cgSize=[PublicMethod setNameFontSize:endNameLab.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    endNameLab.frame = CGRectMake(CGRectGetMaxX(scrlab.frame)+28, ORIGIN_Y(firSecLine)+15, cgSize.width, cgSize.height);
    
    if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==0){
        timeLab.text=@"未开赛";
    }else if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==1){
        timeLab.text=[NSString stringWithFormat:@"%@'",[gqXQMdl.dicNo objectForKey:@"hasBeenMinutes"] ];
    }else if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==2){
        timeLab.text=@"已结束";
    }
    
    cgSize=[PublicMethod setNameFontSize:timeLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=timeLab.frame;
    rect.origin.x=160-cgSize.width/2;
    rect.origin.y=ORIGIN_Y(scrlab)+8.0;
    rect.size.width=cgSize.width;
    [timeLab setFrame:rect];
    
    secSecLine.frame = CGRectMake(0, CGRectGetMaxY(timeLab.frame)+15, MyWidth, 0.5);
    
    rect=gamePlanView.frame;
    rect.size.height=ORIGIN_Y(timeLab)+15;
    [gamePlanView setFrame:rect];
    
    rect=gqBgView.frame;
    rect.origin.y=ORIGIN_Y(gamePlanView)+8;
    if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==0){
        rect.size.height=82;
    }else{
        rect.size.height=217;
        if ([[gqXQMdl.dicNo objectForKey:@"recommendStatus"] intValue]==0) {
            rect.size.height=217-53-cgSize.height;
        }
    }
    [gqBgView setFrame:rect];
    
    ChartFormView *charForV=(ChartFormView *)[gqBgView viewWithTag:702];
    UILabel *lab=(UILabel *)[charForV viewWithTag:703];
    lab.text=[NSString stringWithFormat:@"主(%@)",gqXQMdl.oddsBeforeHomeWin];
    
    UIButton *btn=(UIButton *)[charForV viewWithTag:704];
    [btn setTitle:gqXQMdl.hostRqBefore forState:UIControlStateNormal];
    
    lab=(UILabel *)[charForV viewWithTag:705];
    lab.text=[NSString stringWithFormat:@"客(%@)",gqXQMdl.oddsBeforeAwayWin];
    
    charForV=(ChartFormView *)[gqBgView viewWithTag:802];
    lab=(UILabel *)[gqBgView viewWithTag:801];
    if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==0){
        lab.hidden=YES;
        charForV.hidden=YES;
    }else{
        lab.hidden=NO;
        charForV.hidden=NO;
    }
    lab=(UILabel *)[charForV viewWithTag:803];
    lab.text=[NSString stringWithFormat:@"主(%@)",gqXQMdl.oddsNewHomeWin];
    
    btn=(UIButton *)[charForV viewWithTag:804];
    [btn setTitle:gqXQMdl.hostRqNew forState:UIControlStateNormal];
    
    lab=(UILabel *)[charForV viewWithTag:805];
    lab.text=[NSString stringWithFormat:@"客(%@)",gqXQMdl.oddsNewAwayWin];
    
    charForV=(ChartFormView *)[gqBgView viewWithTag:902];
    lab=(UILabel *)[gqBgView viewWithTag:901];
    if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==0){
        lab.hidden=YES;
        charForV.hidden=YES;
    }else{
        lab.hidden=NO;
        charForV.hidden=NO;
        if ([[gqXQMdl.dicNo objectForKey:@"recommendStatus"] intValue]==0) {
            lab.hidden=YES;
            charForV.hidden=YES;
        }
    }
    
    str = gqXQMdl.recommendContent;

    lab=(UILabel *)[charForV viewWithTag:903];
    lab.text=[NSString stringWithFormat:@"主(%@)",gqXQMdl.oddsReleaseHomeWin];
    if([str isEqualToString:@"主"]){
        lab.backgroundColor=[UIColor colorWithHexString:@"#fda000"];
        lab.textColor=[UIColor whiteColor];
    } else {
        lab.backgroundColor=[UIColor whiteColor];
        lab.textColor=BLACK_FIFITYFOUR;
    }
    
    btn=(UIButton *)[charForV viewWithTag:904];
    [btn setTitle:gqXQMdl.hostRqRelease forState:UIControlStateNormal];
    
    lab=(UILabel *)[charForV viewWithTag:905];
    lab.text=[NSString stringWithFormat:@"客(%@)",gqXQMdl.oddsReleaseAwayWin];
    if([str isEqualToString:@"客"]){
        lab.backgroundColor=[UIColor colorWithHexString:@"#fda000"];
        lab.textColor=[UIColor whiteColor];
    } else {
        lab.backgroundColor=[UIColor whiteColor];
        lab.textColor=BLACK_FIFITYFOUR;
    }
    
    if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==0){
        str=@"暂未开赛";
        cgSize=[PublicMethod setNameFontSize:str andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(300, 3000)];
        recResnView.frame=CGRectMake(0, CGRectGetMaxY(gqBgView.frame)+8, 320, 140+cgSize.height);
        contentLab.frame=CGRectMake(160-cgSize.width/2, 70, cgSize.width, cgSize.height);
    }else{
        str=gqXQMdl.recommendExplain;
        cgSize=[PublicMethod setNameFontSize:str andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(300, 3000)];
        recResnView.frame=CGRectMake(0, CGRectGetMaxY(gqBgView.frame)+8, 320, recLab.frame.size.height+cgSize.height+45);
        contentLab.frame=CGRectMake(15, CGRectGetMaxY(recLab.frame), 290, cgSize.height+30);
    }
    contentLab.text=str;
    
    if([[gqXQMdl.dicNo valueForKey:@"matchStatus"] intValue]==0){
        planCTlab.hidden=YES;
    }else{
        planCTlab.hidden=NO;
        
        planCTlab.text=[NSString stringWithFormat:@"方案创建于 %@",gqXQMdl.releaseTime];
        cgSize=[PublicMethod setNameFontSize:planCTlab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGRect rect=planCTlab.frame;
        rect.size.width=cgSize.width;
        rect.size.height=cgSize.height;
        rect.origin.y=ORIGIN_Y(recResnView)+8.0;
        [planCTlab setFrame:rect];
        
        if ([[gqXQMdl.dicNo objectForKey:@"recommendStatus"] intValue]==0) {
            planCTlab.hidden=YES;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    