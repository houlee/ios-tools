//
//  MyProfileViewController.m
//  caibo
//
//  Created by Kiefer on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyProfileViewController.h"
#import "Info.h"
#import <QuartzCore/QuartzCore.h>
#import "UserInfo.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "ProfileTabBarController.h"
#import "EditPerInfoViewController.h"
#import "AddressView.h"
#import "Draft.h"
#import "caiboAppDelegate.h"

#import "BudgeButton.h"
#import "DataUtils.h"
#import "MessageViewController.h"
#import "datafile.h"
#import "DataBase.h"
#import "PhotographViewController.h"
#import "Info.h"
#import "User.h"
#import "BudgeButton.h"
#import "NewPostViewController.h"
#import "GC_UserInfo.h"
#import "HomeViewController.h"
#import "JSON.h"
#import "PreJiaoDianTabBarController.h"
#import "CP_NTableView.h"
#import "MobClick.h"
#import "MyProfileTableViewCell.h"
#import "SendMicroblogViewController.h"
//#import "MyProfileWCTableViewCell.h"
//#import "CP_UIAlertView.h"
//#import "FlagRuleViewController.h"
#import "MLNavigationController.h"
#import "caiboAppDelegate.h"
#import "HongBaoInfo.h"
#import "CP_PrizeView.h"
#define HEADER_HEIGHT 23

@implementation MyProfileViewController
@synthesize homebool;
@synthesize headView;
//@synthesize lbNickName;
@synthesize btnEdit;
@synthesize mTableView, popyes;
//@synthesize mActivityIV;
@synthesize reqGetUserInfo;
@synthesize mUserInfo;

@synthesize budgeButton;

@synthesize noticeFansNum;
@synthesize fansstr;
@synthesize pinglunstr;
@synthesize atmestr;
@synthesize sixinstr;
@synthesize shifou;
@synthesize str11;
@synthesize str22;
@synthesize str33;
@synthesize str44;
@synthesize myziliao;
@synthesize delegate;
@synthesize httprequest;
@synthesize reqEditPerInfo;
@synthesize mHeaderImage;
//@synthesize signUpRequest;
//@synthesize getFlagItemRequest;
//@synthesize getBonusRequest;
//@synthesize getSignUpStatus;
//@synthesize myTimer;
//@synthesize myRequest;
//@synthesize winningList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {

        
        UIImageView *imageView = [[UIImageView alloc] init];
        if( [[Info getInstance] headImage])
        {
            [imageView setImage:[[Info getInstance] headImage]];
        }
        else
        {
            [imageView setImage:UIImageGetImageFromName(@"defaulUserImage.png")];
        }
        [imageView setFrame:CGRectMake(12, 12, 40, 40)];
        [imageView.layer setMasksToBounds:YES]; // 设置圆角边框
        [imageView.layer setCornerRadius:5];
        self.headView = imageView;
        [imageView release];
        
   
        [btnEdit addTarget:self action:@selector(doEdit) forControlEvents:(UIControlEventTouchUpInside)];
		
		isRefresh = NO;

  
    }
    return self;
}


- (id)initWithType:(int)type
{
    self = [super init];
    if (self) {
        initType = type;
        titleArray = [[NSArray alloc] initWithObjects:@"我的彩票",@"我的合买",@"我的收藏", nil];
        iconNameArray = [[NSArray alloc] initWithObjects:@"wb_mycp.png",@"wb_myhm.png",@"wb_mysc.png", nil];
//        activeOpen = NO;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        titleArray = [[NSArray alloc] initWithObjects:@"我的彩票",@"我的合买",@"我的收藏", nil];
        iconNameArray = [[NSArray alloc] initWithObjects:@"wb_mycp.png",@"wb_myhm.png",@"wb_mysc.png", nil];
//        activeOpen = NO;
    }
    return self;
}

- (void)gotohome{
    if (homebool) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hometozhuye" object:nil];
    }else{
        [[caiboAppDelegate getAppDelegate] switchToHomeView];
    }
    
}

