//
//  PhotographViewController.m
//  caibo
//
//  Created by  on 12-5-9.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "PhotographViewController.h"
#import "QuartzCore/QuartzCore.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Info.h"
#import "ImageUtils.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "CP_PTButton.h"

@implementation PhotographViewController
@synthesize reqUserInfo;
@synthesize reqEditPerInfo;
@synthesize padDoBack,finish;
@synthesize xiugaitouxiangtype;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
   // [self.navigationController setNavigationBarHidden:YES];
    //titleLabel.hidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)LoadiPhoneView {

    [self.navigationController setNavigationBarHidden:YES];
    self.CP_navigation.title = @"修改头像";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    [self.CP_navigation setLeftBarButtonItem:(leftItem)];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBounds:CGRectMake(0, 0, 70, 40)];
//    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
//    imagevi.backgroundColor = [UIColor clearColor];
//    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
//    [btn addSubview:imagevi];
//    [imagevi release];
    
    UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
    lilable.textColor = [UIColor whiteColor];
    lilable.backgroundColor = [UIColor clearColor];
    lilable.textAlignment = NSTextAlignmentCenter;
    lilable.font = [UIFont boldSystemFontOfSize:14];
    lilable.shadowColor = [UIColor blackColor];//阴影
    lilable.shadowOffset = CGSizeMake(0, 1.0);
    lilable.text = @"完成";
    [btn addSubview:lilable];
    [lilable release];
    [btn addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];
    //    UIBarButtonItem *rightItem = [Info itemInitWithTitle:nil Target:self action:@selector(actionSave:) ImageName:@"wb63.png"];
    //    [self.CP_navigation setRightBarButtonItem:rightItem];
    
    UIImageView * baimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // baimage.image = UIImageGetImageFromName(@"login_bgn.png");
    baimage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:baimage];
    [baimage release];
    
    [reqUserInfo clearDelegatesAndCancel];
    self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:[[Info getInstance] userId]]];
    [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished:)];
    [reqUserInfo setDelegate:self];
    [reqUserInfo startAsynchronous];
    
    UIImageView *bgkuang = [[UIImageView alloc] initWithFrame:CGRectMake(95, 50, 134, 132)];
    // bgkuang.image = UIImageGetImageFromName(@"wb1.png");
    bgkuang.image = UIImageGetImageFromName(@"touxiangbudaigoubeijing.png");
    bgkuang.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:bgkuang];
    [bgkuang release];
    
    myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 3, 126, 126)];
    myImageView.backgroundColor = [UIColor whiteColor];
    // 设置圆角背景
    myImageView.layer.cornerRadius = 12;
    [myImageView.layer setMasksToBounds:YES];
    
    [bgkuang addSubview:myImageView];
    
    CP_PTButton *phoButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(90, 220, 145, 45)];
    // [phoButton loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"拍 照"];
    [phoButton loadButonImage:@"dengluanniu_1.png" LabelName:@"拍 照"];
    phoButton.buttonName.font = [UIFont boldSystemFontOfSize:20];
    phoButton.buttonImage.frame = phoButton.bounds;
   // phoButton.buttonImage.image = [UIImageGetImageFromName(@"TCKJXQXDAN960.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    phoButton.buttonImage.image = [UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];

    [phoButton addTarget:self action:@selector(pressPotButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:phoButton];
    [phoButton release];
    
    CP_PTButton *xcButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(90, 280, 145, 45)];
    //[xcButton loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"相 册"];
    [xcButton loadButonImage:@"dengluanniu_1.png" LabelName:@"相 册"];

    xcButton.buttonName.font = [UIFont boldSystemFontOfSize:20];
    xcButton.buttonImage.frame = xcButton.bounds;
    // xcButton.buttonImage.image = [UIImageGetImageFromName(@"TCKJXQXDAN960.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
    xcButton.buttonImage.image = [UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];

    [xcButton addTarget:self action:@selector(pressPotButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:xcButton];
    [xcButton release];
    
    


}

