//
//  TimeCell.m
//  Experts
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "TimeCell.h"

@interface TimeCell()

@property(nonatomic,strong) CompPlanInfoMdl *plainMdl;
@property(nonatomic,strong) CompExpInfoMdl *expMdl;
@property(nonatomic,strong) CompMdl *comptMdl;

@end

@implementation TimeCell

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
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 86.0)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    
    //头像
    headImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    headImage.frame = CGRectMake(16.0, topView.frame.size.height/2-27.5, 55.0, 55.0);
    headImage.clipsToBounds  = YES;
    headImage.layer.cornerRadius = 55.0/2;
    [topView addSubview:headImage];
    
    //红色V
    redVImage = [[UIImageView alloc]initWithFrame:CGRectMake(headImage.frame.size.width+32./4-6, (headImage.frame.size.height-15.0/4+3), 14.0, 14.0)];
    [topView addSubview:redVImage];
    
    //名字
    labName = [[UILabel alloc]initWithFrame:CGRectMake(15.0+CGRectGetMaxX(headImage.frame), 33,100.0, 20.0)];
    labName.font = FONTTHIRTY_SIX;
    [topView addSubview:labName];
    
    djImgV=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(labName)+10, labName.frame.size.height/2-7, 39, 14)];
    djImgV.backgroundColor=[UIColor clearColor];
    [topView addSubview:djImgV];
    djImgV.hidden = YES;
    
    djLab=[[UILabel alloc] initWithFrame:CGRectMake(17, 0, 22, 14)];
    djLab.backgroundColor=[UIColor clearColor];
    djLab.font=[UIFont systemFontOfSize:8.0];
    djLab.textColor=RGBColor(255.0, 96.0, 0.0);
    djLab.textAlignment=NSTextAlignmentLeft;
    [djImgV addSubview:djLab];
    
    topViewLine = [[UIView alloc]initWithFrame:CGRectMake(0, topView.frame.size.height-0.5, MyWidth, 0.5)];
    topViewLine.backgroundColor = SEPARATORCOLOR;
    [topView addSubview:topViewLine];
    
    gamePlanView = [[UIView alloc]initWithFrame:CGRectMake(0.0, ORIGIN_Y(topView)+10, MyWidth, 125)];
    gamePlanView.backgroundColor = [UIColor whiteColor];
    gamePlanView.layer.masksToBounds=YES;
    gamePlanView.layer.borderWidth=0.5;
    gamePlanView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [self.contentView addSubview:gamePlanView];
    
    //时间
    NSString *str=@"周四 009";
    CGSize cgSize=[PublicMethod setNameFontSize:str andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    gameNolab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, cgSize.width, cgSize.height)];
    gameNolab.font = FONTTWENTY_FOUR;
    [gamePlanView addSubview:gameNolab];
    
    //英超
    backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(gameNolab.frame)+10, 10, 42.5, 15.5)];
    backImageView.image = [UIImage imageNamed:@"已发方案-英超-描边标签"];
    [gamePlanView addSubview:backImageView];
    
    //联赛名称
    workNameLab = [[UILabel alloc]init];
    workNameLab.textAlignment = NSTextAlignmentCenter;
    workNameLab.textColor = [UIColor colorWithRed:0.1 green:0.64 blue:1 alpha:1];
    workNameLab.font = FONTTWENTY_FOUR;
    [backImageView addSubview:workNameLab];
    
    //比赛时间
    gameTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth-130, 10, 130, 20)];
    gameTimeLab.font = FONTTWENTY_FOUR;
    gameTimeLab.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.54];
    [gamePlanView addSubview:gameTimeLab];
    
    firSecLine = [[UIView alloc]initWithFrame:CGRectMake(0, ORIGIN_Y(backImageView)+10, MyWidth, 0.5)];
    firSecLine.backgroundColor = SEPARATORCOLOR;
    [gamePlanView addSubview:firSecLine];
    
    cgSize=[PublicMethod setNameFontSize:@"VS" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    VSLab = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth/2-cgSize.width, 27.5-cgSize.height/2, cgSize.width*2, cgSize.height)];
    VSLab.textAlignment=NSTextAlignmentCenter;
    VSLab.font = FONTTHIRTY;
    VSLab.text = @"VS";
    [gamePlanView addSubview:VSLab];
    
    //比赛双方
    startNameLab = [[UILabel alloc]init];
    startNameLab.font = FONTTHIRTY;
    startNameLab.textAlignment = NSTextAlignmentRight;
    [gamePlanView addSubview:startNameLab];
    
    endNameLab = [[UILabel alloc]init];
    endNameLab.font = FONTTHIRTY;
    endNameLab.textAlignment = NSTextAlignmentLeft;
    [gamePlanView addSubview:endNameLab];
    
    secSecLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(VSLab.frame)+20, MyWidth, 0.5)];
    secSecLine.backgroundColor = SEPARATORCOLOR;
    [gamePlanView addSubview:secSecLine];
    
    str=@"让球(++7)";
    cgSize=[PublicMethod setNameFontSize:str andFont:FONTTWENTY_EIGHT andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //让球
    letGameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(secSecLine.frame)+10, cgSize.width, cgSize.height)];
    letGameLab.font = FONTTWENTY_EIGHT;
    letGameLab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    [gamePlanView addSubview:letGameLab];
    
    //让球前中后比分图
    countStartLab = [UIButton buttonWithType:UIButtonTypeCustom];
    countStartLab.frame = CGRectMake(CGRectGetMaxX(letGameLab.frame)+15, CGRectGetMaxY(secSecLine.frame)+10, 65*MyWidth/320, 30);
    countStartLab.tag = 101;
    countStartLab.titleLabel.font=FONTTWENTY_FOUR;
    [gamePlanView addSubview:countStartLab];
    
    //橘色比分
    countMidLab =  [UIButton buttonWithType:UIButtonTypeCustom];
    countMidLab.frame = CGRectMake(CGRectGetMaxX(countStartLab.frame)+10, CGRectGetMinY(countStartLab.frame), 65*MyWidth/320, 30);
    countMidLab.tag = 102;
    countMidLab.titleLabel.font=FONTTWENTY_FOUR;
    [gamePlanView addSubview:countMidLab];
    
    //后比分
    countEndLab =  [UIButton buttonWithType:UIButtonTypeCustom];
    countEndLab.frame = CGRectMake(CGRectGetMaxX(countMidLab.frame)+10,CGRectGetMinY(countStartLab.frame), 65*MyWidth/320, 30);
    countEndLab.tag = 103;
    countEndLab.titleLabel.font=FONTTWENTY_FOUR;
    [gamePlanView addSubview:countEndLab];
    
