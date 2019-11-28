//
//  ExpertDetailListTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/30.
//
//

#import "ExpertDetailListTableViewCell.h"
#import "SharedMethod.h"

@implementation ExpertDetailListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        
        _pointIma1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 16, 8, 8)];
        _pointIma1.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_pointIma1];
        _pointIma1.layer.borderColor = [[SharedMethod getColorByHexString:@"6e29bd"] CGColor];
        _pointIma1.layer.borderWidth = 1.0f;
        _pointIma1.layer.cornerRadius = 2;
        _pointIma1.layer.masksToBounds = YES;
        
        _teamNameLab1 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma1)+8, 10, size.width-80, 20)];
        _teamNameLab1.backgroundColor = [UIColor clearColor];
        _teamNameLab1.font = [UIFont systemFontOfSize:14];
        _teamNameLab1.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_teamNameLab1];
        
        _matchTimeLab1 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_teamNameLab1)+5, size.width-70, 15)];
        _matchTimeLab1.backgroundColor = [UIColor clearColor];
        _matchTimeLab1.font = [UIFont systemFontOfSize:11];
        _matchTimeLab1.textColor = BLACK_SEVENTY;
        [self.contentView addSubview:_matchTimeLab1];
        
        _pointIma2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, ORIGIN_Y(_matchTimeLab1)+11, 8, 8)];
        _pointIma2.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_pointIma2];
        _pointIma2.hidden = YES;
        _pointIma2.layer.borderColor = [[SharedMethod getColorByHexString:@"6e29bd"] CGColor];
        _pointIma2.layer.borderWidth = 1.0f;
        _pointIma2.layer.cornerRadius = 2;
        _pointIma2.layer.masksToBounds = YES;
        
        _teamNameLab2 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma2)+8, ORIGIN_Y(_matchTimeLab1)+5, size.width-80, 20)];
        _teamNameLab2.backgroundColor = [UIColor clearColor];
        _teamNameLab2.font = [UIFont systemFontOfSize:14];
        _teamNameLab2.textColor = BLACK_EIGHTYSEVER;
        _teamNameLab2.hidden = YES;
        [self.contentView addSubview:_teamNameLab2];
        
        _matchTimeLab2 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma2)+8, ORIGIN_Y(_teamNameLab2)+5, size.width-70, 15)];
        _matchTimeLab2.backgroundColor = [UIColor clearColor];
        _matchTimeLab2.font = [UIFont systemFontOfSize:11];
        _matchTimeLab2.textColor = BLACK_SEVENTY;
        _matchTimeLab2.hidden = YES;
        [self.contentView addSubview:_matchTimeLab2];
        
        _commentLab = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(_pointIma2)+8, ORIGIN_Y(_matchTimeLab1)+5, size.width-70, 15)];
        _commentLab.backgroundColor = [UIColor clearColor];
        _commentLab.font = [UIFont systemFontOfSize:11];
        _commentLab.textColor = BLACK_SEVENTY;
        _commentLab.text = @"推荐评语：";
        [self.contentView addSubview:_commentLab];
        
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookBtn.frame = CGRectMake(15, ORIGIN_Y(_commentLab)+10, size.width-30, 35);
        _lookBtn.backgroundColor = [SharedMethod getColorByHexString:@"1588da"];
        [_lookBtn setTitle:@"查看方案详情" forState:UIControlStateNormal];
        _lookBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_lookBtn addTarget:self action:@selector(chakanfanganAction:) forControlEvents:UIControlEventTouchUpInside];
        [_lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_lookBtn];
        _lookBtn.layer.masksToBounds = YES;
        _lookBtn.layer.cornerRadius = 4;
        
        _statueIma = [[UIImageView alloc]init];
        _statueIma.frame = CGRectMake(size.width-30-30, 11.5, 30, 30);
        _statueIma.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_statueIma];
        _statueIma.hidden = YES;
        
        _lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110+9.5, size.width, 0.5)];
        _lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:_lineIma];
    }
    return self;
}
-(void)loadAppointInfo:(NewPlanList *)data{//竞彩
    
    _commentLab.hidden = NO;
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    _pointIma2.hidden = YES;
    _statueIma.hidden = YES;
    if(![data.passType isEqualToString:@"2x1"]){
        NSDictionary *dict = [data.matchs objectAtIndex:0];
        
        _teamNameLab1.text = [dict valueForKey:@"matchesName"];
        NSString *time = [dict valueForKey:@"matchTime"];
        NSArray *ary = [time componentsSeparatedByString:@" "];
        if(ary.count == 2){
            time = [ary objectAtIndex:1];
        }
        _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"leagueName"],[dict valueForKey:@"matchesId"],time];
