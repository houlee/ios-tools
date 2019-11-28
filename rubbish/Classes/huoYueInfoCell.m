//
//  huoYueInfoCell.m
//  caibo
//
//  Created by houchenguang on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "huoYueInfoCell.h"

@implementation huoYueInfoCell

- (void)setInfodata:(houYueInfoDataResult *)_infodata{
    if (infodata != _infodata) {
        [infodata release];
        infodata = [_infodata retain];
    }
    NSArray * dataarr = [_infodata.jiaoyitime componentsSeparatedByString:@" "];
    if ([dataarr count] > 0) {
         datela.text = [dataarr objectAtIndex:0];
    }else{
        datela.text = @"";
    }
    if ([dataarr count] > 1) {
        timela.text = [dataarr objectAtIndex:1];
    }else{
        timela.text = @"";
    }
   
    
    userla.text = _infodata.username;
    operatela.text = _infodata.jiaoyitype;
    moneyla.text = _infodata.shejimoney;
    
}

- (houYueInfoDataResult *)infodata{
    return infodata;
}

- (UIView *)tableViewCellReturn{
    UIView * retView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 15)] autorelease];
    retView.backgroundColor = [UIColor clearColor];
    UIImageView * baviewimage = [[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, 290, 15)];
    baviewimage.backgroundColor = [UIColor clearColor];
   // baviewimage.image = [UIImageGetImageFromName(@"huoyuecell.png") stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    [retView addSubview:baviewimage];
    [baviewimage release];
    
    gangla = [[UILabel alloc] initWithFrame:CGRectMake(-2, 0, 6, 15)];
    gangla.backgroundColor = [UIColor clearColor];
    gangla.textAlignment = NSTextAlignmentRight;
    gangla.font = [UIFont systemFontOfSize:10];
    gangla.textColor = [UIColor whiteColor];
    gangla.text = @"-";
    
    datela = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 55, 15)];
    datela.backgroundColor = [UIColor clearColor];
    datela.textAlignment = NSTextAlignmentRight;
    datela.font = [UIFont systemFontOfSize:10];
    datela.textColor = [UIColor whiteColor];
 //   datela.text = @"2012-07-23";
    
    timela = [[UILabel alloc] initWithFrame:CGRectMake(59, 0, 35, 15)];
    timela.backgroundColor = [UIColor clearColor];
    timela.textAlignment = NSTextAlignmentRight;
    timela.font = [UIFont systemFontOfSize:10];
    timela.textColor = [UIColor whiteColor];
  //  timela.text = @"16:32";
    
    userla = [[UILabel alloc] initWithFrame:CGRectMake(94, 0, 50, 15)];
    userla.backgroundColor = [UIColor clearColor];
    userla.textAlignment = NSTextAlignmentRight;
    userla.font = [UIFont systemFontOfSize:10];
    userla.textColor = [UIColor whiteColor];
   // userla.text = @"lldixns";
    
    
    operatela = [[UILabel alloc] initWithFrame:CGRectMake(144, 0, 73, 15)];
    operatela.backgroundColor = [UIColor clearColor];
    operatela.textAlignment = NSTextAlignmentRight;
    operatela.font = [UIFont systemFontOfSize:10];
    operatela.textColor = [UIColor whiteColor];
   // operatela.text = @"*中奖*";
    
    
    moneyla = [[UILabel alloc] initWithFrame:CGRectMake(217, 0, 70, 15)];
    moneyla.backgroundColor = [UIColor clearColor];
    moneyla.textAlignment = NSTextAlignmentRight;
    moneyla.font = [UIFont systemFontOfSize:10];
    moneyla.textColor = [UIColor whiteColor];
   // moneyla.text = @"50000000000000元";
    
    [retView addSubview:gangla];
    [retView addSubview:datela];
    [retView addSubview:timela];
    [retView addSubview:userla];
    [retView addSubview:operatela];
    [retView addSubview:moneyla];
    
    return retView;
}

- (void)dealloc{
    [infodata release];
    [gangla release];
    [datela release];
    [timela release];
    [operatela release];
    [userla release];
    [moneyla release];
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
        [self.contentView addSubview:[self tableViewCellReturn]];
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