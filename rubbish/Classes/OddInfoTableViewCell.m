//
//  OddInfoTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-5-23.
//
//

#import "OddInfoTableViewCell.h"

@implementation OddInfoTableViewCell
@synthesize oddIndexPath;
@synthesize oddsInteger;

- (void)dealloc{
    [oddsDictionary release];
    [oddIndexPath release];
    [super dealloc];
}

- (void)setOddsDictionary:(NSDictionary *)_oddsDictionary{
    
    if (oddsDictionary != _oddsDictionary) {
        [oddsDictionary release];
        oddsDictionary = [_oddsDictionary retain];
    }
    
    NSArray * dataArray = [oddsDictionary objectForKey:@"change"];
    NSDictionary * dict = [dataArray objectAtIndex:oddIndexPath.row];
    NSArray * timearr = [[dict objectForKey:@"change_date"] componentsSeparatedByString:@" "];
     chupanLabel.text = @"";
    if ([timearr count]>=2) {
        NSArray * dateArray = [[timearr objectAtIndex:0] componentsSeparatedByString:@"-"];
        NSArray * timeArray = [[timearr objectAtIndex:1] componentsSeparatedByString:@":"];
        
        if ([dateArray count] >= 3 && [timeArray count] >= 3) {
            chupanLabel.text = [NSString stringWithFormat:@"%@-%@ %@:%@", [dateArray objectAtIndex:1], [dateArray objectAtIndex:2], [timeArray objectAtIndex:0], [timeArray objectAtIndex:1]];
        }
    }
    
    
   
    oneShengLable.text = [dict objectForKey:@"win"];
    onePingLable.text = [dict objectForKey:@"same"];
    oneFuLable.text = [dict objectForKey:@"lost"];
    
//    oneShengLable.text = [dict objectForKey:@"firstwin"];
//    onePingLable.text = [dict objectForKey:@"firstsame"];
//    oneFuLable.text = [dict objectForKey:@"firstlost"];
    
    
    if (oddIndexPath.row == 0) {
        if ( [oneShengLable.text floatValue] > [[_oddsDictionary objectForKey:@"firstwin"] floatValue] ) {//比较第一个
            oneShengLable.textColor = [UIColor colorWithRed:246/255.0 green:0 blue:7/255.0 alpha:1];
            
        }else if ([oneShengLable.text floatValue] < [[_oddsDictionary objectForKey:@"firstwin"] floatValue] ){
            oneShengLable.textColor = [UIColor colorWithRed:0 green:38/255.0 blue:175/255.0 alpha:1];
            
        }else{
            oneShengLable.textColor = [UIColor blackColor];
            
        }
        if (oddsInteger == 1) {
            if ( [onePingLable.text floatValue] > [[_oddsDictionary objectForKey:@"firstsame"] floatValue] ) {//比较第一个
                onePingLable.textColor = [UIColor colorWithRed:246/255.0 green:0 blue:7/255.0 alpha:1];
                
            }else if ([onePingLable.text floatValue] < [[_oddsDictionary objectForKey:@"firstsame"] floatValue] ){
                onePingLable.textColor = [UIColor colorWithRed:0 green:38/255.0 blue:175/255.0 alpha:1];
                
            }else{
                onePingLable.textColor = [UIColor blackColor];
                
            }
        }else{
            onePingLable.textColor = [UIColor blackColor];
        }
        
        
        if ( [oneFuLable.text floatValue] > [[_oddsDictionary objectForKey:@"firstlost"] floatValue] ) {//比较第一个
            oneFuLable.textColor = [UIColor colorWithRed:246/255.0 green:0 blue:7/255.0 alpha:1];
            
        }else if ([oneFuLable.text floatValue] < [[_oddsDictionary objectForKey:@"firstlost"] floatValue] ){
            oneFuLable.textColor = [UIColor colorWithRed:0 green:38/255.0 blue:175/255.0 alpha:1];
            
        }else{
            oneFuLable.textColor = [UIColor blackColor];
            
        }
    }else{
        oneShengLable.textColor = [UIColor blackColor];
        onePingLable.textColor = [UIColor blackColor];
        oneFuLable.textColor = [UIColor blackColor];
    }
    
    
    
    
}

- (NSDictionary *)oddsDictionary{

    return oddsDictionary;
}

- (void)tableViewCellShowFunc{

    chupanLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 109, 49.5)];
    chupanLabel.backgroundColor = [UIColor clearColor];
    chupanLabel.textAlignment = NSTextAlignmentCenter;
    chupanLabel.font = [UIFont systemFontOfSize:14];
    chupanLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
//    chupanLabel.text = @"01-28 14:49";
    [self.contentView addSubview:chupanLabel];
    [chupanLabel release];
    
    oneShengLable = [[UILabel alloc] initWithFrame:CGRectMake(109, 0, 50, 49.5)];
    oneShengLable.backgroundColor = [UIColor clearColor];
    oneShengLable.textAlignment = NSTextAlignmentCenter;
    oneShengLable.font = [UIFont systemFontOfSize:14];
    oneShengLable.textColor = [UIColor blackColor];
//    oneShengLable.text = @"6.7";
    [self.contentView addSubview:oneShengLable];
    [oneShengLable release];
    
    onePingLable = [[UILabel alloc] initWithFrame:CGRectMake(159, 0, 98, 49.5)];
    onePingLable.backgroundColor = [UIColor clearColor];
    onePingLable.textAlignment = NSTextAlignmentCenter;
    onePingLable.font = [UIFont systemFontOfSize:14];
    onePingLable.textColor = [UIColor blackColor];
//    onePingLable.text = @"3/3.5球";
    [self.contentView addSubview:onePingLable];
    [onePingLable release];
    
    
    oneFuLable = [[UILabel alloc] initWithFrame:CGRectMake(258, 0, 320 - 258, 49.5)];
    oneFuLable.backgroundColor = [UIColor clearColor];
    oneFuLable.textAlignment = NSTextAlignmentCenter;
    oneFuLable.font = [UIFont systemFontOfSize:14];
    oneFuLable.textColor = [UIColor blackColor];
//    oneFuLable.text = @"1.44";
    [self.contentView addSubview:oneFuLable];
    [oneFuLable release];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self tableViewCellShowFunc];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
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