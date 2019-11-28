//
//  ExpertMainListTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/22.
//
//

#import "ExpertMainListTableViewCell.h"
#import "SharedMethod.h"

@implementation ExpertMainListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        size = [UIScreen mainScreen].bounds.size;
        
        _headIma = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 35, 35)];
        _headIma.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headIma];
        
        _rankingIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        _rankingIma.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_rankingIma];
        
        _levelIma = [[UIImageView alloc]initWithFrame:CGRectMake(ORIGIN_X(_headIma)+5, 12.5, 8, 30)];
        _levelIma.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_levelIma];
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_levelIma)+5, 10, 100, 20)];
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_nameLab];
        
        _starIma = [[UIImageView alloc]initWithFrame:CGRectMake(ORIGIN_X(_nameLab), 13, 18, 13)];
        _starIma.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_starIma];
        
        _rankImgView=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(_nameLab)+5, 13, 39, 14)];
        _rankImgView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_rankImgView];
        
        _rankLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 24, 14)];
        _rankLab.backgroundColor=[UIColor clearColor];
        _rankLab.font=[UIFont systemFontOfSize:8.0];
        _rankLab.textColor=RGBColor(255.0, 96.0, 0.0);
        _rankLab.textAlignment=NSTextAlignmentCenter;
        [_rankImgView addSubview:_rankLab];
        
        _hitRateLab = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_nameLab), 13, 100, 15)];
        _hitRateLab.backgroundColor = [UIColor clearColor];
        _hitRateLab.font = [UIFont systemFontOfSize:11];
        _hitRateLab.textColor = [SharedMethod getColorByHexString:@"ed3f30"];
        [self.contentView addSubview:_hitRateLab];
        
        _levelLab = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_levelIma)+5, ORIGIN_Y(_nameLab), 100, 15)];
        _levelLab.backgroundColor = [UIColor clearColor];
        _levelLab.font = [UIFont systemFontOfSize:11];
        _levelLab.textColor = [SharedMethod getColorByHexString:@"f8b551"];
        [self.contentView addSubview:_levelLab];
        
        _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordBtn.frame = CGRectMake(ORIGIN_X(_headIma)+5, 13, 28, 13);
        _recordBtn.backgroundColor = [UIColor clearColor];
        [_recordBtn setTitle:@"5中5" forState:UIControlStateNormal];
        _recordBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _recordBtn.enabled = NO;
        _recordBtn.layer.borderColor = [[SharedMethod getColorByHexString:@"ed3f30"] CGColor];
        _recordBtn.layer.borderWidth = 0.5f;
        _recordBtn.layer.cornerRadius = 2;
        _recordBtn.layer.masksToBounds = YES;
        [_recordBtn setTitleColor:[SharedMethod getColorByHexString:@"ed3f30"] forState:UIControlStateNormal];
        [self.contentView addSubview:_recordBtn];
        
        _tuidanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tuidanBtn.frame = CGRectMake(ORIGIN_X(_headIma)+5, 12, 21, 13);
        _tuidanBtn.backgroundColor = [UIColor clearColor];
        [_tuidanBtn setTitle:@"退" forState:UIControlStateNormal];
        _tuidanBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _tuidanBtn.enabled = NO;
        _tuidanBtn.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:187/255.0 blue:109/255.0 alpha:1] CGColor];
        _tuidanBtn.layer.borderWidth = 0.5f;
        _tuidanBtn.layer.cornerRadius = 2;
        _tuidanBtn.layer.masksToBounds = YES;
        [_tuidanBtn setTitleColor:[UIColor colorWithRed:78/255.0 green:187/255.0 blue:109/255.0 alpha:1] forState:UIControlStateNormal];
        [self.contentView addSubview:_tuidanBtn];
        
        _pointIma1 = [[UIImageView alloc]initWithFrame:CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_nameLab)+30, 8, 8)];
        _pointIma1.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_pointIma1];
        _pointIma1.layer.borderColor = [[SharedMethod getColorByHexString:@"6e29bd"] CGColor];
        _pointIma1.layer.borderWidth = 1.0f;
        _pointIma1.layer.cornerRadius = 2;
        _pointIma1.layer.masksToBounds = YES;
        _pointIma1.hidden = YES;
        
        _teamNameLab1 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma1)+5, ORIGIN_Y(_pointIma1)-14, size.width-80, 20)];
        _teamNameLab1.backgroundColor = [UIColor clearColor];
        _teamNameLab1.font = [UIFont systemFontOfSize:14];
        _teamNameLab1.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_teamNameLab1];
        
        _liansaiBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _liansaiBtn1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab1)+5, 40, 12);
        _liansaiBtn1.backgroundColor = [UIColor colorWithRed:53/255.0 green:160/255.0 blue:233/255.0 alpha:1];
        _liansaiBtn1.enabled = NO;
        _liansaiBtn1.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_liansaiBtn1];
        _liansaiBtn1.layer.masksToBounds = YES;
        _liansaiBtn1.layer.cornerRadius = 2;
        
        _matchTimeLab1 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_liansaiBtn1)+5, ORIGIN_Y(_teamNameLab1)+5, size.width-70, 15)];
        _matchTimeLab1.backgroundColor = [UIColor clearColor];
        _matchTimeLab1.font = [UIFont systemFontOfSize:11];
        _matchTimeLab1.textColor = BLACK_SEVENTY;
        [self.contentView addSubview:_matchTimeLab1];
        
        _pointIma2 = [[UIImageView alloc]initWithFrame:CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_pointIma1)+30, 8, 8)];
        _pointIma2.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_pointIma2];
        _pointIma2.layer.borderColor = [[SharedMethod getColorByHexString:@"6e29bd"] CGColor];
        _pointIma2.layer.borderWidth = 1.0f;
        _pointIma2.layer.cornerRadius = 2;
        _pointIma2.layer.masksToBounds = YES;
        _pointIma2.hidden = YES;
        
        _teamNameLab2 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma1)+5, ORIGIN_Y(_pointIma2)-14, size.width-80, 20)];
        _teamNameLab2.backgroundColor = [UIColor clearColor];
        _teamNameLab2.font = [UIFont systemFontOfSize:14];
        _teamNameLab2.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_teamNameLab2];
        
        _liansaiBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _liansaiBtn2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab2)+5, 40, 12);
        _liansaiBtn2.backgroundColor = [UIColor colorWithRed:53/255.0 green:160/255.0 blue:233/255.0 alpha:1];
        _liansaiBtn2.enabled = NO;
        _liansaiBtn2.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_liansaiBtn2];
        _liansaiBtn2.layer.masksToBounds = YES;
        _liansaiBtn2.layer.cornerRadius = 2;
        _liansaiBtn2.hidden = YES;
        
        _matchTimeLab2 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_liansaiBtn2)+5, ORIGIN_Y(_teamNameLab2)+5, size.width-70, 15)];
        _matchTimeLab2.backgroundColor = [UIColor clearColor];
        _matchTimeLab2.font = [UIFont systemFontOfSize:11];
        _matchTimeLab2.textColor = BLACK_SEVENTY;
        [self.contentView addSubview:_matchTimeLab2];
        
        _commentLab = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_matchTimeLab1), size.width-70, 20)];
        _commentLab.backgroundColor = [UIColor clearColor];
        _commentLab.font = [UIFont systemFontOfSize:11];
        _commentLab.textColor = BLACK_SEVENTY;
        _commentLab.text = @"推荐评语：";
        [self.contentView addSubview:_commentLab];
        
        _coinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coinBtn.frame = CGRectMake(size.width-69, 15, 54, 23);