- (void)dealloc
{
    [mHeaderImage release];
    mHeaderImage = nil;
    [httprequest clearDelegatesAndCancel];
    self.httprequest = nil;
    if (reqGetUserInfo) 
    {
     //   [mActivityIV stopAnimating];
        [reqGetUserInfo clearDelegatesAndCancel];
        [reqGetUserInfo release];
    }
    [headView release];
    [btnEdit release];
    [mTableView release];
    [mUserInfo release];
    
    receiver.imageContainer = nil;
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:headImageUrl];
    [headImageUrl release];
    [receiver release];
	
	[noticeFansNum release];
	[budgeButton release];
    
    [titleArray release];
    [iconNameArray release];
    
//    [getFlagItemRequest clearDelegatesAndCancel];
//    self.getFlagItemRequest = nil;
    
//    [signUpRequest clearDelegatesAndCancel];
//    self.signUpRequest = nil;

//    [getBonusRequest clearDelegatesAndCancel];
//    self.getBonusRequest = nil;
    
//    [getSignUpStatus clearDelegatesAndCancel];
//    self.getSignUpStatus = nil;
    
//    [myRequest clearDelegatesAndCancel];
//    self.myRequest = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}



#pragma mark - View lifecycle
// 界面初始化
- (void)viewDidLoad
{

    [super viewDidLoad];
    self.CP_navigation.title = @"我";
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
#ifdef isCaiPiaoForIPad
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.CP_navigation.leftBarButtonItem = nil;
    self.mainView.frame = CGRectMake(0, 44, 768, 1024);
    UIImageView * backImage1 = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImage1.image = UIImageGetImageFromName(@"login_bgn.png");
    
    backImage1.backgroundColor = [UIColor clearColor];
	
    [self.mainView addSubview:backImage1];
    [backImage1 release];
#endif
   
    
    UIImageView * backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backi.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    backi.userInteractionEnabled = YES;
    [self.mainView addSubview:backi];
    [backi release];
    
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imagerigthItem = UIImageGetImageFromName(@"wb_write_normal.png");
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
    [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
    [rigthItem setImage:UIImageGetImageFromName(@"wb_write_selected.png") forState:UIControlStateHighlighted];
    [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
    [rigthItemButton release];
    
    UIView *upView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    upView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:upView];
    [upView release];
    
    UIButton *headImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headImageBtn setFrame:CGRectMake(0, 0, 320, 64)];
    [headImageBtn addTarget:self action:@selector(changeHeaderImage:) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:headImageBtn];
    
    [headImageBtn addSubview:headView];
    
    UILabel *lbNickName = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_Y(headView)+15, 22, 200, 20)];
    lbNickName.text = [[Info getInstance] nickName];
    lbNickName.backgroundColor = [UIColor clearColor];
    lbNickName.font = [UIFont systemFontOfSize:15];
    lbNickName.textColor = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
    [headImageBtn addSubview:lbNickName];
    [lbNickName release];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(headImageBtn), 320, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1];
    [self.mainView addSubview:line];
    [line release];
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line), 320, 55)];
    middleView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:middleView];
    [middleView release];
    
    //微博
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(0, 0, 107, 55);
    [weiboBtn addTarget:self action:@selector(weiboPress:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:weiboBtn];
    
    weiboCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 107, 18)];
    weiboCount.text = mUserInfo.topicsize;
    weiboCount.userInteractionEnabled = NO;
    weiboCount.backgroundColor = [UIColor clearColor];
    weiboCount.textAlignment = NSTextAlignmentCenter;
    weiboCount.textColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    weiboCount.font = [UIFont systemFontOfSize:18];
    [weiboBtn addSubview:weiboCount];
    [weiboCount release];
    
    UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(weiboCount)+5, 107, 12)];
    weiboLabel.text = @"微博";
    weiboLabel.userInteractionEnabled = NO;
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    weiboLabel.font = [UIFont systemFontOfSize:12];
    weiboLabel.backgroundColor = [UIColor clearColor];
    weiboLabel.textColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
    [weiboBtn addSubview:weiboLabel];
    [weiboLabel release];
    
    
    //关注
    UIButton *guanzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guanzhuBtn.frame = CGRectMake(107, 0, 107, 55);
    [guanzhuBtn addTarget:self action:@selector(guanzhuPress:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:guanzhuBtn];
    
    guanzhuCount = [[UILabel alloc] initWithFrame:CGRectMake(0,10 , 107, 18)];
    guanzhuCount.text = mUserInfo.attention;
    guanzhuCount.textAlignment = NSTextAlignmentCenter;
    guanzhuCount.backgroundColor = [UIColor clearColor];
    guanzhuCount.textColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    guanzhuCount.font = [UIFont systemFontOfSize:18];
    [guanzhuBtn addSubview:guanzhuCount];
    [guanzhuCount release];
    
    
    UILabel *guanzhuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(guanzhuCount)+5, 107, 12)];
    guanzhuLabel.text = @"关注";
    guanzhuLabel.textAlignment = NSTextAlignmentCenter;
    guanzhuLabel.font = [UIFont systemFontOfSize:12];
    guanzhuLabel.backgroundColor = [UIColor clearColor];
    guanzhuLabel.textColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
    [guanzhuBtn addSubview:guanzhuLabel];
    [guanzhuLabel release];
    
    
    //粉丝
    UIButton *fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fansBtn.frame = CGRectMake(214, 0, 107, 55);
    [fansBtn addTarget:self action:@selector(fansPress:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:fansBtn];
    
    
    fensiCount = [[UILabel alloc] initWithFrame:CGRectMake(0,10 , 107, 18)];
    fensiCount.text = mUserInfo.fans;
    fensiCount.textAlignment = NSTextAlignmentCenter;
    fensiCount.backgroundColor = [UIColor clearColor];
    fensiCount.textColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    fensiCount.font = [UIFont systemFontOfSize:18];
    [fansBtn addSubview:fensiCount];
    [fensiCount release];
    
    UILabel *fensiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(fensiCount)+5, 107, 12)];
    fensiLabel.text = @"粉丝";
    fensiLabel.textAlignment = NSTextAlignmentCenter;
    fensiLabel.font = [UIFont systemFontOfSize:12];
    fensiLabel.backgroundColor = [UIColor clearColor];
    fensiLabel.textColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
    [fansBtn addSubview:fensiLabel];
    [fensiLabel release];
    
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(middleView), 320, 0.5)];
    line1.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1];
    [self.mainView addSubview:line1];
    [line1 release];
    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line1)+10, 320, self.mainView.frame.size.height - 48) style:UITableViewStylePlain];
    if (initType) {
        mTableView.frame = CGRectMake(0, ORIGIN_Y(line1)+10, 320, self.mainView.frame.size.height);
    }
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.scrollEnabled = NO;
//    [mTableView setContentSize:CGSizeMake(320, 280)];
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:mTableView];
    

    
    
