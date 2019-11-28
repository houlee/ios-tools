//
//  Info.m
//  caibo
//
//  Created by Kiefer on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Info.h"
#import "CP_UIAlertView.h"

#import "GC_HttpService.h"

@implementation Info

@synthesize userId;
@synthesize nickName;
@synthesize password; 
@synthesize headImage;
@synthesize provinceId;
@synthesize cityId;
@synthesize mAddress;
@synthesize himId;
@synthesize mUserInfo;
@synthesize phoneNum;
@synthesize mailNum;
@synthesize isNeedRefreshHome;
@synthesize login_name;
@synthesize cbSID;
@synthesize cbVersion;
@synthesize userName;
@synthesize isbindmobile, authentication;
@synthesize caipaocount;
@synthesize requestArray,accesstoken;
@synthesize BundleId;
@synthesize jifen;
@synthesize choujiangcishu;
@synthesize headImageURL;
@synthesize caijin;
@synthesize choujiangXiaohao;

@synthesize testHost,testwapURL,testwap_pay,testRechage,testTixian,testBangdingurl,testipURL,testhost2,testpkweburl,testcheckNew,testbuylotter,testverify;
@synthesize testlicai;
@synthesize testHappy;

static Info *mInfo;

static NSString *key_username = @"nickName";
static NSString *key_password = @"password";

+ (id)getInstance
{
    @synchronized(mInfo)
    {
        if (!mInfo) 
        {
            mInfo = [[Info alloc] init];
        }
        return mInfo;
    }
    return nil;
}

- (NSString *)getPassword {
    return @"1";
}

