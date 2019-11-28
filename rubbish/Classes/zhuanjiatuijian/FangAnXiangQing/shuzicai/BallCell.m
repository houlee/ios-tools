//
//  BallCell.m
//  Experts
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "BallCell.h"
@implementation BallCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self makeUI];
    }
    return self;
}

-(void)makeUI{
    
    self.bigView = [[UIView alloc] initWithFrame:CGRectMake(10.0,0,MyWidth-20.0,45)];
    self.bigView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bigView];
    
    self.lefView = [[UIView alloc] initWithFrame:CGRectMake(0,0,1,45)];
    self.lefView.backgroundColor = [UIColor lightGrayColor];
    [self.bigView addSubview: self.lefView];
    
    self.rigView = [[UIView alloc] initWithFrame:CGRectMake(self.bigView.frame.size.width-1,0,1,45)];
    self.rigView.backgroundColor = [UIColor  lightGrayColor];
    [self.bigView addSubview: self.rigView];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,MyWidth-20.0,1)];
    self.topView.backgroundColor = [UIColor  lightGrayColor];
    [self.bigView addSubview: self.topView];
    
    self.lowView = [[UIView alloc] init];
    if ([UIDevice currentDevice].systemVersion.floatValue >7.0&&[UIDevice currentDevice].systemVersion.floatValue<8.0) {
        self.lowView.frame = CGRectMake(0,45.0,MyWidth-20.0,0);
    }else{
        self.lowView.frame = CGRectMake(0,45.0,MyWidth-20.0,1);
    }
    self.lowView.backgroundColor = [UIColor  lightGrayColor];
    [self.bigView addSubview: self.lowView];
    
    self.midView = [[UIView alloc] initWithFrame:CGRectMake(57.5,0,1,45.0)];
    self.midView.backgroundColor = [UIColor  lightGrayColor];
    [self.bigView addSubview: self.midView];
    
    self.ballNameLab = [[UILabel alloc] initWithFrame:CGRectMake(1,0,56.5,45)];
    self.ballNameLab.font=FONTTWENTY_FOUR;
    self.ballNameLab.numberOfLines=2;
    self.ballNameLab.textAlignment = NSTextAlignmentCenter;
    self.ballNameLab.backgroundColor = [UIColor clearColor];
    self.ballNameLab.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.54];
    [self.bigView addSubview: self.ballNameLab];
    
    self.countNameLab = [[UILabel alloc] initWithFrame:CGRectMake(66.5,0,self.rigView.frame.origin.x-self.midView.frame.origin.x-2*(10.0+113.0/2-self.midView.frame.origin.x),45)];
    self.countNameLab.font=FONTTWENTY_FOUR;
    self.countNameLab.numberOfLines = 2;
    self.countNameLab.backgroundColor = [UIColor clearColor];
    [self.bigView addSubview: self.countNameLab];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end

@implementation BetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self makeUI];
    }
    return self;
}

-(void)makeUI{
    self.firstView = [[UIView alloc] init];
    self.firstView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.firstView];
    
    self.remmodLab = [[UILabel alloc] init];
    self.remmodLab.text = @"推荐标题";
    self.remmodLab.font = FONTTHIRTY_TWO;
    [self.firstView addSubview:self.remmodLab];
    
    self.remContentLab = [[UILabel alloc] init];
    self.remContentLab.textColor = [UIColor lightGrayColor];
    self.remContentLab.numberOfLines = 0;
    self.remContentLab.font = FONTTWENTY_SIX;
    [self.firstView addSubview:self.remContentLab];
    
    self.goBetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goBetBtn.frame = CGRectMake(15,self.firstView.frame.size.height+20,290,50);
#if defined YUCEDI || defined DONGGEQIU
    [self.goBetBtn setTitle:@"立即买彩票" forState:normal];
#else
    [self.goBetBtn setTitle:@"去投注" forState:normal];
#endif
    [self.goBetBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:UIControlStateNormal];
    self.goBetBtn.hidden=YES;
    [self.contentView addSubview:self.goBetBtn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //NSString *remmodContent = @"";
    //CGRect remContentSize=[remmodContent boundingRectWithSize:CGSizeMake(MyWidth-20.0, 3000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
}