#ifdef isCaiPiaoForIPad
    mTableView.frame = CGRectMake(35, 0, 320, self.mainView.frame.size.height);

#endif
    
    if (homebool){
        [self viewWillAppear:YES];
    }
    [backImage release];
    pophome = YES;
    
    if (myziliao == YES) {
        self.title = @"我的资料";
    }else{
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        UIButton *  headButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        headButton1.frame = CGRectMake(30, 7, 70, 30);
        headButton1.tag = 8040;
        [headButton1 setImage:UIImageGetImageFromName(@"wb_dt.png") forState:UIControlStateNormal];
        [headButton1 addTarget:self action:@selector(pressheadButton1:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *  headButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        headButton2.frame = CGRectMake(100, 7, 70, 30);
        [headButton2 setImage:UIImageGetImageFromName(@"wb_zl_0.png") forState:UIControlStateNormal];
        [titleView addSubview:headButton1];
        [titleView addSubview:headButton2];
        [titleView release];

    }
               
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear:) name:@"jijiangchuxian" object:nil];
    
}

-(void)changeHeaderImage:(UIButton *)sender
{
    NSLog(@"changeHeaderImage");
    
//    PhotographViewController * pho = [[PhotographViewController alloc] init];
//    [self.navigationController pushViewController:pho animated:YES];
//    [pho release];
    
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];

    CP_Actionsheet * sheet = [[CP_Actionsheet alloc] initWithType:writeMicroblogActionsheetType Title:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍 照",@"相 册", nil];
    sheet.tag = 10;
    sheet.delegate = self;
    [app.window addSubview:sheet];
    [sheet release];
}

