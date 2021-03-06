//
//  CPSlefHelpTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-5-6.
//
//

#import "CPSlefHelpTableViewCell.h"

@implementation CPSlefHelpTableViewCell
@synthesize cellIndexPath;
@synthesize nameLabel;
@synthesize lineImage;
- (void)dealloc{
    [cellIndexPath release];
    [super dealloc];
}

- (void)setSelfHelpData:(CPSlefHelpData *)_selfHelpData{

    if (selfHelpData != _selfHelpData) {
        [selfHelpData release];
        selfHelpData = [_selfHelpData retain];
    }
    
    
    
    headImageView.image = UIImageGetImageFromName(_selfHelpData.headImageName);
    nameLabel.text = _selfHelpData.labelName;
    
    [headImageButton setImage:UIImageGetImageFromName(_selfHelpData.headImageName) forState:UIControlStateNormal];
    [headImageButton setImage:UIImageGetImageFromName(_selfHelpData.headSelectedImage) forState:UIControlStateSelected];
    
    
    if (cellIndexPath.section == 2 && cellIndexPath.row == 0) {
        
        kfmarkImageView.hidden = NO;
        selfHelpImageView.hidden = NO;
        
    }else{
        
        kfmarkImageView.hidden = YES;
        selfHelpImageView.hidden = YES;
    }
    
    if (selfHelpData.imageHidder) {
        selfHelpImageView.hidden = NO;
    }else{
        selfHelpImageView.hidden = YES;
    }
    
    
    
    // 加的上中下三种图片
    if ([_selfHelpData.bgImageName isEqualToString:@"SZT-S-960.png"]) {
        // bgImageView.image = [UIImageGetImageFromName(_selfHelpData.bgImageName) stretchableImageWithLeftCapWidth:10 topCapHeight:8];
        bgImageView.backgroundColor = [UIColor whiteColor];
    }else if ([_selfHelpData.bgImageName isEqualToString:@"SZT960.png"]){
        
        bgImageView.backgroundColor = [UIColor whiteColor];
        // bgImageView.image = [UIImageGetImageFromName(_selfHelpData.bgImageName) stretchableImageWithLeftCapWidth:15 topCapHeight:23];
    }else{
       // bgImageView.image = [UIImageGetImageFromName(_selfHelpData.bgImageName) stretchableImageWithLeftCapWidth:15 topCapHeight:2];
        bgImageView.backgroundColor = [UIColor whiteColor];
    }
    
    
    
    
    
    // 中间的分割线
    // lineImage.image = UIImageGetImageFromName(_selfHelpData.lineName);
    
}

- (CPSlefHelpData *)selfHelpData{
    return selfHelpData;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.backgroundColor = [UIColor clearColor];
        bgImageView = [[UIImageView alloc] init];
        bgImageView.frame = CGRectMake(0, 5, 320, 45);
        bgImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bgImageView];
        [bgImageView release];
        
       
        
        // WithFrame:CGRectMake(26, 11, 22, 22)
        headImageView = [[UIImageView alloc] init];
        headImageView.frame = CGRectMake(15, 17, 22, 22);
        headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:headImageView];
        [headImageView release];
        
        
//        // 加按钮图片
//        headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        headImageButton.frame = CGRectMake(15, 8, 305, 45);
//        headImageButton.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 15, 305-22);
//        headImageButton.backgroundColor = [UIColor clearColor];
//        [headImageButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:headImageButton];
        
        
        
        // WithFrame:CGRectMake(61, 0, 150, 44)
        nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(50, 5, 200, 45);
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:nameLabel];
        [nameLabel release];
        
        
       
        // 在线客服的邮件提醒----->改为红色小圆点
        kfmarkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(135, 20, 20, 15)];
        kfmarkImageView.hidden = YES;
        kfmarkImageView.backgroundColor = [UIColor clearColor];
        kfmarkImageView.image = UIImageGetImageFromName(@"youjiantixing.png");
        [self.contentView addSubview:kfmarkImageView];
        [kfmarkImageView release];
        
       
        // 信息提示图
        selfHelpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(135+9, (44 - 15)/2 - 11, 22, 22)];
        selfHelpImageView.backgroundColor = [UIColor clearColor];
        selfHelpImageView.hidden = YES;
        selfHelpImageView.image = UIImageGetImageFromName(@"xinxitishitu.png");
        //    selfHelpImageView.hidden = YES;
        [self.contentView addSubview:selfHelpImageView];
        [selfHelpImageView release];
        
        
        
       // 提示条数
        UILabel *selfHelpNo = [[UILabel alloc] initWithFrame:selfHelpImageView.bounds];
        selfHelpNo.text = @"1";
        selfHelpNo.font = [UIFont boldSystemFontOfSize:11];
        selfHelpNo.backgroundColor = [UIColor clearColor];
        selfHelpNo.textAlignment = NSTextAlignmentCenter;
        selfHelpNo.textColor = [UIColor whiteColor];
        [selfHelpImageView addSubview:selfHelpNo];
        [selfHelpNo release];
        
        
        
        // 箭头图片
        UIImageView * jianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 - 35, (45 - 10)/2+5, 5, 10)];
        // login_arr
        jianImageView.image = UIImageGetImageFromName(@"san_1.png");
        [self.contentView addSubview:jianImageView];
        [jianImageView  release];
        
        
        //  分割线 WithFrame:CGRectMake(12, 43, 296, 1)
        lineImage = [[UIImageView alloc] init];
        lineImage.frame = CGRectMake(15, 50, 305, 0.5);
        lineImage.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
        // lineImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:lineImage];
        [lineImage release];
        
        
    }
    return self;
}

- (void)btnClick:(UIButton *)btn
{

    
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