//=======================================第二场比赛============================================
    gamePlanView2 = [[UIView alloc]initWithFrame:CGRectMake(0.0, ORIGIN_Y(gamePlanView), MyWidth, 125)];
    gamePlanView2.backgroundColor = [UIColor whiteColor];
    gamePlanView2.layer.masksToBounds=YES;
    gamePlanView2.layer.borderWidth=0.5;
    gamePlanView2.layer.borderColor=SEPARATORCOLOR.CGColor;
    [self.contentView addSubview:gamePlanView2];
    
    //时间
    NSString *str2=@"周四 009";
    CGSize cgSize2=[PublicMethod setNameFontSize:str2 andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    gameNolab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, cgSize2.width, cgSize2.height)];
    gameNolab2.font = FONTTWENTY_FOUR;
    [gamePlanView2 addSubview:gameNolab2];
    
    //英超
    backImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(gameNolab2.frame)+10, 10, 42.5, 15.5)];
    backImageView2.image = [UIImage imageNamed:@"已发方案-英超-描边标签"];
    [gamePlanView2 addSubview:backImageView2];
    
    //联赛名称
    workNameLab2 = [[UILabel alloc]init];
    workNameLab2.textAlignment = NSTextAlignmentCenter;
    workNameLab2.textColor = [UIColor colorWithRed:0.1 green:0.64 blue:1 alpha:1];
    workNameLab2.font = FONTTWENTY_FOUR;
    [backImageView2 addSubview:workNameLab2];
    
    //比赛时间
    gameTimeLab2 = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth-130, 10, 130, 20)];
    gameTimeLab2.font = FONTTWENTY_FOUR;
    gameTimeLab2.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.54];
    [gamePlanView2 addSubview:gameTimeLab2];
    
    firSecLine2 = [[UIView alloc]initWithFrame:CGRectMake(0, ORIGIN_Y(backImageView2)+10, MyWidth, 0.5)];
    firSecLine2.backgroundColor = SEPARATORCOLOR;
    [gamePlanView2 addSubview:firSecLine2];
    
    cgSize2=[PublicMethod setNameFontSize:@"VS" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    VSLab2 = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth/2-cgSize2.width, 27.5-cgSize2.height/2, cgSize2.width*2, cgSize2.height)];
    VSLab2.textAlignment=NSTextAlignmentCenter;
    VSLab2.font = FONTTHIRTY;
    VSLab2.text = @"VS";
    [gamePlanView2 addSubview:VSLab2];
    
    //比赛双方
    startNameLab2 = [[UILabel alloc]init];
    startNameLab2.font = FONTTHIRTY;
    startNameLab2.textAlignment = NSTextAlignmentRight;
    [gamePlanView2 addSubview:startNameLab2];
    
    endNameLab2 = [[UILabel alloc]init];
    endNameLab2.font = FONTTHIRTY;
    endNameLab2.textAlignment = NSTextAlignmentLeft;
    [gamePlanView2 addSubview:endNameLab2];
    
    secSecLine2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(VSLab2.frame)+20, MyWidth, 0.5)];
    secSecLine2.backgroundColor = SEPARATORCOLOR;
    [gamePlanView2 addSubview:secSecLine2];
    
    str2=@"让球(++7)";
    cgSize2=[PublicMethod setNameFontSize:str2 andFont:FONTTWENTY_EIGHT andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //让球
    letGameLab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(secSecLine2.frame)+10, cgSize2.width, cgSize2.height)];
    letGameLab2.font = FONTTWENTY_EIGHT;
    letGameLab2.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    [gamePlanView2 addSubview:letGameLab2];
    
    //让球前中后比分图
    countStartLab2 = [UIButton buttonWithType:UIButtonTypeCustom];
    countStartLab2.frame = CGRectMake(CGRectGetMaxX(letGameLab2.frame)+15, CGRectGetMaxY(secSecLine2.frame)+10, 65*MyWidth/320, 30);
    countStartLab2.tag = 101;
    countStartLab2.titleLabel.font=FONTTWENTY_FOUR;
    [gamePlanView2 addSubview:countStartLab2];
    
    //橘色比分
    countMidLab2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    countMidLab2.frame = CGRectMake(CGRectGetMaxX(countStartLab2.frame)+10, CGRectGetMinY(countStartLab2.frame), 65*MyWidth/320, 30);
    countMidLab2.tag = 102;
    countMidLab2.titleLabel.font=FONTTWENTY_FOUR;
    [gamePlanView2 addSubview:countMidLab2];
    
    //后比分
    countEndLab2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    countEndLab2.frame = CGRectMake(CGRectGetMaxX(countMidLab2.frame)+10,CGRectGetMinY(countStartLab2.frame), 65*MyWidth/320, 30);
    countEndLab2.tag = 103;
    countEndLab2.titleLabel.font=FONTTWENTY_FOUR;
    [gamePlanView2 addSubview:countEndLab2];
