//
//  EditPerInfoViewController.m
//  caibo
//
//  Created by Kiefer on 11-6-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EditPerInfoViewController.h"
#import "Info.h"
#import "AddressView.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "JSON.h"
#import "ImageUtils.h"
#import "YDDebugTool.h"
#import "UIImageExtra.h"

@implementation EditPerInfoViewController

@synthesize mTableView;
@synthesize mHeadView;
@synthesize checkboxM;
@synthesize checkboxF;
@synthesize mLbIntro;
@synthesize mLbAddress;
@synthesize mHeadImage;
@synthesize introStr;
@synthesize reqUserInfo;
@synthesize reqEditPerInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil type:(short)index
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) 
    {
        mViewIndex = index;
        
        [self.navigationItem setHidesBackButton:(YES)];
        [self setTitle:(@"编辑个人资料")];
        
        UIBarButtonItem *leftItem = [Info itemInitWithTitle:@"取 消" Target:self action:@selector(actionCanCel:)];
        [self.navigationItem setLeftBarButtonItem:leftItem];
        
        UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"保 存" Target:self action:@selector(actionSave:)];
        [self.navigationItem setRightBarButtonItem:rightItem];
    }
    return self;
}

- (void)dealloc
{   
    [reqUserInfo clearDelegatesAndCancel];
    [reqUserInfo release];
    [reqEditPerInfo clearDelegatesAndCancel];
    [reqEditPerInfo release];
    
    [mTableView release];
    [mHeadView release];
    [checkboxM release];
    [checkboxF release];
    [mLbIntro release];
    [mLbAddress release];
    [mHeadImage release];
    [introStr release];
    
    [mProgressBar release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// 界面初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mAddressView = [AddressView getInstance];
    [mAddressView setDelegate:self];
    [self.view addSubview:mAddressView];
    
    mProgressBar = [[ProgressBar getProgressBar] retain];
}

- (void)viewDidUnload
{
    self.mTableView = nil;
    
    [mProgressBar release]; mProgressBar = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

// checkBox
- (IBAction) actionCheck:(UIButton *)sender
{
    if (sender == checkboxM) 
    {
        if (!checkboxM.selected) 
        {
            checkboxM.selected = YES;
            checkboxF.selected = NO;
        }
    }
    else
    {
        if (!checkboxF.selected) 
        {
            checkboxF.selected = YES;
            checkboxM.selected = NO;
        }
    }
}

// 取消
- (IBAction)actionCanCel:(UIButton *)sender
{
    if (mViewIndex == 0) 
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (mViewIndex == 1)
    {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

// 发送保存账户信息请求
- (void) sendRequest 
{
    Info *mInfo = [Info getInstance];
    NSInteger userId = [mInfo.userId intValue];
    NSInteger provinceId = mInfo.provinceId;
    NSInteger cityId = mInfo.cityId;
    NSInteger sex = 0;
    if (checkboxM.selected) 
    {
        sex = 1;
    } 
    else if (checkboxF.selected) 
    {
        sex = 2;
    }
    NSString *signatures = mLbIntro.text;
    if (!signatures) 
    {
        signatures = @"";
    }
    if (!imageUrl) 
    {
        imageUrl = @"";
    }
    
    [reqEditPerInfo clearDelegatesAndCancel];
    self.reqEditPerInfo = [ASIHTTPRequest requestWithURL:[NetURL CbEditPerInfo:(userId) Province:(provinceId) City:(cityId) Sex:(sex) Signatures:(signatures) ImageUrl:(imageUrl)]];
    [reqEditPerInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqEditPerInfo setDelegate:self];
    [reqEditPerInfo setDidFinishSelector:@selector(reqEditPerInfoFinished:)];
    [reqEditPerInfo startAsynchronous];
}

// 保存
- (IBAction)actionSave:(UIButton *)sender 
{
    [mProgressBar show:@"正在发送个人信息..." view:self.view];
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
            [self uploadHeadImage:UIImageJPEGRepresentation(mHeadImage, 0.2)];
        }
        else if (scale < 1.0) 
        {
            [self uploadHeadImage:UIImageJPEGRepresentation([mHeadImage scaleAndRotateImage:640], 0.2)];
        }
    }
    else 
    {
        // 没有修改头像，直接保存
        [self sendRequest];
    }
}

#pragma mark -
#pragma mark 实现UITableViewDataSource接口

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return section == 1 ? 3:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSInteger sectionIndex = indexPath.section;
    NSInteger rowIndex = indexPath.row;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    }
    else 
    {
        while ([cell.contentView.subviews lastObject]) 
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    CGFloat fontSize = 16;
    CGFloat cell_cy = cell.frame.size.height/2;
    if(sectionIndex == 0)
    {
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        if ( [[Info getInstance] headImage])
        {
            [imageView setImage:[[Info getInstance] headImage]];
        }
        else
        {
            [imageView setImage:UIImageGetImageFromName(@"defaulUserImage.png")];
        }
        [imageView setBounds:CGRectMake(0, 0, 40, 40)];
        [imageView setCenter:CGPointMake(imageView.bounds.size.width/2 + 10, 25)];
        [cell.contentView addSubview:imageView];
        self.mHeadView = imageView;
        [imageView release];
        
        UILabel *lbHead = [Info lbInit:(@"上传头像") :(fontSize)];
        [lbHead setFrame:CGRectMake(80, 8, 180, 30)];
        [cell.contentView addSubview:lbHead];
        
    }
    else if (sectionIndex == 1) 
    {
        [cell setSelectionStyle:(UITableViewCellSelectionStyleBlue)];
        
        UILabel *lb = [Info lbInit:(@"") :(fontSize)];
        [lb setBounds:CGRectMake(0, 0, 60, 30)];
        [lb setCenter:CGPointMake(lb.bounds.size.width/2 + 10, cell_cy)];
        [lb setTextAlignment:(NSTextAlignmentRight)];
        if (indexPath.row == 0) 
        {
            [lb setText:(@"昵称")];
        }
        else if(rowIndex == 1)
        {
            [lb setText:(@"简介")];
        }
        else if(rowIndex == 2)
        {
            [lb setText:(@"所在地")];
        }
        [cell.contentView addSubview:(lb)];
        
        if (rowIndex == 0) 
        {
            UILabel *lbNikename = [Info lbInit:[[Info getInstance] nickName] :fontSize];
            [lbNikename setBounds:CGRectMake(0, 0, 180, 30)];
            [lbNikename setCenter:CGPointMake(lbNikename.bounds.size.width/2 + 80, cell_cy)];
            [cell.contentView addSubview:lbNikename];
        }
        else if(rowIndex == 1)
        {
            UILabel *lbIntro = [[UILabel alloc] init];
            [lbIntro setText:introStr];
            [lbIntro setFont:[UIFont systemFontOfSize:fontSize]];
            [lbIntro setLineBreakMode:(UILineBreakModeWordWrap)];
            CGSize fontH = [lbIntro.text sizeWithFont:lbIntro.font];
            lbIntro.numberOfLines = ceil(introCellSize.height/fontH.height);
            if (lbIntro.numberOfLines <= 1) 
            {
                [lb setCenter:CGPointMake(lb.bounds.size.width/2 + 10, 22)];
                [lbIntro setBounds:CGRectMake(0, 0, 180, 30)];
                [lbIntro setCenter:CGPointMake(lbIntro.bounds.size.width/2 + 80, 22)];
            }
            else
            {
                [lb setCenter:CGPointMake(lb.bounds.size.width/2, 20)];
                [lbIntro setBounds:CGRectMake(0, 0, introCellSize.width, introCellSize.height)];
                [lbIntro setCenter:CGPointMake(lbIntro.bounds.size.width/2 + lb.bounds.size.width + 15, lbIntro.bounds.size.height/2 + 10)];
            }
            self.mLbIntro = lbIntro;
            [lbIntro release];
            [cell.contentView addSubview:mLbIntro];
        }
        else if(rowIndex == 2)
        {        
            UILabel *lbAddress = [Info lbInit:[[Info getInstance] mAddress] :(fontSize)];
            [lbAddress setBounds:CGRectMake(0, 0, 180, 30)];
            [lbAddress setCenter:CGPointMake(lbAddress.bounds.size.width/2 + 80, cell_cy)];
            self.mLbAddress = lbAddress;
            [cell.contentView addSubview:mLbAddress];
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 1 ? 50:20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) 
    {
        if (introStr) 
        {
            introCellSize = [Info getExpectedSizeWithStr:introStr MaxWidth:180 FontSize:16];
            return (introCellSize.height + 25) < 60? 60 : (introCellSize.height + 25);
        }
        else
        {
            return 60;
        }
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) 
    {
        UIView *headerView = [[[UIView alloc] init] autorelease];
        
        UIView *view = [[UIView alloc] init];
        [view setBounds:CGRectMake(0, 0, 300, 50)];
        [view setCenter:CGPointMake(170, 40)];
        
        UILabel *lbSex = [Info lbInit:(@"性别:") :(16)];
        [lbSex setFrame:CGRectMake(0, 0, 70, 20)];
        [view addSubview:lbSex];
        
        CGFloat lbSex_w = lbSex.frame.size.width;
        UIButton* btn_M = [Info checkBoxInit:(@"sex_m.png") :(@"sex_m_sel.png")];
        [btn_M setFrame:CGRectMake(lbSex_w, 0, 20, 20)];
        [btn_M addTarget:(self) action:(@selector(actionCheck:)) forControlEvents:(UIControlEventTouchUpInside)];
        self.checkboxM = btn_M;
        [view addSubview:checkboxM];
        
        CGFloat lbSexM_x = lbSex_w + checkboxM.frame.size.width;
        UILabel *lbSexM = [Info lbInit:(@"男") :(16)];
        [lbSexM setFrame:CGRectMake(lbSexM_x, 0, 20, 20)];
        [lbSexM setFont:[UIFont boldSystemFontOfSize:16]];
        [view addSubview:lbSexM];
        
        CGFloat checkboxF_x = lbSexM_x + lbSexM.frame.size.width + 15;
        UIButton *btn_F  = [Info checkBoxInit:(@"sex_w.png") :(@"sex_w_sel.png")];
        [btn_F setFrame:CGRectMake(checkboxF_x, 0,  20, 20)];
        [btn_F addTarget:(self) action:(@selector(actionCheck:)) forControlEvents:(UIControlEventTouchUpInside)];
        self.checkboxF = btn_F;
        [view addSubview:checkboxF];
        
        UserInfo *mUserInfo = [[Info getInstance] mUserInfo];
        if (mUserInfo) 
        {
            NSString *sexStr = [mUserInfo sex];
            if ([sexStr isEqualToString:@"1"]) 
            {
                [checkboxM setSelected:YES];
            }
            else if([sexStr isEqualToString:@"2"]) 
            {
                [checkboxF setSelected:YES];
            }
        }
        else
        {
            [checkboxF setSelected:YES];
        }
        
        CGFloat lbSexF_x = checkboxF_x + checkboxF.frame.size.width;
        UILabel *lbSexF = [Info lbInit:(@"女") :(16)];
        [lbSexF setFrame:CGRectMake(lbSexF_x, 0, 20, 20)];
        [lbSexF setFont:[UIFont boldSystemFontOfSize:16]];
        [view addSubview:lbSexF];
        
        [headerView addSubview:view];
        [view release];
        return headerView;
    }
    return nil;
}

#pragma mark -
#pragma mark 重写UITableViewDelegate接口

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSInteger sectionIndex = indexPath.section;
    NSInteger rowIndex = indexPath.row;
    if (sectionIndex == 0) 
    {
        if (rowIndex == 0) 
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"用户相册", @"拍照",nil];
            [actionSheet showInView:self.view];
            [actionSheet release];
        } 
    }
    else if(sectionIndex == 1)
    {
        if (rowIndex == 1) 
        {
            InputViewController *inputVC = [[InputViewController alloc] initWithText:mLbIntro.text];
            inputVC.delegate = self;
            [self.navigationController pushViewController:inputVC animated:YES];
            [inputVC release];
        }
        else if(rowIndex == 2)
        {
            [mAddressView show];
        }
    }
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark 重写UITextFieldDelegate接口