- (id)init 
{	
	if((self = [super init])) 
    { //这里可以设置变量初始值
        self.userId = @"";
        self.login_name = @"";
        self.nickName = @"";
        self.password = @"";
        self.mAddress = @"其他";
        self.himId = @"";
        self.mUserInfo = nil;
        self.phoneNum = @"";
        self.mailNum = @"";
        self.cbSID = @"";
        self.cbVersion = @"";
        self.isbindmobile = @"";
        self.authentication = @"";
         self.accesstoken = @"";
        self.caijin = @"";
        isNeedRefreshHome = NO;
        caipaocount = 1;
        if (GC_testModle_1) {
            NSString *testMode = [[NSUserDefaults standardUserDefaults] valueForKey:@"test_netModel"];
            if ([testMode isEqualToString:@"56"]) {
                     self.testHost = @"http://tmoapi.cmwb.com/servlet/LotteryService"; // 测试地址
                     self.testwapURL = @"http://tm.cmwb.com/wap/csj/charge/zfb/index.jsp"; //测试wap地址
                     self.testwap_pay = @"http://tm.cmwb.com/wap/csj/openapi/check.jsp"; //测试支付Url
                     self.testRechage = @"http://tm.cmwb.com/wap/csj/charge/phone/index2.jsp";//充值地址
                     self.testTixian = @"http://tm.cmwb.com/wap/csj/tixian/login.jsp";//提现
                                
                
                     self.testBangdingurl = @"http://cpapi.dingdingcai.com/api/unionLogin/postLogin.action?";//122.11.50.208:8088
                     self.testipURL = @"http://cpapi.dingdingcai.com";
                     self.testhost2 = @"http://tcpapi.cmwb.com/api/mobileClientApi.action?";//测试cpapi.betrich.com// //@"http://tcpapi.cmwb.com/api/mobileClientApi.action?"

                     self.testpkweburl = @"http://tm.cmwb.com/wap//csj/openapi/PKcheck.jsp?";//pk赛跳网页
                     self.testcheckNew = @"http://tcpapi.cmwb.com/api/mobileClientApi.action?";//checkNew新地址
                     self.testbuylotter = @"http://download.caipiao365.com/cp365/config/tc_lotteryhall.txt";
                     self.testverify = @"http://tcpapi.cmwb.com/api/servlet/verifyCode?type=reg";
                     self.testlicai = @"http://h5123.cmwb.com/";
                     self.testHappy = @"http://h5123.cmwb.com/";

            }
            else if ([testMode isEqualToString:@"23"]) {
                     self.testHost = @"http://moapi.zcw.com/servlet/LotteryService"; // 测试地址
                     self.testwapURL = @"http://wap.zcw.com/wap/csj/charge/zfb/index.jsp"; //测试wap地址
                     self.testwap_pay = @"http://192.168.5.23:8080/wap/csj/openapi/check.jsp"; //测试支付Url
                     self.testRechage = @"http://192.168.5.23:8080/wap/csj/charge/phone/index2.jsp";//充值地址
                     self.testTixian = @"http://192.168.5.23:8080/wap/csj/tixian/login.jsp";//提现

                     self.testBangdingurl = @"http://tcpapi.cmwb.com/api/unionLogin/postLogin.action?";//122.11.50.208:8088
                     self.testipURL = @"http://tcpapi.cmwb.com";
                     self.testhost2 = @"http://cpapi.zcw.com/api/mobileClientApi.action?";//测试cpapi.betrich.com// //@"http://tcpapi.cmwb.com/api/mobileClientApi.action?"

                     self.testpkweburl = @"http://tm.cmwb.com/wap//csj/openapi/PKcheck.jsp?";//pk赛跳网页
                     self.testcheckNew = @"http://test2.cmwb.com/api/mobileClientApi.action?";//checkNew新地址
                     self.testbuylotter = @"http://tmoapi.cmwb.com/buylotteryhall.txt";
                     self.testverify = @"http://tcpapi.cmwb.com/api/servlet/verifyCode?type=reg";
                     self.testlicai = @"http://th6.cmwb.com/";
                     self.testHappy = @"http://h5123.cmwb.com/";


                
            }
            else if ([testMode isEqualToString:@"57"]) {
                     self.testHost =   @"http://211.151.37.57:8082/servlet/LotteryService"; // 正式地址
                     self.testwapURL = @"http://wap.dingdingcai.com/wap/csj/charge/zfb/index.jsp"; //wap地=
                     self.testwap_pay = @"http://tm.cmwb.com/wap/csj/openapi/check.jsp"; //测试支付Url
                     self.testRechage = @"http://wap.dingdingcai.com/wap/csj/charge/phone/index2.jsp";
                     self.testTixian = @"http://wap.dingdingcai.com/wap/csj/tixian/login.jsp";

                     self.testBangdingurl = @"http://cpapi.dingdingcai.com/api/unionLogin/postLogin.action?";
                     self.testipURL = @"http://cpapi.dingdingcai.com";
                     self.testhost2 =  @"http://211.151.37.58:8080/api/mobileClientApi.action?";//正式
                     self.testpkweburl = @"http://m.dingdingcai.com/wap//csj/openapi/PKcheck.jsp?";//pk赛跳网页
                     self.testcheckNew = @"http://211.151.37.58:8080/api/mobileClientApi.action?";//checkNew新地址
                     self.testbuylotter = @"http://download.caipiao365.com/cp365/config/buylotteryhall.txt";
                     self.testverify = @"http://211.151.37.58/api/servlet/verifyCode?type=reg";
                    self.testlicai = @"http://t.caipiao365.com/";
                    self.testHappy = @"http://t.caipiao365.com/";



            }
            else {//正式
                     self.testHost =   @"http://moapi.dingdingcai.com/servlet/LotteryService"; // 正式地址
                     self.testwapURL = @"http://wap.dingdingcai.com/wap/csj/charge/zfb/index.jsp"; //wap地=
                     self.testwap_pay = @"http://wap.dingdingcai.com/wap/csj/openapi/check.jsp"; //支付Url
                     self.testRechage = @"http://wap.dingdingcai.com/wap/csj/charge/phone/index2.jsp";
                     self.testTixian = @"http://wap.dingdingcai.com/wap/csj/tixian/login.jsp";
                
                     self.testBangdingurl = @"http://cpapi.dingdingcai.com/api/unionLogin/postLogin.action?";
                     self.testipURL = @"http://cpapi.dingdingcai.com";
                     self.testhost2 =  @"http://cpapi.dingdingcai.com/api/mobileClientApi.action?";//正式
                     self.testpkweburl = @"http://m.dingdingcai.com/wap//csj/openapi/PKcheck.jsp?";//pk赛跳网页
                     self.testcheckNew = @"http://cpapinc.diyicai.com/api/mobileClientApi.action?";//checkNew新地址
                     self.testbuylotter = @"http://download.caipiao365.com/cp365/config/tc_lotteryhall.txt";
                     self.testverify = @"http://cpapi.dingdingcai.com/api/servlet/verifyCode?type=reg";
                     self.testlicai = @"http://t.caipiao365.com/";
                     self.testHappy = @"http://t.caipiao365.com/";





            }
            
            
        }
	}
	return self;
}

