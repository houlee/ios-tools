//
//  Info.h
//  caibo
//
//  Created by Kiefer on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define numColor [UIColor colorWithRed:50/255.0 green:79/255.0 blue:133/255.0 alpha:1.0]
#define bgColor [UIColor colorWithRed:255/255.0 green:247/255.0 blue:232/255.0 alpha:1.0]
#define bgColor2 [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

@class UserInfo;

typedef enum
{
    leftPosition,
    rightPosition
} position;

@interface Info : NSObject
{
    NSString *userId; // 用户id
    NSString *login_name;// 登录时的账号
    NSString *nickName; // 用户昵称
    NSString *password; // 密码
    UIImage *headImage; // 头像图片
    NSInteger provinceId; // 省份
    NSInteger cityId; // 城市
    NSString *mAddress; // 地址
    NSString *himId; // 他人id
    UserInfo *mUserInfo; // 我的资料
    NSString *phoneNum; // 绑定的手机号
    NSString *mailNum; // 绑定的邮箱号
	
	NSString *userName;//买彩票用户名
    
    BOOL isNeedRefreshHome; // 主页是否需要刷新
    
    NSString *cbSID;
    NSString *cbVersion;
    NSString *BundleId;//BundleId
    NSString * isbindmobile;//手机是否绑定
    NSString * authentication;//是否实名信息
    NSInteger caipaocount;
    NSMutableArray *requestArray;
    NSString * accesstoken;//加密秘钥
    
    NSString *jifen;  //积分
    NSInteger choujiangcishu;//抽奖次数
    NSString * choujiangXiaohao;//一次抽奖消耗积分
    
    NSString *headImageURL;//头像地址
    
    NSString *caijin;   //注册送彩金金额
    

    //测试用的测试地址
    NSString *testHost;
    NSString *testwapURL;
    NSString *testwap_pay;
    NSString *testRechage;
    NSString *testTixian;
    NSString *testBangdingurl;
    NSString *testipURL;
    NSString *testhost2;
    NSString *testpkweburl;
    NSString *testcheckNew;
    NSString *testbuylotter;
    NSString *testverify;
    NSString *testlicai;
    NSString *testHappy;
    
    
    
}
@property (nonatomic, retain) NSString * isbindmobile, *authentication;//手机是否绑定
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *login_name;
@property (nonatomic, retain) NSString *nickName;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) UIImage *headImage;
@property (nonatomic) NSInteger provinceId;
@property (nonatomic) NSInteger cityId;
@property (nonatomic, retain) NSString *mAddress;
@property (nonatomic, retain) NSString *himId;
@property (nonatomic, retain) UserInfo *mUserInfo;
@property (nonatomic, retain) NSString *phoneNum;
@property (nonatomic, retain) NSString *mailNum;
@property (nonatomic, assign) BOOL isNeedRefreshHome;
@property (nonatomic, retain) NSString *cbSID,*BundleId;
@property (nonatomic, retain) NSString *cbVersion;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, assign)NSInteger caipaocount;
@property (nonatomic, retain) NSMutableArray *requestArray;
@property (nonatomic, retain)NSString * accesstoken;
@property (nonatomic, retain)NSString *jifen;
@property (nonatomic, retain)NSString *headImageURL;
@property (nonatomic) NSInteger choujiangcishu;
@property (nonatomic, retain)NSString *caijin;
@property (nonatomic,retain) NSString *testlicai;
@property (nonatomic,retain) NSString *testHappy;
@property (nonatomic,copy) NSString * choujiangXiaohao;

@property (nonatomic,retain)NSString *testHost,*testwapURL,*testwap_pay,*testRechage,*testTixian,*testBangdingurl,*testipURL,*testhost2,*testpkweburl,*testcheckNew,*testbuylotter,*testverify;

