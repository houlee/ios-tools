//
//  ExpertHomeCollectionViewCell.m
//  caibo
//
//  Created by GongHe on 16/8/11.
//
//

#import "ExpertHomeCollectionViewCell.h"

@implementation ExpertHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MyWidth/2.0 - 10 - 40, (55 - 40)/2.0, 40, 40)];
        [self.contentView addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, MyWidth/2.0 - _iconImageView.frame.size.width - 20, 12)];
        _titleLabel.textColor = DEFAULT_TEXTBLACKCOLOR;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(_titleLabel) + 5, 0, 14)];
        _moneyLabel.font = [UIFont systemFontOfSize:8];
        _moneyLabel.layer.borderWidth = 0.5;
        _moneyLabel.layer.masksToBounds = YES;
        _moneyLabel.layer.cornerRadius = 5;
        _moneyLabel.textAlignment = 1;
        [self.contentView addSubview:_moneyLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(MyWidth/2.0 - 0.5, 0, 0.5, 55)];
        _lineView.backgroundColor = DEFAULT_LINECOLOR;
        [self.contentView addSubview:_lineView];
        
        UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 55 - 0.5, MyWidth/2.0, 0.5)];
        lineView1.backgroundColor = DEFAULT_LINECOLOR;
        [self.contentView addSubview:lineView1];
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    