- (void)CP_Actionsheet:(CP_Actionsheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (actionSheet.tag == 10) {
        if (buttonIndex == 1) {//打开相机
            [self openPhotoFunc];
        }else if (buttonIndex == 2){//打开相册
            [self photoAlbumFunc];
            
        }
    }
    
}
#pragma mark 打开相机 相册
- (void)openPhotoFunc{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){// 判断是否有摄像头
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated: YES completion:nil];
        //        [self.navigationController pushViewController:picker animated:YES];
        [picker release];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示",nil)
                                                       message:NSLocalizedString(@"没有摄像头",nil)
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    
    
}


- (void)photoAlbumFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
        
        
        [self presentViewController:picker animated: YES completion:nil];
        
        
        //        [self.navigationController pushViewController:picker animated:YES];
        [picker release];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil)
                                                        message:NSLocalizedString(@"没有摄像头",nil)
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    [picker dismissViewControllerAnimated: YES completion: nil];
    NSLog(@"info = %@",info);
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (image) {
            if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
                NSLog(@"111111");
            } else {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
                NSLog(@"222222");
            }

            
            self.mHeaderImage = image;
            
            // 如果本地头像图片不为空,先上传此头像
            if (mHeaderImage)
            {
                float width  = mHeaderImage.size.width;
                float height = mHeaderImage.size.height;
                float scale;
                
                if (width > height)
                {
                    scale = 640.0 / width;
                }
                else
                {
                    scale = 480.0 / height;
                }
                
                if (scale >= 1.0)
                {
                    [self uploadHeadImage:UIImageJPEGRepresentation(mHeaderImage, 1.0)];
                }
                else if (scale < 1.0)
                {
                    [self uploadHeadImage:UIImageJPEGRepresentation([mHeaderImage scaleAndRotateImage:640], 1.0)];
                }
            }
            
            NSData *data = nil;
            data = UIImageJPEGRepresentation(image,1.0);
            
            if ([data length] > 3646056) {//GIFDATALength*2.3
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"图片大于2MB，会耗费较多流量，是否继续？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
                alert.tag = 1112;
                [alert show];
                [alert release];
                
            }
            
            
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil)
                                                            message:@"无法读取图片，请重试"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
    

}

- (void)uploadHeadImage:(NSData*)imageData
{
    NSString *urlString = @"http://t.diyicai.com/servlet/UploadGroupPic";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"vim_go.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    if (returnStr)
    {
        imageUrl = returnStr;
    }
    
    [self sendRequest];
    [[Info getInstance] setHeadImage:[UIImage imageWithData:imageData]];
    [request release];
    [returnStr release];
}


- (void) sendRequest
{
    Info *mInfo = [Info getInstance];
    NSInteger userId = [mInfo.userId intValue];
    NSInteger provinceId = mInfo.provinceId;
    NSInteger cityId = mInfo.cityId;
    NSInteger sex = 0;
    
    if (!imageUrl)
    {
        imageUrl = @"";
    }
    
    [reqEditPerInfo clearDelegatesAndCancel];
    self.reqEditPerInfo = [ASIHTTPRequest requestWithURL:[NetURL CbEditPerInfo:(userId) Province:(provinceId) City:(cityId) Sex:(sex) Signatures:(@"") ImageUrl:(imageUrl)]];
    [reqEditPerInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqEditPerInfo setDelegate:self];
    [reqEditPerInfo setDidFinishSelector:@selector(reqEditPerInfoFinished:)];
    [reqEditPerInfo startAsynchronous];
}
-(void)reqEditPerInfoFinished:(ASIHTTPRequest *)requests{
    
    NSString *responseStr = [requests responseString];
    if (![responseStr isEqualToString:@"fail"])
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if(dic)
        {
            NSString *resultStr = [dic valueForKey:@"result"];
            if ([resultStr isEqualToString:@"succ"])
            {
                [headView setImage:mHeaderImage];
                
                [[caiboAppDelegate getAppDelegate] showMessage:@"上传头像成功"];
            }
        }
        [jsonParse release];
    }
    
}