//
+ (id)getInstance;
//获得文件绝对路径
+ (NSString *)getFilePath:(NSString *)fileName;
//将一个对象写入文件
+ (void)writeObject:(NSObject *)obj toFile:(NSString *)fileName;
//从文件中读一个对象
+ (NSObject *)getObject:(NSString *) fileName;

// 针对第一视频头像图片地址http头后双斜杠和不带http头的解决方案
+ (NSString*)strFormatWithUrl:(NSString*)url;

// 从地址读取图片
+ (UIImage *) imageFromURLString: (NSString *)urlstring;

/**********************************UI组件初始化*************************************/
// UILabel初始化
+ (UILabel *)lbInit: (NSString *)text : (CGFloat)fontSize;
// 根据字符串 预估组件大小
+ (CGSize)getExpectedSizeWithStr:(NSString*)text MaxWidth:(CGFloat)width FontSize:(CGFloat)fontsize;
// UILabel初始化
+ (UILabel *)lbInitWithTextSize:(NSString*)text MaxWidth:(CGFloat)maxWidth FontSize:(CGFloat)fontSize;
// UITextField初始化
+ (UITextField *)tfInit :(CGFloat)fontSize;
// ImageButton初始化
+ (UIButton *)imageBtnInit :(NSString *)imageName :(id)target :(SEL)action;
// UIImageView初始化 根据图片大小
+ (UIImageView *)imageViewInit :(NSString*)imageName;
// UIImageView初始化 根据自定义大小
+ (UIImageView *)imageViewInitSize :(NSString*)imageName :(CGSize)size;
// CheckBox初始化
+ (UIButton *)checkBoxInit :(NSString *)imageName :(NSString *)imageName_s;
// UIBarButtonItem初始化
+ (UIBarButtonItem *)barItemWithImage:(NSString*)imageName addTarget:(id)target action:(SEL)action;
// 取消对话框
+ (void)showCancelDialog:(NSString *)title :(NSString *)message :(id)delegate;
+ (void)showOkDialog:(NSString *)title :(NSString *)message :(id)delegate;
// 对话框
+ (void)showDialogWithTitle:(NSString *)title BtnTitle:(NSString*)btnTitle Msg:(NSString *)msg :(id)delegate;
//资料界面 TableViewCell
+ (UIView *)getCellView:(NSUInteger)rowIndex :(NSUInteger)position :(SEL)action;
// BackgroundImageBtn初始化
+ (UIButton *)imageBtnInitWithStr:(NSString*)imageName Text:(NSString*)text addTarget:(id)target action:(SEL)action;
// 返回barItem初始化
+ (UIBarButtonItem *)backItemTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem*) backItemTarget:(id)target action:(SEL)action normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlighted;

//特殊图片Item
+ (UIBarButtonItem*) itemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action ImageName:(NSString *)imageName;
//带大小的Item
+ (UIBarButtonItem*) itemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action ImageName:(NSString *)imageName Size:(CGSize)size;

+ (UIBarButtonItem*) itemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action ImageName:(NSString *)imageName Size:(CGSize)size titleColor:(UIColor *)titleColor;

// 矩形Item初始化
+ (UIBarButtonItem *)itemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action;
// 长矩形Item初始化
+ (UIBarButtonItem*) longItemInitWithTitle:(NSString*)title Target:(id)target action:(SEL)action;
// 刷新barItem初始化
+ (UIBarButtonItem*) refreshItemTarget:(id)target action:(SEL)action;
// 主页barItem初始化
+ (UIBarButtonItem*) homeItemTarget:(id)target action:(SEL)action;
// 关系按钮
+ (UIButton *)RelButtonInit:(NSString*)title addTarget:(id)comp action:(SEL)act;
// 黑名单按钮
+ (UIButton *)BlackBtnInit:(id)view action:(SEL)act;
// 收藏按钮
+ (UIButton*) CollectBtnInit:(id)view imageNamed:imageName action:(SEL)act;
+ (UIBarButtonItem*) itemInitWithTitletwo:(NSString*)title Target:(id)target action:(SEL)action ;

@end
