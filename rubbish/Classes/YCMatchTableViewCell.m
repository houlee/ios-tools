//
//  YCMatchTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-5-24.
//
//

#import "YCMatchTableViewCell.h"

@implementation YCMatchTableViewCell

- (NSDictionary *)dataDictionary{
    return dataDictionary;
}

- (void)setDataDictionary:(NSDictionary *)_dataDictionary{
    
    
    if (_dataDictionary) {
        if (dataDictionary != _dataDictionary) {
            [dataDictionary release];
            dataDictionary = [_dataDictionary retain];
        }
        
        NSArray * timeArray = [[dataDictionary objectForKey:@"match_date"] componentsSeparatedByString:@" "];
        if (timeArray && [timeArray count] >= 2) {
            NSArray * dateArray = [[timeArray objectAtIndex:0] componentsSeparatedByString:@"-"];
            NSArray * shiArray = [[timeArray objectAtIndex:1] componentsSeparatedByString:@":"];
            if (dateArray && shiArray && [dateArray count] >= 3 && [shiArray count] >= 3) {
                monthLabel.text = [NSString stringWithFormat:@"%@-%@", [dateArray objectAtIndex:1], [dateArray objectAtIndex:2]];//@"01-18";
                dateLabel.text = [NSString stringWithFormat:@"%@:%@", [shiArray objectAtIndex:0], [shiArray objectAtIndex:1]];//@"09:28";
            }else{
                monthLabel.text = @"";
                dateLabel.text = @"";
            }
        }else{
            monthLabel.text = @"";
            dateLabel.text = @"";
        }
        
        
        homeLabel.text = [dataDictionary objectForKey:@"host_name"];
        scoreLabel.text = [NSString stringWithFormat:@"%@-%@", [dataDictionary objectForKey:@"host_goal"], [dataDictionary objectForKey:@"guest_goal"]];
        guestLabel.text = [dataDictionary objectForKey:@"guest_name"];
        
        oneOPeiLabel.text = [dataDictionary objectForKey:@"win"];
        twoOPeiLabel.text = [dataDictionary objectForKey:@"same"];
        threeOPeiLabel.text = [dataDictionary objectForKey:@"lost"];
        
        if ([[dataDictionary objectForKey:@"fsl"] integerValue] == 1) {
            shoucimoImage.image = UIImageGetImageFromName(@"bfycshouimage.png");//bfycciimage.png  bfycmoimage.png
        }else if ([[dataDictionary objectForKey:@"fsl"] integerValue] == 2) {
            shoucimoImage.image = UIImageGetImageFromName(@"bfycciimage.png");//bfycciimage.png  bfycmoimage.png
        }else if ([[dataDictionary objectForKey:@"fsl"] integerValue] == 3) {
            shoucimoImage.image = UIImageGetImageFromName(@"bfycmoimage.png");//bfycciimage.png  bfycmoimage.png
        }else{
            shoucimoImage.image = UIImageGetImageFromName(nil);//bfycciimage.png  bfycmoimage.png
        }
        
        if ([[dataDictionary objectForKey:@"result"] length] > 0) {
            vsImageView.hidden = YES;
            scoreLabel.hidden = NO;
            if ([[dataDictionary objectForKey:@"result"] isEqualToString:@"胜"]) {
                oneOPeiLabel.textColor = [UIColor redColor];
                twoOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
                threeOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            }else if ([[dataDictionary objectForKey:@"result"] isEqualToString:@"平"]) {
                oneOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
                twoOPeiLabel.textColor = [UIColor redColor];
                threeOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            }else if ([[dataDictionary objectForKey:@"result"] isEqualToString:@"负"]) {
                oneOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
                twoOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
                threeOPeiLabel.textColor = [UIColor redColor];
            }else{
                vsImageView.hidden = NO;
                scoreLabel.hidden = YES;
                oneOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
                twoOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
                threeOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            }
        }else{
            vsImageView.hidden = NO;
            scoreLabel.hidden = YES;
            oneOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            twoOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            threeOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        
        }
        
        
    }else{
    
        monthLabel.text = @"";
        dateLabel.text = @"";
        homeLabel.text = @"";
        scoreLabel.text = @"";
        guestLabel.text = @"";
        
        oneOPeiLabel.text = @"";
        twoOPeiLabel.text = @"";
        threeOPeiLabel.text = @"";
        vsImageView.image = UIImageGetImageFromName(nil);//bfycciimage.png  bfycmoimage.png
    }
    
    
    
}