- (void)unReadPushNumData:(ASIHTTPRequest *)mrequest{
    
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    
    
    
    NSString *hongBaoMes = [dict objectForKey:@"hongbaoMsg"];
    if(hongBaoMes && hongBaoMes.length && ![hongBaoMes isEqualToString:@"null"]){
        
        HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:hongBaoMes];
        
        CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
        prizeView.prizeType = (int)[hongbao.showType integerValue]-1;
        prizeView.tag = 200;
        prizeView.delegate = self;
        [prizeView show];
        [prizeView release];
        [hongbao release];
    }
    
    str22 = [[dict objectForKey:@"pl"] intValue];
    str44 = [[dict objectForKey:@"sx"] intValue];
    str11 = [[dict objectForKey:@"gz"] intValue];
    str33 = [[dict objectForKey:@"atme"] intValue];
    //xttz
  //  str11 = [[dict objectForKey:@"gzrft"] intValue];
    
  //  NSLog(@"gzrftstr = %d", str33);
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
    NSArray * views = a.viewControllers;
    if ([views count] >= 2) {
        PreJiaoDianTabBarController *c = [views objectAtIndex:1];
        if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
            if (str11 > 99) {
                c.ziliaobadge.hidden = NO;
                c.zlbadgeValue.text = @"N";
                
            }else if(str11 <= 99 && str11 > 0){
                c.ziliaobadge.hidden = NO;
                c.zlbadgeValue.text = [NSString stringWithFormat:@"%d",(int)str11];
            }else{
                c.ziliaobadge.hidden = YES;
                c.zlbadgeValue.text = @"";
            }
            
        }
    }
   
    [mTableView reloadData];
}

-(void)CP_PrizeViewGetPressDelegate:(CP_PrizeView *)prizeview returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{
    
    [[caiboAppDelegate getAppDelegate] hongBaoFunction:_returntype topicID:_topicid lotteryID:_lotteryid];
    
}
- (void)pressWriteButton:(UIButton *)sender{
    [MobClick event:@"event_weibohudong_faxinweibo"];
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController shareTo:@"" isShare:NO];
#else

    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    
#endif

}

- (void)pressheadButton1:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    [mTableView setContentOffset:CGPointMake(0, 0)];
    self.mUserInfo = [[Info getInstance] mUserInfo];


    [self doSendRequest];
    
    [httprequest clearDelegatesAndCancel];
    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(unReadPushNumData:)];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest setShouldContinueWhenAppEntersBackground:YES];
    [httprequest startAsynchronous];
}

- (void)returnstr1:(NSInteger)str1 str2:(NSInteger)str2 str3:(NSInteger)str3 str4:(NSInteger)str4{
    if ([delegate respondsToSelector:@selector(returnstr1:str2:str3:str4:)]) {
        [delegate returnstr1:str1 str2:str2 str3:str3 str4:str4];
    }
}


//即将消失时调用

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.myTimer invalidate];
//    self.myTimer = nil;
//    if (entRunLoopRef) {
//        CFRunLoopStop(entRunLoopRef);
//        entRunLoopRef = nil;
//    }
}


- (void)viewDidDisappear:(BOOL)animated{

//    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidDisappear:animated];
    NSLog(@"%ld %ld %ld %ld", (long)str11, (long)str22, (long)str33, (long)str44);
    if (pophome) {
        [self returnstr1:str11 str2:str22 str3:str33 str4:str44];
    }
    
}

- (void)viewDidUnload
{

    self.btnEdit = nil;
    self.mTableView = nil;
   // self.mActivityIV = nil;
	
	self.noticeFansNum = nil;
	
	self.budgeButton =nil;
	self.headView =nil;
	self.mUserInfo =nil;

    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

// 返回
- (void)doBack
{
   // [self.navigationController popViewControllerAnimated:YES];
    if (popyes) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (myziliao) {
        pophome = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        pophome = NO;
        if (homebool) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hometozhuye" object:nil];
        }else{
            [[caiboAppDelegate getAppDelegate] switchToHomeView];
        }
        
    }
    
}

// 编辑
- (void)doEdit
{
    EditPerInfoViewController *editPerInfoVC = [[EditPerInfoViewController alloc] initWithNibName:@"EditPerInfoViewController" type:1];
    editPerInfoVC.introStr = [mUserInfo signatures];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editPerInfoVC];
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] == 6) {
#ifdef isCaiPiaoForIPad
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
        
#else
        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        
#endif
//        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    }

    [navController setNavigationBarHidden:NO];
    if (navController) 
    {
        [self presentViewController:navController animated: YES completion:nil];
    }
    [navController release];
    [editPerInfoVC release];
}