- (void)dealloc
{
    [testHappy release];
    [testlicai release];
    [accesstoken release];
    [isbindmobile release];
    [mInfo release];
    [userId release];
    [login_name release];
    [nickName release];
    [password release];
    [headImage release];
    [mAddress release];
    [himId release];
    [mUserInfo release];
    [phoneNum release];
    [mailNum release];
    [userName release];
    [cbSID release];
    [cbVersion release];
    [BundleId release];
    [jifen release];
    [headImageURL release];
    self.caijin = nil;
    self.choujiangXiaohao = nil;
    [super dealloc];
}

//获得文件绝对路径
+ (NSString *)getFilePath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

//将一个对象写入文件
+ (void)writeObject:(NSObject *)obj toFile:(NSString *)fileName
{
    NSString *filePath = [self getFilePath:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
}

//从文件中读一个对象
+ (NSObject *)getObject:(NSString *) fileName
{
    NSString *filePath = [self getFilePath:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
         NSObject *obj = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        return obj;
    }
    return nil;
}

#pragma mark NSCoding
//编码
- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:nickName forKey:key_username];
    [encoder encodeObject:password forKey:key_password];
}

//解码
- (id)initWithCoder:(NSCoder*)decoder
{
    if ((self = [super init])) 
    {
        self.nickName = [decoder decodeObjectForKey:key_username];
        self.password = [decoder decodeObjectForKey:key_password];
    }
    return self;
}

// 针对第一视频头像图片地址http头后双斜杠和不带http头的解决方案
+ (NSString*)strFormatWithUrl:(NSString*)url
{    
    if (url) 
    {
        if (![url hasPrefix:@"http://"]) 
        {
            return [NSString stringWithFormat:@"http://t.diyicai.com%@", url];
        }
		return url;
//        NSMutableString *newUrl = [[NSMutableString alloc] initWithString:url];
//        NSRange range = [newUrl rangeOfString:@"http://"];
//        [newUrl deleteCharactersInRange:range];
//        NSRange range2 = [newUrl rangeOfString:@"//"];
//        [newUrl replaceCharactersInRange:range2 withString:@"/"];
//        
//        NSString *newUrlStr = [NSString stringWithFormat:@"http://%@", newUrl];
//        [newUrl release];
//        return newUrlStr;
    }
    return @"";
}


// 从地址读取图片
+ (UIImage *) imageFromURLString: (NSString *)urlstring

{
	
    //This call is synchronous and blocking
	
	return [UIImage imageWithData:[NSData dataWithContentsOfURL:[ NSURL URLWithString:urlstring ]]];
	
}

/**********************************UI组件初始化*************************************/
// UILabel初始化
+ (UILabel*) lbInit: (NSString*)text : (CGFloat)fontSize
{
    UILabel *lb = [[[UILabel alloc] init] autorelease];
    [lb setBackgroundColor:([UIColor clearColor])];
    [lb setText:(text)];
    [lb setFont:[UIFont systemFontOfSize:fontSize]];
    return lb;
}

// 根据字符串 预估组件大小
+ (CGSize) getExpectedSizeWithStr:(NSString*)text MaxWidth:(CGFloat)width FontSize:(CGFloat)fontsize
{
    UIFont *curFont = [UIFont fontWithName:(@"Helvetica") size:(fontsize)];
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    CGSize expectedSize = [text sizeWithFont:curFont constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
    return expectedSize;
}

// UILabel初始化
+ (UILabel*) lbInitWithTextSize:(NSString*)text MaxWidth:(CGFloat)maxWidth FontSize:(CGFloat)fontSize
{
    UILabel *lb = [[[UILabel alloc] init] autorelease];
    [lb setBackgroundColor:([UIColor clearColor])];
    [lb setText:(text)];
    [lb setFont:[UIFont systemFontOfSize:fontSize]];
    CGSize expectedSize = [Info getExpectedSizeWithStr:(text) MaxWidth:(maxWidth) FontSize:(fontSize)];
    [lb setBounds:CGRectMake(0, 0, expectedSize.width, expectedSize.height)];
    return lb;
}

// UITextField初始化
+ (UITextField*) tfInit :(CGFloat)fontSize
{
    UITextField *tf = [[[UITextField alloc] init] autorelease];
    [tf setBackgroundColor:([UIColor clearColor])];
    [tf setBorderStyle:(UITextBorderStyleRoundedRect)];
    [tf setFont:[UIFont systemFontOfSize:(fontSize)]];
    [tf setContentVerticalAlignment:(UIControlContentVerticalAlignmentCenter)];
    return tf;
}

// ImageButton初始化
+ (UIButton*) imageBtnInit :(NSString*)imageName :(id)target :(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIImage *image = UIImageGetImageFromName(imageName);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBounds:CGRectMake(0, 0, 44, 44)];
    [btn addTarget:(target) action:(action) forControlEvents:(UIControlEventTouchUpInside)];
    btn.backgroundColor = [UIColor clearColor];
	return btn;
}

