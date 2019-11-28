//
//  UserListMailController.m
//  caibo
//
//  Created by jacob on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserListMailController.h"
#import "CheckNetwork.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "Info.h"
#import "ChatBubbleCell.h"
#import "ColorUtils.h"
#import "DataUtils.h"
#import "NSStringExtra.h"
#import "MyProfileViewController.h"
#import "ProfileViewController.h"
#import "FolloweesViewController.h"
#import "ProgressBar.h"
#import "Result.h"
#import "Face.h"
#import "JSON.h"
#import "BubbleView.h"

@implementation UserListMailController

@synthesize mailListArry;
@synthesize senderId;
@synthesize mList;
//@synthesize mTableView;
@synthesize request;
@synthesize followKeybord;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.CP_navigation setTitle: self.mList.nickName];
    
    NSMutableArray * arraydd = [[NSMutableArray alloc] initWithCapacity:0];
    self.mailListArry = arraydd;
    [arraydd release];
	
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];

    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(actionBack:)];
  
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height - 45) style:UITableViewStylePlain];
    [mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    mTableView.dataSource = self;
    mTableView.delegate = self;
    mTableView.backgroundColor = [UIColor usersMailListBgColor];
    [self.mainView addSubview:mTableView];
    
    
#ifdef isCaiPiaoForIPad
   
//    mTableView.backgroundColor = [UIColor clearColor];
    mBackground = [[EditText alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height-44, 390, 44)];
#else
    mBackground = [[EditText alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height-44, 320, 44)];
#endif
    
    

    mBackground.backgroundColor = [UIColor clearColor];
    
    mBackground.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    mBackground.image=nil;
    [mBackground.showFaceBtn setImage:UIImageGetImageFromName(@"paizhaohui.png") forState:UIControlStateNormal];
    mBackground.editText.layer.borderColor=[UIColor lightGrayColor].CGColor;
    mBackground.editText.layer.cornerRadius=4;
    mBackground.editText.layer.borderWidth=0.5;
    mBackground.editText.backgroundColor=[UIColor whiteColor];
    
    [mBackground setDelegate:self];
    [mBackground.editText setDelegate:self];
//    mBackground.sendBtn.backgroundColor = [UIColor blackColor];
    [mBackground.sendBtn addTarget:self action:@selector(actionSendMail:) forControlEvents:(UIControlEventTouchUpInside)];
    [mBackground.mDeleteText addTarget:self action:@selector(actionDeleteText:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mainView addSubview:mBackground];
    
    faceSystem = [[Face alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height+44, 320, 216)];
    [faceSystem setDelegate:self];
    [self.mainView addSubview:faceSystem];
    
    [faceSystem.addLinkM addTarget:self action:@selector(actionTopicOrLinkMan:) forControlEvents:(UIControlEventTouchUpInside)];
    [faceSystem.addTopic addTarget:self action:@selector(actionTopicOrLinkMan:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [mTableView setBackgroundColor:[UIColor usersMailListBgColor]];
    self.mainView.backgroundColor = [UIColor usersMailListBgColor];
#ifdef  isCaiPiaoForIPad
//    self.view.frame = CGRectMake(0, 0, 468, 1024);
     self.mainView.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(0, 44, 468, 748);
    
    self.mainView.backgroundColor = [UIColor clearColor];
    
    mTableView.frame = CGRectMake(0, 0, 390, self.mainView.frame.size.height - 45-40);
    mBackground.frame = CGRectMake(0, self.mainView.frame.size.height-88, 390, 44);
    faceSystem.frame =  CGRectMake(0, self.mainView.frame.size.height+44, 390, 216);
    
#endif
    
}

// 返回
- (void) actionBack:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PrivateLetterBack" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self sendRequest];
}

// 获取私信列表数据
- (void)sendRequest{
	if([CheckNetwork isExistenceNetwork]){
		
		[request clearDelegatesAndCancel];
		
	    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId] userId2:self.senderId pageNum:@"1" pageSize:@"20"]]];
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(mailListDataBack:)];
		[request setNumberOfTimesToRetryOnTimeout:2];
		[request startAsynchronous];// 异步获取
	}
}

