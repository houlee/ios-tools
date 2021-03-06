//
//  DuiHuanCJBCell.m
//  caibo
//
//  Created by cp365dev on 15/1/14.
//
//

#import "DuiHuanCJBCell.h"
#import "SharedMethod.h"
@implementation DuiHuanCJBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
    
        UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 290, 68)];
        bgImg.backgroundColor = [UIColor clearColor];
        bgImg.image = UIImageGetImageFromName(@"point_usable_red.png");
        [self.contentView addSubview:bgImg];
        [bgImg release];
        
        
        UIImageView *caijin = [[UIImageView alloc] initWithFrame:CGRectMake(12, 14, 40, 20)];
        caijin.backgroundColor = [UIColor clearColor];
        caijin.image = UIImageGetImageFromName(@"point_caijin.png");
        [bgImg addSubview:caijin];
        [caijin release];

        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(63, 10, 25, 25)];
        moneyLabel.font = [UIFont boldSystemFontOfSize:22];
        moneyLabel.textColor = [UIColor colorWithRed:243/255.0 green:221/255.0 blue:101/255.0 alpha:1];
        moneyLabel.backgroundColor = [UIColor clearColor];
        [bgImg addSubview:moneyLabel];
        [moneyLabel release];
        
        
        yuanImage = [[UIImageView alloc] initWithFrame:CGRectMake(91, 14, 20, 20)];
        yuanImage.image = UIImageGetImageFromName(@"point_yuan.png");
        yuanImage.backgroundColor = [UIColor clearColor];
        [bgImg addSubview:yuanImage];
        [yuanImage release];
        
        needPoints = [[UILabel alloc] initWithFrame:CGRectMake(12, 46, 80, 12)];
        needPoints.backgroundColor = [UIColor clearColor];
        needPoints.textColor = [UIColor whiteColor];
        needPoints.font = [UIFont systemFontOfSize:12];
        [bgImg addSubview:needPoints];
        [needPoints release];
        
        people = [[UILabel alloc] initWithFrame:CGRectMake(107, 46, 25, 12)];
        people.backgroundColor = [UIColor clearColor];
        people.textColor = [SharedMethod getColorByHexString:@"ffe71d"];
        people.font = [UIFont systemFontOfSize:12];
        [bgImg addSubview:people];
        [people release];
        
        yiduihuan = [[UILabel alloc] initWithFrame:CGRectMake(132, 46, 50, 12)];
        yiduihuan.text = @"人已兑换";
        yiduihuan.backgroundColor = [UIColor clearColor];
        yiduihuan.textColor = [UIColor whiteColor];
        yiduihuan.font = [UIFont systemFontOfSize:12];
        [bgImg addSubview:yiduihuan];
        [yiduihuan release];
        
        UIImageView *xianimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89, 320, 1)];
        xianimage.backgroundColor = [SharedMethod getColorByHexString:@"cccccc"];
        [self.contentView addSubview:xianimage];
        [xianimage release];
        
    }
    return self;
}
-(void)LoadData:(NSString *)_money points:(NSString *)_jifen people:(NSString *)_ren{

    moneyLabel.text = _money;
    CGSize moneySize = CGSizeMake(320, 25);
    CGSize moneySize1 = [moneyLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:25] constrainedToSize:moneySize lineBreakMode:NSLineBreakByCharWrapping];
    moneyLabel.frame = CGRectMake(63, 10, moneySize1.width, 25);
    
    yuanImage.frame = CGRectMake(moneyLabel.frame.origin.x+moneyLabel.frame.size.width+8, 14, 20, 20);
    
    needPoints.text = [NSString stringWithFormat:@"所需积分 %@",_jifen];
    
    CGSize needpointSize = CGSizeMake(320, 12);
    CGSize needpointSize1 = [needPoints.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:needpointSize lineBreakMode:NSLineBreakByCharWrapping];
    needPoints.frame = CGRectMake(12, 46, needpointSize1.width, 12);
    
    
    people.text = _ren;
    CGSize peopleSize = CGSizeMake(320, 12);
    CGSize peopleSize1 = [people.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:peopleSize lineBreakMode:NSLineBreakByCharWrapping];
    
    people.frame =CGRectMake(needPoints.frame.origin.x+needPoints.frame.size.width+15, 46, peopleSize1.width, 12);
    
    yiduihuan.frame = CGRectMake(people.frame.origin.x+people.frame.size.width, 46, 50, 12);
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    