//        _coinBtn.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
        _coinBtn.backgroundColor = [UIColor clearColor];
        [_coinBtn setBackgroundImage:[[UIImage imageNamed:@"expert_price_image.png"] stretchableImageWithLeftCapWidth:27 topCapHeight:11.5] forState:UIControlStateNormal];
        [_coinBtn setTitle:@"金币" forState:UIControlStateNormal];
        _coinBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_coinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_coinBtn];
        _coinBtn.layer.masksToBounds = YES;
        _coinBtn.layer.cornerRadius = 2.5;
        [_coinBtn addTarget:self action:@selector(cionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 119.5, size.width, 0.5)];
        _lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:_lineIma];
    }
    return self;
}
-(void)loadAppointInfo:(ExpertMainListModel *)data{
    
    _rankingIma.hidden = YES;
    _levelIma.hidden = YES;
    _levelLab.hidden = YES;
    _hitRateLab.hidden = YES;
    _starIma.hidden = YES;
    _recordBtn.hidden = YES;
    _tuidanBtn.hidden = YES;
    
    _pointIma2.hidden = YES;
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    _liansaiBtn2.hidden = YES;
    
    if(_isZhuanjia){
        [self loadZhuanjiaAppointInfo:data];
    }else{
        [self loadBangdanAppointInfo:data];
    }
//    [self loadBangdanAppointInfo:data];
}
-(void)loadZhuanjiaAppointInfo:(ExpertMainListModel *)data{
    
    [_headIma sd_setImageWithURL:[NSURL URLWithString:data.HEAD_PORTRAIT]];
    UIImage *image = _headIma.image;
    _headIma.layer.contents = (__bridge id)image.CGImage;
    _headIma.layer.contentsGravity = kCAGravityResizeAspectFill;
    _headIma.layer.contentsScale = image.scale;
    _headIma.layer.masksToBounds=YES;
    _headIma.layer.cornerRadius = 17.5;
    
    _nameLab.text = data.EXPERTS_NICK_NAME;
    CGSize nameSize=[PublicMethod setNameFontSize:_nameLab.text andFont:_nameLab.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLab.frame = CGRectMake(ORIGIN_X(_headIma)+5, 10, nameSize.width+5, 20);
    
    CGFloat xxxx = ORIGIN_X(_nameLab);
    if([data.ISSTAR isEqualToString:@"1"]){
        _starIma.hidden = NO;
        _starIma.frame = CGRectMake(ORIGIN_X(_nameLab), 13, 18, 13);
        _starIma.image = [UIImage imageNamed:@"expert_star.png"];
        xxxx = ORIGIN_X(_starIma);
    }
    
    NSString *recordStr = [NSString stringWithFormat:@"%@中%@",data.ALL_HIT_NUM,data.HIT_NUM];
    CGSize reSize=[PublicMethod setNameFontSize:recordStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _recordBtn.hidden = NO;
    [_recordBtn setTitle:recordStr forState:UIControlStateNormal];
    _recordBtn.frame = CGRectMake(xxxx+5, 13, reSize.width+5, 13);
    
    if(data.FREE_STATUS){
        _tuidanBtn.hidden = NO;
        _tuidanBtn.frame = CGRectMake(ORIGIN_X(_recordBtn)+5, 13, 21, 13);
    }
    
    CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME1 andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _liansaiBtn1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_nameLab)+6.5, liansaiSize.width+5, 12);
    [_liansaiBtn1 setTitle:data.LEAGUE_NAME1 forState:UIControlStateNormal];
    
    _teamNameLab1.text = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME1,data.AWAY_NAME1];
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_liansaiBtn1)+5, ORIGIN_Y(_nameLab)+5, size.width-80, 15);
    
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@",data.MATCHES_ID1,data.MATCH_DATA_TIME1];
    _matchTimeLab1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab1)+5, size.width-70, 15);
    
    
    UILabel *lab = _matchTimeLab1;
    if([data.LOTTEY_CLASS_CODE isEqualToString:@"201"]){//二串一
        
        _teamNameLab2.hidden = NO;
        _liansaiBtn2.hidden = NO;
        _matchTimeLab2.hidden = NO;
        
        _teamNameLab2.text = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME2,data.AWAY_NAME2];
        _teamNameLab2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_matchTimeLab1)+5, size.width-80, 15);
        
        CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME2 andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _liansaiBtn2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab2)+5, liansaiSize.width+5, 12);
        [_liansaiBtn2 setTitle:data.LEAGUE_NAME2 forState:UIControlStateNormal];
        
        _matchTimeLab2.text = [NSString stringWithFormat:@"%@  %@",data.MATCHES_ID2,data.MATCH_DATA_TIME2];
        _matchTimeLab2.frame = CGRectMake(ORIGIN_X(_liansaiBtn2)+5, ORIGIN_Y(_teamNameLab2)+5, size.width-70, 15);
        
        lab = _matchTimeLab2;
    }
    
    
    if ([data.RECOMMEND_COMMENT length] && ![data.RECOMMEND_COMMENT isEqualToString:@"null"]) {
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.RECOMMEND_COMMENT];
    }
    else {
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.RECOMMEND_TITLE];
    }
    _commentLab.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(lab), size.width-70, 20);
    NSString *coinStr = [NSString stringWithFormat:@"%.2f元",data.DISCOUNTPRICE];
    [_coinBtn setTitle:coinStr forState:UIControlStateNormal];
    CGSize coinSize=[PublicMethod setNameFontSize:coinStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if(coinSize.width < 54){
        coinSize.width = 54;
    }
    _coinBtn.frame = CGRectMake(size.width-coinSize.width-25, 15, coinSize.width+10, 23);
    
    _lineIma.frame = CGRectMake(0, ORIGIN_Y(_commentLab)+4.5, size.width, 0.5);//95+40
}
-(void)loadBangdanAppointInfo:(ExpertMainListModel *)data{
    [_headIma sd_setImageWithURL:[NSURL URLWithString:data.HEAD_PORTRAIT]];
    UIImage *image = _headIma.image;
    _headIma.layer.contents = (__bridge id)image.CGImage;
    _headIma.layer.contentsGravity = kCAGravityResizeAspectFill;
    _headIma.layer.contentsScale = image.scale;
    _headIma.layer.masksToBounds=YES;
    _headIma.layer.cornerRadius = 17.5;
    
    _levelLab.hidden = NO;
    _levelIma.hidden = NO;
    if([data.NEW_STAR integerValue] <= 5 && [data.NEW_STAR integerValue] > 0){
        _levelLab.text = [NSString stringWithFormat:@"业余%@段",data.NEW_STAR];
        _levelLab.textColor = [SharedMethod getColorByHexString:@"f8b551"];
        _levelIma.image = [UIImage imageNamed:@"expert_level_amateur.png"];
    }else if ([data.NEW_STAR integerValue] <= 8){
        _levelLab.text = [NSString stringWithFormat:@"专业%@段",data.NEW_STAR];
        _levelLab.textColor = [SharedMethod getColorByHexString:@"f88051"];
        _levelIma.image = [UIImage imageNamed:@"expert_level_major.png"];
    }else{
        _levelLab.text = @"大神";
        _levelLab.textColor = [SharedMethod getColorByHexString:@"f23900"];
        _levelIma.image = [UIImage imageNamed:@"expert_level_okami.png"];
    }
    
    _nameLab.text = data.EXPERTS_NICK_NAME;
    CGSize nameSize=[PublicMethod setNameFontSize:_nameLab.text andFont:_nameLab.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLab.frame = CGRectMake(ORIGIN_X(_levelIma)+5, 10, nameSize.width+5, 20);
    
    NSString *recordStr = [NSString stringWithFormat:@"%@中%@",data.ALL_HIT_NUM,data.HIT_NUM];
    CGSize reSize=[PublicMethod setNameFontSize:recordStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if(data.RANKRATE.length > 0 && ![data.RANKRATE isEqualToString:@"null"]){
        _hitRateLab.hidden = NO;
        _hitRateLab.frame = CGRectMake(ORIGIN_X(_nameLab), 13, 100, 15);
        _hitRateLab.text = [NSString stringWithFormat:@"命中率%@%%",data.RANKRATE];
    }else{
        _recordBtn.hidden = NO;
        [_recordBtn setTitle:recordStr forState:UIControlStateNormal];
        _recordBtn.frame = CGRectMake(ORIGIN_X(_nameLab), 13, reSize.width+5, 13);
    }
    if(data.FREE_STATUS){
        _tuidanBtn.hidden = NO;
        _tuidanBtn.frame = CGRectMake(ORIGIN_X(_nameLab)+5, 13, 21, 13);
        _hitRateLab.frame = CGRectMake(ORIGIN_X(_tuidanBtn)+5, 13, 100, 15);
        _recordBtn.frame = CGRectMake(ORIGIN_X(_tuidanBtn)+5, 13, reSize.width+5, 13);
    }
    
    
    CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME1 andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _liansaiBtn1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_levelLab)+6.5, liansaiSize.width+5, 12);
    [_liansaiBtn1 setTitle:data.LEAGUE_NAME1 forState:UIControlStateNormal];
    
    _teamNameLab1.text = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME1,data.AWAY_NAME1];
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_liansaiBtn1)+5, ORIGIN_Y(_levelLab)+5, size.width-80, 15);//ORIGIN_Y(_levelLab) = 45
    
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@",data.MATCHES_ID1,data.MATCH_DATA_TIME1];
    _matchTimeLab1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab1)+5, size.width-70, 15);
    
    UILabel *lab = _matchTimeLab1;
    if([data.LOTTEY_CLASS_CODE isEqualToString:@"201"]){//二串一
        
        _teamNameLab2.hidden = NO;
        _liansaiBtn2.hidden = NO;
        _matchTimeLab2.hidden = NO;
        
        _teamNameLab2.text = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME2,data.AWAY_NAME2];
        _teamNameLab2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_matchTimeLab1)+5, size.width-80, 15);
        
        CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME2 andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _liansaiBtn2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab2)+5, liansaiSize.width+5, 12);
        [_liansaiBtn2 setTitle:data.LEAGUE_NAME2 forState:UIControlStateNormal];
        
        _matchTimeLab2.text = [NSString stringWithFormat:@"%@  %@",data.MATCHES_ID2,data.MATCH_DATA_TIME2];
        _matchTimeLab2.frame = CGRectMake(ORIGIN_X(_liansaiBtn2)+5, ORIGIN_Y(_teamNameLab2)+5, size.width-70, 15);
        
        lab = _matchTimeLab2;
    }
    
    if ([data.RECOMMEND_COMMENT length] && ![data.RECOMMEND_COMMENT isEqualToString:@"null"]) {
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.RECOMMEND_COMMENT];
    }
    else {
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.RECOMMEND_TITLE];
    }
    _commentLab.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(lab), size.width-70, 20);
    NSString *coinStr = [NSString stringWithFormat:@"%.2f元",data.DISCOUNTPRICE];
    [_coinBtn setTitle:coinStr forState:UIControlStateNormal];
    CGSize coinSize=[PublicMethod setNameFontSize:coinStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if(coinSize.width < 54){
        coinSize.width = 54;
    }
    _coinBtn.frame = CGRectMake(size.width-coinSize.width-25, 15, coinSize.width+10, 23);
    
    _lineIma.frame = CGRectMake(0, ORIGIN_Y(_commentLab)+4.5, size.width, 0.5);//110+40
}

