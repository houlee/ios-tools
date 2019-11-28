//
//  ReplaceBankCardsViewController.m
//  caibo
//
//  Created by cp365dev on 14-5-21.
//
//

#import "ReplaceBankCardsViewController.h"
#import "Info.h"
#import "CP_UIAlertView.h"
#import "Statement.h"
#import "User.h"
#import "DataBase.h"
#import "ASIHTTPRequest.h"
#import "GC_UserInfo.h"
#import "GC_HttpService.h"
#import "SelfHelpView.h"
#import "NetURL.h"
#import "JSON.h"
#import "CP_HiddenAlertView.h"
#import "UIImage+Additions.m"
@interface ReplaceBankCardsViewController ()
{
    UITapGestureRecognizer *_tapGestureRec;

}
@end

@implementation ReplaceBankCardsViewController
@synthesize request;
@synthesize mReqData;
@synthesize mNickName;
@synthesize mBankIdCard;
@synthesize mBankName;
@synthesize password;
@synthesize reqUserInfo;
@synthesize mTrueName;
@synthesize mUserIdCard;
@synthesize mBankAddress;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//请求用户信息
-(void)loadUserInfo
{
    NSString * type;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
        type = @"0";
    }else{
        type = @"1";
    }
    
    NSString * passwstr = @"";
    if(self.password){
        passwstr = self.password;
        
    }
    NSLog(@"url = %@", [NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]);
    self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]];
    [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished:)];
    [reqUserInfo setDelegate:self];
    [reqUserInfo startAsynchronous];
}