// 接收服务器返回私信数据并解析
- (void)mailListDataBack:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];NSLog(@"mailist responseString = %@\n", responseString);
	if(responseString){
		MailList *maillist = [[MailList alloc]initWithParse:responseString];
		if (maillist) {
//            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] autorelease];
//            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//            NSArray *array = [maillist.arryList sortedArrayUsingDescriptors:sortDescriptors];
//            NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:array];
//        
//			self.mailListArry = sortedArray;
//            [sortedArray release];
//			[maillist release];
            
            
            [self.mailListArry removeAllObjects];
            
            for (int i = (int)[maillist.arryList count]; i > 0; i--) {
                [self.mailListArry addObject:[maillist.arryList objectAtIndex:i-1]];
            }

            
            
            //self.mailListArry = maillist.arryList;
            
			[mTableView reloadData];
            
            // 滚动到tableView最后一条数据位置
            if ([self.mailListArry count] > 0) {
                NSIndexPath *lastRow = [NSIndexPath indexPathForRow:([self.mailListArry count] - 1) inSection:0];
                [mTableView scrollToRowAtIndexPath:lastRow atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
		}
        [maillist release];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mailListArry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	MailList *pic = [self.mailListArry objectAtIndex:indexPath.row];
    
	CGFloat	cellHeigth  = [DataUtils CellHeigth:pic.mcontent messageFontSize:FONT_MIDDLE originText:nil originTextFontSize:FONT_SMALL];	
   
	return  cellHeigth;  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    ChatBubbleCell *cell = (ChatBubbleCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ChatBubbleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// 取消选中背景
    }
    
	MailList *pic = [self.mailListArry objectAtIndex:indexPath.row];
	if (pic.mcontent) {
		[cell setUserself:[pic.senderId isUserself]];
		[cell setInfoText:pic.mcontent];
		[cell.chatview setTime:pic.createDate];
		[cell fetchProfileImage:pic.senderHead];

		if ([pic.vip intValue] == 1) {
			if ([mList.nickName isEqualToString:pic.nickName]) {
				cell.pImageView.frame = CGRectMake(39, 48, 14, 14);
			}
			else {
				cell.pImageView.frame = CGRectMake(306, 48, 14, 14);
			}
		}
		else if([pic.vip intValue] == 0){
			cell.pImageView.frame = CGRectMake(0, 0, 0, 0);
		}
        
        [cell.imageButton setTag:indexPath.row];
        [cell.imageButton addTarget:self action:@selector(actionHeader:) forControlEvents:(UIControlEventTouchUpInside)];
	}
	
    return cell;
}

// 选中table列表项
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    // 判断键盘或者表情是否显示
    if (isShow) {
        if ([self respondsToSelector:@selector(hideKeyBoard)]) {
            [self performSelector:@selector(hideKeyBoard)];
        }
        return;
    }
	MailList *pic = [self.mailListArry objectAtIndex:indexPath.row];
	if (!mList) {
		mList = nil;
	}
	
	self.mList = pic;
	
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择需要的操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"复制该条私信",@"删除与该好友全部私信",nil];
	[sheet showInView:self.mainView.superview];
	[sheet release];
}

// 响应 UIActionSheet（操作表） 按钮
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 10) {// 清除文字
        if (buttonIndex == actionSheet.destructiveButtonIndex) {
            // 清除文字后恢复输入框状态
            [mBackground resumeDefaultAndKeyBoardIsShow:isShow];
        }
    } else {
        if(buttonIndex != [actionSheet cancelButtonIndex]) {
            if (buttonIndex == 0) {// 复制该条消息
                UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
                [generalPasteBoard setString:mList.mcontent];
            } else {// 删除与该好友全部私信	
                UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除与此人对话？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
                [myalert show];
                [myalert release];
            }
        } else {
            [actionSheet canResignFirstResponder];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex ==alertView.cancelButtonIndex) {
		[alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
		[self performSelector:@selector(senddleUsrsMailList) withObject:nil afterDelay:1.0];
	}
}

// 发送删除私信记录请求
-(void)senddleUsrsMailList{
	if([CheckNetwork isExistenceNetwork]){
#ifdef isCaiPiaoForIPad
       
#else
        [[ProgressBar getProgressBar] show:@"正在请求数据..." view:mTableView];
#endif
		
		
		[request clearDelegatesAndCancel];
        
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBdelUsersMailList:[[Info getInstance]userId] userId2:self.senderId]]] ;
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(delUsersMailListBack:)];
		[request setNumberOfTimesToRetryOnTimeout:2];
		[request startAsynchronous];// 异步获取
	}
}

// 接收服务器返回删除私信记录结果
-(void)delUsersMailListBack:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	if (responseString) {
		Result *result = [[Result alloc] initWithParse:responseString];
		if ([result.result isEqualToString:@"succ"]) {
			[[ProgressBar getProgressBar] dismiss];
			[self.navigationController popViewControllerAnimated:YES];
		} else {
			[[ProgressBar getProgressBar] setTitle:@"删除失败"];
			[self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1.0];
		}
		[result release];
	}
}