- (void)dealloc{
    [dataDictionary release];
    [super dealloc];
}

- (void)tableViewCellShowFunc{
    
    UIImageView * twoLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    twoLineImage.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.contentView addSubview:twoLineImage];
    [twoLineImage release];

    UIImageView * oneLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 0.5, 0.5, 65.5)];
    oneLineImage.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.contentView addSubview:oneLineImage];
    [oneLineImage release];
    
    monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, 60, 14)];
    monthLabel.backgroundColor = [UIColor clearColor];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    monthLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    monthLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:monthLabel];
    [monthLabel release];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, 60, 14)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    dateLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:dateLabel];
    [dateLabel release];
    
    homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75.5, 14, 88, 20)];
    homeLabel.backgroundColor = [UIColor clearColor];
    homeLabel.textAlignment = NSTextAlignmentLeft;
    homeLabel.textColor = [UIColor blackColor];
    homeLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:homeLabel];
    [homeLabel release];
    
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(163.5, 14, 52.5, 20)];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textColor = [UIColor redColor];
    scoreLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:scoreLabel];
    [scoreLabel release];
    
    vsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(163.5 + (52.5 - 18)/2, 16, 18, 15)];
    vsImageView.backgroundColor = [UIColor clearColor];
    vsImageView.image = UIImageGetImageFromName(@"vsimage.png");//
    [self.contentView addSubview:vsImageView];
    [vsImageView release];
    
    

    guestLabel = [[UILabel alloc] initWithFrame:CGRectMake(217, 14, 88, 20)];
    guestLabel.backgroundColor = [UIColor clearColor];
    guestLabel.textAlignment = NSTextAlignmentRight;
    guestLabel.textColor = [UIColor blackColor];
    guestLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:guestLabel];
    [guestLabel release];
    
    shoucimoImage = [[UIImageView alloc] initWithFrame:CGRectMake(320-12-13, 1.5, 13, 13)];
    shoucimoImage.backgroundColor = [UIColor clearColor];
//    shoucimoImage.image = UIImageGetImageFromName(@"bfycshouimage.png");//bfycciimage.png  bfycmoimage.png
    [self.contentView addSubview:shoucimoImage];
    [shoucimoImage release];
    
    
    UILabel *opeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(75.5, 38, 36, 20)];
    opeiLabel.backgroundColor = [UIColor clearColor];
    opeiLabel.textAlignment = NSTextAlignmentLeft;
    opeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    opeiLabel.font = [UIFont systemFontOfSize:11];
    opeiLabel.text = @"欧赔";
    [self.contentView addSubview:opeiLabel];
    [opeiLabel release];
    
    oneOPeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(163.5 - 52.5, 38, 52.5, 20)];
    oneOPeiLabel.backgroundColor = [UIColor clearColor];
    oneOPeiLabel.textAlignment = NSTextAlignmentCenter;
    oneOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    oneOPeiLabel.font = [UIFont systemFontOfSize:11];
    
    [self.contentView addSubview:oneOPeiLabel];
    [oneOPeiLabel release];
    
    twoOPeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(163.5, 38, 52.5, 20)];
    twoOPeiLabel.backgroundColor = [UIColor clearColor];
    twoOPeiLabel.textAlignment = NSTextAlignmentCenter;
    twoOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    twoOPeiLabel.font = [UIFont systemFontOfSize:11];
    
    [self.contentView addSubview:twoOPeiLabel];
    [twoOPeiLabel release];
    
    threeOPeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(163.5+52.5, 38, 52.5, 20)];
    threeOPeiLabel.backgroundColor = [UIColor clearColor];
    threeOPeiLabel.textAlignment = NSTextAlignmentCenter;
    threeOPeiLabel.textColor = [UIColor colorWithRed:125/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    threeOPeiLabel.font = [UIFont systemFontOfSize:11];
    
    [self.contentView addSubview:threeOPeiLabel];
    [threeOPeiLabel release];
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