-(void)loadProgramListInfo:(SuperiorMdl *)data{
    
    _rankingIma.hidden = YES;
    _levelIma.hidden = YES;
    _levelLab.hidden = YES;
    _hitRateLab.hidden = YES;
    _starIma.hidden = YES;
    _recordBtn.hidden = YES;
    _tuidanBtn.hidden = YES;
    
    _pointIma2.hidden = YES;
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    
    
    [_headIma sd_setImageWithURL:[NSURL URLWithString:data.headPortrait]];
    UIImage *image = _headIma.image;
    _headIma.layer.contents = (__bridge id)image.CGImage;
    _headIma.layer.contentsGravity = kCAGravityResizeAspectFill;
    _headIma.layer.contentsScale = image.scale;
    _headIma.layer.masksToBounds=YES;
    _headIma.layer.cornerRadius = 17.5;
    
    _nameLab.text = data.expertsNickName;
    CGSize nameSize=[PublicMethod setNameFontSize:_nameLab.text andFont:_nameLab.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLab.frame = CGRectMake(ORIGIN_X(_headIma)+5, 10, nameSize.width+5, 20);
    
    NSString *recordStr = [NSString stringWithFormat:@"%@中%@",[data.SiperiorExpertsLeastFiveHitInfo objectForKey:@"totalNum"],[data.SiperiorExpertsLeastFiveHitInfo objectForKey:@"hitNum"]];
    CGSize reSize=[PublicMethod setNameFontSize:recordStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _recordBtn.hidden = NO;
    [_recordBtn setTitle:recordStr forState:UIControlStateNormal];
    
    if([data.isStar isEqualToString:@"1"]){
        _recordBtn.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_nameLab)+5, reSize.width+5, 13);
        _starIma.hidden = NO;
        _starIma.frame = CGRectMake(ORIGIN_X(_nameLab), 13, 18, 13);
        _starIma.image = [UIImage imageNamed:@"expert_star.png"];
    }else{
        _levelLab.hidden = NO;
        _levelIma.hidden = NO;
        if([data.newstar integerValue] <= 5 && [data.newstar integerValue] > 0){
            _levelLab.text = [NSString stringWithFormat:@"业余%@段",data.newstar];
            _levelLab.textColor = [SharedMethod getColorByHexString:@"f8b551"];
            _levelIma.image = [UIImage imageNamed:@"expert_level_amateur.png"];
        }else if ([data.newstar integerValue] <= 8){
            _levelLab.text = [NSString stringWithFormat:@"专业%@段",data.newstar];
            _levelLab.textColor = [SharedMethod getColorByHexString:@"f88051"];
            _levelIma.image = [UIImage imageNamed:@"expert_level_major.png"];
        }else{
            _levelLab.text = @"大神";
            _levelLab.textColor = [SharedMethod getColorByHexString:@"f23900"];
            _levelIma.image = [UIImage imageNamed:@"expert_level_okami.png"];
        }
        _nameLab.frame = CGRectMake(ORIGIN_X(_levelIma)+5, 10, nameSize.width+5, 20);
        _recordBtn.frame = CGRectMake(ORIGIN_X(_nameLab)+5, 13, reSize.width+5, 13);
        if(data.free_status){
            _tuidanBtn.hidden = NO;
            _tuidanBtn.frame = CGRectMake(ORIGIN_X(_recordBtn)+5, 13, 21, 13);
        }
    }
    
    NSString *compTime=data.matchTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date=[dateFormatter dateFromString:compTime];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm"];
    
    _teamNameLab1.text = [NSString stringWithFormat:@"%@  VS  %@",data.hostNameSimply,data.guestNameSimply];
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@",data.CCId,[dateFormatter2 stringFromDate:date]];
    CGSize liansaiSize=[PublicMethod setNameFontSize:data.leagueNameSimply andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _liansaiBtn1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab1)+5, liansaiSize.width+5, 12);
    [_liansaiBtn1 setTitle:data.leagueNameSimply forState:UIControlStateNormal];
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_pointIma1)-14, size.width-80, 20);
    _matchTimeLab1.frame = CGRectMake(ORIGIN_X(_liansaiBtn1)+5, ORIGIN_Y(_teamNameLab1)+4, size.width-70, 15);
    
    if (data.recommend_comment.length && ![data.recommend_comment isEqualToString:@"null"]) {
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.recommend_comment];
    }
    else {
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.recommend_title];
    }
    [_coinBtn setTitle:[NSString stringWithFormat:@"%.2f元",data.discountPrice] forState:UIControlStateNormal];
    if(data.discountPrice == 0.0){
        [_coinBtn setTitle:@"免费" forState:UIControlStateNormal];
    }
    