- (void)LoadiPadView {

    
        [self.navigationController setNavigationBarHidden:YES];
        self.CP_navigation.image = UIImageGetImageFromName(@"daohangtiao.png");//更换导航栏
        self.CP_navigation.frame = CGRectMake(0, 0, 540, 44);
        self.CP_navigation.title = @"修改头像";
    
        
        self.CP_navigation.leftBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"kf-quxiao2.png"];
  
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBounds:CGRectMake(0, 0, 70, 40)];
        UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
        imagevi.backgroundColor = [UIColor clearColor];
        imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
        [btn addSubview:imagevi];
        [imagevi release];
        
        UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
        lilable.textColor = [UIColor whiteColor];
        lilable.backgroundColor = [UIColor clearColor];
        lilable.textAlignment = NSTextAlignmentCenter;
        lilable.font = [UIFont boldSystemFontOfSize:14];
        lilable.shadowColor = [UIColor blackColor];//阴影
        lilable.shadowOffset = CGSizeMake(0, 1.0);
        lilable.text = @"完成";
        [btn addSubview:lilable];
        [lilable release];
        [btn addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.CP_navigation.rightBarButtonItem = barBtnItem;
        [barBtnItem release];
        
        
        UIImageView *baimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 540, 570)];
        baimage.image = UIImageGetImageFromName(@"bejing.png");
        [self.mainView addSubview:baimage];
        [baimage release];
        
        [reqUserInfo clearDelegatesAndCancel];
        self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:[[Info getInstance] userId]]];
        [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
        [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished:)];
        [reqUserInfo setDelegate:self];
        [reqUserInfo startAsynchronous];
        
        UIImageView *bgkuang = [[UIImageView alloc] initWithFrame:CGRectMake(195, 50, 134, 132)];
        bgkuang.image = UIImageGetImageFromName(@"wb1.png");
        bgkuang.backgroundColor = [UIColor clearColor];
        [self.mainView addSubview:bgkuang];
        [bgkuang release];
        
        myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 3, 126.5, 125.5)];
        myImageView.backgroundColor = [UIColor whiteColor];
        myImageView.layer.cornerRadius = 10;
        [myImageView.layer setMasksToBounds:YES];
        [bgkuang addSubview:myImageView];
        
        CP_PTButton *phoButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(190, 220, 145, 45)];
        [phoButton loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"拍 照"];
        phoButton.buttonName.font = [UIFont boldSystemFontOfSize:20];
        phoButton.buttonImage.frame = phoButton.bounds;
        phoButton.buttonImage.image = [UIImageGetImageFromName(@"TCKJXQXDAN960.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
        [phoButton addTarget:self action:@selector(pressPotButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:phoButton];
        [phoButton release];
        
        CP_PTButton *xcButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(190, 280, 145, 45)];
        [xcButton loadButonImage:@"TCKJXQXDAN960.png" LabelName:@"相 册"];
        xcButton.buttonName.font = [UIFont boldSystemFontOfSize:20];
        xcButton.buttonImage.frame = xcButton.bounds;
        xcButton.buttonImage.image = [UIImageGetImageFromName(@"TCKJXQXDAN960.png") stretchableImageWithLeftCapWidth:21 topCapHeight:13];
        [xcButton addTarget:self action:@selector(pressPotButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:xcButton];
        [xcButton release];
    


}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
#ifdef isCaiPiaoForIPad
    
    [self LoadiPadView];
    
#else
    
    [self LoadiPhoneView];
    
#endif
}

- (void)reqUserInfoFinished:(ASIHTTPRequest *)request
{
	NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"]) 
        {
        UserInfo *mUserInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        if (mUserInfo) 
            {
            [[Info getInstance] setMUserInfo:mUserInfo];
            NSLog(@"image = %@", mUserInfo.big_image);
            if (mUserInfo.big_image) 
                {
                NSString *urlStr = [Info strFormatWithUrl:mUserInfo.big_image];
                NSURL *url = [NSURL URLWithString:urlStr];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
               // NSLog(@"ssassss = %d", imageData);
                UIImage *headImage = [UIImage imageWithData:imageData];
                myImageView.image = headImage;
                [[Info getInstance] setHeadImage:headImage];
                }
            
            NSInteger pId = [mUserInfo.province intValue];
            NSInteger cId = [mUserInfo.city intValue];
            [[Info getInstance] setProvinceId:pId];
            [[Info getInstance] setCityId:cId];
            [[AddressView getInstance] getAddressWithId:pId :cId];
            
            
            
            
            }
        [mUserInfo release];
        }
}

- (void)doBack{
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"jijiangchuxian" object:self];
    if (padDoBack) {
        caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
        UIView * backview = (UIView *)[app.window viewWithTag:10212];
        [backview removeFromSuperview];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)gotohome{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)actionSave:(UIButton *)sender 
{
#ifdef isCaiPiaoForIPad
    
    [mProgressBar show:@"正在发送个人信息..." view:self.mainView];
    mProgressBar.mDelegate = self;
    [mAddressView dimiss];
    
    // 如果本地头像图片不为空,先上传此头像
    if (mHeadImage)
    {
        float width  = mHeadImage.size.width;
        float height = mHeadImage.size.height;
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
            [self uploadHeadImage:UIImageJPEGRepresentation(mHeadImage, 1.0)];
        }
        else if (scale < 1.0)
        {
            [self uploadHeadImage:UIImageJPEGRepresentation([mHeadImage scaleAndRotateImage:640], 1.0)];
        }
    }
    else
    {
        // 没有修改头像，直接保存
        [self sendRequest];
    }
    if (finish) {
        [self gotohome];
    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
#else
    
    [mProgressBar show:@"正在发送个人信息..." view:self.mainView];
    mProgressBar.mDelegate = self;
    [mAddressView dimiss];
    
    // 如果本地头像图片不为空,先上传此头像
    if (mHeadImage)
    {
        float width  = mHeadImage.size.width;
        float height = mHeadImage.size.height;
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
            [self uploadHeadImage:UIImageJPEGRepresentation(mHeadImage, 1.0)];
        }
        else if (scale < 1.0)
        {
            [self uploadHeadImage:UIImageJPEGRepresentation([mHeadImage scaleAndRotateImage:640], 1.0)];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        // 没有修改头像，直接保存
        [self sendRequest];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
#endif
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

- (void)pressPotButton:(UIButton *)sender{
    //拍照
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){// 判断是否有摄像头
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated: YES completion:nil];
        [picker release];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error",nil)
                                                       message:NSLocalizedString(@"have no camera",nil)
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

}


- (void)pressPotButtonTwo:(UIButton *)sender{
    //选择已存的照片
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        
#ifdef isCaiPiaoForIPad
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        UIPopoverController *popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        popoverController.delegate=self;
        [popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
#else
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
        [self presentViewController:picker animated: YES completion:nil];
        [picker release];

#endif
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                        message:NSLocalizedString(@"have no camera",nil)
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated: YES completion: nil];
    NSLog(@"info = %@",info);
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if ([mediaType isEqualToString:@"public.image"]) {
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		if (image) {
			if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
				NSLog(@"111111");
			} else {
				UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
                NSLog(@"222222");
			}
            
            
           // UIImage * imagev = [UIImage createRoundedRectImage:image size:size]; 
            
           // myImageView.image = imagev;
            mHeadImage = image;
            myImageView.image = image;
            
            
            
            
		} else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error",nil)
														   message:@"无法读取图片，请重试"
														  delegate:self
												 cancelButtonTitle:@"确定"
												 otherButtonTitles:nil, nil];
			[alert show];
            [alert release];
		}
	}
}