-(void)reqUserInfoFinished:(ASIHTTPRequest *)requests
{
    NSLog(@"requests.responseString : %@",requests.responseString);
    NSString *responseString = requests.responseString;
    NSDictionary *result = [responseString JSONValue];
    if(responseString && ![responseString isEqualToString:@"fail"])
    {
        self.mNickName = [result objectForKey:@"nick_name"];
        self.mBankIdCard = [result objectForKey:@"bankNo"];
        self.mBankName = [result objectForKey:@"bankName"];
        self.mTrueName = [result objectForKey:@"true_name"];
        self.mUserIdCard = [result objectForKey:@"user_id_card"];
        self.mBankAddress = [result objectForKey:@"bank_address"];


        NSMutableString *name = [NSMutableString stringWithString:self.mTrueName];
        if (name != nil && name.length >= 2) {
            NSRange rang = NSMakeRange(1, name.length-1);
            [name replaceCharactersInRange:rang withString:@"**"];
        }
        
        NSMutableString *idcard = [NSMutableString stringWithString:self.mUserIdCard];
        if (idcard != nil && idcard.length > 6) {
            NSRange rang1 = NSMakeRange(2, idcard.length-6);
            [idcard replaceCharactersInRange:rang1 withString:@"************"];
        }
        NSMutableString *bankidcard = nil;
        if(self.mBankIdCard != nil) {
            bankidcard = [NSMutableString stringWithString:self.mBankIdCard];
            if (bankidcard != nil && bankidcard.length > 6) {
                
                NSRange rang2 = NSMakeRange(2, bankidcard.length-6);
                [bankidcard replaceCharactersInRange:rang2 withString:@"************"];
            }

        } else {
            bankidcard = [NSMutableString stringWithString:@""];
        }
        
        
        userName.text= self.mNickName;
        
        truenameLabel.text = [NSString stringWithFormat:@"姓          名        %@",name];

        oldUserCardidLabel.text = [NSString stringWithFormat:@"身 份 证 号        %@",idcard];

        oldBankidLabel.text = bankidcard;
        
        oldBankaddressLabel.text = self.mBankAddress;
        
//        oldBankaddressLabel.text = @"中国工商银行支行";


//        NSMutableString *mutableBankMessage = nil;
//        if(![self.mBankIdCard isEqualToString:@"(null)"] && self.mBankIdCard != nil && self.mBankIdCard.length >4)
//        {
//            mutableBankMessage = [NSMutableString stringWithString:self.mBankIdCard];
//            [mutableBankMessage replaceCharactersInRange:NSMakeRange(0, self.mBankIdCard.length-4) withString:@"尾号为"];
//        }
//        
//        if([self.mBankName isEqualToString:@"(null)"] || self.mBankName== nil || self.mBankName.length == 0)
//            self.mBankName = @"";
//        phonemessage.text = [NSString stringWithFormat:@"更换银行卡 %@ %@(现绑定),请按以下步骤操作",mutableBankMessage,self.mBankName];


    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    self.CP_navigation.titleLabel.text = @"更换银行卡";

    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    // backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.frame = CGRectMake(0, 44, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor clearColor];
    [backImage release];
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height)];
    myScrollView.userInteractionEnabled = YES;
    [myScrollView setContentSize:CGSizeMake(320, 900)];
    if (myScrollView.contentSize.height < myScrollView.bounds.size.height) {
        myScrollView.scrollEnabled = NO;
    }
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    _tapGestureRec.enabled = NO;
    [myScrollView addGestureRecognizer:_tapGestureRec];
    [_tapGestureRec release];
    
    //用户名
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 50, 17)];
    userNameLabel.text = @"用户名";
    userNameLabel.backgroundColor = [UIColor clearColor];
    userNameLabel.font = [UIFont systemFontOfSize:14];
    [myScrollView addSubview:userNameLabel];
    [userNameLabel release];
    
    userName = [[UILabel alloc] initWithFrame:CGRectMake(65, 17, 320-65, 17)];
    userName.text= @"- -";
    userName.backgroundColor = [UIColor clearColor];
    userName.font = [UIFont systemFontOfSize:14];
    [myScrollView addSubview:userName];
    [userName release];
    
    
    //线
    UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(userName)+9, 300, 1)];
    [xian1 setImage:UIImageGetImageFromName(@"wf_xian2.png")];
    [myScrollView addSubview:xian1];
    [xian1 release];
    
    truenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(xian1)+10, 300, 12)];
    truenameLabel.text = @"姓          名        - -";
    truenameLabel.backgroundColor = [UIColor clearColor];
    truenameLabel.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    truenameLabel.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:truenameLabel];
    [truenameLabel release];
    
    oldUserCardidLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(truenameLabel)+10, 300, 12)];
    oldUserCardidLabel.text = @"身 份 证 号        ";
    oldUserCardidLabel.backgroundColor = [UIColor clearColor];
    oldUserCardidLabel.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    oldUserCardidLabel.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:oldUserCardidLabel];
    [oldUserCardidLabel release];
    
    
    UILabel *oldbankcard = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(oldUserCardidLabel)+15, 80, 12)];
    oldbankcard.backgroundColor = [UIColor clearColor];
    oldbankcard.text = @"原银行卡号";
    oldbankcard.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    oldbankcard.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:oldbankcard];
    [oldbankcard release];
    
    oldBankidLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(oldbankcard)+10, ORIGIN_Y(oldUserCardidLabel)+15, 200, 12)];
    oldBankidLabel.text = @"- -";
    oldBankidLabel.backgroundColor = [UIColor clearColor];
    oldBankidLabel.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    oldBankidLabel.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:oldBankidLabel];
    [oldBankidLabel release];
    
    
    UILabel *oldbankaddress = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(oldbankcard)+15, 80, 12)];
    oldbankaddress.backgroundColor = [UIColor clearColor];
    oldbankaddress.text = @"原开户行地址";
    oldbankaddress.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    oldbankaddress.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:oldbankaddress];
    [oldbankaddress release];
    
    oldBankaddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(oldbankaddress)+10, ORIGIN_Y(oldBankidLabel)+15, 200, 12)];
    oldBankaddressLabel.text = @"- -";
    oldBankaddressLabel.backgroundColor = [UIColor clearColor];
    oldBankaddressLabel.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    oldBankaddressLabel.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:oldBankaddressLabel];
    [oldBankaddressLabel release];
    
    
    UILabel *newbankid = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(oldBankaddressLabel)+15, 80, 33)];
    newbankid.text = @"新银行卡号";
    newbankid.backgroundColor = [UIColor clearColor];
    newbankid.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    newbankid.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:newbankid];
    [newbankid release];
    
    
    UIImageView * kuangimage = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(newbankid)+15, ORIGIN_Y(oldBankaddressLabel) + 15, 190, 33)];
    kuangimage.backgroundColor = [UIColor clearColor];
    kuangimage.userInteractionEnabled = YES;
    kuangimage.image = [UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [myScrollView addSubview:kuangimage];
    [kuangimage release];
    
    newBankIdField = [[UITextField alloc] initWithFrame:CGRectMake(3, 10, 187, 13)];
    newBankIdField.placeholder = @"请输入";
    newBankIdField.delegate = self;
    newBankIdField.keyboardType = UIKeyboardTypeNumberPad;
    newBankIdField.font = [UIFont systemFontOfSize:12];
    newBankIdField.backgroundColor = [UIColor clearColor];
    [kuangimage addSubview:newBankIdField];
    [newBankIdField release];
    
    
    UILabel *newbankaddres = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(newbankid)+15, 80, 33)];
    newbankaddres.text = @"新开户行地址";
    newbankaddres.backgroundColor = [UIColor clearColor];
    newbankaddres.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1];
    newbankaddres.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:newbankaddres];
    [newbankaddres release];
    
    UIImageView * kuangimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(newbankaddres)+15, ORIGIN_Y(kuangimage) + 15, 190, 33)];
    kuangimage1.backgroundColor = [UIColor clearColor];
    kuangimage1.userInteractionEnabled = YES;
    kuangimage1.image = [UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [myScrollView addSubview:kuangimage1];
    [kuangimage1 release];
    
    newBankAddressField = [[UITextField alloc] initWithFrame:CGRectMake(3 , 10, 187, 13)];
    newBankAddressField.placeholder = @"请输入";
    newBankAddressField.delegate = self;
    newBankAddressField.font = [UIFont systemFontOfSize:12];
    newBankAddressField.backgroundColor = [UIColor clearColor];
    [kuangimage1 addSubview:newBankAddressField];
    [newBankAddressField release];
    
    
    UIButton *mesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mesBtn setFrame:CGRectMake(140, ORIGIN_Y(kuangimage1)+6, 160, 24)];
    [mesBtn addTarget:self action:@selector(showPhoneList:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:mesBtn];
    
    UILabel *meslabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 24)];
    meslabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    meslabel.text = @"提示: 请详细到支行地址";
    meslabel.textAlignment = NSTextAlignmentRight;
    meslabel.backgroundColor = [UIColor clearColor];
    meslabel.font = [UIFont systemFontOfSize:12];
    [mesBtn addSubview:meslabel];
    [meslabel release];
    
    UIImageView *mesImg = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(meslabel)+6, 0, 24, 24)];
    mesImg.backgroundColor = [UIColor clearColor];
    mesImg.image = UIImageGetImageFromName(@"replaceBankCard_ques.png");
    [mesBtn addSubview:mesImg];
    [mesImg release];
    
    
    UILabel *meslabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(mesBtn)+20, 200, 12)];
    meslabel1.backgroundColor = [UIColor clearColor];
    meslabel1.text =@"请按以下步骤操作";
    meslabel1.font = [UIFont systemFontOfSize:12];
    meslabel1.textColor = [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
    [myScrollView addSubview:meslabel1];
    [meslabel1 release];
    
    
    
    
    //①标号
    UIImageView *markTag = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(meslabel1)+20, 22, 22)];
    [markTag setImage:UIImageGetImageFromName(@"shuzi-tiaomu480_1.png")];
    [myScrollView addSubview:markTag];
    [markTag release];
    UILabel *markTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
    markTagLabel.text=@"1";
    markTagLabel.backgroundColor = [UIColor clearColor];
    markTagLabel.font = [UIFont systemFontOfSize:10];
    markTagLabel.textAlignment = NSTextAlignmentCenter;
    markTagLabel.textColor=[UIColor whiteColor];
    [markTag addSubview:markTagLabel];
    [markTagLabel release];
    
    //请上传
    UILabel *pleaseUpload = [[UILabel alloc] initWithFrame:CGRectMake(42,ORIGIN_Y(meslabel1)+20 , 320-42, 22)];
    pleaseUpload.text = @"请上传您的身份证正反面照片";
    pleaseUpload.backgroundColor = [UIColor clearColor];
    pleaseUpload.font = [UIFont systemFontOfSize:14];
    [myScrollView addSubview:pleaseUpload];
    [pleaseUpload release];
    
    //上传View
    selfHelp = [[SelfHelpView alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(markTag)+10, 320-40-21, 393) andTitle1:@"上传身份证正面照片" title2:@"上传身份证背面照片"];
    [myScrollView addSubview:selfHelp];
    [selfHelp release];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setFrame:CGRectMake(112, 97, 35, 35)];
    addBtn.tag = 101;
    [addBtn setImage:UIImageGetImageFromName(@"selfhelp_addBtn.png") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [selfHelp addSubview:addBtn];
    
    UIButton *addBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn1 setFrame:CGRectMake(112, 281, 35, 35)];
    addBtn1.tag = 102;
    [addBtn1 setImage:UIImageGetImageFromName(@"selfhelp_addBtn.png") forState:UIControlStateNormal];
    [addBtn1 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [selfHelp addSubview:addBtn1];
    
    //竖线
    UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, ORIGIN_Y(markTag)+10, 1, 393)];
    [xian2 setImage:UIImageGetImageFromName(@"wf_xian.png")];
    [myScrollView addSubview:xian2];
    [xian2 release];
    
