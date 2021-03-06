//
//  GuangChangTopNewsCell.m
//  caibo
//
//  Created by GongHe on 14-10-30.
//
//

#import "GuangChangTopNewsCell.h"
#import "ColorView.h"
#import "SharedDefine.h"

@implementation GuangChangTopNewsCell
@synthesize titleLabel;

- (void)dealloc
{
    [titleLabel release];
    [contentLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:titleLabel];
        
        contentLabel = [[UILabel alloc] init];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = titleLabel.font;
        contentLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [self.contentView addSubview:contentLabel];
        
        UIImageView * arrowImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 8 - 10, 16.3, 8, 12.5)] autorelease];
        arrowImageView.image = UIImageGetImageFromName(@"chongzhijian.png");
        [self.contentView addSubview:arrowImageView];
        
        UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(0, WEIBO_GUANGCHANG_TOPNEWS_HEIGHT - 0.5, self.frame.size.width, 0.5)] autorelease];
        line.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
        [self.contentView addSubview:line];
        
    }
    return self;
}

-(void)setContentString:(NSString *)contentStr
{
    contentLabel.text = contentStr;
    contentLabel.frame = CGRectMake(0, 0, self.frame.size.width - ORIGIN_X(titleLabel) - 20, WEIBO_GUANGCHANG_TOPNEWS_HEIGHT);
    
    if ([contentStr hasPrefix:@"【"]) {
        NSArray * contentArray = [contentStr componentsSeparatedByString:@"】"];
        if (contentArray.count > 1) {
            NSArray * contentArray1 = [[contentArray objectAtIndex:0] componentsSeparatedByString:@"【"];
            if (contentArray1.count < 3) {
                NSRange range = [contentStr rangeOfString:@"】"];
                titleLabel.text = [contentStr substringToIndex:range.location + 1];
                CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(self.frame.size.width - ORIGIN_X(titleLabel) - 20, WEIBO_GUANGCHANG_TOPNEWS_HEIGHT)];
                titleLabel.frame = CGRectMake(0, 0, titleSize.width, WEIBO_GUANGCHANG_TOPNEWS_HEIGHT);
                
                contentLabel.text = [contentStr substringFromIndex:range.location + 1];
                contentLabel.frame = CGRectMake(ORIGIN_X(titleLabel), titleLabel.frame.origin.y, self.frame.size.width - ORIGIN_X(titleLabel) - 20, titleLabel.frame.size.height);
            }
        }
    }
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