+ (UIImage *)autoFitFormatImage:(UIImage *)image
{	
	CGSize size = image.size;
	CGFloat edge = MIN(size.width,size.height);
	CGFloat scale = 612.0f/edge;
	UIGraphicsBeginImageContext(CGSizeMake(612, 612));
	
	float dwidth = 0;
	float dheight = 0;
	CGRect rect = CGRectMake(0, 0, 0, 0);
	switch (image.imageOrientation) {
		case UIImageOrientationUp:  //正常 left
			dwidth = (edge - size.width +48.0f)*scale;
			dheight = (edge - size.height -21.0f)*scale;
			rect = CGRectMake(dwidth,dheight,size.width*scale+30.0f,size.height*scale+30.0f);
			break;
		case UIImageOrientationDown: //正常 right
			dwidth = -80;//-(edge - size.width);
			dheight = (edge - size.height -21.0f)*scale;
			rect = CGRectMake(dwidth,dheight,size.width*scale+30.0f,size.height*scale+30.0f);
			break;
		case UIImageOrientationLeft: //正常 updown
			dwidth = (edge - size.width -21.0f)*scale;
			dheight = 0;//-(edge - size.height);
			rect = CGRectMake(dwidth,dheight,size.width*scale+30.0f,size.height*scale+30.0f);
			break;
		case UIImageOrientationRight: //正常  up
			dwidth = (edge - size.width-21.0f)*scale;
			dheight = (edge - size.height+48.0f)*scale;
			rect = CGRectMake(dwidth,dheight,size.width*scale+30.0f,size.height*scale+30.0f);
			break;
		default:
			break;
	}
	
	NSLog(@"%f,%f",size.width*scale,size.height*scale);
	[image drawInRect:rect];
    
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newimg;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, 10, 10);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *image2 = [UIImage imageWithCGImage:imageMasked];
    CFRelease(imageMasked);
    return image2;
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (void)dealloc{
    [reqEditPerInfo clearDelegatesAndCancel];
    [reqEditPerInfo release];
    [myImageView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    