//#if defined CRAZYSPORTS
//    [_coinBtn setTitle:[NSString stringWithFormat:@"%@金币",data.goldDiscountPrice] forState:UIControlStateNormal];
//    if([data.goldDiscountPrice floatValue] == 0.0){
//        [_coinBtn setTitle:@"免费" forState:UIControlStateNormal];
//    }
//#endif
    
    if([data.playTypeCode isEqualToString:@"27"] || [data.playTypeCode isEqualToString:@"29"]){//篮球
        _recordBtn.hidden = YES;
        NSString *str = @"让分胜负";
        if([data.playTypeCode isEqualToString:@"29"]){
            str = @"大小分";
        }
        
        NSString *name = [NSString stringWithFormat:@"%@(客)VS%@(主) | %@ %@",data.guestNameSimply,data.hostNameSimply,str,data.rqs];
        
        NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:name];
        
        NSRange range = [name rangeOfString:@"|"];
//        if (range.location == NSNotFound) {
//            range = [name rangeOfString:@" "];
//        }
        if (range.location != NSNotFound) {
            [aString setAttributes:@{NSForegroundColorAttributeName:BLACK_EIGHTYSEVER,NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, range.location)];
            [aString setAttributes:@{NSForegroundColorAttributeName:DEFAULT_TEXTGRAYCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(range.location, aString.length-range.location)];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:3];
            [aString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [name length])];
            _teamNameLab1.attributedText = aString;
        }
        
    }
}
-(void)loadYuecaiExpertListInfo:(ExpertJingjiModel *)data{
    
    _rankingIma.hidden = YES;
    _levelIma.hidden = YES;
    _levelLab.hidden = YES;
    _hitRateLab.hidden = YES;
    _starIma.hidden = YES;
    _recordBtn.hidden = YES;
    _tuidanBtn.hidden = YES;
    
    _pointIma2.hidden = YES;
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    
    [_headIma sd_setImageWithURL:[NSURL URLWithString:data.HEAD_PORTRAIT]];
    UIImage *image = _headIma.image;
    _headIma.layer.contents = (__bridge id)image.CGImage;
    _headIma.layer.contentsGravity = kCAGravityResizeAspectFill;
    _headIma.layer.contentsScale = image.scale;
    _headIma.layer.masksToBounds=YES;
    _headIma.layer.cornerRadius = 17.5;
    
    _levelLab.hidden = NO;
    _levelIma.hidden = NO;
    if(data.STAR <= 5 && data.STAR > 0){
        _levelLab.text = [NSString stringWithFormat:@"业余%ld段",(long)data.STAR];
        _levelLab.textColor = [SharedMethod getColorByHexString:@"f8b551"];
        _levelIma.image = [UIImage imageNamed:@"expert_level_amateur.png"];
    }else if (data.STAR <= 8){
        _levelLab.text = [NSString stringWithFormat:@"专业%ld段",(long)data.STAR];
        _levelLab.textColor = [SharedMethod getColorByHexString:@"f88051"];
        _levelIma.image = [UIImage imageNamed:@"expert_level_major.png"];
    }else{
        _levelLab.text = @"大神";
        _levelLab.textColor = [SharedMethod getColorByHexString:@"f23900"];
        _levelIma.image = [UIImage imageNamed:@"expert_level_okami.png"];
    }
    
    _nameLab.text = data.EXPERTS_NICK_NAME;
    CGSize nameSize=[PublicMethod setNameFontSize:_nameLab.text andFont:_nameLab.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLab.frame = CGRectMake(ORIGIN_X(_levelIma)+5, 10, nameSize.width+5, 20);
    
    _hitRateLab.hidden = NO;
    _hitRateLab.frame = CGRectMake(ORIGIN_X(_nameLab), 13, 100, 15);
    CGFloat hit = ([data.HIT_NUM floatValue]/[data.ALL_HIT_NUM floatValue])*100;
    _hitRateLab.text = [NSString stringWithFormat:@"命中率%.0f%%",hit];
    if(data.FREE_STATUS){
        _tuidanBtn.hidden = NO;
        _tuidanBtn.frame = CGRectMake(ORIGIN_X(_nameLab)+5, 13, 21, 13);
        _hitRateLab.frame = CGRectMake(ORIGIN_X(_tuidanBtn)+5, 13, 100, 15);
    }
    CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _liansaiBtn1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_levelLab)+6.5, liansaiSize.width+5, 12);
    [_liansaiBtn1 setTitle:data.LEAGUE_NAME forState:UIControlStateNormal];
    
    _teamNameLab1.text = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME,data.AWAY_NAME];
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_liansaiBtn1)+5, ORIGIN_Y(_levelLab)+5, size.width-80, 15);//ORIGIN_Y(_levelLab) = 45
    
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@",data.MATCHES_ID,data.MATCH_TIME];
    _matchTimeLab1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab1)+5, size.width-70, 15);
    
    UILabel *lab = _matchTimeLab1;
    if([data.LOTTEY_CLASS_CODE isEqualToString:@"201"]){//二串一
        
//        _teamNameLab2.hidden = NO;
//        _liansaiBtn2.hidden = NO;
//        _matchTimeLab2.hidden = NO;
//        
//        _teamNameLab2.text = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME2,data.AWAY_NAME2];
//        _teamNameLab2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_matchTimeLab1)+5, size.width-80, 15);
//        
//        CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME2 andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//        _liansaiBtn2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab2)+5, liansaiSize.width+5, 12);
//        [_liansaiBtn2 setTitle:data.LEAGUE_NAME2 forState:UIControlStateNormal];
//        
//        _matchTimeLab2.text = [NSString stringWithFormat:@"%@  %@",data.MATCHES_ID2,data.MATCH_DATA_TIME2];
//        _matchTimeLab2.frame = CGRectMake(ORIGIN_X(_liansaiBtn2)+5, ORIGIN_Y(_teamNameLab2)+5, size.width-70, 15);
//        
//        lab = _matchTimeLab2;
    }
    
