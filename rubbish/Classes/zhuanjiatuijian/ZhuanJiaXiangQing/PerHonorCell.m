//
//  PerHonorCell.m
//  caibo
//
//  Created by zhoujunwang on 16/1/4.
//
//

#import "PerHonorCell.h"
#import "SepratorLineView.h"

@implementation NSString(perhonor)

+ (NSString *)setDataNo:(NSString *)str{
    if ([str isEqualToString:@"0"]||[str intValue]>50) {
        str=@"--";
    }
    return str;
}

@end

@interface PerHonorCell()

@property(nonatomic,strong) UILabel *hitWeekLab;
@property(nonatomic,strong) UILabel *hitMthLab;
@property(nonatomic,strong) UILabel *rtnWeekLab;
@property(nonatomic,strong) UILabel *rtnMthLab;
@property(nonatomic,strong) UILabel *pplWeekLab;
@property(nonatomic,strong) UILabel *pplMthLab;

@end

@implementation PerHonorCell

+(id)perhonorCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * SMGDetailCellId=@"perHonorCell";
    PerHonorCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[PerHonorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SMGDetailCellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGSize labSize=[PublicMethod setNameFontSize:@"命中率排行" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        CGSize listSize=[PublicMethod setNameFontSize:@"周榜：" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];

        for (int i=0; i<4; i++) {
            SepratorLineView *line=[[SepratorLineView alloc] initWithFrame:CGRectMake(18,15+29.5*i,MyWidth-33,0.5)];
            [self addSubview:line];
        }
        
        for (int i=0; i<3; i++) {
            CGFloat width=15+MyWidth/320*87;
            if (i==1) {
                width=15+MyWidth/320*189;
            }else if(i==2){
                width=MyWidth-15.5;
            }
            NSString *imgName=@"命中率";
            NSString *labStr=@"命中率排行";
            if (i==1) {
                imgName=@"回报率";
                labStr=@"回报率排行";
            }else if (i==2) {
                imgName=@"人气度";
                labStr=@"人气度排行";
            }
            UIImageView *imgRank=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15+30*i, 3, 30)];
            imgRank.image=[UIImage imageNamed:imgName];
            [self addSubview:imgRank];
            
            UILabel *rateLab=[[UILabel alloc] initWithFrame:CGRectMake(57-labSize.width/2, 30-labSize.height/2+29.5*i, labSize.width, labSize.height)];
            rateLab.text=labStr;
            rateLab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
            rateLab.textColor=BLACK_SEVENTY;
            rateLab.font=FONTTWENTY_FOUR;
            [self addSubview:rateLab];
            
            UILabel *weekList=[[UILabel alloc] initWithFrame:CGRectMake(15+MyWidth/320*138-listSize.width/2, 30-listSize.height/2+29.5*i, listSize.width, listSize.height)];
            weekList.text=@"周榜：";
            weekList.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
            weekList.textColor=BLACK_SEVENTY;
            weekList.font=FONTTWENTY_FOUR;
            [self addSubview:weekList];
            
            UILabel *acwLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weekList.frame), 30-listSize.height/2+29.5*i, listSize.width, listSize.height)];
            acwLab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
            acwLab.textColor=[UIColor colorWithRed:255.0/255 green:59.0/255 blue:48.0/255 alpha:0.87];
            acwLab.font=FONTTWENTY_FOUR;
            [self addSubview:acwLab];
            
            UILabel *mouList=[[UILabel alloc] initWithFrame:CGRectMake(15+MyWidth/4*3-listSize.width/2, 30-listSize.height/2+29.5*i, listSize.width, listSize.height)];
            mouList.text=@"月榜：";
            mouList.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
            mouList.textColor=BLACK_SEVENTY;
            mouList.font=FONTTWENTY_FOUR;
            [self addSubview:mouList];
            
            UILabel *acmLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(mouList.frame), 30-listSize.height/2+29.5*i, listSize.width, listSize.height)];
            acmLab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
            acmLab.textColor=[UIColor colorWithRed:255.0/255 green:59.0/255 blue:48.0/255 alpha:0.87];
            acmLab.font=FONTTWENTY_FOUR;
            [self addSubview:acmLab];
            
            if (i==0) {
                _hitWeekLab=acwLab;
                _hitMthLab=acmLab;
            }else if(i==1){
                _rtnWeekLab=acwLab;
                _rtnMthLab=acmLab;
            }else if(i==2){
                _pplWeekLab=acwLab;
                _pplMthLab=acmLab;
            }
            
            for (int j=0; j<3; j++) {
                UIView *verLine=[[SepratorLineView alloc] initWithFrame:CGRectMake(width, 15.5+29.5*j, 0.5, 29)];
                [self addSubview:verLine];
            }
        }
    }
    return self;
}

- (void)hitRateWeek:(NSString *)hitRateWeek hitRateMouth:(NSString *)hitRateMouth returnRankWeek:(NSString *)returnRankWeek returnRankMouth:(NSString *)returnRankMouth popularRankWeek:(NSString *)popularRankWeek popularRankMouth:(NSString *)popularRankMouth{
    _hitWeekLab.text=[NSString setDataNo:hitRateWeek];
    _hitMthLab.text=[NSString setDataNo:hitRateMouth];
    _rtnWeekLab.text=[NSString setDataNo:returnRankWeek];
    _rtnMthLab.text=[NSString setDataNo:returnRankMouth];
    _pplWeekLab.text=[NSString setDataNo:popularRankWeek];
    _pplMthLab.text=[NSString setDataNo:popularRankMouth];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
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