//    //②标号
//    UIImageView *markTag2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(xian2)+20, 22, 22)];
//    [markTag2 setImage:UIImageGetImageFromName(@"shuzi-tiaomu480_1.png")];
//    [myScrollView addSubview:markTag2];
//    [markTag2 release];
//    UILabel *markTagLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
//    markTagLabel2.text=@"2";
//    markTagLabel2.backgroundColor = [UIColor clearColor];
//    markTagLabel2.font = [UIFont systemFontOfSize:10];
//    markTagLabel2.textAlignment = NSTextAlignmentCenter;
//    markTagLabel2.textColor=[UIColor whiteColor];
//    [markTag2 addSubview:markTagLabel2];
//    [markTagLabel2 release];
//    
//    UILabel *markTag2Label = [[UILabel alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(selfHelp)+20, 280, 17)];
//    markTag2Label.backgroundColor = [UIColor clearColor];
//    [markTag2Label setText:@"请上传您现绑定的银行卡正反面照片"];
//    [markTag2Label setFont:[UIFont systemFontOfSize:14]];
//    [myScrollView addSubview:markTag2Label];
//    [markTag2Label release];
//    
//    selfHelp2 = [[SelfHelpView alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(markTag2)+10, 320-40-21, 393) andTitle1:@"上传现绑定的银行卡正面照片" title2:@"上传现绑定的银行卡背面照片"];
//    [myScrollView addSubview:selfHelp2];
//    [selfHelp2 release];
//    
//    UIButton *addBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn2 setFrame:CGRectMake(112, 97, 35, 35)];
//    addBtn2.tag = 103;
//    [addBtn2 setImage:UIImageGetImageFromName(@"selfhelp_addBtn.png") forState:UIControlStateNormal];
//    [addBtn2 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
//    [selfHelp2 addSubview:addBtn2];
//    
//    UIButton *addBtn21 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn21 setFrame:CGRectMake(112, 281, 35, 35)];
//    addBtn21.tag = 104;
//    [addBtn21 setImage:UIImageGetImageFromName(@"selfhelp_addBtn.png") forState:UIControlStateNormal];
//    [addBtn21 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
//    [selfHelp2 addSubview:addBtn21];
//    
//    UIImageView *xian3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, ORIGIN_Y(markTag2)+10, 1, 393)];
//    [xian3 setImage:UIImageGetImageFromName(@"wf_xian.png")];
//    [myScrollView addSubview:xian3];
//    [xian3 release];
//    
//    //③标号
//    UIImageView *markTag3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(xian3)+20, 22, 22)];
//    [markTag3 setImage:UIImageGetImageFromName(@"shuzi-tiaomu480_1.png")];
//    [myScrollView addSubview:markTag3];
//    [markTag3 release];
//    UILabel *markTagLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
//    markTagLabel3.text=@"3";
//    markTagLabel3.backgroundColor = [UIColor clearColor];
//    markTagLabel3.font = [UIFont systemFontOfSize:10];
//    markTagLabel3.textAlignment = NSTextAlignmentCenter;
//    markTagLabel3.textColor=[UIColor whiteColor];
//    [markTag3 addSubview:markTagLabel3];
//    [markTagLabel3 release];
//    
//    //提交Label
//    UILabel *markTag3Label = [[UILabel alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(selfHelp2)+20, 280, 17)];
//    markTag3Label.text = @"请上传您要更换的银行卡正反面照片";
//    markTag3Label.backgroundColor = [UIColor clearColor];
//    markTag3Label.font = [UIFont systemFontOfSize:14];
//    [myScrollView addSubview:markTag3Label];
//    [markTag3Label release];
//    
//    
//    selfHelp3 = [[SelfHelpView alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(markTag3)+10, 320-40-21, 393) andTitle1:@"上传要更换的银行卡正面照片" title2:@"上传要更换的银行卡背面照片"];
//    [myScrollView addSubview:selfHelp3];
//    [selfHelp3 release];
//    
//    UIButton *addBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn3 setFrame:CGRectMake(112, 97, 35, 35)];
//    addBtn3.tag = 105;
//    [addBtn3 setImage:UIImageGetImageFromName(@"selfhelp_addBtn.png") forState:UIControlStateNormal];
//    [addBtn3 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
//    [selfHelp3 addSubview:addBtn3];
//    
//    UIButton *addBtn31 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn31 setFrame:CGRectMake(112, 281, 35, 35)];
//    addBtn31.tag = 106;
//    [addBtn31 setImage:UIImageGetImageFromName(@"selfhelp_addBtn.png") forState:UIControlStateNormal];
//    [addBtn31 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
//    [selfHelp3 addSubview:addBtn31];
//    
//    UIImageView *xian4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, ORIGIN_Y(markTag3)+10, 1, 393)];
//    [xian4 setImage:UIImageGetImageFromName(@"wf_xian.png")];
//    [myScrollView addSubview:xian4];
//    [xian4 release];
    
    
    //④标号
    UIImageView *markTag4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(xian2)+20, 22, 22)];
    [markTag4 setImage:UIImageGetImageFromName(@"shuzi-tiaomu480_1.png")];
    [myScrollView addSubview:markTag4];
    [markTag4 release];
    UILabel *markTagLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
    markTagLabel4.text=@"4";
    markTagLabel4.backgroundColor = [UIColor clearColor];
    markTagLabel4.font = [UIFont systemFontOfSize:10];
    markTagLabel4.textAlignment = NSTextAlignmentCenter;
    markTagLabel4.textColor=[UIColor whiteColor];
    [markTag4 addSubview:markTagLabel4];
    [markTagLabel4 release];
    
    //提交Label
    UILabel *tijiao = [[UILabel alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(selfHelp)+20, 280, 17)];
    tijiao.text = @"提交信息";
    tijiao.backgroundColor = [UIColor clearColor];
    tijiao.font = [UIFont systemFontOfSize:14];
    [myScrollView addSubview:tijiao];
    [tijiao release];
    
    //提交Btn
    tijiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tijiaoBtn setFrame:CGRectMake(40, ORIGIN_Y(tijiao)+20, 320-40-21, 40)];
    [tijiaoBtn setTitle:@"提交" forState:UIControlStateNormal];
    [tijiaoBtn setEnabled:NO];
    [tijiaoBtn setTitleColor:[UIColor colorWithRed:175/255.0 green:170/255.0 blue:164/255.0 alpha:1] forState:UIControlStateNormal];
    [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [tijiaoBtn addTarget:self action:@selector(subMitPic) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:tijiaoBtn];

    
    
    picImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 39, 241, 151)];
    [selfHelp addSubview:picImageView1];
    [picImageView1 release];
    
    delBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn1 setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
    [delBtn1 addTarget:self action:@selector(removePic:) forControlEvents:UIControlEventTouchUpInside];
    [delBtn1 setHidden:YES];
    [delBtn1 setTag:51];
    [delBtn1 setFrame:CGRectMake(229, 24, 30, 30)];
    [selfHelp addSubview:delBtn1];
    
    
    picImageView11 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 229, 241, 151)];
    [selfHelp addSubview:picImageView11];
    [picImageView11 release];
    
    delBtn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn11 setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
    [delBtn11 addTarget:self action:@selector(removePic:) forControlEvents:UIControlEventTouchUpInside];
    [delBtn11 setHidden:YES];
    [delBtn11 setTag:52];
    [delBtn11 setFrame:CGRectMake(229, 218, 30, 30)];
    [selfHelp addSubview:delBtn11];
    
    
