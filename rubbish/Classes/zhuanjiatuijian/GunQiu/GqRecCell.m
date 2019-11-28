//
//  GqRecCell.m
//  caibo
//
//  Created by zhoujunwang on 16/5/26.
//
//

#import "GqRecCell.h"

@interface GqRecCell()

@property(nonatomic,strong)UILabel *homelab;
@property(nonatomic,strong)UILabel *scorelab;
@property(nonatomic,strong)UILabel *guestlab;
@property(nonatomic,strong)UILabel *timelab;
@property(nonatomic,strong)UILabel *leaguelab;
@property(nonatomic,strong)UILabel *recNolab;

@end

@implementation GqRecCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *cellBg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 103.5)];
        cellBg.layer.masksToBounds=YES;
        cellBg.layer.borderWidth=0.5;
        cellBg.layer.borderColor=SEPARATORCOLOR.CGColor;
        cellBg.backgroundColor=[UIColor whiteColor];
        [self addSubview:cellBg];
        
        UILabel *homelab=[[UILabel alloc] initWithFrame:CGRectMake(0, 15, 105, 12)];
        homelab.text=@"";
        homelab.textColor=BLACK_EIGHTYSEVER;
        homelab.font=FONTTWENTY_FOUR;
        homelab.backgroundColor=[UIColor clearColor];
        homelab.textAlignment=NSTextAlignmentRight;
        [cellBg addSubview:homelab];
        _homelab=homelab;
        
        UILabel *scorelab=[[UILabel alloc] initWithFrame:CGRectMake(135, 15, 50, 12)];
        scorelab.text=@"";
        scorelab.textColor=BLACK_EIGHTYSEVER;
        scorelab.font=FONTTWENTY_FOUR;
        scorelab.textAlignment=NSTextAlignmentCenter;
        [cellBg addSubview:scorelab];
        _scorelab=scorelab;
        
        UILabel *guestlab=[[UILabel alloc] initWithFrame:CGRectMake(215, 15, 105, 12)];
        guestlab.text=@"";
        guestlab.textColor=BLACK_EIGHTYSEVER;
        guestlab.font=FONTTWENTY_FOUR;
        guestlab.backgroundColor=[UIColor clearColor];
        guestlab.textAlignment=NSTextAlignmentLeft;
        [self addSubview:guestlab];
        _guestlab=guestlab;
        
        UILabel *timelab=[[UILabel alloc] initWithFrame:CGRectMake(135, ORIGIN_Y(scorelab)+8, 50, 12)];
        timelab.text=@"";
        timelab.textColor=BLACK_EIGHTYSEVER;
        timelab.font=FONTTWENTY_FOUR;
        timelab.textAlignment=NSTextAlignmentCenter;
        [cellBg addSubview:timelab];
        _timelab=timelab;
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(timelab)+15.0, 320, 0.5)];
        lineView.backgroundColor=SEPARATORCOLOR;
        [cellBg addSubview:lineView];
        
        UIImageView *blueImgV=[[UIImageView alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(lineView)+17, 6, 6)];
        blueImgV.image=[UIImage imageNamed:@"gqBluePoint"];
        [cellBg addSubview:blueImgV];
        
        UILabel *leaguelab=[[UILabel alloc] initWithFrame:CGRectMake(27, ORIGIN_Y(lineView)+14, 100, 12)];
        leaguelab.text=@"";
        leaguelab.textColor=BLACK_EIGHTYSEVER;
        leaguelab.font=FONTTWENTY_FOUR;
        leaguelab.textAlignment=NSTextAlignmentLeft;
        [cellBg addSubview:leaguelab];
        _leaguelab=leaguelab;
        
        UIImageView *recNOImgV=[[UIImageView alloc] initWithFrame:CGRectMake(245, ORIGIN_Y(lineView)+9, 60, 22)];
        recNOImgV.image=[UIImage imageNamed:@"gqRecNo"];
        [cellBg addSubview:recNOImgV];
        
        UILabel *recNolab=[[UILabel alloc] initWithFrame:CGRectMake(245, ORIGIN_Y(lineView)+9, 60, 22)];
        recNolab.text=@"";
        recNolab.textAlignment=NSTextAlignmentCenter;
        recNolab.textColor=[UIColor colorWithHexString:@"#FF3B30"];
        recNolab.font=[UIFont systemFontOfSize:11];
        recNolab.backgroundColor=[UIColor clearColor];
        [cellBg addSubview:recNolab];
        _recNolab=recNolab;
        
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)setHostName:(NSString *)hostName score:(NSString *)score guestName:(NSString *)guestName gameTime:(NSString *)gameTime leagueTime:(NSString *)leagueTime recNo:(NSString *)recNo{
    _homelab.text=hostName;
    _scorelab.text=score;
    _guestlab.text=guestName;
    _timelab.text=gameTime;
    _leaguelab.text=leagueTime;
    
    _recNolab.text=[NSString stringWithFormat:@"%@人推荐",recNo];
    //CGSize size=[PublicMethod setNameFontSize:_recNolab.text andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
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

@interface GqZJCell()

@property(nonatomic,strong)UIImageView *gqPortImgView;
@property(nonatomic,strong)UIImageView *gqVipImgView;
@property(nonatomic,strong)UILabel *gqNikNmlab;
@property(nonatomic,strong)UIImageView *gqRkImgView;
@property(nonatomic,strong)UILabel *gqRkLab;
@property(nonatomic,strong)UILabel *gqTwoSideLab;

@property(nonatomic,strong)UILabel *gqsqlab;
@property(nonatomic,strong)UILabel *gqsqslab;
@property(nonatomic,strong)UIButton *gqsqBtn;
@property(nonatomic,strong)UILabel *gqsqflab;

@property(nonatomic,strong)UILabel *gqzxlab;
@property(nonatomic,strong)UILabel *gqzxslab;
@property(nonatomic,strong)UIButton *gqzxBtn;
@property(nonatomic,strong)UILabel *gqzxflab;

@property(nonatomic,strong)UILabel *gqfblab;
@property(nonatomic,strong)UILabel *gqfbtimelab;
@property(nonatomic,strong)UIView *sepline;

@end

@implementation GqZJCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 45, 45)];
        imgView.layer.cornerRadius=22.5;
        imgView.layer.masksToBounds=YES;
        [self addSubview:imgView];
        _gqPortImgView=imgView;
        
        UIImageView *markView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imgView.frame)+32.5, CGRectGetMinY(imgView.frame)+32.5, 10, 10)];
        markView.layer.cornerRadius=5;
        markView.layer.masksToBounds=YES;
        markView.image=[UIImage imageNamed:@"V_red"];
        [self addSubview:markView];
        _gqVipImgView=markView;
        
        CGSize gqSize=[PublicMethod setNameFontSize:@"宝哥" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *nickNameLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+15, 15, gqSize.width, gqSize.height)];
        nickNameLab.font=FONTTHIRTY;
        nickNameLab.textColor=[UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:1.0];
        nickNameLab.backgroundColor=[UIColor clearColor];
        nickNameLab.text=@"";
        [self addSubview:nickNameLab];
        _gqNikNmlab=nickNameLab;
        
        UIImageView *rangImgV=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(nickNameLab)+10, nickNameLab.frame.origin.y+(gqSize.height-14)/2, 39, 14)];
        rangImgV.backgroundColor=[UIColor clearColor];
        rangImgV.image=[UIImage imageNamed:@""];
        [self addSubview:rangImgV];
        _gqRkImgView=rangImgV;
        
        UILabel *rankLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 24, 14)];
        rankLab.backgroundColor=[UIColor clearColor];
        rankLab.font=[UIFont systemFontOfSize:8.0];
        rankLab.textColor=TEXTWITER_COLOR;
        rankLab.textAlignment=NSTextAlignmentCenter;
        rankLab.text=@"";
        [rangImgV addSubview:rankLab];
        _gqRkLab=rankLab;
        
        gqSize=[PublicMethod setNameFontSize:@"中国  1:1  日本" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *gqTwoSideLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+15, CGRectGetMaxY(nickNameLab.frame)+8, gqSize.width, gqSize.height)];
        gqTwoSideLab.font=FONTTHIRTY;
        gqTwoSideLab.textColor=BLACK_EIGHTYSEVER;
        gqTwoSideLab.text=@"";
        [self addSubview:gqTwoSideLab];
        _gqTwoSideLab=gqTwoSideLab;

        gqSize=[PublicMethod setNameFontSize:@"赛前赔率" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *gqsqlab=[[UILabel alloc] initWithFrame:CGRectMake(74,ORIGIN_Y(gqTwoSideLab)+8, gqSize.width, gqSize.height)];
        gqsqlab.font=FONTTWENTY_FOUR;
        gqsqlab.textColor=BLACK_FIFITYFOUR;
        gqsqlab.text=@"赛前赔率";
        gqsqlab.backgroundColor=[UIColor clearColor];
        [self addSubview:gqsqlab];
        _gqsqlab=gqsqlab;
        
        UILabel *gqzxlab=[[UILabel alloc] initWithFrame:CGRectMake(74,ORIGIN_Y(gqsqlab)+8, gqSize.width, gqSize.height)];
        gqzxlab.font=FONTTWENTY_FOUR;
        gqzxlab.textColor=BLACK_FIFITYFOUR;
        gqzxlab.text=@"最新赔率";
        [self addSubview:gqzxlab];
        _gqzxlab=gqzxlab;
        
        UILabel *gqfblab=[[UILabel alloc]initWithFrame:CGRectMake(74,ORIGIN_Y(gqzxlab)+8, gqSize.width, gqSize.height)];
        gqfblab.font=FONTTWENTY_FOUR;
        gqfblab.textColor=BLACK_FIFITYFOUR;
        gqfblab.text=@"发布时间";
        [self addSubview:gqfblab];
        _gqfblab=gqfblab;
        
        gqSize=[PublicMethod setNameFontSize:@"胜(10.20)" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *gqsqslab=[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(gqsqlab)+15, CGRectGetMinY(gqsqlab.frame), gqSize.width, gqSize.height)];
        gqsqslab.font=FONTTWENTY_FOUR;
        gqsqslab.textColor=BLACK_EIGHTYSEVER;
        gqsqslab.text=@"";
        gqsqslab.textAlignment=NSTextAlignmentLeft;
        [self addSubview:gqsqslab];
        _gqsqslab=gqsqslab;
        
        UIButton *gqsqBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        gqsqBtn.frame=CGRectMake(191, CGRectGetMinY(gqsqslab.frame)+(gqSize.height-15)/2, 50, 15);
        [gqsqBtn setBackgroundImage:[UIImage imageNamed:@"gqNewRec"] forState:UIControlStateNormal];
        [gqsqBtn setTitleColor:TEXTWITER_COLOR forState:UIControlStateNormal];
        gqsqBtn.titleLabel.font=FONTEIGHTEEN;
        [self addSubview:gqsqBtn];
        _gqsqBtn=gqsqBtn;
        
        UILabel *gqsqflab=[[UILabel alloc] initWithFrame:CGRectMake(245, CGRectGetMinY(gqsqlab.frame), 50, 12)];
        gqsqflab.font=FONTTWENTY_FOUR;
        gqsqflab.textColor=BLACK_EIGHTYSEVER;
        gqsqflab.text=@"";
        gqsqflab.textAlignment=NSTextAlignmentRight;
        [self addSubview:gqsqflab];
        _gqsqflab=gqsqflab;
        
        UILabel *gqzxslab=[[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(gqzxlab)+15, CGRectGetMinY(gqzxlab.frame), 50, 12)];
        gqzxslab.font=FONTTWENTY_FOUR;
        gqzxslab.textColor=BLACK_EIGHTYSEVER;
        gqzxslab.text=@"";
        gqzxslab.textAlignment=NSTextAlignmentLeft;
        [self addSubview:gqzxslab];
        _gqzxslab=gqzxslab;
        
        UIButton *gqzxBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        gqzxBtn.frame=CGRectMake(191, CGRectGetMinY(gqzxslab.frame)-1.5, 50, 15);
        [gqzxBtn setBackgroundImage:[UIImage imageNamed:@"gqNewRec"] forState:UIControlStateNormal];
        [gqzxBtn setTitleColor:TEXTWITER_COLOR forState:UIControlStateNormal];
        gqzxBtn.titleLabel.font=FONTEIGHTEEN;
        [self addSubview:gqzxBtn];
        _gqzxBtn=gqzxBtn;
        
        UILabel * gqzxflab=[[UILabel alloc]initWithFrame:CGRectMake(245, CGRectGetMinY(gqzxlab.frame), 50, 12)];
        gqzxflab.font=FONTTWENTY_FOUR;
        gqzxflab.textColor=BLACK_EIGHTYSEVER;
        gqzxflab.text=@"";
        gqzxflab.textAlignment=NSTextAlignmentRight;
        [self addSubview:gqzxflab];
        _gqzxflab=gqzxflab;
        
        gqSize=[PublicMethod setNameFontSize:@"27分钟前(已变盘)" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *gqfbtimelab=[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(gqfblab)+15, CGRectGetMinY(gqfblab.frame), gqSize.width, gqSize.height)];
        gqfbtimelab.font=FONTTWENTY_FOUR;
        gqfbtimelab.textColor=BLACK_EIGHTYSEVER;
        gqfbtimelab.text=@"";
        [self addSubview:gqfbtimelab];
        _gqfbtimelab=gqfbtimelab;
        
        UIButton *ckxqBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        ckxqBtn.frame=CGRectMake(15, CGRectGetMaxY(gqfblab.frame)+15, MyWidth-30, 35);
        [ckxqBtn setTitleColor:TEXTWITER_COLOR forState:UIControlStateNormal];
        [ckxqBtn setBackgroundImage:[UIImage imageNamed:@"方案详情按钮"] forState:UIControlStateNormal];
        [ckxqBtn setTitle:@"立即查看" forState:UIControlStateNormal];
        [ckxqBtn addTarget:self action:@selector(ckxqClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ckxqBtn];
        ckxqBtn.titleLabel.font=FONTTWENTY_EIGHT;
        _ckxqBtn=ckxqBtn;
        
        //self.separatorInset=UIEdgeInsetsMake(0,0,0,0);
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, 320, 0.5)];
        view.backgroundColor=SEPARATORCOLOR;
        [self addSubview:view];
        _sepline=view;
    }
    return self;
}

