//
//  ReplaceAccountViewController.m
//  caibo
//
//  Created by cp365dev on 14-5-21.
//
//

#import "ReplaceAccountViewController.h"
#import "Info.h"
#import "CP_UIAlertView.h"
#import "Statement.h"
#import "User.h"
#import "DataBase.h"
#import "ASIHTTPRequest.h"
#import "GC_UserInfo.h"
#import "GC_HttpService.h"
#import "SelfHelpView.h"
#import "JSON.h"
#import "NetURL.h"
#import "CP_HiddenAlertView.h"
#import "UIImage+Additions.h"
@interface ReplaceAccountViewController ()

@end

@implementation ReplaceAccountViewController
@synthesize mReqData;
@synthesize request;
@synthesize mUserIdCard;
@synthesize mNickName;
@synthesize mTrueName;
@synthesize password;
@synthesize reqUserInfo;
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
        self.mTrueName = [result objectForKey:@"true_name"];
        self.mUserIdCard = [result objectForKey:@"user_id_card"];
        
        userName.text= self.mNickName;
        
        phonemessage.text = [NSString stringWithFormat:@"更换账户的真实信息身份证号%@\n姓名 %@(现绑定),请按以下步骤操作",self.mUserIdCard,self.mTrueName];


        
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    self.CP_navigation.titleLabel.text = @"更换账户真实信息";

    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    // backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.frame = CGRectMake(0, 44, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [backImage release];
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height)];
    myScrollView.userInteractionEnabled = YES;
    [myScrollView setContentSize:CGSizeMake(320, 1100)];
    if (myScrollView.contentSize.height < myScrollView.bounds.size.height) {
        myScrollView.scrollEnabled = NO;
    }
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    
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
    
    //提示信息
    phonemessage = [[UILabel alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(xian1)+9, 300, 40)];
    phonemessage.text = @"更换账户的真实信息身份证号- -姓名 - -(现绑定),请按以下步骤操作";
    phonemessage.lineBreakMode = NSLineBreakByWordWrapping;
    phonemessage.numberOfLines = 0;
    phonemessage.font = [UIFont systemFontOfSize:12];
    phonemessage.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:phonemessage];
    [phonemessage release];
    
    //①标号
    UIImageView *markTag = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(phonemessage)+20, 22, 22)];
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
    UILabel *pleaseUpload = [[UILabel alloc] initWithFrame:CGRectMake(42,ORIGIN_Y(phonemessage)+20 , 320-42, 22)];
    pleaseUpload.text = @"请上传您现绑定的身份证正反面照片";
    pleaseUpload.backgroundColor = [UIColor clearColor];
    pleaseUpload.font = [UIFont systemFontOfSize:14];
    [myScrollView addSubview:pleaseUpload];
    [pleaseUpload release];
    
    //上传View
    selfHelp = [[SelfHelpView alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(markTag)+10, 320-40-21, 393) andTitle1:@"上传现绑定的身份证正面照片" title2:@"上传现绑定的身份证背面照片"];
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
    
    //②标号
    UIImageView *markTag2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(xian2)+20, 22, 22)];
    [markTag2 setImage:UIImageGetImageFromName(@"shuzi-tiaomu480_1.png")];
    [myScrollView addSubview:markTag2];
    [markTag2 release];
    UILabel *markTagLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
    markTagLabel2.text=@"2";
    markTagLabel2.backgroundColor = [UIColor clearColor];
    markTagLabel2.font = [UIFont systemFontOfSize:10];
    markTagLabel2.textAlignment = NSTextAlignmentCenter;
    markTagLabel2.textColor=[UIColor whiteColor];
    [markTag2 addSubview:markTagLabel2];
    [markTagLabel2 release];
    
    UILabel *markTag2Label = [[UILabel alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(selfHelp)+20, 280, 17)];
    markTag2Label.backgroundColor = [UIColor clearColor];
    [markTag2Label setText:@"请上传您要更换的身份证正反面照片"];
    [markTag2Label setFont:[UIFont systemFontOfSize:14]];
    [myScrollView addSubview:markTag2Label];
    [markTag2Label release];
    
    selfHelp2 = [[SelfHelpView alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(markTag2)+10, 320-40-21, 393) andTitle1:@"上传要更换的身份证正面照片" title2:@"上传要更换的身份证背面照片"];
    [myScrollView addSubview:selfHelp2];
    [selfHelp2 release];
    
    UIButton *addBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn2 setFrame:CGRectMake(112, 97, 35, 35)];
    addBtn2.tag = 103;
    [addBtn2 setImage:UIImageGetImageFromName(@"selfhelp_addBtn.png") forState:UIControlStateNormal];
    [addBtn2 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [selfHelp2 addSubview:addBtn2];
    
    UIButton *addBtn21 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn21 setFrame:CGRectMake(112, 281, 35, 35)];
    addBtn21.tag = 104;
    [addBtn21 setImage:UIImageGetImageFromName(@"selfhelp_addBtn.png") forState:UIControlStateNormal];
    [addBtn21 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [selfHelp2 addSubview:addBtn21];
    
    UIImageView *xian3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, ORIGIN_Y(markTag2)+10, 1, 393)];
    [xian3 setImage:UIImageGetImageFromName(@"wf_xian.png")];
    [myScrollView addSubview:xian3];
    [xian3 release];
    
    //③标号
    UIImageView *markTag3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(xian3)+20, 22, 22)];
    [markTag3 setImage:UIImageGetImageFromName(@"shuzi-tiaomu480_1.png")];
    [myScrollView addSubview:markTag3];
    [markTag3 release];
    UILabel *markTagLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
    markTagLabel3.text=@"3";
    markTagLabel3.backgroundColor = [UIColor clearColor];
    markTagLabel3.font = [UIFont systemFontOfSize:10];
    markTagLabel3.textAlignment = NSTextAlignmentCenter;
    markTagLabel3.textColor=[UIColor whiteColor];
    [markTag3 addSubview:markTagLabel3];
    [markTagLabel3 release];
    
    //提交Label
    UILabel *tijiao = [[UILabel alloc] initWithFrame:CGRectMake(40, ORIGIN_Y(selfHelp2)+20, 280, 17)];
    tijiao.text = @"提交信息";
    tijiao.backgroundColor = [UIColor clearColor];
    tijiao.font = [UIFont systemFontOfSize:14];
    [myScrollView addSubview:tijiao];
    [tijiao release];
    
    //提交Btn
    tijiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tijiaoBtn setFrame:CGRectMake(40, ORIGIN_Y(tijiao)+20, 320-40-21, 40)];
    [tijiaoBtn setTitle:@"提交" forState:UIControlStateNormal];
    tijiaoBtn.enabled = NO;
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
    
    
    picImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 39, 241, 151)];
    [selfHelp2 addSubview:picImageView2];
    [picImageView2 release];
    
    delBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn2 setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
    [delBtn2 addTarget:self action:@selector(removePic:) forControlEvents:UIControlEventTouchUpInside];
    [delBtn2 setHidden:YES];
    [delBtn2 setTag:53];
    [delBtn2 setFrame:CGRectMake(229, 24, 30, 30)];
    [selfHelp2 addSubview:delBtn2];
    
    
    picImageView22 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 229, 241, 151)];
    [selfHelp2 addSubview:picImageView22];
    [picImageView22 release];
    
    delBtn22 = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn22 setImage:UIImageGetImageFromName(@"zhaoxiangdele.png") forState:UIControlStateNormal];
    [delBtn22 addTarget:self action:@selector(removePic:) forControlEvents:UIControlEventTouchUpInside];
    [delBtn22 setHidden:YES];
    [delBtn22 setTag:54];
    [delBtn22 setFrame:CGRectMake(229, 218, 30, 30)];
    [selfHelp2 addSubview:delBtn22];
    
    [self loadUserInfo];

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
    
    sheet = [[CP_Actionsheet alloc]initWithType:ordinaryActionsheetType Title:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
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
    [delBtn2 setHidden:YES];
    [delBtn11 setHidden:YES];
    [delBtn22 setHidden:YES];
    
    [tijiaoBtn setEnabled:NO];
    [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];

    [tijiaoBtn setTitleColor:[UIColor colorWithRed:175/255.0 green:170/255.0 blue:164/255.0 alpha:1] forState:UIControlStateNormal];
    
    [selfHelp showUpLoadSlider];
    [selfHelp2 showUpLoadSlider];
    
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
        
        [self sendRequestImgeUrl:result withTitle:@"现绑定的身份证正面照片" andUserInfo:@"selfhelp_nowsfzZhengm"];
    }
    //上传图片"现绑定的身份证背面照片"回调
    if([userinfo isEqualToString:@"selectedImage11"])
    {
        [selfHelp refreshBelowUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"现绑定的身份证背面照片" andUserInfo:@"selfhelp_nowsfzBeim"];
        
    }
    //上传图片"要更换的身份证正面照片"回调
    if([userinfo isEqualToString:@"selectedImage2"])
    {
        [selfHelp2 refreshUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"要更换的身份证正面照片" andUserInfo:@"selfhelp_replacesfzZhengm"];
        
    }
    //上传图片"要更换的身份证背面照片"回调
    if([userinfo isEqualToString:@"selectedImage22"])
    {
        [selfHelp2 refreshBelowUploadSlider:1.0];
        
        [self sendRequestImgeUrl:result withTitle:@"要更换的身份证背面照片" andUserInfo:@"selfhelp_replacesfzBeim"];
        
    }