//    picImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 39, 241, 151)];
//    [selfHelp2 addSubview:picImageView2];
//    [picImageView2 release];
//    
//    delBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [delBtn2 setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
//    [delBtn2 addTarget:self action:@selector(removePic:) forControlEvents:UIControlEventTouchUpInside];
//    [delBtn2 setHidden:YES];
//    [delBtn2 setTag:53];
//    [delBtn2 setFrame:CGRectMake(229, 24, 30, 30)];
//    [selfHelp2 addSubview:delBtn2];
//    
//    
//    picImageView22 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 229, 241, 151)];
//    [selfHelp2 addSubview:picImageView22];
//    [picImageView22 release];
//    
//    delBtn22 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [delBtn22 setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
//    [delBtn22 addTarget:self action:@selector(removePic:) forControlEvents:UIControlEventTouchUpInside];
//    [delBtn22 setHidden:YES];
//    [delBtn22 setTag:54];
//    [delBtn22 setFrame:CGRectMake(229, 218, 30, 30)];
//    [selfHelp2 addSubview:delBtn22];
//
//    
//    picImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 39, 241, 151)];
//    [selfHelp3 addSubview:picImageView3];
//    [picImageView3 release];
//    
//    delBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [delBtn3 setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
//    [delBtn3 addTarget:self action:@selector(removePic:) forControlEvents:UIControlEventTouchUpInside];
//    [delBtn3 setHidden:YES];
//    [delBtn3 setTag:55];
//    [delBtn3 setFrame:CGRectMake(229, 24, 30, 30)];
//    [selfHelp3 addSubview:delBtn3];
//    
//    
//    picImageView33 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 229, 241, 151)];
//    [selfHelp3 addSubview:picImageView33];
//    [picImageView33 release];
//    
//    delBtn33 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [delBtn33 setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
//    [delBtn33 addTarget:self action:@selector(removePic:) forControlEvents:UIControlEventTouchUpInside];
//    [delBtn33 setHidden:YES];
//    [delBtn33 setTag:56];
//    [delBtn33 setFrame:CGRectMake(229, 218, 30, 30)];
//    [selfHelp3 addSubview:delBtn33];
    
    [self loadUserInfo];

}


