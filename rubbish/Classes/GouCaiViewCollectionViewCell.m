//
//  GouCaiViewCollectionViewCell.m
//  caibo
//
//  Created by GongHe on 2016/10/10.
//
//

#import "GouCaiViewCollectionViewCell.h"

#define GouCaiViewCollectionViewCell_height 75

@implementation GouCaiViewCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(7, 0, MyWidth/2.0 - 7, GouCaiViewCollectionViewCell_height)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (GouCaiViewCollectionViewCell_height - 42)/2.0, 42, 42)];
        [_bgView addSubview:_iconImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(_iconImageView) + 10, 22, _bgView.frame.size.width - (ORIGIN_X(_iconImageView) + 10), 15)];
        _nameLabel.textColor = DEFAULT_TEXTBLACKCOLOR;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:_nameLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, ORIGIN_Y(_nameLabel) + 5, _nameLabel.frame.size.width, 11)];
        _contentLabel.textColor = DEFAULT_TEXTGRAYCOLOR;
        _contentLabel.font = [UIFont systemFontOfSize:11];
        _contentLabel.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:_contentLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, GouCaiViewCollectionViewCell_height - 0.5, _bgView.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
        [_bgView addSubview:lineView];
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    