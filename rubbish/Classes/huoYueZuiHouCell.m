//
//  huoYueZuiHouCell.m
//  caibo
//
//  Created by houchenguang on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "huoYueZuiHouCell.h"

@implementation huoYueZuiHouCell

//- (void)zaihengxuanzhuan{
//    ganglable.text = @"--";
//    [self performSelector:@selector(gangxuanzhuan) withObject:nil afterDelay:0.8];
//}
//
//- (void)zaixiexuanzhuan{
//    ganglable.text = @"/";
//    [self performSelector:@selector(zaihengxuanzhuan) withObject:nil afterDelay:0.8];
//}
//
//
//- (void)zaishuxuanzhuan{
//    ganglable.text = @"|";
//    [self performSelector:@selector(zaixiexuanzhuan) withObject:nil afterDelay:0.8];
//}

- (void)waixuanzhuan{
    ganglable.text = @"\\";
    [self performSelector:@selector(gangxuanzhuan) withObject:nil afterDelay:0.3];
}




- (void)hengxuanzhuan{
    ganglable.text = @"--";
    [self performSelector:@selector(waixuanzhuan) withObject:nil afterDelay:0.3];
}

- (void)xiexuanzhuan{
    ganglable.text = @"/";
    [self performSelector:@selector(hengxuanzhuan) withObject:nil afterDelay:0.3];
}

- (void)gangxuanzhuan{
    ganglable.text = @"|";
    [self performSelector:@selector(xiexuanzhuan) withObject:nil afterDelay:0.3];
}


- (UIView *)returnTableViewCell{
    UIView * retview = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 15)] autorelease];
    retview.backgroundColor = [UIColor clearColor];
    
    UILabel * jiaolable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    jiaolable.backgroundColor = [UIColor clearColor ];
    jiaolable.textColor = [UIColor greenColor];
    jiaolable.font = [UIFont systemFontOfSize:11];
    jiaolable.textAlignment = NSTextAlignmentLeft;
    jiaolable.text = @">";
    
    ganglable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 15, 15)];
    ganglable.backgroundColor = [UIColor clearColor];
    ganglable.textAlignment = NSTextAlignmentLeft;
    ganglable.textColor = [UIColor whiteColor];
    ganglable.font = [UIFont systemFontOfSize:11];
    ganglable.text = @"\\";
    
    [retview addSubview:jiaolable];
    [jiaolable release];
    [retview addSubview:ganglable];
    [self performSelector:@selector(gangxuanzhuan) withObject:nil afterDelay:0.3];
    
    return retview;
}

- (void)dealloc{
    [ganglable release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:[self returnTableViewCell]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    