// 刷新
- (void)doRefresh
{
	isRefresh = YES;
    [self doSendRequest];
}

#pragma mark -
#pragma mark 实现UITableViewDataSource接口

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"Cell";
        
        MyProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[[MyProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.iconImageView.image = UIImageGetImageFromName([iconNameArray objectAtIndex:indexPath.row]);
        if (indexPath.row == [iconNameArray count] - 1) {
            cell.bottomLine.hidden = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark -
#pragma mark 实现UITableViewDelegate接口
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
#ifdef isCaiPiaoForIPad
    
    if (indexPath.section == 1)
    {
        
        if (indexPath.row == 0) // 我发表的
        {
            [MobClick event:@"event_weibohudong_ziliao_wodefabiao"];
            TwitterMessageViewController *messageController = [[TwitterMessageViewController alloc] init];
            messageController.xitongtz = NO;
            messageController.userID = [[Info getInstance] userId];
            messageController.title = @"我发表的";
            [self.navigationController pushViewController:messageController animated:YES];
            [messageController release];
            
        }else if(indexPath.row == 1) // /*草稿箱*/ 我收藏的
        {
            CollectViewController *fansController = [[CollectViewController alloc] init];
            
            //  fansController.userID = [[Info getInstance] userId];
            fansController.navigationItem.title = @"我收藏的";
            [MobClick event:@"event_weibohudong_ziliao_wodeshoucang"];
            [self.navigationController pushViewController:fansController animated:YES];
            [fansController release];
        }
        else if(indexPath.row == 2) ///* 黑名单*/ 评论我的
        {
            
            str22 = 0;
            [imagenum2 removeFromSuperview];
            MessageViewController * mvc = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
            [mvc setDefaultTitile];
            //
            mvc.segmentedControl.selectedSegmentIndex = 3;
            [mvc segmentedcontrolEventValueChanged];
            mvc.segmentedControl.hidden = YES;
            mvc.navigationItem.title = @"评论我的";
            [self.navigationController pushViewController:mvc animated:YES];
            
            [mvc release];
            
        }else if (indexPath.row == 3){
            str33 = 0;
            [imagenum3 removeFromSuperview];
            
            MessageViewController * mvc = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
            [mvc setDefaultTitile];
            //
            mvc.segmentedControl.selectedSegmentIndex = 2;
            
            [mvc segmentedcontrolEventValueChanged];
            
            mvc.segmentedControl.hidden = YES;
            mvc.navigationItem.title = @"@我的";
            [self.navigationController pushViewController:mvc animated:YES];
            
            [mvc release];
        }else if (indexPath.row == 4){//私信
            str44 = 0;
            [imagenum4 removeFromSuperview];
            MessageViewController * mvc = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
            [mvc setDefaultTitile];
            //
            mvc.segmentedControl.selectedSegmentIndex = 4;
            
            [mvc segmentedcontrolEventValueChanged];
            
            mvc.segmentedControl.hidden = YES;
            mvc.navigationItem.title = @"私信";
            [self.navigationController pushViewController:mvc animated:YES];
            
            [mvc release];
            
            
        }else if(indexPath.row == 5){
            
            
            MessageViewController * mvc = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
            [mvc setDefaultTitile];
            //
            mvc.segmentedControl.selectedSegmentIndex = 1;
            
            [mvc segmentedcontrolEventValueChanged];
            
            mvc.segmentedControl.hidden = YES;
            mvc.navigationItem.title = @"通知";
            [self.navigationController pushViewController:mvc animated:YES];
            
            [mvc release];
            
        }else if(indexPath.row == 6){
            TwitterMessageViewController *messageController = [[TwitterMessageViewController alloc] init];
            messageController.xitongtz = YES;
            messageController.userID = [[Info getInstance] userId];
            messageController.navigationItem.title = @"系统通知";
            [self.navigationController pushViewController:messageController animated:YES];
            [messageController release];
            
        }
    }
    else if(indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            
            [[caiboAppDelegate getAppDelegate] XiuGaiTouXiangForiPad:YES Save:YES];
            
        }
        
    }
    
    
    if (str11 == 0 ) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                
                if (str11 > 99) {
                    c.ziliaobadge.hidden = NO;
                    c.zlbadgeValue.text = @"N";
                    
                }else if(str11 <= 99 && str11 > 0){
                    c.ziliaobadge.hidden = NO;
                    c.zlbadgeValue.text = [NSString stringWithFormat:@"%d",str11];
                }else{
                    c.ziliaobadge.hidden = YES;
                    c.zlbadgeValue.text = @"";
                }
                
            }
        }
        
    }
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