//===========================================================================================
    
    recResnView = [[UIView alloc]initWithFrame:CGRectMake(0, ORIGIN_Y(gamePlanView2)+10, MyWidth, 100)];
    recResnView.backgroundColor = [UIColor whiteColor];
    recResnView.layer.masksToBounds=YES;
    recResnView.layer.borderWidth=0.5;
    recResnView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [self.contentView addSubview:recResnView];
    
    str = @"推荐理由";
    cgSize = [PublicMethod setNameFontSize:str andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    recLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, cgSize.width, cgSize.height)];
    if (IS_IOS7) {
        recLab.tintColor = BLACK_EIGHTYSEVER;
    }
    recLab.textColor=BLACK_EIGHTYSEVER;
    recLab.font = FONTTHIRTY;
    recLab.text = str;
    [recResnView addSubview:recLab];
    
    contentLab = [[UILabel alloc]initWithFrame:CGRectMake(15, ORIGIN_Y(recLab)+15, MyWidth-30, 40)];
    if (IS_IOS7) {
        contentLab.tintColor = BLACK_TWENTYSIX;
    }
    contentLab.textColor = BLACK_SEVENTY;
    contentLab.numberOfLines = 0;
    contentLab.font = FONTTWENTY_SIX;
    [recResnView addSubview:contentLab];
    
    thirdView=[[UIView alloc] init];
    [self.contentView addSubview:thirdView];
    
    betBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [betBtn setTitle:@"投注此推荐" forState:UIControlStateNormal];
    [betBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:normal];
    [betBtn addTarget:self action:@selector(betClick:) forControlEvents:UIControlEventTouchUpInside];
#if defined YUCEDI || defined DONGGEQIU || defined CRAZYSPORTS
    betBtn.hidden=YES;
#else
    betBtn.hidden=NO;
