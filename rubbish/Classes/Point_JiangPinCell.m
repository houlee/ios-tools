//
//  Point_JiangPinCell.m
//  caibo
//
//  Created by cp365dev on 15/1/6.
//
//

#import "Point_JiangPinCell.h"
#import "ColorView.h"
#import "SharedMethod.h"
@implementation Point_JiangPinCell
@synthesize jiangpinMethod;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
    
        bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 70, 41)];
        bgImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bgImage];
        [bgImage release];
        
        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.textColor = [UIColor whiteColor];
        [bgImage addSubview:numLabel];
        [numLabel release];
        
        
        unitLabel = [[UILabel alloc] init];
        unitLabel.font = [UIFont systemFontOfSize:12];
        unitLabel.frame = CGRectMake(numLabel.frame.origin.x+numLabel.frame.size.width, 0,53-numLabel.frame.origin.x-numLabel.frame.size.width, 40);
        unitLabel.hidden = YES;
        unitLabel.backgroundColor = [UIColor clearColor];
        unitLabel.textColor = [UIColor whiteColor];
        [bgImage addSubview:unitLabel];
        [unitLabel release];
        
        
        kindsLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, 5, 8, 30)];
        kindsLabel.backgroundColor = [UIColor clearColor];
        kindsLabel.font = [UIFont systemFontOfSize:8];
        kindsLabel.lineBreakMode = NSLineBreakByCharWrapping;
        kindsLabel.numberOfLines = 0;
        kindsLabel.hidden = YES;
        kindsLabel.textColor = [UIColor whiteColor];
        [bgImage addSubview:kindsLabel];
        [kindsLabel release];
        
        UILabel *huodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 17.5, 50, 12)];
        huodeLabel.text = @"获得类型";
        huodeLabel.backgroundColor = [UIColor clearColor];
        huodeLabel.textColor = [SharedMethod getColorByHexString:@"7c7c7c"];
        huodeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:huodeLabel];
        [huodeLabel release];
        
        methodLabel = [[UILabel alloc] initWithFrame:CGRectMake(147, 14.5, 50, 15)];
        methodLabel.backgroundColor = [UIColor clearColor];
        methodLabel.textColor = [SharedMethod getColorByHexString:@"454545"];
        methodLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:methodLabel];
        [methodLabel release];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 120, 12)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
        timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:timeLabel];
        [timeLabel release];
        
        
        cp365Label = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 50, 7)];
        cp365Label.backgroundColor = [UIColor clearColor];
        cp365Label.text = @"投注站";
        cp365Label.hidden = YES;
        cp365Label.textColor = [UIColor whiteColor];
        cp365Label.font = [UIFont systemFontOfSize:7];
        [bgImage addSubview:cp365Label];
        [cp365Label release];
    
    }
    
    
    return self;
}
- (void)LoadData:(NSString *)getType prizeType:(NSString *)prizeType numString:(NSString *)num unitString:(NSString *)unit andKindsName:(NSString *)_name andTime:(NSString *)_time{
    
    
    numLabel.text = num;
    numLabel.font = [UIFont systemFontOfSize:18];
    
    if(unit && unit.length && ![unit isEqualToString:@"null"]){
        
        unitLabel.text = unit;
        
    }
    
    CGSize size = CGSizeMake(50, 40);
    CGSize size1 = [numLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    CGSize size2 = [unitLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    numLabel.frame = CGRectMake(1.5+(50-size1.width-size2.width)/2.0, 0, size1.width, 40);
    
    unitLabel.frame = CGRectMake(numLabel.frame.origin.x+numLabel.frame.size.width, 0,53-numLabel.frame.origin.x-numLabel.frame.size.width, 40);
    

    
    if([getType isEqualToString:@"兑换"] && [prizeType isEqualToString:@"1"]){
        
        bgImage.image = UIImageGetImageFromName(@"point_duihuan.png");
    }
    else if([getType isEqualToString:@"抽奖"]  && [prizeType isEqualToString:@"1"]){
        
        bgImage.image = UIImageGetImageFromName(@"point_jiang.png");
        
    }
    else if([getType isEqualToString:@"抽奖"]  && [prizeType isEqualToString:@"2"]){
        
        bgImage.image = UIImageGetImageFromName(@"point_shiwu.png");
        
    }
    
    timeLabel.text = _time;
    
    methodLabel.text = getType;

    
    if([prizeType isEqualToString:@"1"]){
    
        cp365Label.hidden = YES;
        kindsLabel.hidden = NO;
        unitLabel.hidden = NO;

        kindsLabel.text = _name;
        

    }
    else if([prizeType isEqualToString:@"2"]){
    
        cp365Label.hidden = NO;
        kindsLabel.hidden = YES;
        unitLabel.hidden = YES;

        numLabel.text = _name;
        numLabel.font = [UIFont systemFontOfSize:10];
        numLabel.frame = CGRectMake(6, 15, 60, 10);
    }
    
    
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    