#else
    
    
    if(indexPath.row == 0){
    
        [MobClick event:@"event_wodecaipiao_quanbucaipiao"];
		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
		my.myLottoryType = MyLottoryTypeMe;
		my.caiLottoryType = CaiLottoryTypeAll;
		my.title = @"全部彩票";
		[(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
		[my release];
        
    }
    if(indexPath.row == 1){
    
        [MobClick event:@"event_wodecaipiao_hemaicaipiao"];
        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
		my.myLottoryType = MyLottoryTypeMeHe;
		my.caiLottoryType = CaiLottoryTypeAll;
		my.title = @"我的合买";
		[(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:my animated:YES];
		[my release];
    }
    if(indexPath.row == 2){
    
        CollectViewController *fansController = [[CollectViewController alloc] init];
        fansController.navigationItem.title = @"我收藏的";
        [MobClick event:@"event_weibohudong_ziliao_wodeshoucang"];
        [self.navigationController pushViewController:fansController animated:YES];
        [fansController release];
    }
    
    if (str11 == 0 ) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                
                if (str11 > 99) {
                    c.ziliaobadge.hidden = NO;
                    c.zlbadgeValue.text = @"N";
                    
                }else if(str11 <= 99 && str11 > 0){
                    c.ziliaobadge.hidden = NO;
                    c.zlbadgeValue.text = [NSString stringWithFormat:@"%ld",(long)str11];
                }else{
                    c.ziliaobadge.hidden = YES;
                    c.zlbadgeValue.text = @"";
                }
                
            }
        }
        
    }
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

#endif
    
}
-(void)weiboPress:(UIButton *)sender{
    
    [MobClick event:@"event_weibohudong_ziliao_wodefabiao"];
    TwitterMessageViewController *messageController = [[TwitterMessageViewController alloc] init];
    messageController.xitongtz = NO;
    messageController.userID = [[Info getInstance] userId];
    messageController.title = @"我发表的";
    [self.navigationController pushViewController:messageController animated:YES];
    [messageController release];
}
-(void)guanzhuPress:(UIButton *)sender{
    
    [MobClick event:@"event_weibohudong_ziliao_guanzhu"];
    AttentionViewController *attentController= [[AttentionViewController alloc] init];
    attentController.userID = [[Info getInstance] userId];
    attentController.title = @"我的关注";
    [self.navigationController pushViewController:attentController animated:YES];
    [attentController release];
}
-(void)fansPress:(UIButton *)sender{
    
    str11 = 0;
    
    if (str11 == 0 ) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UINavigationController *a = (UINavigationController *)appDelegate.window.rootViewController;
        NSArray * views = a.viewControllers;
        if ([views count] >= 2) {
            PreJiaoDianTabBarController *c = [views objectAtIndex:1];
            if ([c isKindOfClass:[PreJiaoDianTabBarController class]]) {
                if (str11 > 99) {
                    c.ziliaobadge.hidden = NO;
                    c.zlbadgeValue.text = @"N";
                    
                }else if(str11 <= 99 && str11 > 0){
                    c.ziliaobadge.hidden = NO;
                    c.zlbadgeValue.text = [NSString stringWithFormat:@"%ld",(long)str11];
                }else{
                    c.ziliaobadge.hidden = YES;
                    c.zlbadgeValue.text = @"";
                }
                
            }
        }
        
    }
    
    
    [imagenum1 removeFromSuperview];
	if (budgeButton) {
		
		[budgeButton setHidden:YES];
        
	}
    [MobClick event:@"event_weibohudong_ziliao_fensi"];
	FansViewController *fansController = [[FansViewController alloc] init];
    
	
    fansController.userID = [[Info getInstance] userId];
    
    fansController.navigationItem.title = @"粉丝";
    [self.navigationController pushViewController:fansController animated:YES];
    [fansController release];

}