//        NSString *str = [dict valueForKey:@"recommendContent"];
//        if(str.length == 0 || [str isEqualToString:@"null"]){
//            str = data.recommendTitle;
//        }
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.recommendTitle];
        
        _commentLab.frame = CGRectMake(ORIGIN_X(_pointIma1)+8, ORIGIN_Y(_matchTimeLab1)+5, size.width-70, 15);
        
        _lookBtn.backgroundColor = [SharedMethod getColorByHexString:@"1588da"];
        if([data.goldDiscountPrice floatValue] > 0 && ![data.goldDiscountPrice isEqualToString:@"null"]){
            [_lookBtn setTitle:[NSString stringWithFormat:@"查看方案详情(%@元)",data.discountPrice] forState:UIControlStateNormal];
#if defined CRAZYSPORTS
//            [_lookBtn setTitle:[NSString stringWithFormat:@"查看方案详情(%@金币)",data.goldDiscountPrice] forState:UIControlStateNormal];
            _lookBtn.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#endif
        }else{
            [_lookBtn setTitle:@"查看方案详情" forState:UIControlStateNormal];
#if defined CRAZYSPORTS
            _lookBtn.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#endif
        }
        _lookBtn.frame = CGRectMake(15, ORIGIN_Y(_commentLab)+10, size.width-30, 35);
        
        _lineIma.frame = CGRectMake(0, 115+9.5, size.width, 0.5);
    }else if([data.passType isEqualToString:@"2x1"]){
        
        _teamNameLab2.hidden = NO;
        _matchTimeLab2.hidden = NO;
        _pointIma2.hidden = NO;
        
        NSDictionary *dict = [data.matchs objectAtIndex:0];
        _teamNameLab1.text = [dict valueForKey:@"matchesName"];
        NSString *time = [dict valueForKey:@"matchTime"];
        NSArray *ary = [time componentsSeparatedByString:@" "];
        if(ary.count == 2){
            time = [ary objectAtIndex:1];
        }
        _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"leagueName"],[dict valueForKey:@"matchesId"],time];