// UIImageView初始化 根据图片大小
+ (UIImageView*) imageViewInit :(NSString*)imageName
{
    UIImage *image = UIImageGetImageFromName(imageName);
    CGSize size = CGSizeMake(image.size.width, image.size.height);
    UIImageView *imageView = [Info imageViewInitSize:(imageName) :(size)];
    return imageView;
}

// UIImageView初始化 根据自定义大小
+ (UIImageView*) imageViewInitSize :(NSString*)imageName :(CGSize)size
{
    UIImage *image = UIImageGetImageFromName(imageName);
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:(image)] autorelease];
    [imageView setBounds:CGRectMake(0, 0, size.width, size.height)];
    return imageView;
}

// CheckBox初始化
+ (UIButton*) checkBoxInit :(NSString*)imageName :(NSString*)imageName_s 
{
    UIImage *image = UIImageGetImageFromName(imageName);
    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkbox setImage:UIImageGetImageFromName(imageName) forState:UIControlStateNormal];
    [checkbox setImage:UIImageGetImageFromName(imageName_s) forState:UIControlStateSelected];
    [checkbox setBounds:CGRectMake(0, 0, image.size.width, image.size.height)];
    return checkbox;
}

// UIBarButtonItem初始化
+ (UIBarButtonItem*) barItemWithImage:(NSString*)imageName addTarget:(id)target action:(SEL)action 
{
    UIButton *btn = [Info imageBtnInit:(imageName) :(target) :(action)];
//    [btn setImage:UIImageGetImageFromName(@"cphome61-1.png") forState:UIControlStateHighlighted];
    
    UIBarButtonItem *barBtnItem = [[[UIBarButtonItem alloc] initWithCustomView:(btn)] autorelease];
	
    return barBtnItem;
}

// 取消对话框
+ (void)showCancelDialog:(NSString *)title :(NSString *)message :(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(title) message:(message) delegate:(delegate) cancelButtonTitle:(@"取消") otherButtonTitles:nil];
    [alert show];
    [alert release];
}

// 取消对话框
+ (void)showOkDialog:(NSString *)title :(NSString *)message :(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(title) message:(message) delegate:(delegate) cancelButtonTitle:(@"确定") otherButtonTitles:nil];
    [alert show];
    [alert release];
}

// 对话框
+ (void)showDialogWithTitle:(NSString *)title BtnTitle:(NSString*)btnTitle Msg:(NSString *)msg :(id)delegate
{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:(msg) delegate:(delegate) cancelButtonTitle:(btnTitle) otherButtonTitles:nil];
    [alert show];
    [alert release];
}

