//
//  ClassifyCell.m
//  caibo
//
//  Created by zhoujunwang on 16/1/11.
//
//

#import "ClassifyCell.h"

@interface ClassifyCell ()


@end

@implementation ClassifyCell

+(id)classifyCellWithTView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString * SMGDetailCellId=@"classifyCell";
    ClassifyCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[ClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SMGDetailCellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        cell.separatorInset=UIEdgeInsetsMake(0,0,0,0);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _txtLabel=[[UILabel alloc] initWithFrame:CGRectMake(36*MyWidth/320, 0, 100, 40)];
        _txtLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        _txtLabel.textColor=BLACK_EIGHTYSEVER;
        _txtLabel.font=FONTTWENTY_FOUR;
        [self addSubview:_txtLabel];
        
        _selectImgV=[[UIImageView alloc] initWithFrame:CGRectMake(15*MyWidth/320, 17, 9, 6)];
        _selectImgV.image=[UIImage imageNamed:@"排行榜对号"];
        _selectImgV.hidden=YES;
        [self addSubview:_selectImgV];
    }
    return self;
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