//    if ([data.RECOMMEND_COMMENT length] && ![data.RECOMMEND_COMMENT isEqualToString:@"null"]) {
//        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.RECOMMEND_COMMENT];
//    }
//    else {
//        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.RECOMMEND_TITLE];
//    }
    _commentLab.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(lab), size.width-70, 20);
    NSString *coinStr = [NSString stringWithFormat:@"%.2f元",data.PRICE];
    [_coinBtn setTitle:coinStr forState:UIControlStateNormal];
    CGSize coinSize=[PublicMethod setNameFontSize:coinStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if(coinSize.width < 54){
        coinSize.width = 54;
    }
    _coinBtn.frame = CGRectMake(size.width-coinSize.width-25, 15, coinSize.width+10, 23);
    
    _lineIma.frame = CGRectMake(0, ORIGIN_Y(_commentLab)+4.5, size.width, 0.5);//110+40
}
-(void)loadYuecaiRankListInfo:(ExpertMainListModel *)data{
//    _liansaiBtn1.backgroundColor = [UIColor clearColor];
    _rankingIma.hidden = YES;
    _levelIma.hidden = YES;
    _levelLab.hidden = YES;
    _hitRateLab.hidden = YES;
    _starIma.hidden = YES;
    _recordBtn.hidden = YES;
    _tuidanBtn.hidden = YES;
    
    _pointIma2.hidden = YES;
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    _liansaiBtn2.hidden = YES;
    [_coinBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [_coinBtn setTitleColor:[UIColor colorWithRed:233/255.0 green:62/255.0 blue:32/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_headIma sd_setImageWithURL:[NSURL URLWithString:data.HEAD_PORTRAIT]];
    UIImage *image = _headIma.image;
    _headIma.layer.contents = (__bridge id)image.CGImage;
    _headIma.layer.contentsGravity = kCAGravityResizeAspectFill;
    _headIma.layer.contentsScale = image.scale;
    _headIma.layer.masksToBounds=YES;
    _headIma.layer.cornerRadius = 17.5;
    
    _nameLab.text = data.EXPERTS_NICK_NAME;
    CGSize nameSize=[PublicMethod setNameFontSize:_nameLab.text andFont:_nameLab.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLab.frame = CGRectMake(ORIGIN_X(_headIma)+5, 10, nameSize.width+5, 20);
    
    
    _rankImgView.frame = CGRectMake(ORIGIN_X(_nameLab)+5, 13, 39, 14);
    NSInteger starNo = [data.STAR integerValue];
    NSString *rankImg=@"";
    if (starNo<=5) {
        rankImg=@"ranklv1-5";
        _rankLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (starNo>5&&starNo<=10){
        rankImg=@"ranklv6-10";
        _rankLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (starNo>10&&starNo<=15){
        rankImg=@"ranklv11-15";
        _rankLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (starNo>15&&starNo<=20){
        rankImg=@"ranklv16-20";
        _rankLab.textColor=[UIColor whiteColor];
    }else if (starNo>20&&starNo<=25){
        rankImg=@"ranklv21-25";
        _rankLab.textColor=[UIColor whiteColor];
    }
    _rankImgView.image=[UIImage imageNamed:rankImg];
    
    _rankLab.text=[NSString stringWithFormat:@"LV%ld",(long)starNo];
    CGSize levelSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)starNo] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_rankLab setFrame:CGRectMake(26-levelSize.width/2,7-levelSize.height/2,levelSize.width,levelSize.height)];
    
//    _starIma.hidden = NO;
//    _starIma.frame = CGRectMake(ORIGIN_X(_nameLab), 13, 18, 13);
//    _starIma.image = [UIImage imageNamed:@"expert_star.png"];
    
    NSString *recordStr = [NSString stringWithFormat:@"准确率%.2f%%",[data.RANKRATE floatValue] * 100];
    CGSize reSize=[PublicMethod setNameFontSize:recordStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _recordBtn.hidden = NO;
    _recordBtn.layer.borderWidth = 0.0f;
    _recordBtn.layer.cornerRadius = 2;
    _recordBtn.layer.masksToBounds = YES;
    [_recordBtn setTitle:recordStr forState:UIControlStateNormal];
    _recordBtn.frame = CGRectMake(ORIGIN_X(_rankImgView)+5, 13, reSize.width+5, 13);
    
    if(data.FREE_STATUS){
        _tuidanBtn.hidden = NO;
        _tuidanBtn.frame = CGRectMake(ORIGIN_X(_recordBtn)+5, 13, 21, 13);
    }
    
    CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME1 andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _liansaiBtn1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_nameLab)+6.5, liansaiSize.width+5, 12);
    [_liansaiBtn1 setTitle:data.LEAGUE_NAME1 forState:UIControlStateNormal];
    
    _teamNameLab1.text = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME1,data.AWAY_NAME1];
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_liansaiBtn1)+5, ORIGIN_Y(_nameLab)+5, size.width-80, 15);
    
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@",data.MATCHES_ID1,data.MATCH_DATA_TIME1];
    _matchTimeLab1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab1)+5, size.width-70, 15);
    
    
    UILabel *lab = _matchTimeLab1;
    if([data.LOTTEY_CLASS_CODE isEqualToString:@"201"]){//二串一
        
        _teamNameLab2.hidden = NO;
        _liansaiBtn2.hidden = NO;
        _matchTimeLab2.hidden = NO;
        
        _teamNameLab2.text = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME2,data.AWAY_NAME2];
        _teamNameLab2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_matchTimeLab1)+5, size.width-80, 15);
        
        CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME2 andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _liansaiBtn2.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab2)+5, liansaiSize.width+5, 12);
        [_liansaiBtn2 setTitle:data.LEAGUE_NAME2 forState:UIControlStateNormal];
        
        _matchTimeLab2.text = [NSString stringWithFormat:@"%@  %@",data.MATCHES_ID2,data.MATCH_DATA_TIME2];
        _matchTimeLab2.frame = CGRectMake(ORIGIN_X(_liansaiBtn2)+5, ORIGIN_Y(_teamNameLab2)+5, size.width-70, 15);
        
        lab = _matchTimeLab2;
    }
    
    
    if ([data.RECOMMEND_COMMENT length] && ![data.RECOMMEND_COMMENT isEqualToString:@"null"]) {
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.RECOMMEND_COMMENT];
    }
    else {
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.RECOMMEND_TITLE];
    }
    _commentLab.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(lab), size.width-70, 20);
    NSString *coinStr = [NSString stringWithFormat:@"%.2f元",data.DISCOUNTPRICE];
    [_coinBtn setTitle:coinStr forState:UIControlStateNormal];
    CGSize coinSize=[PublicMethod setNameFontSize:coinStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if(coinSize.width < 54){
        coinSize.width = 54;
    }
    _coinBtn.frame = CGRectMake(size.width-coinSize.width-25, 25, coinSize.width+10, 23);
    
    _lineIma.frame = CGRectMake(0, ORIGIN_Y(_commentLab)+4.5, size.width, 0.5);//95+40
}
-(void)loadCSBasketExpertListInfo:(ExpertJingjiModel *)data{
    
    _rankingIma.hidden = YES;
    _levelIma.hidden = YES;
    _levelLab.hidden = YES;
    _hitRateLab.hidden = YES;
    _starIma.hidden = YES;
    _recordBtn.hidden = YES;
    _tuidanBtn.hidden = YES;
    
    _pointIma2.hidden = YES;
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    _commentLab.hidden = YES;
    
    
    [_headIma sd_setImageWithURL:[NSURL URLWithString:data.HEAD_PORTRAIT]];
    UIImage *image = _headIma.image;
    _headIma.layer.contents = (__bridge id)image.CGImage;
    _headIma.layer.contentsGravity = kCAGravityResizeAspectFill;
    _headIma.layer.contentsScale = image.scale;
    _headIma.layer.masksToBounds=YES;
    _headIma.layer.cornerRadius = 17.5;
    
    _nameLab.text = data.EXPERTS_NICK_NAME;
    CGSize nameSize=[PublicMethod setNameFontSize:_nameLab.text andFont:_nameLab.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLab.frame = CGRectMake(ORIGIN_X(_headIma)+5, 10, nameSize.width+5, 20);
    
    CGSize liansaiSize=[PublicMethod setNameFontSize:data.LEAGUE_NAME andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _liansaiBtn1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_nameLab)+6.5, liansaiSize.width+5, 12);
    [_liansaiBtn1 setTitle:data.LEAGUE_NAME forState:UIControlStateNormal];
    
    _teamNameLab1.text = [NSString stringWithFormat:@"%@  VS  %@",data.AWAY_NAME,data.HOME_NAME];//篮球
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_liansaiBtn1)+5, ORIGIN_Y(_nameLab)+5, size.width-80, 15);
    
    NSString *str = @"让分胜负";
    if([data.PLAY_TYPE_CODE isEqualToString:@"29"]){
        str = @"大小分";
    }
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@ | %@ %@",data.MATCHES_ID,data.MATCH_TIME,str,data.HOSTRQ];
    _matchTimeLab1.frame = CGRectMake(ORIGIN_X(_headIma)+5, ORIGIN_Y(_teamNameLab1)+5, size.width-70, 15);
    
    NSString *coinStr = [NSString stringWithFormat:@"%.2f元",data.GOLDDISCOUNTPRICE/10.0];
    [_coinBtn setTitle:coinStr forState:UIControlStateNormal];
    CGSize coinSize=[PublicMethod setNameFontSize:coinStr andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if(coinSize.width < 54){
        coinSize.width = 54;
    }
    _coinBtn.frame = CGRectMake(size.width-coinSize.width-25, 15, coinSize.width+10, 23);
    
    _lineIma.frame = CGRectMake(0, ORIGIN_Y(_matchTimeLab1)+4.5, size.width, 0.5);//95+40
}
-(void)cionBtnAction:(UIButton *)button{
    if(self.buttonAction){
        self.buttonAction(button);
    }
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