// 关闭ProgressBar
-(void)dismissProgressBar{
    [[ProgressBar getProgressBar] dismiss];
}

// 点击图标跳转到资料详情界面
-(void)actionHeader:(UIButton*)button{
	MailList *pic = [self.mailListArry objectAtIndex:button.tag];
	if (pic) {
		if ([pic.senderId isUserself]) {
			MyProfileViewController *myProfileVC = [[MyProfileViewController alloc] initWithType:1];
			[self.navigationController pushViewController:myProfileVC animated:YES];
			[myProfileVC release];
		} else {		
			[[Info getInstance] setHimId:pic.senderId];
			ProfileViewController *profileVC = [[ProfileViewController alloc] init];
			[self.navigationController pushViewController:profileVC animated:YES];
			[profileVC release];
		}
	}
}

/**************************** 编写私信相关 ****************************/

- (void)growingTextView:(GrowingTextView *)textView willChangeHeight:(float)height
{
	float diff = (textView.frame.size.height - height);
    
    // 背景
    CGRect bgRect = mBackground.frame;
    bgRect.origin.y += diff;
    bgRect.size.height -= diff;
    mBackground.frame = bgRect;
    
    // 表情按钮
    CGRect faceRect = mBackground.showFaceBtn.frame;
    faceRect.origin.y -= diff;
    mBackground.showFaceBtn.frame = faceRect;
    
    // 发送按钮
    CGRect sendRect = mBackground.sendBtn.frame;
    sendRect.origin.y -= diff;
    mBackground.sendBtn.frame = sendRect;
    
    if (height >= 79) {
        mBackground.mDeleteText.hidden = NO;
    } else {
        mBackground.mDeleteText.hidden = YES;
    }
}

