//
//  HaoShengYinCell.m
//  caibo
//
//  Created by houchenguang on 13-1-17.
//
//

#import "HaoShengYinCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageDownloader.h"
#import "ImageStoreReceiver.h"
#import "caiboAppDelegate.h"

@implementation HaoShengYinCell
@synthesize row;
@synthesize delegate;

- (void)setHaoData:(HaoShengYinData *)_haoData{

    if (haoData != _haoData) {
        [haoData release];
        haoData = [_haoData retain];
    }
    if (!receiver){
        receiver = [[ImageStoreReceiver alloc] init];
        receiver.imageContainer = self;
    }
     [headImge setImageWithURL:_haoData.headImage];
//    headImge.image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : _haoData.headImage Delegate:receiver Big:YES];
    nameLabel.text = _haoData.nickName;
//    timeLabel.text = [NSString stringWithFormat:@"%@\"" ,_haoData.time ];//[NSString stringWithFormat:@"%d", [_haoData.time intValue]];
    dengjiLabel.text = _haoData.zan;//[NSString stringWithFormat:@"%d", [_haoData.zan intValue]];
    if (row == 0 || row == 1 || row == 2) {
        dengjiiamge1.hidden = NO;
        dengjiLabel.frame =  CGRectMake(46+15+19/2+7, 5+28, 40, 9);
//        xinImge.image = UIImageGetImageFromName(@"glxin.png");
        xinImge.image = UIImageGetImageFromName(@"glzanimage.png");
        dengjiiamge1.frame = CGRectMake(0, 0, 42, 42);
        if (row == 0) {
            dengjiiamge1.image = UIImageGetImageFromName(@"gcsf.png");
        }else if(row == 1){
            dengjiiamge1.image = UIImageGetImageFromName(@"glyz.png");
        
        }else if(row == 2){
            dengjiiamge1.image = UIImageGetImageFromName(@"glbd.png");
        
        }
    }else{
        dengjiLabel.frame = CGRectMake(46+15+19/2+7, 5+28, 40, 9);
//        xinImge.image = UIImageGetImageFromName(@"glxin.png");
        xinImge.image = UIImageGetImageFromName(@"glzanimage.png");
        dengjiiamge1.hidden = YES;
        dengjiiamge1.image = nil;
    }
    
    if ([_haoData.bonus intValue] > 0) {
        moneyLabel.text = [NSString stringWithFormat:@"奖励%@元", _haoData.bonus];
       
        moneyLabel.frame = CGRectMake(132, 8, 140, 20);
        moneyLabel.hidden = NO;
       
    }else{
        moneyLabel.text = @"";
        moneyLabel.hidden = YES;
    }
    
    
}

- (HaoShengYinData *)haoData{
    return haoData;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        UIImageView * bgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 296, 52)];
        bgview.backgroundColor = [UIColor clearColor];
        bgview.userInteractionEnabled = YES;
        bgview.image = [UIImageGetImageFromName(@"LBT960.png") stretchableImageWithLeftCapWidth:160 topCapHeight:6];//UIImageGetImageFromName(@"GoucaiCellbtn7.png");
        [self.contentView addSubview:bgview];
        [bgview release];
        
        headImge = [[DownLoadImageView alloc] initWithFrame:CGRectMake(6, 5, 40, 40)];
        [headImge.layer setMasksToBounds:YES]; // 设置圆角边框
        [headImge.layer setCornerRadius:5];
//        [headImge.layer setBorderWidth:1];
        [self.contentView addSubview:headImge];
        [headImge release];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(46+15, 5, 70, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont boldSystemFontOfSize:12];
        nameLabel.textColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1];
