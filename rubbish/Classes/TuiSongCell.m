//
//  TuiSongCell.m
//  caibo
//
//  Created by houchenguang on 12-12-12.
//
//

#import "TuiSongCell.h"

@implementation TuiSongCell

@synthesize bgimage;
@synthesize line;
@synthesize line2;
@synthesize jiantou;
@synthesize titleText;

- (void)dealloc{
    // [line release];
    [titleText release];
    [bgimage release];
    [super dealloc];
    // [jiantou release];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
#ifdef isCaiPiaoForIPad
    
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 475, 44)];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.userInteractionEnabled = YES;
        
        titleText = [[UILabel alloc] initWithFrame:bgimage.bounds];
        titleText.textAlignment = NSTextAlignmentCenter;
        titleText.font = [UIFont boldSystemFontOfSize:18];
        titleText.backgroundColor = [UIColor clearColor ];
        [bgimage addSubview:titleText];
        
        
        
        jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(455, 15, 8, 13)];
        jiantou.backgroundColor = [UIColor clearColor];
        jiantou.image = [UIImage imageNamed:@"JTD960.png"];
        [bgimage addSubview:jiantou];
        
        
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(2, 44, 472, 0.5)];
        line.backgroundColor = [UIColor clearColor];
        line.image = [UIImage imageNamed:@""];
        [bgimage addSubview:line];
        
        [self.contentView addSubview:bgimage];
    }
    return self;

    
#else
    
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        bgimage.backgroundColor = [UIColor clearColor];
        bgimage.backgroundColor = [UIColor whiteColor];
        bgimage.userInteractionEnabled = YES;
        
        titleText = [[UILabel alloc] initWithFrame:bgimage.bounds];
        titleText.textAlignment = NSTextAlignmentCenter;
        titleText.font = [UIFont boldSystemFontOfSize:18];
        titleText.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        titleText.backgroundColor = [UIColor clearColor ];
        [bgimage addSubview:titleText];
        
        
        
        jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(275, 15, 8, 13)];
        jiantou.backgroundColor = [UIColor clearColor];
        // jiantou.image = [UIImage imageNamed:@"JTD960.png"];
        [bgimage addSubview:jiantou];
        
        
        
        line = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 0.5)] autorelease];
        line.backgroundColor = [UIColor clearColor];
        line.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [bgimage addSubview:line];
        
        
        
        
        line2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
        line2.backgroundColor = [UIColor clearColor];
        line2.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [bgimage addSubview:line2];
        
        [self.contentView addSubview:bgimage];
    }
    return self;
    
#endif

    
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