//资料界面 TableViewCell
+ (UIView*) getCellView:(NSUInteger)rowIndex :(NSUInteger)position :(SEL)action
{
    NSString *imageName_nor = @"";
    NSString *imageName_sel = @"";
    
    if (rowIndex == 0) 
    {
        if (position == leftPosition) 
        {
            imageName_nor = @"btn_above_left_nor.png";
            imageName_sel = @"btn_above_left_sel.png";
        }
        else if(position == rightPosition)
        {
            imageName_nor = @"btn_above_right_nor.png";
            imageName_sel = @"btn_above_right_sel.png";
        }
    }
    else
    {
        if (position == leftPosition) 
        {
            imageName_nor = @"btn_below_left_nor.png";
            imageName_sel = @"btn_below_left_sel.png";
        }
        else if(position == rightPosition)
        {
            imageName_nor = @"btn_below_right_nor.png";
            imageName_sel = @"btn_below_right_sel.png";
        }
    }
    
    UIButton *btn = [Info imageBtnInit:(imageName_nor) :(self) :(nil)];
    [btn setImage:UIImageGetImageFromName(imageName_sel) forState:(UIControlStateHighlighted)];
    CGFloat btn_w = btn.bounds.size.width;
    CGFloat btn_h = btn.bounds.size.height;
    [btn setCenter:CGPointMake(btn_w/2, btn_h/2)];
    
    UIView *cellView = [[[UIView alloc] init] autorelease];
    [cellView setBounds:CGRectMake(0, 0, btn_w, btn_h)];
    if (position == leftPosition) 
    {
        [cellView setCenter:CGPointMake(btn_w/2, btn_h/2)];
    }
    else if(position == rightPosition)
    {
        [cellView setCenter:CGPointMake(btn_w*3/2, btn_h/2)];
    }
    [cellView addSubview:(btn)];
    
    NSString *text = @"222";
    UILabel *lbNumber = [[UILabel alloc] init];
    [lbNumber setBackgroundColor:([UIColor clearColor])];
    [lbNumber setText:(text)];
    [lbNumber setFont:[UIFont boldSystemFontOfSize:(16)]];
    [lbNumber setTextColor:numColor];
    [lbNumber setTextAlignment:(NSTextAlignmentCenter)];
    CGSize fontSize = [text sizeWithFont:lbNumber.font];
    [lbNumber setBounds:CGRectMake(0, 0, btn_w, fontSize.height)];
    [lbNumber setCenter:CGPointMake(btn_w/2, btn_h/2 - fontSize.height/2)];
    [cellView addSubview:lbNumber];
    [lbNumber release];
    
    UILabel *lbCaption = [Info lbInitWithTextSize:(@"关注") MaxWidth:(320) FontSize:(16)];
    [lbCaption setCenter:CGPointMake(btn_w/2, btn_h/2 + fontSize.height/2)];
    if (rowIndex == 0) 
    {
        if (position == leftPosition) 
        {
            [lbCaption setText:@"关注"];
        }
        else if(position == rightPosition)
        {
            [lbCaption setText:@"微博"];
        }
    }
    else
    {
        if (position == leftPosition) 
        {
            [lbCaption setText:@"粉丝"];
        }
        else if(position == rightPosition)
        {
            [lbCaption setText:@"话题"];
        }
    }
    [cellView addSubview:lbCaption];
    
    return cellView;
}

// BackgroundImageBtn初始化
+ (UIButton*) imageBtnInitWithStr:(NSString*)imageName Text:(NSString*)text addTarget:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)] ;
   UIImage *image = [UIImageGetImageFromName(imageName) stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    if (imageName && [imageName length]) {
        if ([imageName isEqualToString:@"wb58.png"]) {
            image = UIImageGetImageFromName(imageName);
        }
        [btn setBackgroundImage:image forState:(UIControlStateNormal)];
    }
	if (image.size.height >40) {
		[btn setBounds:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
	}
	else {
		[btn setBounds:CGRectMake(0, 0, image.size.width, image.size.height)];
	}

    [btn setTitle:text forState:(UIControlStateNormal)];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 5)];
    [btn addTarget:(target) action:(action) forControlEvents:(UIControlEventTouchUpInside)];
    return btn;
}

// 返回barItem初始化
+ (UIBarButtonItem *) backItemTarget:(id)target action:(SEL)action
{
    UIBarButtonItem * barBtnItem = [self backItemTarget:target action:action normalImage:@"wb58.png" highlightedImage:nil];
    return barBtnItem;
}

+ (UIBarButtonItem*) backItemTarget:(id)target action:(SEL)action normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlighted
{
    UIButton *btn = [Info imageBtnInitWithStr:normalImage Text:@"" addTarget:target action:action];
    if ([highlighted length]) {
        [btn setImage:UIImageGetImageFromName(highlighted) forState:UIControlStateHighlighted];
    }
    btn.adjustsImageWhenHighlighted = NO;
	UIBarButtonItem *barBtnItem = [[[UIBarButtonItem alloc] initWithCustomView:(btn)] autorelease];
    return barBtnItem;
}