- (void)setPortrait:(NSString *)Portrait gqNikNm:(NSString *)gqNikNm gqRk:(NSInteger)gqRk gqGameSides:(NSString *)gqGameSides gqsqSpl:(NSString *)gqsqSpl gqsqRq:(NSString *)gqsqRq gqsqFpl:(NSString *)gqsqfpl gqzxSpl:(NSString *)gqzxSpl gqzxRq:(NSString *)gqzxRq gqzxfpl:(NSString *)gqzxfpl releasaTime:(NSString *)releseTime gpPrice:(NSString *)gqPrice startOrNo:(NSInteger)startOrNo isRec:(NSInteger)isRec{
    NSURL *url=[NSURL URLWithString:Portrait];
    [_gqPortImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    
    _gqNikNmlab.text=gqNikNm;
    CGSize reSize=[PublicMethod setNameFontSize:gqNikNm andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rect=_gqNikNmlab.frame;
    rect.size.width=reSize.width;
    [_gqNikNmlab setFrame:rect];
    
    rect=_gqRkImgView.frame;
    rect.origin.x=ORIGIN_X(_gqNikNmlab)+10;
    [_gqRkImgView setFrame:rect];
    
    NSString *rankImg=@"";
    if (gqRk<=5) {
        rankImg=@"ranklv1-5";
        _gqRkLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (gqRk>5&&gqRk<=10){
        rankImg=@"ranklv6-10";
        _gqRkLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (gqRk>10&&gqRk<=15){
        rankImg=@"ranklv11-15";
        _gqRkLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (gqRk>15&&gqRk<=20){
        rankImg=@"ranklv16-20";
        _gqRkLab.textColor=[UIColor whiteColor];
    }else if (gqRk>20&&gqRk<=25){
        rankImg=@"ranklv21-25";
        _gqRkLab.textColor=[UIColor whiteColor];
    }
    _gqRkImgView.image=[UIImage imageNamed:rankImg];
    _gqRkLab.text=[NSString stringWithFormat:@"LV%ld",(long)gqRk];
    
    _gqTwoSideLab.text=gqGameSides;
    reSize=[PublicMethod setNameFontSize:gqGameSides andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=_gqTwoSideLab.frame;
    rect.size.width=reSize.width;
    [_gqTwoSideLab setFrame:rect];
    
    _gqsqslab.text=[NSString stringWithFormat:@"主(%@)",gqsqSpl];
    [_gqsqBtn setTitle:gqsqRq forState:UIControlStateNormal];
    _gqsqflab.text=[NSString stringWithFormat:@"客(%@)",gqsqfpl];
    
    _gqzxslab.text=[NSString stringWithFormat:@"主(%@)",gqzxSpl];
    [_gqzxBtn setTitle:gqzxRq forState:UIControlStateNormal];
    _gqzxflab.text=[NSString stringWithFormat:@"客(%@)",gqzxfpl];
    
    _gqfbtimelab.text=releseTime;
    reSize=[PublicMethod setNameFontSize:_gqfbtimelab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=_gqfbtimelab.frame;
    rect.size.width=reSize.width;
    [_gqfbtimelab setFrame:rect];
    
    [_ckxqBtn setTitle:[NSString stringWithFormat:@"立即查看(%@元)",gqPrice] forState:UIControlStateNormal];
    
    if (startOrNo==1) {
        _gqzxlab.hidden=NO;
        _gqzxslab.hidden=NO;
        _gqzxflab.hidden=NO;
        _gqzxBtn.hidden=NO;
        if(isRec==1){
            _gqfblab.hidden=NO;
            _gqfbtimelab.hidden=NO;
            
            rect=_ckxqBtn.frame;
            rect.origin.y=CGRectGetMaxY(_gqfblab.frame)+15;
            [_ckxqBtn setFrame:rect];
        }else if(isRec==0){
            _gqfblab.hidden=YES;
            _gqfbtimelab.hidden=YES;
            
            rect=_ckxqBtn.frame;
            rect.origin.y=CGRectGetMaxY(_gqzxflab.frame)+15;
            [_ckxqBtn setFrame:rect];
        }
    }else if (startOrNo==0) {
        _gqzxlab.hidden=YES;
        _gqzxslab.hidden=YES;
        _gqzxflab.hidden=YES;
        _gqzxBtn.hidden=YES;
        _gqfblab.text=@"开赛时间";
        CGRect rect=_gqzxlab.frame;
        [_gqfblab setFrame:rect];
        
        rect=_gqfbtimelab.frame;
        rect.origin.y=_gqzxslab.frame.origin.y;
        [_gqfbtimelab setFrame:rect];
        
        rect=_ckxqBtn.frame;
        rect.origin.y=CGRectGetMaxY(_gqfblab.frame)+15;
        [_ckxqBtn setFrame:rect];
    }
    [_sepline setFrame:CGRectMake(0, ORIGIN_Y(_ckxqBtn)+15, 320, 0.5)];
}

- (void)ckxqClick:(UIButton *)btn{
    if (_delegate&&[_delegate respondsToSelector:@selector(gqckxqClick:)]) {
        [_delegate gqckxqClick:btn];
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