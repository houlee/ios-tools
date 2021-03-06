//
//  WinRecCell.m
//  caibo
//
//  Created by zhoujunwang on 16/1/5.
//
//

#import "WinRecCell.h"
#import "UUChart.h"
#import "LegMatchModel.h"

@interface WinRecCell ()<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
    NSInteger maxRange;
}

@property(nonatomic,strong)NSMutableArray *leagueHitArr;
@property(nonatomic,strong)NSMutableArray *leagueNameArr;
@property(nonatomic,strong)NSMutableArray *leagueTotalRateArr;
@property(nonatomic,strong)NSMutableArray *leagueHitRateArr;

@end

@implementation WinRecCell

- (void)setLeagueMatchArr:(NSArray *)leagueMatchArr{
    NSMutableArray *nameArr=[NSMutableArray arrayWithCapacity:[leagueMatchArr count]];
    NSMutableArray *hitRateArr=[NSMutableArray arrayWithCapacity:[leagueMatchArr count]];
    NSMutableArray *totalRecArr=[NSMutableArray arrayWithCapacity:[leagueMatchArr count]];
    for (NSDictionary *dic in leagueMatchArr) {
        LegMatchModel *leMthModel=[LegMatchModel legMatchModelWithDic:dic];
        [nameArr addObject:leMthModel.leagueName];
        [hitRateArr addObject:[NSString stringWithFormat:@"%.0f%%",[leMthModel.leagueHitRate floatValue]*100]];
        [totalRecArr addObject:leMthModel.leagueTotalRecommend];
    }
    _leagueNameArr=nameArr;
    _leagueHitRateArr=hitRateArr;
    
    NSInteger max=0;
    for (int i=0; i<[totalRecArr count]; i++) {
        NSInteger total=[[totalRecArr objectAtIndex:i] integerValue];
        if (max<total) {
            max=total;
        }
    }
    maxRange=50*(max/50+1);
    NSLog(@"%ld",(long)maxRange);
    
    NSMutableArray *totalRecTateArr=[NSMutableArray arrayWithCapacity:[leagueMatchArr count]];
    for (NSDictionary *dic in leagueMatchArr) {
        LegMatchModel *leMthModel=[LegMatchModel legMatchModelWithDic:dic];
        [totalRecTateArr addObject:leMthModel.leagueTotalRecommend];
    }
    _leagueTotalRateArr=totalRecTateArr;

    NSMutableArray *hitArr=[NSMutableArray arrayWithCapacity:[leagueMatchArr count]];
    for (NSDictionary *dic in leagueMatchArr) {
        LegMatchModel *leMthModel=[LegMatchModel legMatchModelWithDic:dic];
        [hitArr addObject:leMthModel.leagueHitNum];
    }
    _leagueHitArr=hitArr;
}

- (void)configUI:(NSIndexPath *)indexPath
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(15*MyWidth/320, 15, MyWidth-45*MyWidth/320, 155) withSource:self];
    chartView.layer.borderWidth=0.5;
    chartView.layer.borderColor=SEPARATORCOLOR.CGColor;
    chartView.layer.masksToBounds=YES;
    [chartView showInView:self.contentView];
    
    UIImageView *commendImgV=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(chartView.frame)+5*MyWidth/320, CGRectGetMinY(chartView.frame), 14, 14)];
    commendImgV.image=[UIImage imageNamed:@"推荐场次"];
    [self.contentView addSubview:commendImgV];
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(chartView.frame)+5*MyWidth/320, CGRectGetMaxY(commendImgV.frame), 14, 61)];
    lab.text=@"推荐场次";
    lab.numberOfLines=0;
    lab.lineBreakMode=NSLineBreakByWordWrapping;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.textColor=BLACK_SEVENTY;
    lab.font=FONTTWENTY_FOUR;
    [self.contentView addSubview:lab];
    
    UIImageView *hitImgV=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(chartView.frame)+5*MyWidth/320, CGRectGetMaxY(lab.frame)+6, 14, 14)];
    hitImgV.image=[UIImage imageNamed:@"命中场次"];
    [self.contentView addSubview:hitImgV];
    
    lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(chartView.frame)+5*MyWidth/320, CGRectGetMaxY(hitImgV.frame), 14, 61)];
    lab.text=@"命中场次";
    lab.numberOfLines=0;
    lab.lineBreakMode=NSLineBreakByWordWrapping;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.textColor=BLACK_SEVENTY;
    lab.font=FONTTWENTY_FOUR;
    [self.contentView addSubview:lab];
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"R-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return _leagueNameArr;
}

//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    return @[_leagueHitArr];
}

- (NSArray *)chartConfigRateValue:(UUChart *)chart
{
//    [_leagueTotalRateArr insertObject:@"0" atIndex:0];
    return @[_leagueTotalRateArr];
}

- (NSArray *)chartConfigHitValue:(UUChart *)chart
{
    return @[_leagueHitRateArr];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UIColor colorWithHexString:@"e16239"],[UIColor colorWithHexString:@"f7f3f0"]];
}

//显示数值范围
- (CGRange)chartRange:(UUChart *)chart
{
    return CGRangeMake(maxRange, 0);
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