// 图片下载完成后回调更新图片
- (void)updateImage:(UIImage*)image {
    [headView setImage:image];
    [[Info getInstance] setHeadImage:image];
}

// 获取图片
- (void) fetchHeadImage:(NSString *) url {
    if (headImageUrl != url) {
        [headImageUrl release];
    }
    headImageUrl = [url copy];
    
    UIImage *image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : url Delegate:receiver Big:NO];
    [headView setImage:image];
    
    [[Info getInstance] setHeadImage:image];
}


// 发送请求
- (void)doSendRequest
{
    NSString *userId = [[Info getInstance] userId];
    if (userId) 
    {

        [reqGetUserInfo clearDelegatesAndCancel];
        [self setReqGetUserInfo:[ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:userId]]];
        
        [reqGetUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqGetUserInfo setDelegate:self];
        [reqGetUserInfo setTimeOutSeconds:10];
        [reqGetUserInfo setDidFinishSelector:@selector(requestFinished:)];
        [reqGetUserInfo setDidFailSelector:@selector(requestFailed:)];
        [reqGetUserInfo startAsynchronous];
    }
}

#pragma mark -
#pragma mark 重写ASIHTTPRequestDelegate接口

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
	NSString *responseStr = [request responseString];
    NSLog(@"resp aaaaaaaaaaa =%@", responseStr);
    if (![responseStr isEqualToString:@"fail"]) 
    {
        UserInfo *userInfo= [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        if (userInfo) 
        {
			Info *mInfo = [Info getInstance];
			NSString *unionStatus = [NSString stringWithFormat:@"%@",mInfo.mUserInfo.unionStatus];
            userInfo.unionStatus = unionStatus;
            NSLog(@"unionstatus = %@", userInfo.unionStatus);
			self.mUserInfo = userInfo;
            
            weiboCount.text = mUserInfo.topicsize;
            guanzhuCount.text = mUserInfo.attention;
            fensiCount.text = mUserInfo.fans;
            
            mInfo.mUserInfo = userInfo;
            if (mUserInfo.big_image)
            {
                receiver = [[ImageStoreReceiver alloc] init];
                receiver.imageContainer = self;
                [self fetchHeadImage:[Info strFormatWithUrl:mUserInfo.big_image]];
            }
			
			UIImageView *imageView = [[UIImageView alloc] init];
			imageView.frame = CGRectMake(0, 0, 0, 0);
			[imageView setImage: UIImageGetImageFromName(@"V.png")];
			imageView.backgroundColor = [UIColor clearColor];
			
			if ([mUserInfo.vip intValue] == 1) {
				imageView.frame = CGRectMake(48, 47, 14, 14);
                imagehidd = YES;
			}
			else if([mUserInfo.vip intValue] == 0){
				imageView.frame = CGRectMake(0, 0, 0, 0);
                imagehidd = NO;
			}
			
//			[self.view addSubview: imageView];
			[imageView release];
            
            NSInteger pId = [mUserInfo.province intValue];
            NSInteger cId = [mUserInfo.city intValue];
            [[Info getInstance] setProvinceId:pId];
            [[Info getInstance] setCityId:cId];
            [[AddressView getInstance] getAddressWithId:pId :cId];
            
            [mTableView reloadData];
            [mTableView setHidden:NO];
        }
        [userInfo release];
    }
    

}


- (void)requestFailed:(ASIHTTPRequest *)request
{
//    mUserInfo.isOpen = NO;
    [mTableView reloadData];
}

#pragma mark -
#pragma mark UITableView中间4个按钮


// 微博
- (void)pushBlogView
{
	ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:YES userID:[[Info getInstance] userId]];
	[controller setSelectedIndex:0];
	controller.navigationItem.title = @"微博";
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


// 话题
- (void)pushTopicView
{
	ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:YES userID:[[Info getInstance] userId]];
	[controller setSelectedIndex:1];
	controller.navigationItem.title = @"话题";
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    