-(void)showPhoneList:(UIButton *)sender
{

    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"银行电话" message:@"招商银行 95555   中国银行 95566\n建设银行 95533   工商银行 95588\n中信银行 95558   农业银行 95599\n民生银行 95568   光大银行 95595\n交通银行 95559   广发银行 95508\n浦发银行 95528   华夏银行 95577\n兴业银行 95561" delegate:self cancelButtonTitle:nil otherButtonTitles:@"关闭",nil];
    alert.alertTpye = explainType;
    alert.delegate = self;
    [alert show];
    [alert release];
}
-(void)closeKeyBoard
{
    _tapGestureRec.enabled = NO;
    
    [newBankIdField resignFirstResponder];
    
    [newBankAddressField resignFirstResponder];
    
    
    if(picImageView1.image != nil && picImageView11.image !=nil && newBankIdField.text.length && newBankAddressField.text.length)
    {
        tijiaoBtn.enabled = YES;
        [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"anniu-shangchuanyangshi480_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];

        [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
	[textField resignFirstResponder];
    
    if(picImageView1.image != nil && picImageView11.image !=nil && newBankIdField.text.length &&  newBankAddressField.text.length)
    {
        tijiaoBtn.enabled = YES;
        [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"anniu-shangchuanyangshi480_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];

        [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
	return YES;
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _tapGestureRec.enabled = YES;
    
    return YES;
}


//返回
-(void)doBack
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//注销
- (void)exitLogin{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您是否退出登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 100;
    [alert show];
    [alert release];
    
}
//添加照片
-(void)addPic:(UIButton *)sender
{
    NSLog(@"添加照片");
    CP_Actionsheet *sheet = [[CP_Actionsheet alloc] initWithType:ordinaryActionsheetType Title:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    sheet.tag =sender.tag + 10;
    sheet.delegate = self;
    [self.mainView addSubview:sheet];
    [sheet release];
    
}
//提交
-(void)subMitPic
{
    NSLog(@"提交");
    [delBtn1 setHidden:YES];
    [delBtn11 setHidden:YES];
    [delBtn2 setHidden:YES];
    [delBtn22 setHidden:YES];
    [delBtn3 setHidden:YES];
    [delBtn33 setHidden:YES];
    [tijiaoBtn setEnabled:NO];
    [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [tijiaoBtn setTitleColor:[UIColor colorWithRed:175/255.0 green:170/255.0 blue:164/255.0 alpha:1] forState:UIControlStateNormal];
    
    [selfHelp showUpLoadSlider];
    [selfHelp2 showUpLoadSlider];
    [selfHelp3 showUpLoadSlider];
    
    [self sendRequestImgeUrl:nil withTitle:[NSString stringWithFormat:@"用户名 %@",self.mNickName] andUserInfo:@"selfhelp_username"];
    
}
//图片上传
- (void)uploadHeadImage:(NSData*)imageData andUserInfo:(NSString *)userinfo
{
    NSString *urlString = @"http://t.diyicai.com/servlet/UploadGroupPic";
    
    NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] init];
    [request2 setURL:[NSURL URLWithString:urlString]];
    [request2 setHTTPMethod:@"POST"];
    //
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request2 addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"vim_go.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request2 setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
    NSString *result = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    if (!result) {
        return;
    }
    if([userinfo isEqualToString:@"selectedImage1"])
    {
        [selfHelp refreshUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"身份证正面照片" andUserInfo:@"selfhelp_sfzZhengm"];
    }
    //上传图片"身份证背面照片"回调
    if([userinfo isEqualToString:@"selectedImage11"])
    {
        [selfHelp refreshBelowUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"身份证背面照片" andUserInfo:@"selfhelp_sfzBeim"];
        
    }
    //上传图片"现绑定的银行卡正面照片"回调
    if([userinfo isEqualToString:@"selectedImage2"])
    {
        [selfHelp2 refreshUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"现绑定的银行卡正面照片" andUserInfo:@"selfhelp_nowyhkZhengm"];
        
    }
    //上传图片"现绑定的银行卡背面照片"回调
    if([userinfo isEqualToString:@"selectedImage22"])
    {
        [selfHelp2 refreshBelowUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"现绑定的银行卡背面照片" andUserInfo:@"selfhelp_nowyhkBeim"];
        
    }
    //上传图片"要更换的银行卡正面照片"回调
    if([userinfo isEqualToString:@"selectedImage3"])
    {
        [selfHelp3 refreshUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"要更换的银行卡正面照片" andUserInfo:@"selfhelp_replaceyhkzZhengm"];
        
    }
    //上传图片"要更换的银行卡背面照片"回调
    if([userinfo isEqualToString:@"selectedImage33"])
    {
        [selfHelp3 refreshBelowUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"要更换的银行卡背面照片" andUserInfo:@"selfhelp_replaceyhkzBeim"];
        
    }
//    image1DataLength = imageData.length;
//
//    NSURL *serverURL = [NSURL URLWithString:@"http://t.diyicai.com/servlet/UploadGroupPic"];
//    
//    [mReqData clearDelegatesAndCancel];
//    self.mReqData = [ASIFormDataRequest requestWithURL:serverURL];
//    [mReqData addData:imageData withFileName:@"george.jpg" andContentType:@"image/jpeg" forKey:@"photos"];
//    [mReqData setUsername:@"upload"];
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:userinfo forKey:@"imageUpload_Title"];
//    [mReqData setUserInfo:dic];
//    [mReqData setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [mReqData setTimeOutSeconds:20];
//    //    [mReqData setDidFinishSelector:@selector(uploadFinish:)];
//    [mReqData setDelegate:self];
//    [mReqData setUploadProgressDelegate:self];
//    [mReqData startAsynchronous];
    
}
//获取上传字节数
-(void)request:(ASIHTTPRequest *)requests didSendBytes:(long long)bytes
{
    NSLog(@"%@",requests.userInfo);
    NSLog(@"字节数 %f",image1DataLength);
    NSLog(@"已上传 %lld",bytes);
    
//    bytes = bytes>image1DataLength?image1DataLength:bytes;
    
//    float baifenbi = bytes/image1DataLength;
    
    if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage1"])
    {
        [selfHelp refreshUploadSlider:0.8];
    }
    if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage11"])
    {
        [selfHelp refreshBelowUploadSlider:0.8];
    }
    if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage2"])
    {
        [selfHelp2 refreshUploadSlider:0.8];
    }
    if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage22"])
    {
        [selfHelp2 refreshBelowUploadSlider:0.8];
    }

    if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage3"])
    {
        [selfHelp3 refreshUploadSlider:0.8];
    }
    if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage33"])
    {
        [selfHelp3 refreshBelowUploadSlider:0.8];
    }

}
#pragma mark -
#pragma mark ASIFormDataRequest

-(void)requestFinished:(ASIHTTPRequest *)requests
{
    NSString *result = requests.responseString;
    
    if([requests.username isEqualToString:@"upload"])
    {
        if(!result)
            return;
        //上传图片"身份证正面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage1"])
        {
            [selfHelp refreshUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"身份证正面照片" andUserInfo:@"selfhelp_sfzZhengm"];
        }
        //上传图片"身份证背面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage11"])
        {
            [selfHelp refreshBelowUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"身份证背面照片" andUserInfo:@"selfhelp_sfzBeim"];
            
        }
        //上传图片"现绑定的银行卡正面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage2"])
        {
            [selfHelp2 refreshUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"现绑定的银行卡正面照片" andUserInfo:@"selfhelp_nowyhkZhengm"];
            
        }
        //上传图片"现绑定的银行卡背面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage22"])
        {
            [selfHelp2 refreshBelowUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"现绑定的银行卡背面照片" andUserInfo:@"selfhelp_nowyhkBeim"];
            
        }
        //上传图片"要更换的银行卡正面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage3"])
        {
            [selfHelp3 refreshUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"要更换的银行卡正面照片" andUserInfo:@"selfhelp_replaceyhkzZhengm"];
            
        }
        //上传图片"要更换的银行卡背面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage33"])
        {
            [selfHelp3 refreshBelowUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"要更换的银行卡背面照片" andUserInfo:@"selfhelp_replaceyhkzBeim"];
            
        }
        
    }
}



-(void)requestFailed:(ASIHTTPRequest *)requests
{
    NSLog(@"requestFailed: %@",requests.username);
    
    CP_HiddenAlertView *alert = [[CP_HiddenAlertView alloc] initWithTitle:@"提交失败" delegate:self andTitleImage:@"selfhelp_submitFail.png" andMessage:@"您提交的资料可能由于网络原因提交失败\n请您重新提交" andEndMessage:@"如有疑问请拨打客服电话: QQ：3254056760"];
    [alert showAndHiddenAfter:5 isBack:NO];
    [alert release];
    
    [selfHelp removeSliderFromSuperView];
    [selfHelp2 removeSliderFromSuperView];
    [selfHelp3 removeSliderFromSuperView];
    [delBtn1 setHidden:NO];
    [delBtn2 setHidden:NO];
    [delBtn11 setHidden:NO];
    [delBtn22 setHidden:NO];
    [delBtn3 setHidden:NO];
    [delBtn33 setHidden:NO];

    
    tijiaoBtn.enabled = YES;
    [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"anniu-shangchuanyangshi480_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];

    [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//客服私信图片后 + 文字
-(void)sendRequestImgeUrl:(NSString *)imageUrl withTitle:(NSString *)title andUserInfo:(NSString *)userinfo
{
    [request clearDelegatesAndCancel];
    
	//@"965912"
	[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsendMail:[[Info getInstance] userId] taUserId:@"965912" content:title imageUrl:imageUrl]]];
	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:userinfo forKey:@"TextUpload_Title"];
    [request setUserInfo:dic];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(addAdPicViewSuc:)];
    [request setTimeOutSeconds:20];
	[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];// 异步获取
}

#pragma mark -
#pragma mark ASIHttpRequest

- (void)addAdPicViewSuc:(ASIHTTPRequest *)mrequrt{
    
    
    NSString *result = [mrequrt responseString];
    if (result) {
        
        NSDictionary * dict = [result JSONValue];
        if ([[dict objectForKey:@"result"] isEqualToString:@"succ"])
        {
            //上传用户名(第一项)回调
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_username"])
            {
                [self uploadHeadImage:UIImageJPEGRepresentation(selectedImage1, 1.0) andUserInfo:@"selectedImage1"];
            }
            //身份证正面照片(文字)回调
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_sfzZhengm"])
            {
                [self uploadHeadImage:UIImageJPEGRepresentation(selectedImage11, 1.0) andUserInfo:@"selectedImage11"];
                
            }
            //身份证背面照片(文字)回调
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_sfzBeim"])
            {
                [self sendRequestImgeUrl:nil withTitle:[NSString stringWithFormat:@"用户名  %@  申请更换银行卡 %@ (%@)",self.mNickName,self.mBankIdCard,self.mBankName] andUserInfo:@"selfhelp_allMessage"];
                
            }
//            //现绑定的银行卡正面照片(文字)回调
//            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_nowyhkZhengm"])
//            {
//                [self uploadHeadImage:UIImageJPEGRepresentation(selectedImage22, 1.0) andUserInfo:@"selectedImage22"];
//                
//            }
//            //现绑定的银行卡背面照片(文字)回调
//            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_nowyhkBeim"])
//            {
//                [self uploadHeadImage:UIImageJPEGRepresentation(selectedImage3, 1.0) andUserInfo:@"selectedImage3"];
//
//            }
//            //要更换的银行卡正面(文字)回调
//            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_replaceyhkzZhengm"])
//            {
//                [self uploadHeadImage:UIImageJPEGRepresentation(selectedImage33, 1.0) andUserInfo:@"selectedImage33"];
//
//            }
//            //要更换的银行卡背面(文字)回调
//            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_replaceyhkzBeim"])
//            {
//                [self sendRequestImgeUrl:nil withTitle:[NSString stringWithFormat:@"用户名  %@  申请更换银行卡 %@ (%@)",self.mNickName,self.mBankIdCard,self.mBankName] andUserInfo:@"selfhelp_allMessage"];
// 
//            }
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_allMessage"])
            {
                
                [self sendRequestImgeUrl:nil withTitle:[NSString stringWithFormat:@"新银行卡号 %@,新开户行地址 %@",newBankIdField.text,newBankAddressField.text] andUserInfo:@"selfhelp_endMessage"];

            }
            //最下面说明(文字)回调
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_endMessage"])
            {
                NSLog(@"全部上传成功");
                
                CP_HiddenAlertView *alert = [[CP_HiddenAlertView alloc] initWithTitle:@"提交成功" delegate:self andTitleImage:@"selfhelp_submitSucc.png" andMessage:@"您的资料已经提交成功\n我们将在半小时之内给您答复" andEndMessage:@"如有疑问请拨打客服电话: QQ：3254056760"];
                [alert showAndHiddenAfter:5 isBack:YES];
                [alert release];
                
            }
            
        }
        else
        {

            CP_HiddenAlertView *alert = [[CP_HiddenAlertView alloc] initWithTitle:@"提交失败" delegate:self andTitleImage:@"selfhelp_submitFail.png" andMessage:@"您提交的资料可能由于网络原因提交失败\n请您重新提交" andEndMessage:@"如有疑问请拨打客服电话: QQ：3254056760"];
            [alert showAndHiddenAfter:5 isBack:NO];
            [alert release];
            
            [selfHelp removeSliderFromSuperView];
            [selfHelp2 removeSliderFromSuperView];
            [selfHelp3 removeSliderFromSuperView];
            [delBtn1 setHidden:NO];
            [delBtn2 setHidden:NO];
            [delBtn11 setHidden:NO];
            [delBtn22 setHidden:NO];
            [delBtn3 setHidden:NO];
            [delBtn33 setHidden:NO];
            
            tijiaoBtn.enabled = YES;
            [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"anniu-shangchuanyangshi480_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];

            [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    
    
}

#pragma mark -
#pragma mark CP_UIAlertView Delegate

-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (alertView.tag == 100)
        {// 直接注销此账号，跳转到登录界面
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isAlipay"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tuisongshezhi"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cheknewpush"];
            
            //[[NSUserDefaults standardUserDefaults] setValue:st forKey:@"logincp"];
            Statement *stmt =  [DataBase statementWithQuery:"SELECT * FROM users"];
            int count = 0;
            while ([stmt step] == SQLITE_ROW) {
                count++;
            }
            [stmt reset];
            for (int i = 0; i < count; i++) {
                User *user = [User getLastUser];
                [User deleteFromDB:user.user_id];
                
            }
            NSLog(@"%@",[[[Info getInstance]mUserInfo] nick_name]);
            Info *info = [Info getInstance];
            info.login_name = @"";
            info.userId = @"";
            info.nickName = @"";
            info.userName = @"";
            info.isbindmobile = @"";
            info.authentication = @"";
            info.userName = @"";
            info.requestArray = nil;
            info.mUserInfo = nil;
            [ASIHTTPRequest setSessionCookies:nil];
            //[[NSUserDefaults standardUserDefaults] setValue:[[[Info getInstance]mUserInfo] nick_name] forKey:@"LogInname"];
            [[Info getInstance] setMUserInfo:nil];
            [ASIHTTPRequest clearSession];
            [GC_UserInfo sharedInstance].personalData = nil;
            [GC_HttpService sharedInstance].sessionId = nil;
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
            [GC_UserInfo sharedInstance].accountManage = nil;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    
}
#pragma mark -
#pragma mark - UIActionSheet Delegate

-(void)CP_Actionsheet:(CP_Actionsheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //判断是否有摄像头
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if(actionSheet.tag == 111 || actionSheet.tag == 112 || actionSheet.tag == 113 || actionSheet.tag == 114 ||actionSheet.tag == 115 ||actionSheet.tag == 116)
        {
            NSUInteger sourceType = 0;
            
            switch (buttonIndex)
            {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    
                    break;
                    
            }
            
            
            UIImagePickerController*    imagePicker = [[UIImagePickerController alloc] init];
                
            imagePicker.delegate = self;
            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
            imagePicker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            imagePicker.sourceType = sourceType;
            imagePicker.view.tag = actionSheet.tag;
            
            [self presentViewController:imagePicker animated: YES completion:nil];
            [imagePicker release];

        }
        
    }
    else
    {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您的设备暂时无法拍照" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
        
    }
}
#pragma mark -
#pragma mark UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    imagePickerTag = picker.view.tag;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageWriteToSavedPhotosAlbum(original_image, self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
    }
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    image = [image imageScaledToBigFixedSize:CGSizeMake(964, 604)];
    
    NSData *imageDara = UIImageJPEGRepresentation(image, 0.5);
    image = [UIImage imageWithData:imageDara];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    if(imagePickerTag == 111)
    {
        selectedImage1 =image;

        [picImageView1 setImage:selectedImage1];
        [delBtn1 setHidden:NO];
        [picImageView1 setUserInteractionEnabled:YES];
        
    }
    if(imagePickerTag == 112)
    {
        selectedImage11 = image;

        [picImageView11 setImage:selectedImage11];
        [delBtn11 setHidden:NO];
        [picImageView11 setUserInteractionEnabled:YES];
        
        
    }
    if(imagePickerTag == 113)
    {
        selectedImage2 =image;

        [picImageView2 setImage:selectedImage2];
        [delBtn2 setHidden:NO];
        [picImageView2 setUserInteractionEnabled:YES];
        
    }
    if(imagePickerTag == 114)
    {
        selectedImage22 = image;

        [picImageView22 setImage:selectedImage22];
        [delBtn22 setHidden:NO];
        [picImageView22 setUserInteractionEnabled:YES];
        
    }
    if(imagePickerTag == 115)
    {
        selectedImage3 =image;

        [picImageView3 setImage:selectedImage3];
        [delBtn3 setHidden:NO];
        [picImageView3 setUserInteractionEnabled:YES];
        
    }
    if(imagePickerTag == 116)
    {
        selectedImage33 =image;

        [picImageView33 setImage:selectedImage33];
        [delBtn33 setHidden:NO];
        [picImageView33 setUserInteractionEnabled:YES];
        
    }
    
    image = nil;
    
    [pool release];
    
    
    
    if(picImageView1.image != nil && picImageView11.image !=nil && newBankIdField.text.length && newBankAddressField.text.length)
    {
        tijiaoBtn.enabled = YES;
        [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"anniu-shangchuanyangshi480_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];

        [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo {
    if (error != NULL) {
        NSLog(@"%@", error);
        NSLog(@"图片保存失败");
    } else {// No errors
        NSLog(@"图片保存成功");
    }
}
#pragma mark -
#pragma mark CP_HiddenAlertDelegate
-(void)disMissCP_HiddenAlertAndIsAutoBack:(BOOL)isback
{
    if(isback)
        
        [self performSelector:@selector(doBack) withObject:nil afterDelay:0.5];
}

-(void)removePic:(UIButton *)sender
{
    if(sender.tag == 51)
    {
        [picImageView1 setImage:nil];
        [delBtn1 setHidden:YES];
        [picImageView1 setUserInteractionEnabled:NO];
    }
    
    if(sender.tag == 52)
    {
        [picImageView11 setImage:nil];
        [delBtn11 setHidden:YES];
        [picImageView11 setUserInteractionEnabled:NO];
        
    }
    if(sender.tag == 53)
    {
        [picImageView2 setImage:nil];
        [delBtn2 setHidden:YES];
        [picImageView2 setUserInteractionEnabled:NO];
        
    }
    
    if(sender.tag == 54)
    {
        [picImageView22 setImage:nil];
        [delBtn22 setHidden:YES];
        [picImageView22 setUserInteractionEnabled:NO];
        
    }
    if(sender.tag == 55)
    {
        [picImageView3 setImage:nil];
        [delBtn3 setHidden:YES];
        [picImageView3 setUserInteractionEnabled:NO];
        
    }
    if(sender.tag == 56)
    {
        [picImageView33 setImage:nil];
        [delBtn33 setHidden:YES];
        [picImageView33 setUserInteractionEnabled:NO];
        
    }
    
    if(picImageView1.image == nil || picImageView11.image ==nil)
    {
        tijiaoBtn.enabled = NO;
        [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];

        [tijiaoBtn setTitleColor:[UIColor colorWithRed:175/255.0 green:170/255.0 blue:164/255.0 alpha:1] forState:UIControlStateNormal];
        
    }
    
}
-(void)dealloc
{

    [mReqData clearDelegatesAndCancel];
    [mReqData release];
    [request clearDelegatesAndCancel];
    [request release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    