- (void) changeTextCount : (NSString *) text {
    int textCount = 300 - (int)[text length];
    if (textCount < 0) {
        [mBackground.mDeleteText setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    } else {
        [mBackground.mDeleteText setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    }
    [mBackground.mDeleteText setTitle:[NSString stringWithFormat:@"%d", textCount] forState:(UIControlStateNormal)];
    if ([[mBackground.editText.internalTextView text] length] == 0) {
        mBackground.sendBtn.enabled = false;
        mBackground.mDeleteText.hidden = YES;
    }
}

- (void) keyboardWillShow:(id)sender
{
    [mBackground.editText.internalTextView setSelectedRange:NSMakeRange([mBackground.editText.internalTextView.text length], 0)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
#ifdef isCaiPiaoForIPad
    CGFloat keybordHeight = CGRectGetWidth(keybordFrame);
#else
    CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
#endif
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
#ifdef isCaiPiaoForIPad
    [mBackground setCenter:CGPointMake(390/2, self.mainView.frame.size.height - keybordHeight - mBackground.bounds.size.height/2- 44)];
#else
    [mBackground setCenter:CGPointMake(160, self.mainView.frame.size.height - keybordHeight - mBackground.bounds.size.height/2)];
#endif
    
    [UIView commitAnimations];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}
- (void) keyboardWillDisapper:(id)sender
{
    [mBackground.editText.internalTextView setSelectedRange:NSMakeRange([mBackground.editText.internalTextView.text length], 0)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
#ifdef isCaiPiaoForIPad
    [mBackground setCenter:CGPointMake(390/2, self.mainView.frame.size.height  - mBackground.bounds.size.height/2-44)];
#else
    [mBackground setCenter:CGPointMake(160, self.mainView.frame.size.height - mBackground.bounds.size.height/2)];
#endif
    
    [UIView commitAnimations];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) moveViewPosition {

    [mBackground.editText.internalTextView setSelectedRange:NSMakeRange([mBackground.editText.internalTextView.text length], 0)];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    NSLog(@"hight = %f", self.mainView.frame.size.height);
//    [mBackground setCenter:CGPointMake(160, 416 - 216 - mBackground.frame.size.height/2)];
    
    
#ifdef isCaiPiaoForIPad
   mTableView.frame = CGRectMake(0, 0, 390, self.mainView.frame.size.height - 45-40);
    [mBackground setCenter:CGPointMake(390/2, self.mainView.frame.size.height  - 216 - mBackground.bounds.size.height/2-44)];
#else
    [mBackground setCenter:CGPointMake(160, self.mainView.frame.size.height - 216 - mBackground.bounds.size.height/2)];
    mTableView.frame = CGRectMake(0.0f, 0.0f, 320.0f,self.mainView.frame.size.height -40 - 216-mBackground.bounds.size.height);
#endif
    
    [UIView commitAnimations];
    if([self.mailListArry count])
		[mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.mailListArry count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void) restoreViewPosition {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.3f];
//    [mTableView setCenter:CGPointMake(160, 188)];// 376 / 2 = 188;
//    [UIView commitAnimations];
    [mBackground.editText.internalTextView setSelectedRange:NSMakeRange([mBackground.editText.internalTextView.text length], 0)];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
      NSLog(@"hight = %f", self.mainView.frame.size.height);
//    [mBackground setCenter:CGPointMake(160, self.view.frame.size.height - mBackground.frame.size.height/2)];
    
     
#ifdef isCaiPiaoForIPad
    mTableView.frame = CGRectMake(0, 0, 390, self.mainView.frame.size.height - 45-40);
    [mBackground setCenter:CGPointMake(390/2, self.mainView.frame.size.height  - mBackground.bounds.size.height/2-44)];
#else
    mTableView.frame = CGRectMake(0.0f, 0.0f, 320.0f, self.mainView.frame.size.height -40);//372.0f);
    [mBackground setCenter:CGPointMake(160, self.mainView.frame.size.height - mBackground.bounds.size.height/2)];
#endif
   
    [UIView commitAnimations];
}

// 恢复界面状态
- (void) hideKeyBoard {
    isShow = NO;
    // 根据当前已输入的文字高度将输入框放置底部合适位置
//    int height = mBackground.frame.size.height;
//    int y = 372 + (height / 2) - (height - 44);
//    [mBackground setContentOffset:CGPointMake(160,  y)];
    // 关闭键盘
    [mBackground.editText.internalTextView resignFirstResponder];
    [mBackground.showFaceBtn setSelected:NO];
    // 关闭表情
    [faceSystem dismissFaceSystem];
    // 恢复tableView位置
    [self restoreViewPosition];
}

// tableView滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyBoard];
}

// 开始编辑文字
- (void) growingTextViewDidBeginEditing:(GrowingTextView *)growingTextView {
    isShow = YES;
    
    [mBackground.showFaceBtn setSelected:NO];
    
    // 调整tableView位置
//    [self moveViewPosition];
    
    // 改变输入框及背景位置
//    int y = 164 - (mBackground.frame.size.height / 2);
//    [mBackground setContentOffset:CGPointMake(160, y)];
    [faceSystem dismissFaceSystem];// 关闭表情
}

- (void) growingTextViewDidChange:(GrowingTextView *)textView {
    // 滚动到最后一条数据位置
    if ([self.mailListArry count] > 0) {
        NSIndexPath *lastRow = [NSIndexPath indexPathForRow:([self.mailListArry count] - 1) inSection:0];
        [mTableView scrollToRowAtIndexPath:lastRow atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    if ([textView.text length] == 0) {
        mBackground.sendBtn.enabled = false;
    } else {
        mBackground.sendBtn.enabled = true;
    }
    [self changeTextCount:[textView text]];
}

// 点击关闭表情,键盘弹出
- (void) keyBoardShow {
    isShow = YES;
    [faceSystem dismissFaceSystem];
}

// 点击弹出表情,键盘消失
- (void) keyBoardDismiss {
    isShow = YES;
    // 调整tableView位置
    [self moveViewPosition];
    
    // 改变输入框及背景位置
//    int y = 164 - (mBackground.frame.size.height / 2);
//    [mBackground setContentOffset:CGPointMake(160, y)];
    
    
    
#ifdef isCaiPiaoForIPad
    [faceSystem showFaceSystem:CGPointMake(195, self.mainView.frame.size.height - faceSystem.bounds.size.height/2)];
#else
    [faceSystem showFaceSystem:CGPointMake(160, self.mainView.frame.size.height - faceSystem.bounds.size.height/2)];
#endif
    
}

// 点击表情
- (void) clickFace:(NSString *)faceName {
    NSMutableString *finalText = [[NSMutableString alloc] init];
    [finalText appendString:[mBackground.editText.internalTextView text]];
    [finalText appendString:faceName];
    [mBackground.editText.internalTextView setText:finalText];
    [finalText release];
    
    [mBackground.editText textViewDidChange:mBackground.editText.internalTextView];
    [self changeTextCount:[mBackground.editText.internalTextView text]];
    
    if (mBackground.sendBtn.enabled == NO) {
        mBackground.sendBtn.enabled = YES;
    }
}

// 发送私信
- (IBAction) actionSendMail:(id)sender {
    MailList *list = [[MailList alloc] init];
    list.senderId = [[Info getInstance] userId];
    list.content = [mBackground.editText.internalTextView text]; 
    list.mcontent = [mBackground.editText.internalTextView text];
    list.createDate = @"发送中...";
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:list, nil];
    [self performSelector:@selector(appendMailWith:) withObject:data];
    [list release];
    [data release];
}

-(void) appendMailWith:(NSMutableArray *)data {
    // 每次只能增加一条数据,超过一条数据或不等于一条数据都直接返回
    if ([data count] != 1) {
        return;
    }
    
    // 取得该条数据
    id object = [data objectAtIndex:0];
    // 加入到TableView数据源中
    [self.mailListArry addObject:object];
    
    // 构建IndexPath数据
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:1];
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:[self.mailListArry indexOfObject:object] inSection:0];
    [insertIndexPaths addObject:newPath];
    
    // 加入到TableView中
    [mTableView beginUpdates];
    [mTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [mTableView endUpdates];
    
    // 滚动到最后一条数据位置
    if ([self.mailListArry count] > 0) {
        NSIndexPath *lastRow = [NSIndexPath indexPathForRow:([self.mailListArry count] - 1) inSection:0];
        [mTableView scrollToRowAtIndexPath:lastRow atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    // 发送私信请求
    [request clearDelegatesAndCancel];
    [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsendMail:[[Info getInstance] userId] taUserId:senderId content:[mBackground.editText.internalTextView text]imageUrl:@""]]];
    [request setDelegate:self];
    [request setTimeOutSeconds:60.0];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];
    
    // 清空输入框文字
    [mBackground resumeDefaultAndKeyBoardIsShow:isShow];
}

- (void)requestFinished:(ASIHTTPRequest *)req {
    NSString *result = [req responseString];
    
    if ([result isEqualToString:@"succ"]) {
        
    } else if ([result isEqualToString:@"fail"]) {
        // 透明提示框
    } else {
        NSDictionary *resultDict = [result JSONValue];
        if ([[resultDict objectForKey:@"result"] isEqualToString:@"succ"]) {
            
        } else {
        }
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                    target:self
                                    selector:@selector(dismissDialog:)
                                    userInfo:nil
                                    repeats:NO];
}

// 请求失败
- (void) requestFailed:(ASIHTTPRequest *)req {
	if([req error]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" 
                                            message:@"网络有错误" 
                                            delegate:self 
                                            cancelButtonTitle:@"确定" 
                                            otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (void) dismissDialog : (id) sender {
    // 发送成功：重新请求获取私信列表
    [self sendRequest];
}

// 插入话题和@联系人
- (IBAction)actionTopicOrLinkMan:(UIButton *)sender {
//    FolloweesViewController *followeesController = [[FolloweesViewController alloc] init];
//    if (sender.tag == 0) {
//        followeesController.contentType = kAddTopicController;
//    } else if (sender.tag == 1) {
//        followeesController.contentType = kLinkManController;
//    }
//	UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:followeesController];
//    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
//    NSString * diyistr = [devicestr substringToIndex:1];
//    if ([diyistr intValue] == 6) {
//        [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
//    }
//
//	if (navController) {
//        followeesController.mController = self;
//		[self presentViewController:navController animated: YES completion:nil];
//	}
//	[navController release];
//	[followeesController release];
}

// 选中插入话题或@联系人回调函数
- (void) friendsViewDidSelectFriend : (NSString*) name {
    if ([name hasPrefix:@"@"] || [name hasPrefix:@"#"]) {
        NSMutableString *textBuffer = [[NSMutableString alloc] init];
        [textBuffer appendString:mBackground.editText.internalTextView.text];
        [textBuffer appendString:name];
        
        [mBackground.editText.internalTextView setText:textBuffer];
        NSString *count = [[mBackground.mDeleteText titleLabel] text];
        [mBackground.mDeleteText setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
        [self changeTextCount:textBuffer];
        [textBuffer release];
        
        [mBackground.editText textViewDidChange:mBackground.editText.internalTextView];
        
        if (mBackground.sendBtn.enabled == NO) {
            mBackground.sendBtn.enabled = YES;
        }
    }
}

// 清除文字
- (void) actionDeleteText:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"清除文字"
                                  otherButtonTitles:nil,nil];
    actionSheet.tag = 10;
    [actionSheet showInView:self.mainView];
    [actionSheet release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.mailListArry = nil;
	self.senderId =nil;
	self.mList =nil;
	mTableView =nil;
	self.request =nil;
	[mBackground release];
	mBackground=nil;
	[faceSystem release];
	faceSystem =nil;
	
	
}

- (void)dealloc {
	
	[request clearDelegatesAndCancel];
	[request release];
	[mailListArry release];
	[senderId release];
	[mList release];
	[mTableView release];	
    
    [mBackground release];
    [faceSystem release];
    
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    