//        NSString *str = [dict valueForKey:@"recommendContent"];
//        if(str.length == 0 || [str isEqualToString:@"null"]){
//            str = data.recommendTitle;
//        }
        _commentLab.text = [NSString stringWithFormat:@"推荐评语:%@",data.recommendTitle];
        
        _teamNameLab2.text = [dict valueForKey:@"matchesName2"];
        NSString *time2 = [dict valueForKey:@"matchTime2"];
        NSArray *ary2 = [time componentsSeparatedByString:@" "];
        if(ary2.count == 2){
            time2 = [ary objectAtIndex:1];
        }
        _matchTimeLab2.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"leagueName2"],[dict valueForKey:@"matchesId2"],time2];
        
        _commentLab.frame = CGRectMake(ORIGIN_X(_pointIma2)+8, ORIGIN_Y(_matchTimeLab2)+5, size.width-70, 15);
        
        _lookBtn.backgroundColor = [SharedMethod getColorByHexString:@"1588da"];
        if([data.goldDiscountPrice floatValue] > 0 && ![data.goldDiscountPrice isEqualToString:@"null"]){
            [_lookBtn setTitle:[NSString stringWithFormat:@"查看方案详情(%@元)",data.discountPrice] forState:UIControlStateNormal];
#if defined CRAZYSPORTS
//            [_lookBtn setTitle:[NSString stringWithFormat:@"查看方案详情(%@金币)",data.goldDiscountPrice] forState:UIControlStateNormal];
            _lookBtn.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#endif
        }else{
            [_lookBtn setTitle:@"查看方案详情" forState:UIControlStateNormal];
#if defined CRAZYSPORTS
            _lookBtn.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#endif
        }
        _lookBtn.frame = CGRectMake(15, ORIGIN_Y(_commentLab)+10, size.width-30, 35);
        
        _lineIma.frame = CGRectMake(0, 165+9.5, size.width, 0.5);
    }
    
    if([data.lotteryClassCode isEqualToString:@"204"]){
        NSDictionary *dict = [data.matchs objectAtIndex:0];
        NSString *str = @"让分胜负";
        if([[dict valueForKey:@"playTypeCode"] isEqualToString:@"29"]){
            str = @"大小分";
        }
        
        NSString *raceName = [NSString stringWithFormat:@"%@(客)VS%@(主) | %@ %@",[dict valueForKey:@"awayName"],[dict valueForKey:@"homeName"],str,[dict valueForKey:@"rqs"]];
        
        NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:raceName];
        
        NSRange range = [raceName rangeOfString:@"|"];
        
        [aString setAttributes:@{NSForegroundColorAttributeName:BLACK_EIGHTYSEVER,NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, range.location)];
        [aString setAttributes:@{NSForegroundColorAttributeName:DEFAULT_TEXTGRAYCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(range.location, aString.length-range.location)];
        _teamNameLab1.attributedText = aString;
    }
}
-(void)loadAppointHistoryInfo:(HistoryPlanList *)data{
    
    _statueIma.hidden = NO;
    if ([data.isHit isEqualToString:@"1"]){//推荐结果(0:待确定,1:荐中,2:未荐中,3:取消)
        _statueIma.image = [UIImage imageNamed:@"recommentright.png"];
    }else if ([data.isHit isEqualToString:@"2"]){
        _statueIma.image = [UIImage imageNamed:@"recommentwrong.png"];
    }else if ([data.isHit isEqualToString:@"4"]){
        _statueIma.image = [UIImage imageNamed:@"icon_expert_not_open.png"];
    }else{
        _statueIma.hidden = YES;
    }
    
    _teamNameLab2.hidden = YES;
    _matchTimeLab2.hidden = YES;
    _pointIma2.hidden = YES;
    
    _commentLab.hidden = YES;
    _lookBtn.hidden = YES;
    if(![data.passType isEqualToString:@"2x1"]){
        NSDictionary *dict = [data.matchs objectAtIndex:0];
        
        _teamNameLab1.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"homeName"],[dict valueForKey:@"score"],[dict valueForKey:@"awayName"]];
        if([[dict valueForKey:@"playTypeCode"] isEqualToString:@"27"] || [[dict valueForKey:@"playTypeCode"] isEqualToString:@"29"]){//篮球
            _teamNameLab1.text = [NSString stringWithFormat:@"%@(客)  %@  %@(主)",[dict valueForKey:@"awayName"],[dict valueForKey:@"score"],[dict valueForKey:@"homeName"]];
        }
        NSString *time = [dict valueForKey:@"matchTime"];
        NSArray *ary = [time componentsSeparatedByString:@" "];
        if(ary.count == 2){
            time = [ary objectAtIndex:1];
        }
        _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"leagueName"],[dict valueForKey:@"matchesId"],time];
        
        _lineIma.frame = CGRectMake(0, 59.5, size.width, 0.5);
        _statueIma.frame = CGRectMake(size.width-37-30, 11.5, 30, 30);
    }else if([data.passType isEqualToString:@"2x1"]){
        
        _teamNameLab2.hidden = NO;
        _matchTimeLab2.hidden = NO;
        _pointIma2.hidden = NO;
        
        NSDictionary *dict = [data.matchs objectAtIndex:0];
        _teamNameLab1.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"homeName"],[dict valueForKey:@"score"],[dict valueForKey:@"awayName"]];
        NSString *time = [dict valueForKey:@"matchTime"];
        NSArray *ary = [time componentsSeparatedByString:@" "];
        if(ary.count == 2){
            time = [ary objectAtIndex:1];
        }
        _matchTimeLab1.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"leagueName"],[dict valueForKey:@"matchesId"],time];
        
        _teamNameLab2.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"homeName2"],[dict valueForKey:@"score2"],[dict valueForKey:@"awayName2"]];
        NSString *time2 = [dict valueForKey:@"matchTime2"];
        NSArray *ary2 = [time componentsSeparatedByString:@" "];
        if(ary2.count == 2){
            time2 = [ary objectAtIndex:1];
        }
        _matchTimeLab2.text = [NSString stringWithFormat:@"%@  %@  %@",[dict valueForKey:@"leagueName2"],[dict valueForKey:@"matchesId2"],time2];
        
        _lineIma.frame = CGRectMake(0, 104.5, size.width, 0.5);
        _statueIma.frame = CGRectMake(size.width-37-30, 35, 30, 30);
    }
}
-(void)chakanfanganAction:(UIButton *)button{
    if(self.lookButtonAction){
        self.lookButtonAction(_teamNameLab1.text);
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