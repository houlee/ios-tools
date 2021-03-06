//
//  ExpertRaceListTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/12/8.
//
//

#import "ExpertRaceListTableViewCell.h"
#import "SharedMethod.h"

@implementation ExpertRaceListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        
        _raceTimeLab = [[UILabel alloc]init];
        _raceTimeLab.frame = CGRectMake(15, 5, size.width-30, 20);
        _raceTimeLab.backgroundColor = [UIColor clearColor];
        _raceTimeLab.font = [UIFont systemFontOfSize:12];
        _raceTimeLab.textColor = BLACK_SEVENTY;
        [self.contentView addSubview:_raceTimeLab];
        
        _recommendLab = [[UILabel alloc]init];
        _recommendLab.frame = CGRectMake(size.width-215, 15, 200, 25);
        _recommendLab.backgroundColor = [UIColor clearColor];
        _recommendLab.textAlignment = NSTextAlignmentRight;
        _recommendLab.font = [UIFont systemFontOfSize:12];
        _recommendLab.textColor = [SharedMethod getColorByHexString:@"ff2f1d"];
        [self.contentView addSubview:_recommendLab];
        
        _VSimage = [[UIImageView alloc]init];
        _VSimage.frame = CGRectMake(88, 30, 15, 15);
        _VSimage.backgroundColor = [UIColor clearColor];
        _VSimage.image = [UIImage imageNamed:@"expertVS.png"];
        [self.contentView addSubview:_VSimage];
        
        _homeTeamLab = [[UILabel alloc]init];
        _homeTeamLab.frame = CGRectMake(15, 25, 68, 25);
        _homeTeamLab.backgroundColor = [UIColor clearColor];
        _homeTeamLab.font = [UIFont systemFontOfSize:12];
        _homeTeamLab.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_homeTeamLab];
        
        _visitineTeamLab = [[UILabel alloc]init];
        _visitineTeamLab.frame = CGRectMake(120, 25, size.width-120, 25);
        _visitineTeamLab.backgroundColor = [UIColor clearColor];
        _visitineTeamLab.font = [UIFont systemFontOfSize:12];
        _visitineTeamLab.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_visitineTeamLab];
        
        UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(15, 54.5, size.width-30, 0.5)];
        lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:lineIma];
    }
    return self;
}
-(void)loadAppointInfo:(MatchVCModel *)matchModel{
    
    //时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if(matchModel.matchTime.length == 19){
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式
    }else if (matchModel.matchTime.length == 16){
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];//设定时间格式
    }
    NSDate *date=[dateFormatter dateFromString:matchModel.matchTime];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
    
    NSString * compTime=[NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:date]];
    
    _raceTimeLab.text = [NSString stringWithFormat:@"%@  %@  %@",matchModel.leagueNameSimply,matchModel.ccId,compTime];
    _homeTeamLab.text = matchModel.hostNameSimply;
    _visitineTeamLab.text = matchModel.guestNameSimply;
    
    if([matchModel.source isEqualToString:@"4"]){//篮球
        _homeTeamLab.text = [NSString stringWithFormat:@"%@(客)",matchModel.guestNameSimply];
        _visitineTeamLab.text = [NSString stringWithFormat:@"%@(主)",matchModel.hostNameSimply];
    }
    
    _recommendLab.text = [NSString stringWithFormat:@"%@条推荐",matchModel.planCount];
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