//
//  ExpertCollectionViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/21.
//
//

#import "ExpertCollectionViewCell.h"

@implementation ExpertCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headIma = [[UIImageView alloc]init];
        _headIma.frame = CGRectMake(15, 10, 40, 40);
        _headIma.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headIma];
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.frame = CGRectMake(0, 50, 70, 20);
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.text = @"高洪波";
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:11];
        _nameLab.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_nameLab];
        
        _desLab = [[UILabel alloc]init];
        _desLab.frame = CGRectMake(0, 65, 70, 20);
        _desLab.backgroundColor = [UIColor clearColor];
        _desLab.text = @"近3中3";
        _desLab.textAlignment = NSTextAlignmentCenter;
        _desLab.font = [UIFont systemFontOfSize:11];
        _desLab.textColor = BLACK_SEVENTY;
        [self.contentView addSubview:_desLab];
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    