//
//  DuiHuanYHMCell.m
//  caibo
//
//  Created by cp365dev on 15/1/14.
//
//

#import "DuiHuanYHMCell.h"
#import "SharedMethod.h"
@implementation DuiHuanYHMCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
    
        UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 290, 68)];
        bgImg.backgroundColor = [UIColor clearColor];
        bgImg.image = UIImageGetImageFromName(@"point_usable.png");
        [self.contentView addSubview:bgImg];
        [bgImg release];
        
        UILabel *youhuimaLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 24, 36, 12)];
        youhuimaLabel.text = @"优惠码";
        youhuimaLabel.textColor = [UIColor whiteColor];
        youhuimaLabel.font = [UIFont systemFontOfSize:12];
        youhuimaLabel.backgroundColor = [UIColor clearColor];
        [bgImg addSubview:youhuimaLabel];
        [youhuimaLabel release];
        
        
        youhuimaLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(53, 16, 110, 20)];
        youhuimaLabel1.text = @"充100得102";
        youhuimaLabel1.backgroundColor = [UIColor clearColor];
        youhuimaLabel1.textColor = [UIColor whiteColor];
        youhuimaLabel1.font = [UIFont boldSystemFontOfSize:20];
        [bgImg addSubview:youhuimaLabel1];
        [youhuimaLabel1 release];
        
        
        needpoints = [[UILabel alloc] initWithFrame:CGRectMake(12, 48, 80, 12)];
        needpoints.text = @"所需积分 1000";
        needpoints.textColor = [SharedMethod getColorByHexString:@"ffeec5"];
        needpoints.font = [UIFont systemFontOfSize:12];
        needpoints.backgroundColor = [UIColor clearColor];
        [bgImg addSubview:needpoints];
        [needpoints release];
        
        people = [[UILabel alloc] initWithFrame:CGRectMake(107, 48, 30, 12)];
        people.text = @"1234";
        people.backgroundColor = [UIColor clearColor];
        people.font = [UIFont systemFontOfSize:12];
        people.textColor = [SharedMethod getColorByHexString:@"ffe71d"];
        [bgImg addSubview:people];
        [people release];
        
        people1 = [[UILabel alloc] initWithFrame:CGRectMake(137, 48, 50, 12)];
        people1.text = @"人已兑换";
        people1.backgroundColor = [UIColor clearColor];
        people1.font = [UIFont systemFontOfSize:12];
        people1.textColor = [SharedMethod getColorByHexString:@"ffeec5"];
        [bgImg addSubview:people1];
        [people1 release];
        
        UIImageView *xianimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89, 320, 1)];
        xianimage.backgroundColor = [SharedMethod getColorByHexString:@"cccccc"];
        [self.contentView addSubview:xianimage];
        [xianimage release];
        
        
    }
    
    return self;
}

-(void)LoadData:(NSString *)_chong getM:(NSString *)_de points:(NSString *)_jifen people:(NSString *)_ren{

    youhuimaLabel1.text = [NSString stringWithFormat:@"充%@得%@",_chong,_de];
    CGSize chongSize = CGSizeMake(320, 20);
    CGSize chongSize1 = [youhuimaLabel1.text sizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:chongSize lineBreakMode:NSLineBreakByCharWrapping];
    youhuimaLabel1.frame = CGRectMake(53, 16, chongSize1.width, 20);
   
    needpoints.text = [NSString stringWithFormat:@"所需积分 %@",_jifen];
    CGSize jifenSize = CGSizeMake(320, 12);
    CGSize jifenSize1 = [needpoints.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:jifenSize lineBreakMode:NSLineBreakByCharWrapping];
    needpoints.frame = CGRectMake(12, 48, jifenSize1.width, 12);
    
    people.text = _ren;
    CGSize peopleSize = CGSizeMake(320, 12);
    CGSize peopleSize1 = [people.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:peopleSize lineBreakMode:NSLineBreakByCharWrapping];
    people.frame = CGRectMake(needpoints.frame.origin.x+needpoints.frame.size.width+15, 48, peopleSize1.width, 12);
    people1.frame = CGRectMake(people.frame.origin.x+people.frame.size.width, 48, 50, 12);
    
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    