- (void)setDataModel:(GameDetailMdl *)compModel{
    NSDictionary *plainInfoDic = compModel.planInfo;
    CompPlanInfoMdl *plainModel = [[CompPlanInfoMdl alloc]init];
    [plainModel setValuesForKeysWithDictionary:plainInfoDic];
    NSString *remmodContent = plainModel.recommendTitle;
    CGSize remContentSize=[PublicMethod setNameFontSize:remmodContent andFont:FONTTWENTY_EIGHT andMaxSize:CGSizeMake(MyWidth- 20.0, 3000)];
    
    NSString *remmod=self.remmodLab.text;
    remmodSize=[PublicMethod setNameFontSize:remmod andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [self.remmodLab setFrame:CGRectMake(15.0,15.0,100,remmodSize.height)];
    
    self.remContentLab.frame=CGRectMake(15,ORIGIN_Y(self.remmodLab)+10,MyWidth-30.0,remContentSize.height);
    self.remContentLab.text=remmodContent;
    
    self.firstView.frame=CGRectMake(0,10,MyWidth,25.0+remmodSize.height+remContentSize.height+20);
    
    //数字彩详情中,只有出现未截期的才会去投注,否则无此按钮
    if ([plainModel.closeStatus isEqualToString:@"1"]) {
#if defined YUCEDI || defined DONGGEQIU
        self.goBetBtn.hidden=YES;
#else
        self.goBetBtn.hidden=NO;
#endif
        
        CGRect rect=self.goBetBtn.frame;
        rect.origin.y=ORIGIN_Y(self.firstView);
        [self.goBetBtn setFrame:rect];
    }else{
        self.goBetBtn.hidden=YES;;
    }
}

@end

@implementation HeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = V2FACEBG_COLOR;
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0,0,MyWidth,126.0)];
    [self addSubview:self.backView];
    
    self.headImage=[[UIImageView alloc] initWithFrame:CGRectMake(16.0,31.0/2,55.0,55.0)];
    self.headImage.clipsToBounds  = YES;
    self.headImage.layer.cornerRadius = 55.0/2;
    [self.backView addSubview:self.headImage];
    
    self.redVImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.headImage.frame.size.width+2.0,(self.headImage.frame.size.height-15.0/4+3),14.0,14.0)];
    [self.backView addSubview:self.redVImage];
    
    self.labName = [[UILabel alloc] init];
    self.labName.font = FONTTHIRTY;
    [self.backView addSubview:self.labName];
    
    UIImageView *djImgView=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(_labName)+10, _labName.frame.size.height/2-7, 39, 14)];
    djImgView.backgroundColor=[UIColor clearColor];
    [self.backView addSubview:djImgView];
    _djImgV=djImgView;
    
    UILabel *djLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 22, 14)];
    djLabel.backgroundColor=[UIColor clearColor];
    djLabel.font=[UIFont systemFontOfSize:8.0];
    djLabel.textColor=RGBColor(255.0, 96.0, 0.0);
    djLabel.textAlignment=NSTextAlignmentLeft;
    [_djImgV addSubview:djLabel];
    _djLab=djLabel;
    
    self.divdLine=[[UIView alloc] initWithFrame:CGRectMake(0, 85.0, MyWidth, 1.0)];
    self.divdLine.backgroundColor=SEPARATORCOLOR;
    [self.backView addSubview:self.divdLine];
    
    self.ballNameLab = [[UILabel alloc] init];
    self.ballNameLab.font = FONTTHIRTY;
    [self.backView addSubview:self.ballNameLab];
    
    self.ballTimeLab = [[UILabel alloc] init];
    self.ballTimeLab.font = FONTTHIRTY;
    [self.backView addSubview:self.ballTimeLab];
}

- (void)setDataModel:(GameDetailMdl *)compModel lotterystr:(NSString *)lotteryStr time:(NSString *)timeStr
{
    CompExpInfoMdl *expertModel = [[CompExpInfoMdl alloc]init];
    CompPlanInfoMdl *plainModel = [[CompPlanInfoMdl alloc]init];
    NSDictionary *experInfoDic = compModel.expertInfo;
    NSDictionary *plainInfoDic = compModel.planInfo;
    [expertModel setValuesForKeysWithDictionary:experInfoDic];
    [plainModel setValuesForKeysWithDictionary:plainInfoDic];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:expertModel.headPortrait] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    if ([expertModel.source  isEqualToString:@"0"]) {
        self.redVImage.image = [UIImage imageNamed:@"V_red"];
    }else{
        self.redVImage.image = [UIImage imageNamed:@""];
    }
    
    self.labName.text = expertModel.expertsNickName;
    CGSize distanceSizeName=[PublicMethod setNameFontSize:self.labName.text andFont:[UIFont systemFontOfSize:15.] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.labName.frame = CGRectMake(15.0+CGRectGetMaxX(_headImage.frame), self.frame.size.height/2-distanceSizeName.height/2+10,distanceSizeName.width, self.frame.size.height);
    
    [_djImgV setFrame:CGRectMake(ORIGIN_X(_labName)+10,_labName.frame.origin.y+(_labName.frame.size.height-14)/2,39,14)];
    
    int level=[expertModel.expertsLevelValue intValue];
    NSString *rankImg=@"";
    if (level<=5) {
        rankImg=@"ranklv1-5";
        _djLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (level>5&&level<=10){
        rankImg=@"ranklv6-10";
        _djLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (level>10&&level<=15){
        rankImg=@"ranklv11-15";
        _djLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (level>15&&level<=20){
        rankImg=@"ranklv16-20";
        _djLab.textColor=[UIColor whiteColor];
    }else if (level>20&&level<=25){
        rankImg=@"ranklv21-25";
        _djLab.textColor=[UIColor whiteColor];
    }
    _djImgV.image=[UIImage imageNamed:rankImg];
    _djLab.text=[NSString stringWithFormat:@"LV%ld",(long)level];
    CGSize reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)level] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_djLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    NSString *ballName=@"";
    if ([lotteryStr isEqualToString:@"001"]) {
        ballName = @" 双色球";
    }else if ([lotteryStr isEqualToString:@"108"]) {
        ballName = @" 排列三";
    }else if ([lotteryStr isEqualToString:@"002"]) {
        ballName = @" 福彩3D";
    }else  if([lotteryStr isEqualToString:@"113"]){
        ballName = @" 大乐透";
    }
    self.ballNameLab.text=ballName;
    CGSize ballStrSize=[PublicMethod setNameFontSize:ballName andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.ballNameLab.frame = CGRectMake(10.0,97.5,ballStrSize.width,ballStrSize.height);
    
    NSString *errIssueStr = [NSString stringWithFormat:@"%@ 期",timeStr];
    self.ballTimeLab.text = errIssueStr;
    CGSize ballTimeSize=[PublicMethod setNameFontSize:errIssueStr andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.ballTimeLab.frame = CGRectMake(ORIGIN_X(self.ballNameLab)+15.0,97.5,ballTimeSize.width,ballTimeSize.height);
    
    //NSString  *labStr  = [NSString stringWithFormat:@" %@ 期",timeStr];
    //NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:labStr];
    //NSRange range =[labStr rangeOfString:[NSString stringWithFormat:@"%@",timeStr]];
    //[attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    //self.ballTimeLab.attributedText = attStr;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    