//
//  JinPinTuiJianCell.m
//  caibo
//
//  Created by zhang on 1/9/13.
//
//

#import "JinPinTuiJianCell.h"
#import "caiboAppDelegate.h"

@implementation JinPinTuiJianCell
@synthesize LogoImage;
@synthesize AppName;
@synthesize AppSize;
@synthesize AppInfo;

- (void)setJpdata:(JinPinTuiJianData *)_jpdata{
    if (jpdata != _jpdata) {
        [jpdata release];
        jpdata = [_jpdata retain];
    }
    AppName.text = jpdata.appName;
    AppSize.text = jpdata.appFileSize;
    //AppSize.frame = CGRectMake(AppName.frame.origin.x + [jpdata.appName length] + 20, 8, 35, 20);
    AppInfo.text = jpdata.reMark;
    
    CGSize labelSize = [AppName.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:UILineBreakModeCharacterWrap];
    AppName.frame = CGRectMake(60, 6, labelSize.width, 20);
    AppSize.frame = CGRectMake(AppName.frame.origin.x+labelSize.width+20, 8, 100, 20);
    
    LogoImage.image = UIImageGetImageFromName(@"ay_morentupian.png");
    if ([jpdata.logoMidPath length]) {
        [self.LogoImage setImageWithURL:jpdata.logoMidPath DefautImage:UIImageGetImageFromName(@"ay_morentupian.png")];
//        if (!receiver){
//    
//        receiver = [[ImageStoreReceiver alloc] init];
//        receiver.imageContainer = self;
//            
//        }
//    
//        UIImage *image1 = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage :jpdata.logoMidPath Delegate:receiver Big:YES];
//    
//        self.LogoImage.image = image1;
    	}
    
}

- (JinPinTuiJianData *)jpdata{
    return jpdata;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.userInteractionEnabled = YES;
        
        //推荐程序logo图片
        DownLoadImageView *appimage = [[DownLoadImageView alloc] initWithFrame:CGRectMake(15, 10, 32, 32)];
		self.LogoImage = appimage;
		self.LogoImage.backgroundColor = [UIColor clearColor];
        [appimage release];
        
        //推荐程序名称
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(55, 6, 170, 20)];
        label1.backgroundColor = [UIColor clearColor];
        label1.textAlignment = NSTextAlignmentLeft;
		label1.font = [UIFont systemFontOfSize:15];
		self.AppName = label1;
		[label1 release];
        
        //推荐程序大小
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(250, 8, 40, 20)];
        label2.backgroundColor = [UIColor clearColor];
        label2.textAlignment = NSTextAlignmentLeft;
		label2.font = [UIFont systemFontOfSize:9];
        label2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
		self.AppSize = label2;
		[label2 release];
        
        //推荐程序介绍
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 26, 200, 20)];
        label3.backgroundColor = [UIColor clearColor];
        label3.textAlignment = NSTextAlignmentLeft;
		label3.font = [UIFont systemFontOfSize:10];
        label3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
		self.AppInfo = label3;
		[label3 release];
        
        //推荐程序下载按钮
//        UIButton *XZButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        XZButton.frame = CGRectMake(250, 12, 50, 25);
//        XZButton.backgroundColor = [UIColor clearColor];
//        [XZButton addTarget:self action:@selector(pressDownload) forControlEvents:UIControlEventTouchUpInside];
//        UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
//        btnImage.image = UIImageGetImageFromName(@"wb20.png");
//        btnImage.image = [btnImage.image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
//        [XZButton addSubview:btnImage];
//        [btnImage release];
//        
//        UILabel *buttonTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 50, 25)];
//        buttonTitle.text = @"免费";
//        //self.AppMoney = buttonTitle;
//        buttonTitle.textColor = [UIColor whiteColor];
//        buttonTitle.font = [UIFont systemFontOfSize:12];
//        buttonTitle.backgroundColor = [UIColor clearColor];
//        [XZButton addSubview:buttonTitle];
//        [buttonTitle release];
//
//        [self.contentView addSubview:XZButton];
        [self.contentView addSubview:LogoImage];
        [self.contentView addSubview:AppName];
        [self.contentView addSubview:AppSize];
        [self.contentView addSubview:AppInfo];
        


    }
    return self;
}

//
- (void)pressDownload {

    NSURL *xzURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",jpdata.appPath]];
    [[UIApplication sharedApplication] openURL:xzURL];
//    BOOL b = [[UIApplication sharedApplication] canOpenURL:xzURL];
//    if (b) {
//        
//        [[UIApplication sharedApplication] openURL:xzURL];
//    }else {
//    
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn"]];
//    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [jpdata release];
    self.LogoImage = nil;
    self.AppName = nil;
    self.AppSize = nil;
    self.AppInfo = nil;
    
    //receiver.imageContainer = nil;
//	[[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:jpdata.logoMidPath];
    
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    