//        nameLabel.text = @"姓名姓名";
        [self.contentView addSubview:nameLabel];
        [nameLabel release];
        
        xinImge = [[UIImageView alloc] initWithFrame:CGRectMake(46+15, 5+26, 21/2, 19/2)];
        xinImge.backgroundColor = [UIColor clearColor];
        xinImge.image = UIImageGetImageFromName(@"glzanimage.png");
        [self.contentView addSubview:xinImge];
        [xinImge release];
        
        dengjiLabel = [[UILabel alloc] initWithFrame:CGRectMake(46+15+21/2+7, 5+28, 40, 9)];
        dengjiLabel.backgroundColor = [UIColor clearColor];
        dengjiLabel.textAlignment = NSTextAlignmentLeft;
        dengjiLabel.font = [UIFont systemFontOfSize:10];
//        dengjiLabel.text = @"234";
        dengjiLabel.textColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [self.contentView addSubview:dengjiLabel];
        [dengjiLabel release];
        
        dengjiiamge1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
        dengjiiamge1.image = UIImageGetImageFromName(@"");
        dengjiiamge1.backgroundColor = [UIColor clearColor];
        dengjiiamge1.hidden = YES;
        [headImge addSubview:dengjiiamge1];
        [dengjiiamge1 release];
        
        
        
        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:252/255.0 blue:3/255.0 alpha:1];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.textAlignment = NSTextAlignmentLeft;
        moneyLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:moneyLabel];
        [moneyLabel release];
        
        UIButton * kuangimage = [UIButton buttonWithType:UIButtonTypeCustom];
        kuangimage.frame = CGRectMake(296-8-13-23-52/2, (52-46/2)/2, 52/2, 46/2);
        [kuangimage setImage:UIImageGetImageFromName(@"gckaishi_1.png") forState:UIControlStateNormal];
        [kuangimage setImage:UIImageGetImageFromName(@"gckaishi.png") forState:UIControlStateHighlighted];
        [kuangimage addTarget:self action:@selector(pressShengYinButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:kuangimage];
        
        
        UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(296-8-13, (52-3-13)/2, 8, 13)];
        
        jiantou.backgroundColor = [UIColor clearColor];
        jiantou.image = UIImageGetImageFromName(@"JTD960.png");
        [self.contentView addSubview:jiantou];
        [jiantou release];
        
        
//        UIImageView * butbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 54, 16)];
//        butbg.backgroundColor = [UIColor clearColor];
//        butbg.image = [UIImageGetImageFromName(@"longluekuang.png") stretchableImageWithLeftCapWidth:24 topCapHeight:12];
//        [kuangimage addSubview:butbg];
//        [butbg release];
        
//        UIImage * shengiamge = [[UIImage imageNamed:@"longluekuang.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:12];
//        [kuangimage setImage:shengiamge forState:UIControlStateNormal];
        
//        UIImageView * shengyinimage = [[UIImageView alloc] initWithFrame:CGRectMake(7, 27, 6, 7)];
//        shengyinimage.backgroundColor = [UIColor clearColor];
//        shengyinimage.image = UIImageGetImageFromName(@"VoiceIcon.png");
//        [kuangimage addSubview:shengyinimage];
//        [shengyinimage release];
//        
//        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 23, 41, 16)];
//        timeLabel.textAlignment = NSTextAlignmentCenter;
//        timeLabel.shadowOffset = CGSizeMake(0, 1.0);
//        timeLabel.shadowColor = [UIColor whiteColor];
//        timeLabel.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
//        timeLabel.backgroundColor = [UIColor clearColor];
////        timeLabel.text = @"60\"";
//        timeLabel.font = [UIFont systemFontOfSize:10];
//        [kuangimage addSubview:timeLabel];
//        [timeLabel release];
//        
    }
    return self;
}

- (void)pressShengYinButton:(UIButton *)sender{
    [self returnDidSetSelecteInTheRow:row];
}

- (void)returnDidSetSelecteInTheRow:(NSInteger)selecteRow{
    if ([delegate respondsToSelector:@selector(returnDidSetSelecteInTheRow:)]) {
        [delegate returnDidSetSelecteInTheRow:selecteRow];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    [super dealloc];
    

}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    