- (BOOL) textFieldShouldReturn: (UITextField*) textField
{
    [textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark 实现UIActionSheetDelegate接口

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex 
{
    if (buttonIndex == actionSheet.firstOtherButtonIndex) //用户相册
    {
        //从现有的照片库中选择图像
        if([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setDelegate:self];
            [picker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
            [self presentViewController:picker animated: YES completion:nil];
            [picker release];
        }
    } 
    else if( buttonIndex == 1)  //拍照
    {
        //使用内置的照相机拍摄图片
        if([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)])// 判断是否有摄像头
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setDelegate:self];
            [picker setSourceType:(UIImagePickerControllerSourceTypeCamera)];
            [self presentViewController:picker animated: YES completion:nil];
            [picker release];
        }
        else
        {                
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil) 
                                                            message:NSLocalizedString(@"have no camera",nil)
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

#pragma mark -
#pragma mark 实现UIImagePickerControllerDelegate接口

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
    [picker dismissViewControllerAnimated: YES completion: nil];// 关闭摄像头或用户相册
    
    NSString *mMediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if ([mMediaType isEqualToString:@"public.image"]) 
    {
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		if (image) 
        {
			if (picker.sourceType != UIImagePickerControllerSourceTypePhotoLibrary) 
            {
//				UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
			}
            // 设置头像图片
            self.mHeadImage = [image rescaleImageToSize:CGSizeMake(320, 320)];
            [mHeadView setImage:mHeadImage];
		} 
        else 
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                            message:@"无法读取图片，请重试"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
		}
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker 
{
    [picker dismissViewControllerAnimated: YES completion: nil]; // 关闭摄像头或用户相册
}

// 第一彩博上传头像
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
    
    [request release];
    [returnStr release];
}

- (void)reqEditPerInfoFinished:(ASIHTTPRequest *)request 
{
    NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"]) 
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if(dic)
        {
            NSString *resultStr = [dic valueForKey:@"result"];
            if ([resultStr isEqualToString:@"succ"]) 
            {
                [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(dismissProgressBar)
                                               userInfo:nil
                                                repeats:NO];
                [mProgressBar setTitle:@"个人资料更新成功！"];
                
                [[Info getInstance] setMUserInfo:nil];
                
                if (mViewIndex == 0) 
                {
                    [reqUserInfo clearDelegatesAndCancel];
                    self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBgetUserInfoWithUserId:[[Info getInstance] userId]]];
                    [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished:)];
                    [reqUserInfo setDelegate:self];
                    [reqUserInfo startAsynchronous];
                }
            }
        }
        [jsonParse release];
    }
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
            if (mUserInfo.big_image) 
            {
                NSString *urlStr = [Info strFormatWithUrl:mUserInfo.big_image];
                NSURL *url = [NSURL URLWithString:urlStr];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                UIImage *headImage = [UIImage imageWithData:imageData];
                [[Info getInstance] setHeadImage:headImage];
            }
            
            NSInteger pId = [mUserInfo.province intValue];
            NSInteger cId = [mUserInfo.city intValue];
            [[Info getInstance] setProvinceId:pId];
            [[Info getInstance] setCityId:cId];
            [[AddressView getInstance] getAddressWithId:pId :cId];
            
            self.introStr = mUserInfo.signatures;
            
            [mTableView reloadData];
        }
        [mUserInfo release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	if(error)
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" 
                                                        message:@"网络有错误" 
                                                       delegate:self 
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

// 关闭进度条
- (void) dismissProgressBar
{
    if (mProgressBar) 
    {
        [mProgressBar dismiss];
        if (mViewIndex == 1) 
        {
            [self dismissViewControllerAnimated: YES completion: nil];
        }
    }
}

// 数据更新
- (void)passValue:(NSInteger)typeId Value:(NSString *)value 
{
    if (typeId == 1) 
    {
        self.introStr = value;
        [mTableView reloadData];
    }
    else if(typeId == 2)
    {
        [mLbAddress setText:value];
    }
}

- (void)prograssBarBtnDeleate:(NSInteger)type
{
    [reqUserInfo clearDelegatesAndCancel];
    [reqEditPerInfo clearDelegatesAndCancel];
     
    if (mProgressBar) 
    {
        [mProgressBar dismiss];
    }    
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    