//
//  AwardCell.m
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "AwardCell.h"
#import "ImageStoreReceiver.h"

@implementation AwardCell
@synthesize imageView;
@synthesize useLable;
@synthesize dateLable;
@synthesize moneyLable;
@synthesize yuanLable;
@synthesize backImage;
@synthesize imageUrl;
@synthesize receiver;

//cell的定制
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self viewCell];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)viewCell{
    
    CGRect rect = CGRectMake(10, 2, 300, 53);
    
    
//    //背景图片
    backImage = [[UIImageView alloc] initWithFrame:rect];
    backImage.backgroundColor = [UIColor clearColor];
    backImage.userInteractionEnabled = YES;
    //头像
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 10, 30, 30)];
   // imageView.backgroundColor = [UIColor yellowColor];
    ImageStoreReceiver *tmpReceiver = [[ImageStoreReceiver alloc] init];
    self.receiver = tmpReceiver;
    receiver.imageContainer = self;
    [tmpReceiver release];
    
         
    //用户名
    useLable = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, 70, 15)];
    useLable.textAlignment = NSTextAlignmentLeft;
    useLable.backgroundColor = [UIColor clearColor];
    useLable.font = [UIFont boldSystemFontOfSize:12];
    
    //多少期获奖金
    dateLable = [[UILabel alloc] initWithFrame:CGRectMake(95, 28, 70, 10)];
    dateLable.textAlignment = NSTextAlignmentLeft;
    dateLable.lineBreakMode = NSLineBreakByClipping;
    dateLable.font = [UIFont systemFontOfSize:9];
    dateLable.backgroundColor = [UIColor clearColor];
    dateLable.textColor = [UIColor grayColor];
    
    
    //金额
    moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(150, 15, 100, 17)];
    moneyLable.textAlignment = NSTextAlignmentRight;
    moneyLable.font = [UIFont systemFontOfSize:15];
    moneyLable.backgroundColor = [UIColor clearColor];
    moneyLable.textColor = [UIColor redColor];
   
    
    //元
    yuanLable = [[UILabel alloc] initWithFrame:CGRectMake(255, 20, 20, 13)];
    yuanLable.text = @"元";
    yuanLable.textAlignment = NSTextAlignmentLeft;
    yuanLable.font = [UIFont systemFontOfSize:11];
    yuanLable.backgroundColor = [UIColor clearColor];
    yuanLable.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    
    //箭头
    UIImageView *jian = [[UIImageView alloc] initWithFrame:CGRectMake(280, 20, 8.5, 13)];
    jian.image = UIImageGetImageFromName(@"JTD960.png");
    [backImage addSubview:jian];
    jian.backgroundColor = [UIColor clearColor];
    [jian release];
           
    [backImage addSubview:moneyLable];
    [backImage addSubview:yuanLable];
    
    [self.contentView addSubview:backImage];
    [backImage addSubview:imageView];
    [backImage addSubview:useLable];
    [backImage addSubview:dateLable];
    
   // NSLog(@"budgeView  %@", view);
}
- (void)updateImage:(UIImage*)image{
    imageView.image = image;
    
}


- (NSInteger)row{
    return row;
}

- (void)setRow:(NSInteger)_row{
    row = _row;
        backImage.image = [UIImageGetImageFromName(@"LBT960.png") stretchableImageWithLeftCapWidth:160 topCapHeight:6];
        backImage.frame = CGRectMake(10, 2, 300, 53);
        imageView.frame = CGRectMake(10, 7, 40, 40);
        useLable.frame = CGRectMake(60, 18, 100, 15);
        dateLable.frame = CGRectMake(95, 28, 70, 10);


}

//get方法
- (AwardData *)awardData{
    return awardData;
}

//set方法
- (void)setAwardData:(AwardData *)_awardData{
    if (awardData != _awardData) {
        [awardData release];
        awardData = [_awardData retain];
    }
    
    moneyLable.text = _awardData.money;
    useLable.text = _awardData.use;
    dateLable.text = _awardData.date;
    self.imageUrl = _awardData.imageUrl;
    imageView.image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : imageUrl Delegate:receiver Big:YES];


}

- (void)dealloc{
    [imageUrl release];
    [backImage release];
    [imageView release];
    [useLable release];
    [dateLable release];
    [moneyLable release];
    [yuanLable release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    