#endif
    
    [self.contentView addSubview:betBtn];
}

- (void)setDataModel:(GameDetailMdl *)compModel lotryTy:(NSString *)lotryType isSd:(NSString *)isSd
{
    _expMdl = [[CompExpInfoMdl alloc]init];
    _plainMdl = [[CompPlanInfoMdl alloc]init];
    _comptMdl = [[CompMdl alloc]init];
    NSDictionary *experInfoDic = compModel.expertInfo;
    NSDictionary *plainInfoDic = compModel.planInfo;
    [_expMdl setValuesForKeysWithDictionary:experInfoDic];
    [_plainMdl setValuesForKeysWithDictionary:plainInfoDic];
    for (NSDictionary  *plainDic in _plainMdl.contentInfo) {
        [_comptMdl setValuesForKeysWithDictionary:plainDic];
    }
    [headImage sd_setImageWithURL:[NSURL URLWithString:_expMdl.headPortrait] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    
    if ([_expMdl.source isEqualToString:@"0"]) {
        redVImage.image = [UIImage imageNamed:@"V_red"];
    }else{
        redVImage.image = [UIImage imageNamed:@""];
    }
    
    //根据不同字体大小获取字体的宽度
    NSString  *nameStr = _expMdl.expertsNickName;
    CGSize cgSize=[PublicMethod setNameFontSize:nameStr andFont:[UIFont systemFontOfSize:18] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    labName.text = nameStr;
    labName.frame = CGRectMake(15.0+CGRectGetMaxX(headImage.frame), 43-cgSize.height/2,cgSize.width, cgSize.height);
    
    int level=[_expMdl.expertsLevelValue intValue];
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
    
    //联赛场次
    gameNolab.text = _comptMdl.matchesId;
    cgSize=[PublicMethod setNameFontSize:_comptMdl.matchesId andFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [gameNolab setFrame:CGRectMake(15, 20-cgSize.height/2, cgSize.width+5, cgSize.height)];
    
    cgSize=[PublicMethod setNameFontSize:_comptMdl.leagueName andFont:[UIFont systemFontOfSize:12.] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    backImageView.frame = CGRectMake(CGRectGetMaxX(gameNolab.frame)+10, 10,cgSize.width+20, 20);
    
    //联赛名称
    workNameLab.frame =  CGRectMake(5, 2,cgSize.width+10, cgSize.height);
    workNameLab.text = _comptMdl.leagueName;
    
    //联赛时间
    gameTimeLab.text = _comptMdl.matchTime;
    [gameTimeLab setFrame:CGRectMake(MyWidth-130, 10, 130, 20)];
    
    firSecLine.frame = CGRectMake(0, ORIGIN_Y(backImageView)+10, MyWidth, 0.5);
    
    CGRect rect= VSLab.frame;
    rect.origin.y=ORIGIN_Y(firSecLine)+20;
    VSLab.frame = rect;
    
    //比赛主队
    startNameLab.text = _comptMdl.homeName;
    if([lotryType isEqualToString:@"204"]){
        startNameLab.text = [NSString stringWithFormat:@"%@(客)",_comptMdl.awayName];
    }
    cgSize=[PublicMethod setNameFontSize:startNameLab.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    startNameLab.frame = CGRectMake(CGRectGetMinX(VSLab.frame)-cgSize.width-28, ORIGIN_Y(firSecLine)+20, cgSize.width, cgSize.height);
    
    //比赛客队
    endNameLab.text = _comptMdl.awayName;
    if([lotryType isEqualToString:@"204"]){
        endNameLab.text = [NSString stringWithFormat:@"%@(主)",_comptMdl.homeName];
    }
    cgSize=[PublicMethod setNameFontSize:endNameLab.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    endNameLab.frame = CGRectMake(CGRectGetMaxX(VSLab.frame)+28, ORIGIN_Y(firSecLine)+20, cgSize.width, cgSize.height);
    
    secSecLine.frame = CGRectMake(0, CGRectGetMaxY(VSLab.frame)+20, MyWidth, 0.5);
    
    NSString  *countStr = @"";
    if ([lotryType isEqualToString:@"-201"] || [lotryType isEqualToString:@"201"]) {
        NSString *letPlayStr = _comptMdl.playTypeCode;
        if ([letPlayStr isEqualToString:@"01"]) {//让球胜平负
            countStr = _comptMdl.rqOdds;
            letGameLab.text = [NSString stringWithFormat:@"让球(%@)",_comptMdl.rqs];//让球数
        }else{//胜平负
            countStr = _comptMdl.odds;
            letGameLab.text = @" 胜平负";
        }
    }else if([lotryType isEqualToString:@"202"]){
        countStr = _comptMdl.rqOdds;
        letGameLab.text = _plainMdl.infoSource;
    }else if ([lotryType isEqualToString:@"204"]){
        NSString *letPlayStr = _comptMdl.playTypeCode;
        if ([letPlayStr isEqualToString:@"27"]) {//让分胜负
            countStr = _comptMdl.odds;
            letGameLab.text = [NSString stringWithFormat:@"让分胜负"];//
        }else{//大小分
            countStr = _comptMdl.odds;
            letGameLab.text = @"大小分";
        }
    }
    
    cgSize=[PublicMethod setNameFontSize:letGameLab.text andFont:FONTTWENTY_EIGHT andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    letGameLab.frame = CGRectMake(15,ORIGIN_Y(secSecLine)+25-cgSize.height/2, cgSize.width, cgSize.height);
    
    NSString *startStr = @"胜";
    NSString *midStr = @"平";
    NSString *endStr = @"负";
    
    NSArray *oddArr=[countStr componentsSeparatedByString:@" "];
    
    if ([lotryType isEqualToString:@"-201"] || [lotryType isEqualToString:@"201"]) {
        if (countStr.length > 13) {//球分
            startStr = [oddArr objectAtIndex:0];
            midStr = [oddArr objectAtIndex:1];
            endStr = [oddArr objectAtIndex:2];
        }
    }else if([lotryType isEqualToString:@"202"]){
        midStr = _comptMdl.rqs;
        if ([oddArr count]==2) {//球分
            startStr = [NSString stringWithFormat:@"主(%@)",[oddArr objectAtIndex:0]];
            endStr = [NSString stringWithFormat:@"客(%@)",[oddArr objectAtIndex:1]];
        }
    }else if ([lotryType isEqualToString:@"204"]){
        midStr = @"";
        startStr = [oddArr objectAtIndex:0];
        midStr = _comptMdl.rqs;
        endStr = [oddArr objectAtIndex:1];
    }
    [countStartLab setTitle:startStr forState:UIControlStateNormal];
    [countMidLab setTitle:midStr forState:UIControlStateNormal];
    [countEndLab setTitle:endStr forState:UIControlStateNormal];
    
    //球分的颜色
    NSString *recommentStr = _comptMdl.recommendContent;
//    NSRange range = [recommentStr rangeOfString:@" "];
//    NSString *resultStr=[recommentStr substringFromIndex:(range.length+range.location)];
    
    NSArray *resultAry = [recommentStr componentsSeparatedByString:@" "];
    NSString *resultStr = [resultAry lastObject];
    
    if([lotryType isEqualToString:@"204"]){
        if([resultStr rangeOfString:@"负"].location !=NSNotFound || [resultStr rangeOfString:@"大"].location !=NSNotFound){
            [self result:@"不关键" imgName:@"" btn:countStartLab imgNameNo:@"荐而未中"];
            [countStartLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result:@"不关键" imgName:@"" btn:countStartLab imgNameNo:@"未荐未中"];
            [countStartLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if([resultStr rangeOfString:@"胜"].location !=NSNotFound || [resultStr rangeOfString:@"小"].location !=NSNotFound){
            [self result:@"不关键" imgName:@"" btn:countEndLab imgNameNo:@"荐而未中"];
            [countEndLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result:@"不关键" imgName:@"" btn:countEndLab imgNameNo:@"未荐未中"];
            [countEndLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [self result:@"不关键" imgName:@"" btn:countMidLab imgNameNo:@""];
        [countMidLab setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.87] forState:UIControlStateNormal];
    }
    if ([lotryType isEqualToString:@"-201"] || [lotryType isEqualToString:@"201"]) {
        if([resultStr rangeOfString:@"胜"].location !=NSNotFound){
            [self result:@"胜" imgName:@"荐而命中" btn:countStartLab imgNameNo:@"荐而未中"];
            [countStartLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result:@"胜" imgName:@"未荐而中" btn:countStartLab imgNameNo:@"未荐未中"];
            [countStartLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if([resultStr rangeOfString:@"平"].location !=NSNotFound){
            [self result:@"平" imgName:@"荐而命中" btn:countMidLab imgNameNo:@"荐而未中"];
            [countMidLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result:@"平" imgName:@"未荐而中" btn:countMidLab imgNameNo:@"未荐未中"];
            [countMidLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if([resultStr rangeOfString:@"负"].location !=NSNotFound){
            [self result:@"负" imgName:@"荐而命中" btn:countEndLab imgNameNo:@"荐而未中"];
            [countEndLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result:@"负" imgName:@"未荐而中" btn:countEndLab imgNameNo:@"未荐未中"];
            [countEndLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }else if([lotryType isEqualToString:@"202"]){
        if([resultStr rangeOfString:@"胜"].location !=NSNotFound){
            [self result:@"胜" imgName:@"荐而命中" btn:countStartLab imgNameNo:@"荐而未中"];
            [countStartLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result:@"胜" imgName:@"未荐而中" btn:countStartLab imgNameNo:@"未荐未中"];
            [countStartLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [countMidLab setBackgroundImage:[UIImage imageNamed:@"未荐未中"] forState:normal];
        [countMidLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if([resultStr rangeOfString:@"负"].location !=NSNotFound){
            [self result:@"负" imgName:@"荐而命中" btn:countEndLab imgNameNo:@"荐而未中"];
            [countEndLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result:@"负" imgName:@"未荐而中" btn:countEndLab imgNameNo:@"未荐未中"];
            [countEndLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    //让球前中后比分图
    countStartLab.frame = CGRectMake(CGRectGetMaxX(letGameLab.frame)+15, CGRectGetMaxY(secSecLine.frame)+10, 65*MyWidth/320, 30);
    
    countMidLab.frame = CGRectMake(CGRectGetMaxX(countStartLab.frame)+10, CGRectGetMinY(countStartLab.frame), 65*MyWidth/320, 30);
    
    countEndLab.frame = CGRectMake(CGRectGetMaxX(countMidLab.frame)+10,CGRectGetMinY(countStartLab.frame), 65*MyWidth/320, 30);
    
    rect=gamePlanView.frame;
    rect.size.height=ORIGIN_Y(countEndLab)+10;
    [gamePlanView setFrame:rect];
    
    //第二场比赛
    gamePlanView2.hidden = YES;
    if([_plainMdl.lotteryClassCode isEqualToString:@"201"]){//二串一 _pdLotryType = 201
        gamePlanView2.hidden = NO;
        
        //联赛场次
        gameNolab2.text = _comptMdl.matchesId2;
        cgSize=[PublicMethod setNameFontSize:_comptMdl.matchesId andFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [gameNolab2 setFrame:CGRectMake(15, 20-cgSize.height/2, cgSize.width+5, cgSize.height)];
        
        cgSize=[PublicMethod setNameFontSize:_comptMdl.leagueName2 andFont:[UIFont systemFontOfSize:12.] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        backImageView2.frame = CGRectMake(CGRectGetMaxX(gameNolab2.frame)+10, 10,cgSize.width+20, 20);
        
        //联赛名称
        workNameLab2.frame =  CGRectMake(5, 2,cgSize.width+10, cgSize.height);
        workNameLab2.text = _comptMdl.leagueName2;
        
        //联赛时间
        gameTimeLab2.text = _comptMdl.matchTime2;
        [gameTimeLab2 setFrame:CGRectMake(MyWidth-130, 10, 130, 20)];
        
        firSecLine2.frame = CGRectMake(0, ORIGIN_Y(backImageView2)+10, MyWidth, 0.5);
        
        rect= VSLab2.frame;
        rect.origin.y=ORIGIN_Y(firSecLine2)+20;
        VSLab2.frame = rect;
        
        //比赛主队
        startNameLab2.text = _comptMdl.homeName2;
        cgSize=[PublicMethod setNameFontSize:startNameLab2.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        startNameLab2.frame = CGRectMake(CGRectGetMinX(VSLab2.frame)-cgSize.width-28, ORIGIN_Y(firSecLine2)+20, cgSize.width, cgSize.height);
        
        //比赛客队
        endNameLab2.text = _comptMdl.awayName2;
        cgSize=[PublicMethod setNameFontSize:endNameLab2.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        endNameLab2.frame = CGRectMake(CGRectGetMaxX(VSLab2.frame)+28, ORIGIN_Y(firSecLine2)+20, cgSize.width, cgSize.height);
        
        secSecLine2.frame = CGRectMake(0, CGRectGetMaxY(VSLab2.frame)+20, MyWidth, 0.5);
        
        countStr = @"";
        NSString *letPlayStr = _comptMdl.playTypeCode2;
        if ([letPlayStr isEqualToString:@"01"]) {//让球胜平负
            countStr = _comptMdl.rqOdds2;
            letGameLab2.text = [NSString stringWithFormat:@"让球(%@)",_comptMdl.rqs2];//让球数
        }else{//胜平负
            countStr = _comptMdl.odds2;
            letGameLab2.text = @" 胜平负";
        }
        
        cgSize=[PublicMethod setNameFontSize:letGameLab2.text andFont:FONTTWENTY_EIGHT andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        letGameLab2.frame = CGRectMake(15,ORIGIN_Y(secSecLine2)+25-cgSize.height/2, cgSize.width, cgSize.height);
        
        startStr = @"胜";
        midStr = @"平";
        endStr = @"负";
        
        oddArr=[countStr componentsSeparatedByString:@" "];
        
        if (countStr.length > 13) {//球分
            startStr = [oddArr objectAtIndex:0];
            midStr = [oddArr objectAtIndex:1];
            endStr = [oddArr objectAtIndex:2];
        }
        
        [countStartLab2 setTitle:startStr forState:UIControlStateNormal];
        [countMidLab2 setTitle:midStr forState:UIControlStateNormal];
        [countEndLab2 setTitle:endStr forState:UIControlStateNormal];
        
        //球分的颜色
        recommentStr = _comptMdl.recommendContent2;
//        range = [recommentStr rangeOfString:@" "];
//        resultStr=[recommentStr substringFromIndex:(range.length+range.location)];
        NSArray *ary = [recommentStr componentsSeparatedByString:@" "];
        resultStr = [ary lastObject];
        
        if([resultStr rangeOfString:@"胜"].location !=NSNotFound){
            [self result2:@"胜" imgName:@"荐而命中" btn:countStartLab2 imgNameNo:@"荐而未中"];
            [countStartLab2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result2:@"胜" imgName:@"未荐而中" btn:countStartLab2 imgNameNo:@"未荐未中"];
            [countStartLab2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if([resultStr rangeOfString:@"平"].location !=NSNotFound){
            [self result2:@"平" imgName:@"荐而命中" btn:countMidLab2 imgNameNo:@"荐而未中"];
            [countMidLab2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result2:@"平" imgName:@"未荐而中" btn:countMidLab2 imgNameNo:@"未荐未中"];
            [countMidLab2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if([resultStr rangeOfString:@"负"].location !=NSNotFound){
            [self result2:@"负" imgName:@"荐而命中" btn:countEndLab2 imgNameNo:@"荐而未中"];
            [countEndLab2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            [self result2:@"负" imgName:@"未荐而中" btn:countEndLab2 imgNameNo:@"未荐未中"];
            [countEndLab2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        //让球前中后比分图
        countStartLab2.frame = CGRectMake(CGRectGetMaxX(letGameLab2.frame)+15, CGRectGetMaxY(secSecLine2.frame)+10, 65*MyWidth/320, 30);
        
        countMidLab2.frame = CGRectMake(CGRectGetMaxX(countStartLab2.frame)+10, CGRectGetMinY(countStartLab2.frame), 65*MyWidth/320, 30);
        
        countEndLab2.frame = CGRectMake(CGRectGetMaxX(countMidLab2.frame)+10,CGRectGetMinY(countStartLab2.frame), 65*MyWidth/320, 30);
        
        rect=gamePlanView2.frame;
        rect.origin.y = ORIGIN_Y(gamePlanView);
        rect.size.height=ORIGIN_Y(countEndLab2)+10;
        [gamePlanView2 setFrame:rect];
    }
    
    NSString *str = _plainMdl.recommendExplain;
    CGSize contentSize = [PublicMethod setNameFontSize:str andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(MyWidth-30, 3000)];

    recResnView.frame = CGRectMake(0, CGRectGetMaxY(gamePlanView.frame)+10, MyWidth, recLab.frame.size.height+contentSize.height+45);
    
    if([_plainMdl.lotteryClassCode isEqualToString:@"201"]){
        recResnView.frame = CGRectMake(0, CGRectGetMaxY(gamePlanView2.frame)+10, MyWidth, recLab.frame.size.height+contentSize.height+45);
    }
    
    contentLab.frame = CGRectMake(15, CGRectGetMaxY(recLab.frame), MyWidth-30, contentSize.height+10);
    if (IS_IOS7) {
        contentLab.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.26];
    }
    contentLab.text = str;
    
    if ([_plainMdl.orderStatus isEqualToString:@"3"]) {
        NSString *refuseStr = @"未通过理由";
        CGSize refuseSize = [PublicMethod setNameFontSize:refuseStr andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        NSString *refuseContentStr = _plainMdl.deny_reason;
        
        CGSize refuseContentRect = [PublicMethod setNameFontSize:refuseContentStr andFont:FONTTHIRTY andMaxSize:CGSizeMake(MyWidth-20, 3000)];;
        
        [thirdView setFrame:CGRectMake(0, CGRectGetMaxY(recResnView.frame)+10, MyWidth, refuseSize.height+refuseContentRect.height+45)];
        thirdView.backgroundColor=[UIColor whiteColor];
        thirdView.layer.masksToBounds=YES;
        thirdView.layer.borderWidth=0.5;
        thirdView.layer.borderColor=SEPARATORCOLOR.CGColor;
        
        refTitLab=[[UILabel alloc] init];
        refTitLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 15, refuseSize.width, refuseSize.height)];
        refTitLab.text=@"未通过理由";
        refTitLab.textColor=BLACK_EIGHTYSEVER;
        refTitLab.textAlignment=NSTextAlignmentCenter;
        refTitLab.font=FONTTHIRTY;
        [thirdView addSubview:refTitLab];

        refContentLab=[[UILabel alloc] init];
        refContentLab.frame=CGRectMake(15, CGRectGetMaxY(refTitLab.frame), MyWidth-30, refuseContentRect.height+30);
        refContentLab.textColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.65];
        refContentLab.font=FONTTWENTY_SIX;
        refContentLab.text=_plainMdl.deny_reason;
        [thirdView addSubview:refContentLab];
#if defined YUCEDI || defined DONGGEQIU
        betBtn.hidden=NO;
#endif
        [betBtn setTitle:@"重新编辑此方案" forState:normal];

    }else
        [thirdView setFrame:CGRectMake(0, CGRectGetMaxY(recResnView.frame)+10, MyWidth, 0)];

    betBtn.frame = CGRectMake(15, CGRectGetMaxY(thirdView.frame)+30, 290, 50);
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:_comptMdl.matchTime];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *matchDate = [date  dateByAddingTimeInterval: interval];
    
    NSDate *dateNow=[NSDate date];
    NSInteger intervalNow=[zone secondsFromGMTForDate:dateNow];
    NSDate *localeDate=[dateNow dateByAddingTimeInterval:intervalNow];
    
    //竞彩详情中方案状态未截期时显示此按钮
    if (![_plainMdl.closeStatus isEqualToString:@"1"]||[matchDate compare:localeDate]==NSOrderedAscending||[isSd isEqualToString:@"1"]) {
        betBtn.hidden=YES;
    }
    
    NSDictionary *dic=[DEFAULTS objectForKey:@"qihaodic"];
    NSString *jcTdyPubNum=dic[@"today_PublishNum_JcSingle"];
    NSString *ypTdyPubNum=dic[@"today_PublishNum_Asian"];
    if (((([lotryType isEqualToString:@"-201"] || [lotryType isEqualToString:@"201"])&&[jcTdyPubNum intValue]>=3)||([lotryType isEqualToString:@"202"]&&[ypTdyPubNum intValue]>=3))&&[_plainMdl.orderStatus isEqualToString:@"3"]) {
        betBtn.hidden=YES;
    }
    if (![_plainMdl.orderStatus isEqualToString:@"3"]&&[lotryType isEqualToString:@"202"]) {
        betBtn.hidden=YES;
    }
}

- (void)betClick:(UIButton *)btn{
    if ([_timeCellDelegate respondsToSelector:@selector(betClick:)]) {
        [_timeCellDelegate betClick:btn];
    }
}

- (void)result:(NSString *)result imgName:(NSString *)imgName btn:(UIButton *)btn imgNameNo:(NSString *)imgNameNo{
    NSString *matchResult=_comptMdl.matchResult;
    if (matchResult!=nil&&![matchResult isEqualToString:@""]&&[matchResult isEqualToString:result]) {
        [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:normal];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:imgNameNo] forState:normal];
    }
}
- (void)result2:(NSString *)result imgName:(NSString *)imgName btn:(UIButton *)btn imgNameNo:(NSString *)imgNameNo{
    NSString *matchResult=_comptMdl.matchResult2;
    if (matchResult!=nil&&![matchResult isEqualToString:@""]&&[matchResult isEqualToString:result]) {
        [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:normal];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:imgNameNo] forState:normal];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    