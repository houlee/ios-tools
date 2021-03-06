//
//  Point_YouHuiMaCell.m
//  caibo
//
//  Created by cp365dev on 15/1/6.
//
//

#import "Point_YouHuiMaCell.h"
#import "SharedMethod.h"
@implementation Point_YouHuiMaCell
@synthesize youhuimaType;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
    
        bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 290, 68)];
        bgImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bgImg];
        [bgImg release];
        
        
        UILabel *youhuimaLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 26, 36, 12)];
        youhuimaLabel.text = @"优惠码";
        youhuimaLabel.textColor = [UIColor whiteColor];
        youhuimaLabel.font = [UIFont systemFontOfSize:12];
        youhuimaLabel.backgroundColor = [UIColor clearColor];
        [bgImg addSubview:youhuimaLabel];
        [youhuimaLabel release];
        
        youhuimaLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(54, 18, 150, 20)];
        youhuimaLabel1.backgroundColor = [UIColor clearColor];
        youhuimaLabel1.textColor = [UIColor whiteColor];
        youhuimaLabel1.font = [UIFont systemFontOfSize:20];
        [bgImg addSubview:youhuimaLabel1];
        [youhuimaLabel1 release];
        
        youxiaoqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 54, 190, 10)];
        youxiaoqiLabel.backgroundColor = [UIColor clearColor];
        youxiaoqiLabel.font = [UIFont systemFontOfSize:10];
        [bgImg addSubview:youxiaoqiLabel];
        [youxiaoqiLabel release];
        
    }
    
    return self;
}
- (void)LoadData:(NSString *)_cellType WithMes:(NSString *)_mes andTime:(NSString *)_time{

    if([@"0" isEqualToString:_cellType]){
        
        bgImg.image = UIImageGetImageFromName(@"mypoint_useable.png");
    }
    else if([@"1" isEqualToString:_cellType]){
        
        bgImg.image = UIImageGetImageFromName(@"mypoint_expire.png");
        
    }
    else if ([@"2" isEqualToString:_cellType]){
        
        bgImg.image = UIImageGetImageFromName(@"mypoint_used.png");
    }
    
    youhuimaLabel1.text = [NSString stringWithFormat:@"%@",_mes];
    
    youxiaoqiLabel.text = [NSString stringWithFormat:@"%@(有效期)",_time];
    
    if([@"0" isEqualToString:_cellType]){
        youxiaoqiLabel.textColor = [SharedMethod getColorByHexString:@"fddfbb"];
    }
    else{
        
        youxiaoqiLabel.textColor = [SharedMethod getColorByHexString:@"d4d4d4"];
    }
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    