//特殊图片Item
+ (UIBarButtonItem*) itemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action ImageName:(NSString *)imageName{
    UIButton *btn = [Info imageBtnInitWithStr:imageName Text:title addTarget:target action:action];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIBarButtonItem *btnItem = [[[UIBarButtonItem alloc] initWithCustomView:(btn)] autorelease];
    return btnItem;
}

+ (UIBarButtonItem*) itemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action ImageName:(NSString *)imageName Size:(CGSize)size {

    return [self itemInitWithTitle:title Target:target action:action ImageName:imageName Size:size titleColor:[UIColor whiteColor]];
}

+ (UIBarButtonItem*) itemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action ImageName:(NSString *)imageName Size:(CGSize)size titleColor:(UIColor *)titleColor
{
    UIButton *btn = [Info imageBtnInitWithStr:imageName Text:title addTarget:target action:action];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    btn.adjustsImageWhenHighlighted = NO;
    UIBarButtonItem *btnItem = [[[UIBarButtonItem alloc] initWithCustomView:(btn)] autorelease];
    return btnItem;
}

// 矩形Item初始化
+ (UIBarButtonItem*) itemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action 
{
    UIButton *btn = [Info imageBtnInitWithStr:@"btn_longbtn.png" Text:title addTarget:target action:action];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [btn setBounds:CGRectMake(0, 0, 70, 30)];
    UIBarButtonItem *btnItem = [[[UIBarButtonItem alloc] initWithCustomView:(btn)] autorelease];
    return btnItem;
}
// 矩形Item初始化two
+ (UIBarButtonItem*) itemInitWithTitletwo:(NSString*)title Target:(id)target action:(SEL)action 
{
    UIButton *btn = [Info imageBtnInitWithStr:@"btn_longbtn_123.png" Text:title addTarget:target action:action];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [btn setBounds:CGRectMake(0, 0, 70, 30)];
    UIBarButtonItem *btnItem = [[[UIBarButtonItem alloc] initWithCustomView:(btn)] autorelease];
    return btnItem;
}

// 长矩形Item初始化
+ (UIBarButtonItem*) longItemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action 
{
    UIButton *btn = [Info imageBtnInitWithStr:@"btn_longbtn.png" Text:title addTarget:target action:action];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [btn setBounds:CGRectMake(0, 0, 70, 30)];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    UIBarButtonItem *btnItem = [[[UIBarButtonItem alloc] initWithCustomView:(btn)] autorelease];
    return btnItem;
}

// 刷新barItem初始化
+ (UIBarButtonItem*) refreshItemTarget:(id)target action:(SEL)action 
{
    UIBarButtonItem *barBtnItem = [Info barItemWithImage:@"refreshButton.png" addTarget:target action:action];
    return barBtnItem;
}

// 主页barItem初始化
+ (UIBarButtonItem*) homeItemTarget:(id)target action:(SEL)action 
{
    UIBarButtonItem *barBtnItem = [Info barItemWithImage:@"wb61.png" addTarget:target action:action];
    barBtnItem.customView.frame = CGRectMake(0, 0, 60, 44);
    return barBtnItem;
}

// 关系按钮
+ (UIButton*) RelButtonInit:(NSString*)title addTarget:(id)view action:(SEL)act
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setBackgroundImage:UIImageGetImageFromName(@"btn_attention_bg.png") forState:(UIControlStateNormal)];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setFrame:CGRectMake(222, 8, 85, 30)];
    [btn addTarget:view action:act forControlEvents:(UIControlEventTouchUpInside)];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    return btn;
}

// 黑名单按钮
+ (UIButton*) BlackBtnInit:(id)target action:(SEL)act
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIImage *image = UIImageGetImageFromName(@"icon_blacklist.png");
    [btn setImage:image forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(240, 367, 80, 44)];
    [btn addTarget:target action:act forControlEvents:(UIControlEventTouchUpInside)];
    
    return btn;
}

// 收藏按钮
+ (UIButton*) CollectBtnInit:(id)target imageNamed:imageName action:(SEL)act
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)] ;
    UIImage *image = UIImageGetImageFromName(imageName);
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:act forControlEvents:(UIControlEventTouchUpInside)];
    
    return btn;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    