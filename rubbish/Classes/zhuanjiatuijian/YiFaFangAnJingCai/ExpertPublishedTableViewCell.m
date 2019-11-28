//
//  ExpertPublishedTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/12/1.
//
//

#import "ExpertPublishedTableViewCell.h"
#import "SharedMethod.h"

@implementation ExpertPublishedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        
        _matchTimeLab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, size.width-80, 20)];
        _matchTimeLab1.backgroundColor = [UIColor clearColor];
        _matchTimeLab1.font = [UIFont systemFontOfSize:11];
        _matchTimeLab1.textColor = BLACK_SEVENTY;
        [self.contentView addSubview:_matchTimeLab1];
        
        _tuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tuiBtn.frame = CGRectMake(100, 10, 21, 13);
        _tuiBtn.backgroundColor = [UIColor clearColor];
        [_tuiBtn setTitle:@"退" forState:UIControlStateNormal];
        _tuiBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _tuiBtn.enabled = NO;
        _tuiBtn.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:187/255.0 blue:109/255.0 alpha:1] CGColor];
        _tuiBtn.layer.borderWidth = 0.5f;
        _tuiBtn.layer.cornerRadius = 2;
        _tuiBtn.layer.masksToBounds = YES;
        [_tuiBtn setTitleColor:[UIColor colorWithRed:78/255.0 green:187/255.0 blue:109/255.0 alpha:1] forState:UIControlStateNormal];
        [self.contentView addSubview:_tuiBtn];
        
        _pointIma1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 33, 8, 8)];
        _pointIma1.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_pointIma1];
        _pointIma1.layer.borderColor = [[SharedMethod getColorByHexString:@"6e29bd"] CGColor];
        _pointIma1.layer.borderWidth = 1.0f;
        _pointIma1.layer.cornerRadius = 2;
        _pointIma1.layer.masksToBounds = YES;
        
        _teamNameLab1 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_matchTimeLab1)+0, size.width-70, 25)];
        _teamNameLab1.backgroundColor = [UIColor clearColor];
        _teamNameLab1.font = [UIFont systemFontOfSize:14];
        _teamNameLab1.numberOfLines = 2;
        _teamNameLab1.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_teamNameLab1];
        
        
        _matchTimeLab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 55, size.width-80, 20)];
        _matchTimeLab2.backgroundColor = [UIColor clearColor];
        _matchTimeLab2.font = [UIFont systemFontOfSize:11];
        _matchTimeLab2.textColor = BLACK_SEVENTY;
        _matchTimeLab2.hidden = YES;
        [self.contentView addSubview:_matchTimeLab2];
        
        _pointIma2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 83, 8, 8)];
        _pointIma2.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_pointIma2];
        _pointIma2.hidden = YES;
        _pointIma2.layer.borderColor = [[SharedMethod getColorByHexString:@"6e29bd"] CGColor];
        _pointIma2.layer.borderWidth = 1.0f;
        _pointIma2.layer.cornerRadius = 2;
        _pointIma2.layer.masksToBounds = YES;
        
        _teamNameLab2 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma2)+8, ORIGIN_Y(_matchTimeLab2)+5, size.width-70, 15)];
        _teamNameLab2.backgroundColor = [UIColor clearColor];
        _teamNameLab2.font = [UIFont systemFontOfSize:14];
        _teamNameLab2.textColor = BLACK_EIGHTYSEVER;
        _teamNameLab2.hidden = YES;
        [self.contentView addSubview:_teamNameLab2];
        
        _statueIma = [[UIImageView alloc]init];
        _statueIma.frame = CGRectMake(size.width-110, 8, 35, 35);
        _statueIma.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_statueIma];
//        _statueIma.hidden = YES;
        
        _coinLab = [[UILabel alloc]init];
        _coinLab.frame = CGRectMake(size.width-115, 15, 110, 20);
        _coinLab.backgroundColor = [UIColor clearColor];
        _coinLab.font = [UIFont systemFontOfSize:13];
        _coinLab.textColor = [SharedMethod getColorByHexString:@"1da3ff"];
#if defined CRAZYSPORTS
        _coinLab.textColor = [SharedMethod getColorByHexString:@"6e29bd"];
