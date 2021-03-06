//
//  ExpertMatchListTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/22.
//
//

#import "ExpertMatchListTableViewCell.h"
#import "SharedMethod.h"

@implementation ExpertMatchListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        
        _matchLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 20)];
        _matchLab.backgroundColor = [UIColor clearColor];
        _matchLab.font = [UIFont systemFontOfSize:11];
        _matchLab.textColor = BLACK_SEVENTY;
        _matchLab.text = @"英超";
        _matchLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_matchLab];
        
        _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 25, 60, 35)];
        _dateLab.backgroundColor = [UIColor clearColor];
        _dateLab.font = [UIFont systemFontOfSize:11];
        _dateLab.textColor = BLACK_SEVENTY;
        _dateLab.numberOfLines = 2;
        _dateLab.text = @"11-10\n16:60";
        _dateLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dateLab];
        
        _teamLab = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 200, 20)];
        _teamLab.backgroundColor = [UIColor clearColor];
        _teamLab.font = [UIFont systemFontOfSize:13];
        _teamLab.textColor = BLACK_EIGHTYSEVER;
        _teamLab.text = @"曼联 VS 曼城";
        [self.contentView addSubview:_teamLab];
        
        _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recommendBtn.frame = CGRectMake(size.width-55, 10, 40, 17);
        _recommendBtn.backgroundColor = [UIColor clearColor];
        [_recommendBtn setTitle:@"推荐69" forState:UIControlStateNormal];
        _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_recommendBtn setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateNormal];
        [self.contentView addSubview:_recommendBtn];
        _recommendBtn.layer.borderColor = [[SharedMethod getColorByHexString:@"6e29bd"] CGColor];
        _recommendBtn.layer.borderWidth = 0.5f;
        _recommendBtn.layer.cornerRadius = 2;
        _recommendBtn.layer.masksToBounds = YES;
        
        UIImageView *kuangIma = [[UIImageView alloc]initWithFrame:CGRectMake(70, 30, 180, 20)];
        kuangIma.backgroundColor = [UIColor clearColor];
        kuangIma.layer.borderColor = [[SharedMethod getColorByHexString:@"6f6f6f"] CGColor];
        kuangIma.layer.borderWidth = 0.5f;
        [self.contentView addSubview:kuangIma];
        UIImageView *lineIma1 = [[UIImageView alloc]initWithFrame:CGRectMake(60, 0, 0.5, 20)];
        lineIma1.backgroundColor = [SharedMethod getColorByHexString:@"6f6f6f"];
        [kuangIma addSubview:lineIma1];
        UIImageView *lineIma2 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 0, 0.5, 20)];
        lineIma2.backgroundColor = [SharedMethod getColorByHexString:@"6f6f6f"];
        [kuangIma addSubview:lineIma2];
        
        _shengLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        _shengLab.backgroundColor = [UIColor clearColor];
        _shengLab.font = [UIFont systemFontOfSize:11];
        _shengLab.textColor = BLACK_EIGHTYSEVER;
        _shengLab.text = @"胜 2.25";
        _shengLab.textAlignment = NSTextAlignmentCenter;
        [kuangIma addSubview:_shengLab];
        _pingLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 60, 20)];
        _pingLab.backgroundColor = [UIColor clearColor];
        _pingLab.font = [UIFont systemFontOfSize:11];
        _pingLab.textColor = BLACK_EIGHTYSEVER;
        _pingLab.text = @"平 2.25";
        _pingLab.textAlignment = NSTextAlignmentCenter;
        [kuangIma addSubview:_pingLab];
        _fuLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 60, 20)];
        _fuLab.backgroundColor = [UIColor clearColor];
        _fuLab.font = [UIFont systemFontOfSize:11];
        _fuLab.textColor = BLACK_EIGHTYSEVER;
        _fuLab.text = @"负 2.25";
        _fuLab.textAlignment = NSTextAlignmentCenter;
        [kuangIma addSubview:_fuLab];
        
        
        
        
        
        
        
        UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(15, 64.5, size.width-30, 0.5)];
        lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:lineIma];
    }
    return self;
}
-(void)loadAppointInfo:(MatchVCModel *)matchModel
{
    //联赛名称
    self.matchLab.text = matchModel.leagueNameSimply;
    
    //时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式
    NSDate *date=[dateFormatter dateFromString:matchModel.matchTime];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
    
    NSString * compTime=[NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:date]];
    compTime = [compTime stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    self.dateLab.text=compTime;
    
    self.teamLab.text = [NSString stringWithFormat:@"%@  VS  %@",matchModel.hostNameSimply,matchModel.guestNameSimply];
    [_recommendBtn setTitle:[NSString stringWithFormat:@"推荐%@",matchModel.planCount] forState:UIControlStateNormal];
    NSArray *spAry = [matchModel.spfSp componentsSeparatedByString:@" "];
    if(spAry.count == 3){
        self.shengLab.text = [NSString stringWithFormat:@"胜 %@",[spAry objectAtIndex:0]];
        self.pingLab.text = [NSString stringWithFormat:@"平 %@",[spAry objectAtIndex:1]];
        self.fuLab.text = [NSString stringWithFormat:@"负 %@",[spAry objectAtIndex:2]];
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