//    image1DataLength = (float)imageData.length;
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
        //上传图片"现绑定的身份证正面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage1"])
        {
            [selfHelp refreshUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"现绑定的身份证正面照片" andUserInfo:@"selfhelp_nowsfzZhengm"];
        }
        //上传图片"现绑定的身份证背面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage11"])
        {
            [selfHelp refreshBelowUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"现绑定的身份证背面照片" andUserInfo:@"selfhelp_nowsfzBeim"];
            
        }
        //上传图片"要更换的身份证正面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage2"])
        {
            [selfHelp2 refreshUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"要更换的身份证正面照片" andUserInfo:@"selfhelp_replacesfzZhengm"];
            
        }
        //上传图片"要更换的身份证背面照片"回调
        if([[requests.userInfo objectForKey:@"imageUpload_Title"] isEqualToString:@"selectedImage22"])
        {
            [selfHelp2 refreshBelowUploadSlider:1.0];

            [self sendRequestImgeUrl:result withTitle:@"要更换的身份证背面照片" andUserInfo:@"selfhelp_replacesfzBeim"];
            
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
    [delBtn1 setHidden:NO];
    [delBtn2 setHidden:NO];
    [delBtn11 setHidden:NO];
    [delBtn22 setHidden:NO];

    
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
            //现绑定的身份证正面照片(文字)回调
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_nowsfzZhengm"])
            {
                [self uploadHeadImage:UIImageJPEGRepresentation(selectedImage11, 1.0) andUserInfo:@"selectedImage11"];
                
            }
            //现绑定的身份证背面照片(文字)回调
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_nowsfzBeim"])
            {
                [self uploadHeadImage:UIImageJPEGRepresentation(selectedImage2, 1.0) andUserInfo:@"selectedImage2"];
                
            }
            //要更换的身份证正面照片(文字)回调
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_replacesfzZhengm"])
            {
                [self uploadHeadImage:UIImageJPEGRepresentation(selectedImage22, 1.0) andUserInfo:@"selectedImage22"];
                
            }
            //要更换的身份证背面照片(文字)回调
            if([[mrequrt.userInfo objectForKey:@"TextUpload_Title"] isEqualToString:@"selfhelp_replacesfzBeim"])
            {
                [self sendRequestImgeUrl:nil withTitle:[NSString stringWithFormat:@"用户名  %@  申请更换身份证号 %@ 姓名 %@ 账户的真实信息",self.mNickName,self.mUserIdCard,self.mTrueName] andUserInfo:@"selfhelp_endMessage"];
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
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                            message:@"发送失败"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//            [alert show];
//            [alert release];
            CP_HiddenAlertView *alert = [[CP_HiddenAlertView alloc] initWithTitle:@"提交失败" delegate:self andTitleImage:@"selfhelp_submitFail.png" andMessage:@"您提交的资料可能由于网络原因提交失败\n请您重新提交" andEndMessage:@"如有疑问请拨打客服电话: QQ：3254056760"];
            [alert showAndHiddenAfter:5 isBack:NO];
            [alert release];
            
            
            [selfHelp removeSliderFromSuperView];
            [selfHelp2 removeSliderFromSuperView];
            [delBtn1 setHidden:NO];
            [delBtn2 setHidden:NO];
            [delBtn11 setHidden:NO];
            [delBtn22 setHidden:NO];
            
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
        if(actionSheet.tag == 111 || actionSheet.tag == 112 || actionSheet.tag == 113 || actionSheet.tag == 114)
        {
            NSUInteger sourceType = 0;
            
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    break;
            }
             UIImagePickerController*   imagePicker = [[UIImagePickerController alloc] init];
                
            imagePicker.delegate = self;
            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
            imagePicker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            imagePicker.sourceType = sourceType;
            imagePicker.view.tag = actionSheet.tag;
            
            [self presentViewController:imagePicker animated: YES completion:nil];
            [imagePicker release];
            
            // 跳转到相机或相册页面
//            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//            
//            imagePickerController.delegate = self;
//            
//            imagePickerController.view.tag = actionSheet.tag;
//            
//            imagePickerController.allowsEditing = YES;
//            
//            imagePickerController.sourceType = sourceType;
//            
//            [self presentModalViewController:imagePickerController animated:YES];
//            
//            [imagePickerController release];
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
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    image = [UIImage imageWithData:imageData];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    if(picker.view.tag == 111)
    {
        selectedImage1 =image;

        [picImageView1 setImage:selectedImage1];
        [delBtn1 setHidden:NO];
        [picImageView1 setUserInteractionEnabled:YES];
        
    }
    if(picker.view.tag == 112)
    {
        selectedImage11 = image;

        [picImageView11 setImage:selectedImage11];
        [delBtn11 setHidden:NO];
        [picImageView11 setUserInteractionEnabled:YES];
        
    }
    if(picker.view.tag == 113)
    {
        selectedImage2 = image;

        [picImageView2 setImage:selectedImage2];
        [delBtn2 setHidden:NO];
        [picImageView2 setUserInteractionEnabled:YES];
    }
    if(picker.view.tag == 114)
    {
        selectedImage22 = image;

        [picImageView22 setImage:selectedImage22];
        [delBtn22 setHidden:NO];
        [picImageView22 setUserInteractionEnabled:YES];
    }
    
    image = nil;
    [pool release];
    
    if(picImageView1.image != nil && picImageView11.image !=nil && picImageView2.image !=nil && picImageView22.image !=nil)
    {
        tijiaoBtn.enabled = YES;
        [tijiaoBtn setBackgroundImage:[UIImageGetImageFromName(@"anniu-shangchuanyangshi480_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];

        [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
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
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated: NO completion:nil];
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
    if(picImageView1.image == nil || picImageView11.image ==nil|| picImageView2.image ==nil|| picImageView22.image ==nil)
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