#endif
        _coinLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_coinLab];
        
        _lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(15, 54.5, size.width-30, 0.5)];
        _lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:_lineIma];
    }
    return self;
}
-(void)loadAppointInfo:(BeenPlanSMGModel *)data isErchuanyi:(BOOL)isErchuanyi{
    
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    _pointIma2.hidden = YES;
    _statueIma.hidden = YES;
    _tuiBtn.hidden = YES;
    
    _teamNameLab1.text  = data.matchesName;
    
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_matchTimeLab1)+5, size.width-70, 15);
    
    if([data.lotteryClassCode isEqualToString:@"204"]){//篮球
        NSString *str = @"让分胜负";
        if([data.playTypeCode isEqualToString:@"29"]){
            str = @"大小分";
        }
        NSString *raceName = [NSString stringWithFormat:@"%@(客)VS%@(主) \n%@ %@",data.awayName,data.homeName,str,data.rqs];
//        NSString *raceName = [NSString stringWithFormat:@"%@ | %@ %@",data.matchesName,str,data.rqs];
        
        NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:raceName];
        
        NSRange range = [raceName rangeOfString:@" "];
        
        [aString setAttributes:@{NSForegroundColorAttributeName:BLACK_EIGHTYSEVER,NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, range.location)];
        [aString setAttributes:@{NSForegroundColorAttributeName:DEFAULT_TEXTGRAYCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(range.location, aString.length-range.location)];
        _teamNameLab1.attributedText = aString;
        
        _teamNameLab1.frame = CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_matchTimeLab1)+0, size.width-70, 35);
    }
    
    NSString *compTime=data.matchTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date=[dateFormatter dateFromString:compTime];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
    
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@ %@ %@",data.leagueName,data.matchesId,[dateFormatter2 stringFromDate:date]];
    CGSize timeSize=[PublicMethod setNameFontSize:_matchTimeLab1.text andFont:_matchTimeLab1.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if([data.FREE_STATUS isEqualToString:@"1"]){
        _tuiBtn.hidden = NO;
        _tuiBtn.frame = CGRectMake(20 + timeSize.width, 7, 21, 13);
    }
    
    _statueIma.frame = CGRectMake(size.width-110, 8, 35, 35);
    
    _lineIma.frame = CGRectMake(15, 54.5, size.width-30, 0.5);
    if([data.lotteryClassCode isEqualToString:@"204"]){
        _lineIma.frame = CGRectMake(15, 59.5, size.width-30, 0.5);
    }
    
    if(isErchuanyi){
        
        _teamNameLab2.hidden = NO;
        _matchTimeLab2.hidden = NO;
        _pointIma2.hidden = NO;
        
        _teamNameLab2.text  = data.matchesName2;
        
        NSString *compTime=data.matchTime2;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
        NSDate *date=[dateFormatter dateFromString:compTime];
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
        
        _matchTimeLab2.text = [NSString stringWithFormat:@"%@ %@ %@",data.leagueName2,data.matchesId2,[dateFormatter2 stringFromDate:date]];
        
        _statueIma.frame = CGRectMake(size.width-110, 32.5, 35, 35);
        
        _lineIma.frame = CGRectMake(0, 104.5, size.width, 0.5);
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@",data.orderStatus,data.closeStatus];
    if ([str isEqualToString:@"21"]) {
//        _contestStatus.text = @"在售中";
        _statueIma.hidden = NO;
        _statueIma.image = [UIImage imageNamed:@"icon_expert_sell_ing"];
    }else if ([str isEqualToString:@"22"]){
//        _contestStatus.text = @"已停售";
        _statueIma.hidden = NO;
        _statueIma.image = [UIImage imageNamed:@"icon_expert_sell_stop.png"];
    }else if ([[str substringToIndex:1] isEqualToString:@"1"]){
//        _contestStatus.text = @"审核中";
        _statueIma.hidden = NO;
        _statueIma.image = [UIImage imageNamed:@"icon_expert_checking.png"];
    }else if ([[str substringToIndex:1] isEqualToString:@"3"]){
//        _contestStatus.text = @"未通过";
        _statueIma.hidden = NO;
        _statueIma.image = [UIImage imageNamed:@"icon_expert_no_pass.png"];
    }else{
        _statueIma.hidden = YES;
    }
    
    if([data.discountPrice floatValue]!=0.00){
        CGFloat coin = [data.discountPrice floatValue];
        _coinLab.text=[NSString stringWithFormat:@"%.2f元",coin];
    }else{
        _coinLab.text=@"免费";
    }
//#if defined CRAZYSPORTS
//    if([data.goldDiscountPrice floatValue]!=0.00){
//       CGFloat  coin = [data.goldDiscountPrice floatValue];
//        _coinLab.text=[NSString stringWithFormat:@"%.1f金币",coin];
//    }else{
//        _coinLab.text=@"免费";
//    }
//#endif
}
-(void)loadAppointHistoryInfo:(BeenPlanHisModel *)data isErchuanyi:(BOOL)isErchuanyi{
    
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    _pointIma2.hidden = YES;
    _statueIma.hidden = YES;
    _tuiBtn.hidden = YES;
    
    _teamNameLab1.text  = [NSString stringWithFormat:@"%@  %@:%@  %@",data.homeName,data.homeScore,data.awayScore,data.awayName];
    
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_matchTimeLab1)+5, size.width-70, 15);
    
    if([data.lotteryClassCode isEqualToString:@"204"]){//篮球
        NSString *str = @"让分胜负";
        if([data.playTypeCode isEqualToString:@"29"]){
            str = @"大小分";
        }
        NSString *raceName = [NSString stringWithFormat:@"%@(客)%@:%@%@(主) \n%@ %@",data.awayName,data.awayScore,data.homeScore,data.homeName,str,data.rqs];
        //        NSString *raceName = [NSString stringWithFormat:@"%@ | %@ %@",data.matchesName,str,data.rqs];
        
        NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:raceName];
        
        NSRange range = [raceName rangeOfString:@" "];
        
        [aString setAttributes:@{NSForegroundColorAttributeName:BLACK_EIGHTYSEVER,NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, range.location)];
        [aString setAttributes:@{NSForegroundColorAttributeName:DEFAULT_TEXTGRAYCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(range.location, aString.length-range.location)];
        _teamNameLab1.attributedText = aString;
        
        _teamNameLab1.frame = CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_matchTimeLab1)+0, size.width-70, 35);
    }
    
    NSString *compTime=data.matchTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date=[dateFormatter dateFromString:compTime];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
    
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@ %@ %@",data.leagueName,data.matchesId,[dateFormatter2 stringFromDate:date]];
    CGSize timeSize=[PublicMethod setNameFontSize:_matchTimeLab1.text andFont:_matchTimeLab1.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if([data.FREE_STATUS isEqualToString:@"1"]){
        _tuiBtn.hidden = NO;
        _tuiBtn.frame = CGRectMake(20 + timeSize.width, 7, 21, 13);
    }
    
    _statueIma.frame = CGRectMake(size.width-110, 8, 35, 35);
    
    _lineIma.frame = CGRectMake(15, 54.5, size.width-30, 0.5);
    if([data.lotteryClassCode isEqualToString:@"204"]){
        _lineIma.frame = CGRectMake(15, 59.5, size.width-30, 0.5);
    }
    
    if(isErchuanyi){
        
        _teamNameLab2.hidden = NO;
        _matchTimeLab2.hidden = NO;
        _pointIma2.hidden = NO;
        
        _teamNameLab2.text  = [NSString stringWithFormat:@"%@  %@:%@  %@",data.homeName2,data.homeScore2,data.awayScore2,data.awayName2];
        
        NSString *compTime=data.matchTime2;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
        NSDate *date=[dateFormatter dateFromString:compTime];
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
        
        _matchTimeLab2.text = [NSString stringWithFormat:@"%@ %@ %@",data.leagueName2,data.matchesId2,[dateFormatter2 stringFromDate:date]];
        
        _statueIma.frame = CGRectMake(size.width-110, 32.5, 35, 35);
        
        _lineIma.frame = CGRectMake(15, 104.5, size.width-30, 0.5);
    }
    
    NSString *str = data.hitStatus;
    if([str isEqualToString:@"1"]){
        _statueIma.hidden = NO;
        _statueIma.image = [UIImage imageNamed:@"recommentright.png"];
    } else if([str isEqualToString:@"2"]){
        _statueIma.hidden = NO;
        _statueIma.image = [UIImage imageNamed:@"recommentwrong.png"];
    } else if([str isEqualToString:@"4"]){
        _statueIma.hidden = NO;
        _statueIma.image = [UIImage imageNamed:@"icon_expert_not_open.png"];
    }else{
        _statueIma.hidden = YES;
    }
    if([data.goldDiscountPrice floatValue]!=0.00){
        CGFloat coin = [data.goldDiscountPrice floatValue];
        _coinLab.text=[NSString stringWithFormat:@"%.2f元",coin/10.0];
    }else{
        _coinLab.text=@"免费";
    }
    
//#if defined CRAZYSPORTS
//    if([data.goldDiscountPrice floatValue]!=0.00){
//        CGFloat coin = [data.goldDiscountPrice floatValue];
//        _coinLab.text=[NSString stringWithFormat:@"%.1f金币",coin];
//    }else{
//        _coinLab.text=@"免费";
//    }
//#endif
}
-(void)loadBuyAppointInfo:(BuyPlanModel *)data isErchuanyi:(BOOL)isErchuanyi{
    
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    _pointIma2.hidden = YES;
    _statueIma.hidden = YES;
    _tuiBtn.hidden = YES;
    
    _teamNameLab1.text  = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME,data.AWAY_NAME];
    
    _teamNameLab1.frame = CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_matchTimeLab1)+5, size.width-70, 15);
    
    if([data.LOTTEY_CLASS_CODE isEqualToString:@"204"]){//篮球
        NSString *str = @"让分胜负";
        if([data.PLAY_TYPE_CODE isEqualToString:@"29"]){
            str = @"大小分";
        }
        NSString *raceName = [NSString stringWithFormat:@"%@(客)VS%@(主) \n%@ %@",data.AWAY_NAME,data.HOME_NAME,str,data.HOSTRQ];
        
        NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:raceName];
        
        NSRange range = [raceName rangeOfString:@" "];
        
        [aString setAttributes:@{NSForegroundColorAttributeName:BLACK_EIGHTYSEVER,NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, range.location)];
        [aString setAttributes:@{NSForegroundColorAttributeName:DEFAULT_TEXTGRAYCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(range.location, aString.length-range.location)];
        _teamNameLab1.attributedText = aString;
        
        _teamNameLab1.frame = CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_matchTimeLab1)+0, size.width-70, 35);
    }
    
    _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@",data.LEAGUE_NAME,data.MATCH_TIME];
    CGSize timeSize=[PublicMethod setNameFontSize:_matchTimeLab1.text andFont:_matchTimeLab1.font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if(data.FREE_STATUS == 1){
        _tuiBtn.hidden = NO;
        _tuiBtn.frame = CGRectMake(20 + timeSize.width, 7, 21, 13);
    }
    
    _statueIma.frame = CGRectMake(size.width-110, 8, 35, 35);
    
    _lineIma.frame = CGRectMake(15, 54.5, size.width-30, 0.5);
    if([data.LOTTEY_CLASS_CODE isEqualToString:@"204"]){
        _lineIma.frame = CGRectMake(15, 59.5, size.width-30, 0.5);
    }
    
    if(isErchuanyi){
        
        _teamNameLab2.hidden = NO;
        _matchTimeLab2.hidden = NO;
        _pointIma2.hidden = NO;
        
        _teamNameLab2.text  = [NSString stringWithFormat:@"%@  VS  %@",data.HOME_NAME2,data.AWAY_NAME2];
        
        _matchTimeLab2.text = [NSString stringWithFormat:@"%@  %@",data.LEAGUE_NAME2,data.MATCH_TIME2];
        
        _statueIma.frame = CGRectMake(size.width-110, 32.5, 35, 35);
        
        _lineIma.frame = CGRectMake(15, 104.5, size.width-30, 0.5);
    }
    
    CGFloat coin = [data.AMOUNT floatValue];
    NSString *amount = [NSString stringWithFormat:@"%.2f元",coin];
    
//#if defined CRAZYSPORTS
//    coin = [data.GOLDDISCOUNTPRICE floatValue];
//    amount = [NSString stringWithFormat:@"%.1f金币",coin];
//#endif
    
    if (coin==0.00) {
        amount=@"免费";
    }
    _coinLab.text=amount;
    NSString *statics = [NSString stringWithFormat:@"%@%@",data.CLOSE_STATUS,data.HIT_STATUS];
    _statueIma.hidden = YES;
    if ([[statics substringToIndex:1]isEqualToString:@"3"]) {
        if ([[statics substringFromIndex:1] isEqualToString:@"1"]) {
//            self.statLab.text = @"荐中";
            _statueIma.hidden = NO;
            _statueIma.image = [UIImage imageNamed:@"recommentright.png"];
        }else if ([[statics substringFromIndex:1] isEqualToString:@"2"]) {
//            self.statLab.text = @"未中";
            _statueIma.hidden = NO;
            _statueIma.image = [UIImage imageNamed:@"recommentwrong.png"];
            if (data.FREE_STATUS==1) {
//                self.statLab.text = @"已退款";
                _statueIma.image = [UIImage imageNamed:@"icon_expert_return_money.png"];
            }
        }else if ([[statics substringFromIndex:1] isEqualToString:@"4"]) {
//            self.statLab.text = @"走盘";
            _statueIma.hidden = NO;
            _statueIma.image = [UIImage imageNamed:@"icon_expert_not_open.png"];
            if (data.FREE_STATUS==1) {
//                self.statLab.text = @"已退款";
                _statueIma.image = [UIImage imageNamed:@"icon_expert_return_money.png"];
            }
        }
    }else if (![[statics substringToIndex:1]isEqualToString:@"3"]) {
//        self.statLab.text = @"未开";
        _statueIma.hidden = NO;
        _statueIma.image = [UIImage imageNamed:@"icon_expert_not_open.png"];
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