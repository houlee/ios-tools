//
//  SendMicroblogViewController.m
//  caibo
//
//  Created by houchenguang on 14-10-29.
//
//

#import "SendMicroblogViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "JSON.h"
#import "SinaBindViewController.h"
#import "NetURL.h"
#import "MobClick.h"
#import "FaceSystem.h"
#import "ImageUtils.h"
#import "TopicThemeListViewController.h"
#import "NSStringExtra.h"

//#include <netdb.h>
//#include <sys/socket.h>
//#include <unistd.h>
//#include <sys/types.h>
//#include <netdb.h>
//#include <netinet/in.h>
//#include <stdlib.h>
//#include <netinet/in.h>
//#include <arpa/inet.h>
//#include <stdio.h>


@interface SendMicroblogViewController ()

@end

@implementation SendMicroblogViewController
@synthesize microblogType, mRequest, share0,three, mStatus, play, lottery_id, weiBoContent, keyArray, caizhong, textString, textRang;
@synthesize mSelectImage, viewControllers, mReqUpload, shareTo, infoShare, lotteryID, cpthree, mReqData, orderID, myyuce, faxqUlr, detailedBool,urlConnection;


- (void)sendEnabledFunc{//发送按钮的状态
    
    if ([mMessage.text length] <= 0 && mSelectImage == nil) {
        btnwan.enabled = YES;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor colorWithRed:167/255.0 green:201/255.0 blue:237/255.0 alpha:1];
    }else{
        btnwan.enabled = YES;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor whiteColor];
    }
    

}

- (void)returnDoBack{
    [mMessage becomeFirstResponder];
}

// 关闭该界面
- (void)dismissSelf:(BOOL)animated {
    
    if (three) {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        NSLog(@"myyuce = %@", myyuce);
        
        NSArray * comarr = [myyuce componentsSeparatedByString:@" "];
        if ([comarr count] == 3) {
            TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:[comarr objectAtIndex:0]];
            topicThemeListVC.cpsanliu = CpSanLiuWuyes;
            topicThemeListVC.jinnang = YES;
            [self.navigationController pushViewController:topicThemeListVC animated:YES];
            [topicThemeListVC release];
        }else{
            TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:myyuce];
            topicThemeListVC.cpsanliu = CpSanLiuWuyes;
            topicThemeListVC.jinnang = YES;
            [self.navigationController pushViewController:topicThemeListVC animated:YES];
            [topicThemeListVC release];
        }
        
        
        
    }else{
       [self dismissViewControllerAnimated: animated completion:nil];
    }
   
}
#pragma mark 返回上一个界面
// 返回上一个界面
- (void)actionBack {
    if (microblogType == ForwardTopicController || microblogType == ShareController || microblogType == CommentTopicController) {
        if ([mMessage.text length] > 0 || mSelectImage != nil) {
            [mMessage resignFirstResponder];
            CP_LieBiaoView *lb1 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            lb1.delegate = self;
            lb1.tag = 101;
            [lb1 LoadButtonName:[NSArray arrayWithObjects:@"放弃",nil]];
            [lb1 show];
            [lb1 release];
        } else {

            [self dismissSelf:YES];

            
            
            
        }
    } else {
        if ([mMessage.text length] > 0) {
            [mMessage resignFirstResponder];
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"内容尚未发布，是否退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 102;
            [alert show];
            [alert release];
        
        } else {
            

            [self dismissSelf:YES];

            
            
        }
    }
    
}

#pragma mark 监听用户输入
// 监听用户输入；改变字数限制提示


- (NSRange)insertionFunc:(NSInteger)locationCount {

    NSRange rang = NSMakeRange(locationCount, 0);
    for (int i = 0; i < [rangArray count]; i++) {
        NSRange arrayRang = [[rangArray objectAtIndex:i] rangeValue];
        if ((locationCount > arrayRang.location )&& (locationCount <= arrayRang.location + arrayRang.length)) {
            
            rang = NSMakeRange(arrayRang.location + arrayRang.length, 0);
        }
        
        
    }
    return rang;
}

- (void)deleteStringFunc:(NSInteger)locationCount{
    
    for (int i = 0; i < [rangArray count]; i++) {
        NSRange arrayRang = [[rangArray objectAtIndex:i] rangeValue];
        if ((locationCount > arrayRang.location )&& (locationCount <= arrayRang.location + arrayRang.length)) {
            
            if (locationCount == arrayRang.location+1) {
//                if ([mMessage.text length] > arrayRang.location) {
                
                
                NSString * frontString = @"";
                NSString * rearString = @"";
                if ([mMessage.text length] >= arrayRang.location) {
                    frontString = [mMessage.text substringToIndex:arrayRang.location ];
                }
                if ([mMessage.text length] >= arrayRang.location + arrayRang.length) {
                    rearString = [mMessage.text substringFromIndex:arrayRang.location + arrayRang.length];
                }
                
                    NSLog(@"front = %@  reat = %@", frontString, rearString);
                mMessage.text = [NSString stringWithFormat:@"%@%@ ", frontString, rearString];
//                }
                
            }else if ((locationCount > arrayRang.location) && (locationCount <= arrayRang.location + arrayRang.length - 1)){
            

                NSString * frontString = @"";
                NSString * rearString = @"";
                if ([mMessage.text length] >= arrayRang.location) {
                    frontString = [mMessage.text substringToIndex:arrayRang.location ];
                }
                if ([mMessage.text length] >= arrayRang.location + arrayRang.length-1) {
                    rearString = [mMessage.text substringFromIndex:arrayRang.location + arrayRang.length - 1];
                }
                
                NSLog(@"front = %@  reat = %@", frontString, rearString);
                mMessage.text = [NSString stringWithFormat:@"%@%@ ", frontString, rearString];
            
            }else if (locationCount == arrayRang.location + arrayRang.length){
                
                
                
                NSString * frontString = @"";
                NSString * rearString = @"";
                if ([mMessage.text length] >= arrayRang.location) {
                    frontString = [mMessage.text substringToIndex:arrayRang.location ];
                }
                if ([mMessage.text length] >= arrayRang.location + arrayRang.length-1) {
                    rearString = [mMessage.text substringFromIndex:arrayRang.location + arrayRang.length - 1];
                }
                
                NSLog(@"front = %@  reat = %@", frontString, rearString);
                mMessage.text = [NSString stringWithFormat:@"%@%@ ", frontString, rearString];
            }
            
            
        }
        
       
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    [rangArray removeAllObjects];
    [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
    for (int i = 0; i < [rangArray count]; i++) {
        NSRange arrayRang = [[rangArray objectAtIndex:i] rangeValue];
//        NSLog(@"arrayRang.location = %d arrayRang.length = %d", arrayRang.location, arrayRang.length);
        if ((mMessage.selectedRange.location > arrayRang.location )&& (mMessage.selectedRange.location < arrayRang.location + arrayRang.length)) {
        
            mMessage.selectedRange = NSMakeRange(arrayRang.location + arrayRang.length, 0);
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    
    [self changeTextCount:[textView text]];
    
    

    mIndex = mMessage.selectedRange;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [rangArray removeAllObjects];
        [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
//        [self setupKeywordColorInTextView:mMessage ranges:rangArray];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8  ) {
            if ( eightBool == NO ) {
                
                
//                [rangArray removeAllObjects];
//                [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
//                NSRange newRang = [self insertionFunc:mMessage.selectedRange.location];
//                mMessage.selectedRange = NSMakeRange(newRang.location + newRang.length - 1, 0);
//                mIndex = mMessage.selectedRange;
//                
//                [rangArray removeAllObjects];
//                [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
                
                [self setupKeywordColorInTextView:mMessage ranges:rangArray];
                
//                mMessage.selectedRange = mIndex;
            }
            
        }else{
           
            [self setupKeywordColorInTextView:mMessage ranges:rangArray];
        }
        
        
    }else{
        [rangArray removeAllObjects];
        [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
        
    }
    
    if (eightTextBool) {
        eightTextBool = NO;
        
    }else{
        eightBool = NO;
    }
    
    
//if ([[UITextInputMode currentInputMode] primaryLanguage] == @"en-US") {
//        NSLog(@"en-US = %@", [[UITextInputMode currentInputMode] primaryLanguage]);
//    }
//    else
//    {
//        NSLog(@"zh-hans");
//    }
    
    [self sendEnabledFunc];
   
}

- (void) lengthWithInRange:(NSRange)range replacementText:(NSString *)string {
    eightBool = NO;
//    NSInteger textLength = 0;
    UITextRange *selectedRange = [mMessage markedTextRange];
    //获取高亮部分
//    UITextPosition *position = [mMessage positionFromPosition:selectedRange.start offset:0];
//    
//    
//    if (!position) {
//        textLength = [mMessage.text length];
//    }
    if (string.length > 0) {
        //输入状态
        NSString * newText = [mMessage textInRange:selectedRange];
        
        if (newText && [string length] > 1) {       //候选词替换高亮拼音时
            
//            if (newText != nil) {
//                NSInteger tvLength = [mMessage.text length];
//                textLength += (tvLength-[newText length]);
//            }
//            
//            textLength += [string length];
        }else {
//            if (newText != nil) {
//                NSInteger tvLength = [mMessage.text length];
//                textLength += (tvLength-[newText length]);
//            }
//            
//            textLength += 1;
            eightBool = YES;
        }
    }else {
        //删除状态
        if (mMessage.text.length > 0) {
            NSString * newText = [mMessage textInRange:selectedRange];
            if ([newText length] > 0) {
                 eightBool = YES;
            }else{
                eightBool = NO;
            }
//            if (newText != nil) {
//                NSInteger newLength = [newText length];
//                NSInteger tvLength = [mMessage.text length];
//                textLength += (tvLength-newLength);
//                if (newLength > 1) {
//                    textLength += 1;
//                }
//            }
//            else {
//                textLength = [[mMessage.text substringToIndex:range.location] length];
//            }
        }
    }
    
//    return textLength;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    eightTextBool = YES;
    if (textView == mMessage) {
        if ( [text isEqualToString:@""]) {
            eightBool = NO;
            [rangArray removeAllObjects];
            [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
            
            [self deleteStringFunc:mMessage.selectedRange.location];
            
        }else{
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                
            }else{
                //            if (range.length > 0) {
                self.textRang = range;
                self.textString = text;
                [self performSelector:@selector(sleepTextViewText) withObject:nil afterDelay:0.1];
                //            }else{
                //
                //
                //            }
                
            }
            
            
            
        }
        
        [self sendEnabledFunc];
        
        
        [self lengthWithInRange:range replacementText:text] ;
    }
    

    
    
    return YES;
}

- (void)sleepTextViewText{

    NSString *  mMessageString = mMessage.text;
    
    if ([mMessage.text length] >= self.textRang.location + [self.textString length]) {
        mMessageString = [mMessage.text stringByReplacingCharactersInRange:NSMakeRange(self.textRang.location, [self.textString length]) withString:@""];
    }
    
    
    
    [rangArray removeAllObjects];
    [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessageString usingKeyword:keyArray]];
    NSRange newRang = [self insertionFunc:mMessage.selectedRange.location - [self.textString length]];

    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    

    if (mMessage.selectedRange.location - [self.textString length] < newRang.location) {
        
        [textBuffer appendString:[mMessageString substringToIndex:newRang.location ]];
        [textBuffer appendString:self.textString];
        [textBuffer appendString:[mMessageString substringFromIndex:newRang.location]];
        mMessage.text = textBuffer;
        mMessage.selectedRange = NSMakeRange(newRang.location + newRang.length+self.textString.length , 0);
        mIndex = mMessage.selectedRange;
    }
    
    [textBuffer release];
   
}



#pragma mark 看字数是否超出300

- (int)countWord:(NSString*)s {
    int i, n = (int)[s length], l = 0, a = 0, b = 0;
    
    unichar c;
    
    for(i = 0; i < n; i++) {
        c = [s characterAtIndex:i];
        if(isblank(c)) {
            b++;
        } else if(isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    
    if(a == 0 && l == 0) return 0;
    
    return l + (int)ceilf((float)(a + b) / 2.0);
}

- (void) changeTextCount : (NSString *) text {
    int textCount = 300 - [self countWord:text];
   
    if (textCount < 0) {
        [mTextCount setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    } else {
        [mTextCount setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", textCount] forState:(UIControlStateNormal)];
    if([mMessage.text length] == 0 && !mSelectImage) {
        if (microblogType == ForwardTopicController) {
            canPublice = YES;
            UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
            telabel.textColor = [UIColor whiteColor];
            
        }else{
            canPublice = NO;
            UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
            telabel.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        }
        
        [mTextCount setEnabled:NO];
        [[mTextCount imageView] setHidden:YES];
    } else {
        canPublice = YES;
        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
        telabel.textColor = [UIColor whiteColor];
        [mTextCount setEnabled:YES];
        [[mTextCount imageView] setHidden:NO];
    }
    
    if (mIndex.location >[mMessage.text length]) {
        mIndex.location = [mMessage.text length];
    }
//    mIndex.location = [mMessage.text length];
    
    if ([mMessage.text length] <= 0) {
        preinstallLabel.hidden = NO;
    }else{
        preinstallLabel.hidden = YES;
    }
}

#pragma mark alerView liebiao delegate

-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            
                
                [self dismissSelf:YES];
    
            
            
        }
    }
}


- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (liebiaoView.tag == 101) {
        if (buttonIndex == 0) {
            [self dismissSelf:YES];
        }
    }
    if (liebiaoView.tag == 102) {
        if (buttonIndex == 0) {
            
            
            [self dismissSelf:YES];

            
        }
    }
    if (liebiaoView.tag == 103)//清除文字
    {
        
        if (buttonIndex == 0) {
            [keyArray removeAllObjects];
            [mMessage setText:@""];
            
            [self changeTextCount:[mMessage text]];
            mIndex = NSMakeRange([mMessage.text length], 0);
            [mMessage becomeFirstResponder  ];
        }
    }
}

- (void)myLottoryReturn:(MyLottoryViewController *)myLottory url:(NSString *)url infoName:(NSString *)name{

    if (mIndex.location >[mMessage.text length]) {
        mIndex.location = [mMessage.text length];
    }
    
    [keyArray addObject:url];
    NSString * urlName = [NSString stringWithFormat:@"%@ %@", name, url];
    NSMutableString *finalText = [[NSMutableString alloc] init];
    [finalText appendString:[mMessage.text substringToIndex:mIndex.location]];
    [finalText appendString:urlName];
    [finalText appendString:[mMessage.text substringFromIndex:mIndex.location]];
    
    mIndex.location += [urlName length];// 保存输入框光标位置
    
    [mMessage setText:finalText];
    [finalText release];
    
    [self textViewDidChange:mMessage];
    
    [mMessage becomeFirstResponder];
}

#pragma mark 打开相机 相册
- (void)openPhotoFunc{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){// 判断是否有摄像头
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
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
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
        
//        UIButton *butunView = (UIButton *)picker.navigationItem.rightBarButtonItem.customView;
//        if ([butunView isKindOfClass:[UIButton class]]) {
//            [butunView setTintColor:[UIColor whiteColor]];
//        }
        [self presentViewController:picker animated: YES completion:nil];
        
        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
        NSString * diyistr = [devicestr substringToIndex:1];
        if ([diyistr intValue] >= 5) {

            [picker.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            
            picker.navigationBar.backgroundColor = [UIColor blackColor];
        
        }
        
       
        
        
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

// 接收图片
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
            
           
            NSData *data = nil;
            data = UIImageJPEGRepresentation(image,1.0);
           
            if ([data length] > 3646056) {//GIFDATALength*2.3
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"图片大于2MB，会耗费较多流量，是否继续？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
                alert.tag = 1112;
                [alert show];
                [alert release];
                
            }
            
            [self setMSelectImage:image];
            
            imageButtonPicture.hidden = NO;
            if (IS_IPHONE_5) {
                
                
                if (imageButtonPicture.hidden == NO) {
                    
                    mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height  - toolView.frame.size.height  - imageButtonPicture.frame.size.height- 25);
                    
                }
                
            }else{
                
                if (imageButtonPicture.hidden == NO) {
                    mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, imageButtonPicture.frame.origin.y - 10);
                }
            }
            UIImageView * showImageView = (UIImageView *)[imageButtonPicture viewWithTag:74];
            showImageView.image = image;
            [self sendEnabledFunc];
            potoButton.selected = YES;
            
            myPageControl.hidden = YES;
            myScrollView.hidden = YES;
       
            [mMessage resignFirstResponder];
            
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



- (void)CP_Actionsheet:(CP_Actionsheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (actionSheet.tag == 10) {
        if (buttonIndex == 1) {//打开相机
            [self openPhotoFunc];
        }else if (buttonIndex == 2){//打开相册
            [self photoAlbumFunc];
        
        }
    }
//    else if (actionSheet.tag == 11){
//        
//        if (buttonIndex == 1) {//分享到新浪微博
//          
//        }else if (buttonIndex == 2){//分享到腾讯微博
//     
//            
//        }
//        
//    }
    
    
}


#pragma mark 工具栏按钮的点击事件

- (void)frameFunc{
    mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height - shareView.frame.size.height - mTextCount.frame.size.height- 10);
    toolView.frame = CGRectMake(toolView.frame.origin.x, self.mainView.frame.size.height - shareView.frame.size.height - toolView.frame.size.height, toolView.frame.size.width, toolView.frame.size.height);
    if (microblogType == NewTopicController||microblogType == CommentTopicController) {
        kefuButton.frame = CGRectMake(kefuButton.frame.origin.x, toolView.frame.origin.y - kefuButton.frame.size.height, kefuButton.frame.size.width, kefuButton.frame.size.height);
    }
      mTextCount.frame = CGRectMake(mTextCount.frame.origin.x,  toolView.frame.origin.y - 15 - 30, mTextCount.frame.size.width, mTextCount.frame.size.height);
    if (microblogType == ForwardTopicController || microblogType == CommentTopicController || microblogType == CommentRevert) {
        
        transmitView.frame = CGRectMake(transmitView.frame.origin.x, self.mainView.frame.size.height - shareView.frame.size.height - toolView.frame.size.height - transmitView.frame.size.height, transmitView.frame.size.width, transmitView.frame.size.height);
        mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height  - transmitView.frame.size.height - shareView.frame.size.height - mTextCount.frame.size.height- 10);
    }
    
    if (microblogType == NewTopicController || microblogType == ShareController) {
       
        
        if (IS_IPHONE_5) {
           imageButtonPicture.frame = CGRectMake(15, self.mainView.frame.size.height - shareView.frame.size.height - toolView.frame.size.height - imageButtonPicture.frame.size.height - 15, 72, 72);
            
            if (imageButtonPicture.hidden == NO) {
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height - shareView.frame.size.height - imageButtonPicture.frame.size.height- 25);

            }
            
        }else{
            
            imageButtonPicture.frame = CGRectMake(15, 86, 72, 72);
            
            if (imageButtonPicture.hidden == NO) {
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, imageButtonPicture.frame.origin.y - 10);
            }
        }
        
    }
}

- (void)pressPotoButton:(UIButton *)sender{//图
    shareView.hidden = YES;
    [self dismissFaceSystem];
   
    
    [mMessage resignFirstResponder];
    
    mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height - mTextCount.frame.size.height- 10);
    toolView.frame = CGRectMake(toolView.frame.origin.x, self.mainView.frame.size.height  - toolView.frame.size.height, toolView.frame.size.width, toolView.frame.size.height);
    if (microblogType == NewTopicController||microblogType == CommentTopicController) {
        kefuButton.frame = CGRectMake(kefuButton.frame.origin.x, toolView.frame.origin.y - kefuButton.frame.size.height, kefuButton.frame.size.width, kefuButton.frame.size.height);
    }
    mTextCount.frame = CGRectMake(mTextCount.frame.origin.x,  toolView.frame.origin.y - 15 - 30, mTextCount.frame.size.width, mTextCount.frame.size.height);
    if (microblogType == ForwardTopicController || microblogType == CommentTopicController || microblogType == CommentRevert) {
        
        transmitView.frame = CGRectMake(transmitView.frame.origin.x, self.mainView.frame.size.height  - toolView.frame.size.height - transmitView.frame.size.height, transmitView.frame.size.width, transmitView.frame.size.height);
        
    }
    
    if (microblogType == NewTopicController || microblogType == ShareController) {
        imageButtonPicture.frame = CGRectMake(15, self.mainView.frame.size.height  - toolView.frame.size.height - imageButtonPicture.frame.size.height - 15, 72, 72);
        
        if (imageButtonPicture.hidden == NO) {
             mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height - imageButtonPicture.frame.size.height- 25);
        }
        
    }
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    
    CP_Actionsheet * sheet = [[CP_Actionsheet alloc] initWithType:writeMicroblogActionsheetType Title:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍 照",@"相 册", nil];
    sheet.tag = 10;
    sheet.delegate = self;
    [app.window addSubview:sheet];
    [sheet release];
    
    
    
}

- (void)pressTopicButton:(UIButton *)sender{//话题

    shareView.hidden = YES;
    [self dismissFaceSystem];
    
    
    [mMessage becomeFirstResponder];
    NSString * st;
    
    if ([mMessage.text length] > mMessage.selectedRange.location) {
        st = [mMessage.text substringWithRange:NSMakeRange(mMessage.selectedRange.location, 1)];
        NSLog(@"st = %@,  ing = %@", st, mMessage.text);
        if ([st isEqualToString:@"#"]) {
            mMessage.selectedRange = NSMakeRange(mMessage.selectedRange.location+1, mMessage.selectedRange.length);
        }
        
    }
    if (mMessage.selectedRange.location !=NSNotFound) {
        mIndex = mMessage.selectedRange;
    }
    else {
        mIndex = NSMakeRange([mMessage.text length], 0);
    }
    
    
    NSString * name = @"##";
    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    [rangArray removeAllObjects];
    [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
    NSRange newRang = [self insertionFunc:mMessage.selectedRange.location];
    
    [textBuffer appendString:[mMessage.text substringToIndex:newRang.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:newRang.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    
    [mMessage setText:textBuffer];
    
    
    
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
    [textBuffer release];
    
    mMessage.selectedRange = NSMakeRange(newRang.location + newRang.length+name.length - 1, 0);
    mIndex = mMessage.selectedRange;
    
    [self performSelector:@selector(sleepKeyColer) withObject:nil afterDelay:0.1];
//    [self setupKeywordColorInTextView:mMessage ranges:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
}

- (void)sleepKeyColer{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        [self setupKeywordColorInTextView:mMessage ranges:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
    }
    
    mMessage.selectedRange = mIndex;
}
    


- (void)pressAtButton:(UIButton *)sender{//@
    
    
    if (detailedBool) {
        [mMessage resignFirstResponder];
        [[caiboAppDelegate getAppDelegate] showMessage:@"稍后上线" ];
        
        return;
    }
    
    
    
    [self dismissFaceSystem];
    
    
    
    

    FolloweesViewController *followeesController = [[FolloweesViewController alloc] init];
//    if (sender.tag == 0) {
//        followeesController.contentType = kAddTopicController;
//        
//        
//    } else if (sender.tag == 1) {
    followeesController.delegate = self;
        followeesController.contentType = kLinkManController;
        
//    }
    followeesController.mController = self;
    [self.navigationController pushViewController:followeesController animated:YES];
    [followeesController release];

    
}

- (void)pressSchemeButton:(UIButton *)sender{//方案
    [self dismissFaceSystem];
    mIndex = mMessage.selectedRange;
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    my.delegate = self;
    my.myLottoryType = MyLottoryTypeMe;
    my.caiLottoryType = CaiLottoryTypeAll;
    my.microblogBool = YES;
    my.title = @"全部彩票";
    [self presentViewController:my animated: YES completion:nil];
    [my release];
    
}

- (void)pressFaceButton:(UIButton *)sender{//表情
    shareView.hidden = YES;
//    pageControl.hidden = NO;
    
    
    
    [myPageControl setNumberOfPages:3];
    [myPageControl setHidesForSinglePage:NO];
    NSLog(@"11111111111111111111111111111111111111");

    if(sender.selected == NO){
        
       
        
        [self showFaceSystem];
        [sender setTag:1];
        sender.selected = YES;
    } else {
        [self dismissFaceSystem];
        [mMessage becomeFirstResponder];
        [sender setTag:0];
        sender.selected = NO;
    }
    
}

- (void)pressShareButton:(UIButton *)sender{//分享
    
    [self dismissFaceSystem];
   [mMessage resignFirstResponder];
    shareView.hidden = NO;
    
    
   [self frameFunc];
    
}

// 常用联系人和插入话题回调函数
- (void)friendsViewDidSelectFriend:(NSString *)name {

    
    NSMutableString *textBuffer = [[NSMutableString alloc] init];
    [rangArray removeAllObjects];
    [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
     NSRange newRang = [self insertionFunc:mMessage.selectedRange.location];
    
    [textBuffer appendString:[mMessage.text substringToIndex:newRang.location]];
    [textBuffer appendString:name];
    [textBuffer appendString:[mMessage.text substringFromIndex:newRang.location]];
    
    mIndex.location += [name length];// 保存输入框光标位置
    [mMessage setText:textBuffer];
    
    mMessage.selectedRange = NSMakeRange(newRang.location + newRang.length+name.length , 0);
    mIndex = mMessage.selectedRange;
    
    NSString *count = [[mTextCount titleLabel] text];
    [mTextCount setTitle:[NSString stringWithFormat:@"%d", (int)([count intValue] - [name length])] forState:(UIControlStateNormal)];
    [self changeTextCount:textBuffer];
//    yszLabel.hidden = YES;
    [textBuffer release];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        [self setupKeywordColorInTextView:mMessage ranges:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
    }

    
    [mMessage becomeFirstResponder];
}

- (void)pressMicroblogButton:(UIButton *)sender{

    qqMicroblogButton.selected = NO;
    UILabel * qqLabel = (UILabel *)[qqMicroblogButton viewWithTag:11];
    qqLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    
    UILabel * sinaLabel = (UILabel *)[sinaMicroblogButton viewWithTag:11];
    if (sinaMicroblogButton.selected) {
        sinaMicroblogButton.selected = NO;
        sinaLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }else{
        sinaMicroblogButton.selected = YES;
        sinaLabel.textColor = [UIColor whiteColor];
    }
//    UIButton * shareButton = (UIButton *)[toolView viewWithTag:706];
    if (qqMicroblogButton.selected || sinaMicroblogButton.selected) {
        
        shareButton.selected = YES;
    }else{
        shareButton.selected = NO;
    }
}

- (void)pressqqMicroblogButton:(UIButton *)sender{
    sinaMicroblogButton.selected = NO;
    UILabel * sinaLabel = (UILabel *)[sinaMicroblogButton viewWithTag:11];
    sinaLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];

    
    UILabel * qqLabel = (UILabel *)[qqMicroblogButton viewWithTag:11];
    if (qqMicroblogButton.selected) {
        qqMicroblogButton.selected = NO;
        qqLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        
    }else{
        
        qqMicroblogButton.selected = YES;
        qqLabel.textColor = [UIColor whiteColor];
    }
//    UIButton * shareButton = (UIButton *)[toolView viewWithTag:706];
    if (qqMicroblogButton.selected || sinaMicroblogButton.selected) {
        
        shareButton.selected = YES;
    }else{
         shareButton.selected = NO;
    }
    
}

- (void)pressImageButtonPicture:(UIButton *)sender{
    
    MicroblogPictureViewController * mp = [[MicroblogPictureViewController alloc] init];
    mp.delegate = self;
    NSLog(@"%f", mSelectImage.size.height);
    mp.selectImage = mSelectImage;
    [self.navigationController pushViewController:mp animated:YES];
    [mp release];
    
}

- (void)microblogPictureDelegateFunc{
    
    potoButton.selected = NO;
    imageButtonPicture.hidden = YES;
    mSelectImage = nil;
    [self sendEnabledFunc];
    if (![mMessage becomeFirstResponder]) {
        mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height  - toolView.frame.size.height  - mTextCount.frame.size.height- 10);
    }

}

#pragma mark 载入表情系统视图

/**
 *载入表情系统视图
 */
- (void)loadFaceSystemViewWithPage:(int)page {
    if (page < 0) return;
    if (page > 2) return;

    
    // 从内存中获取已加载过的视图，不重新构建
    FaceSystem *faceSystem = [viewControllers objectAtIndex:page];
    if ((NSNull *)faceSystem == [NSNull null]) {
        faceSystem = [[FaceSystem alloc] initWithPageNumber:page row:4 col:8];
        [faceSystem setController:self];
        [viewControllers replaceObjectAtIndex:page withObject:faceSystem];
        [faceSystem release];
    }
    
    if (nil == faceSystem.superview) {
        CGRect frame = myScrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        faceSystem.frame = frame;
        [myScrollView addSubview:faceSystem];
    }
    
    
}

- (void) scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = myScrollView.frame.size.width;
    int page = floor((myScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    myPageControl.currentPage = page;
    
    [self loadFaceSystemViewWithPage:page - 1];
    [self loadFaceSystemViewWithPage:page];
    [self loadFaceSystemViewWithPage:page + 1];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void) showFaceSystem {
    myScrollView.hidden = NO;
    myPageControl.hidden = NO;
    
//    if (faceButton.tag == 0) {
        mIndex = mMessage.selectedRange;// 弹出表情时，记录当前的输入位置
//    }
    
    [mMessage resignFirstResponder];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        if (IS_IPHONE_5) {

            [myScrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 125)];

            
        }else{

            [myScrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 115)];
            myPageControl.frame = CGRectMake(0, self.mainView.bounds.size.height - 30, 320, 36);

        }
        
    }else{
        
        if (IS_IPHONE_5) {
            
            [myScrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 95)];
            myPageControl.frame = CGRectMake(0, self.mainView.bounds.size.height -10, 320, 36);
            
        }else{
            [myScrollView setCenter:CGPointMake(160, self.mainView.bounds.size.height - 95)];
            myPageControl.frame = CGRectMake(0, self.mainView.bounds.size.height -5, 320, 36);
        }
    }
    
    [UIView commitAnimations];
    
    [self loadFaceSystemViewWithPage:0];
    
    [self performSelector:@selector(sleepToolViewFunc) withObject:nil afterDelay:0.3];
    
    

}

- (void)sleepToolViewFunc{
    toolView.frame = CGRectMake(toolView.frame.origin.x, self.mainView.frame.size.height - myPageControl.frame.size.height - myScrollView.frame.size.height - toolView.frame.size.height + 3, toolView.frame.size.width, toolView.frame.size.height);
    if (microblogType == NewTopicController||microblogType == CommentTopicController) {
        kefuButton.frame = CGRectMake(kefuButton.frame.origin.x, toolView.frame.origin.y - kefuButton.frame.size.height, kefuButton.frame.size.width, kefuButton.frame.size.height);
    }
   mTextCount.frame = CGRectMake(mTextCount.frame.origin.x,  toolView.frame.origin.y - 15 - 30, mTextCount.frame.size.width, mTextCount.frame.size.height);
    if (microblogType == ForwardTopicController || microblogType == CommentTopicController || microblogType == CommentRevert) {
        
        transmitView.frame = CGRectMake(transmitView.frame.origin.x, self.mainView.frame.size.height - myPageControl.frame.size.height - myScrollView.frame.size.height - toolView.frame.size.height + 3 - transmitView.frame.size.height, transmitView.frame.size.width, transmitView.frame.size.height);
        
    }
    
    if (microblogType == NewTopicController || microblogType == ShareController) {
        
        
        if (IS_IPHONE_5) {
            imageButtonPicture.frame = CGRectMake(15, self.mainView.frame.size.height - myPageControl.frame.size.height - myScrollView.frame.size.height - toolView.frame.size.height + 3 - imageButtonPicture.frame.size.height - 15, 72, 72);
            
            if (imageButtonPicture.hidden == NO) {
            
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - myScrollView.frame.size.height - myPageControl.frame.size.height - toolView.frame.size.height  - imageButtonPicture.frame.size.height- 25);
                
            }else{
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - myScrollView.frame.size.height - myPageControl.frame.size.height - toolView.frame.size.height  - mTextCount.frame.size.height- 10);
            }
            
        }else{
            
            imageButtonPicture.frame = CGRectMake(15, 86, 72, 72);
            
            if (imageButtonPicture.hidden == NO) {
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, imageButtonPicture.frame.origin.y - 10);
            }else{
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - myScrollView.frame.size.height - myPageControl.frame.size.height - toolView.frame.size.height  - mTextCount.frame.size.height- 10);
            }
        }
        
    }
}

- (void) dismissFaceSystem {
    if (nil == myScrollView) {
        return;
    }
    
    faceButton.selected = NO;
    
    myScrollView.hidden = YES;
    myPageControl.hidden = YES;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];

    [myScrollView setCenter:CGPointMake(160, 567)];

    
    [UIView commitAnimations];
}

// 点击表情
- (void) clickFace:(NSString *)faceName {
    if (mIndex.location >[mMessage.text length]) {
        mIndex.location = [mMessage.text length];
    }
    NSMutableString *finalText = [[NSMutableString alloc] init];
    [rangArray removeAllObjects];
    [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
    NSRange newRang = [self insertionFunc:mMessage.selectedRange.location];
    [finalText appendString:[mMessage.text substringToIndex:newRang.location]];
    [finalText appendString:faceName];
    [finalText appendString:[mMessage.text substringFromIndex:newRang.location]];
    
    mIndex.location += [faceName length];// 保存输入框光标位置
    
    [mMessage setText:finalText];
    [finalText release];
    
    mMessage.selectedRange = NSMakeRange(newRang.location + newRang.length+faceName.length, 0);
    mIndex = mMessage.selectedRange;
    
    [self textViewDidChange:mMessage];
    
    
    
    
    
//    if (mSaveDraft.enabled == NO) {
//        mSaveDraft.enabled = YES;
//    }
//    if (mPostBtn.enabled == NO) {
//        mPostBtn.enabled = YES;
//        canPublice = YES;
//        UILabel * telabel = (UILabel *)[btnwan viewWithTag:10];
//        telabel.textColor = [UIColor whiteColor];
//    }
}

#pragma mark 界面初始化

- (void)shareViewFunc{

    shareView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height -  216, self.mainView.frame.size.width, 216)];
    shareView.hidden = YES;
    shareView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    [self.mainView addSubview:shareView];
    [shareView release];
    
    sinaMicroblogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sinaMicroblogButton.frame = CGRectMake((self.mainView .frame.size.width - 278)/2, 50, 278, 45);
    [sinaMicroblogButton setBackgroundImage:[UIImageGetImageFromName(@"sharebuttonimage.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateNormal];
    [sinaMicroblogButton setBackgroundImage:[UIImageGetImageFromName(@"sharebuttonimage_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateSelected];
    [sinaMicroblogButton addTarget:self action:@selector(pressMicroblogButton:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:sinaMicroblogButton];
    
    
    UILabel * sinaLabel = [[UILabel alloc] initWithFrame:sinaMicroblogButton.bounds];
    sinaLabel.backgroundColor = [UIColor clearColor];
    sinaLabel.textAlignment = NSTextAlignmentCenter;
    sinaLabel.tag = 11;
    sinaLabel.font = [UIFont systemFontOfSize:13];
    sinaLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    sinaLabel.text = @"分享到新浪微博";
    [sinaMicroblogButton addSubview:sinaLabel];
    [sinaLabel release];
    
    
    qqMicroblogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    qqMicroblogButton.frame = CGRectMake((self.mainView .frame.size.width - 278)/2, 105, 278, 45);
    [qqMicroblogButton setBackgroundImage:[UIImageGetImageFromName(@"sharebuttonimage.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateNormal];
    [qqMicroblogButton setBackgroundImage:[UIImageGetImageFromName(@"sharebuttonimage_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:20] forState:UIControlStateSelected];
    [qqMicroblogButton addTarget:self action:@selector(pressqqMicroblogButton:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:qqMicroblogButton];
    
    UILabel * qqLabel = [[UILabel alloc] initWithFrame:qqMicroblogButton.bounds];
    qqLabel.backgroundColor = [UIColor clearColor];
    qqLabel.textAlignment = NSTextAlignmentCenter;
    qqLabel.tag = 11;
    qqLabel.font = [UIFont systemFontOfSize:13];
    qqLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    qqLabel.text = @"分享到腾讯微博";
    [qqMicroblogButton addSubview:qqLabel];
    [qqLabel release];
}

- (void)toolBarFunc{
    
    
    
    toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height - 47, self.mainView.frame.size.width, 47)];
    toolView.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:246/255.0 alpha:1];
    [self.mainView addSubview:toolView];
    [toolView release];
    
    
    
    //图片
    potoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    potoButton.tag = 701;
    [potoButton addTarget:self action:@selector(pressPotoButton:) forControlEvents:UIControlEventTouchUpInside];
    [potoButton setBackgroundImage:UIImageGetImageFromName(@"potoImagenew.png") forState:UIControlStateNormal];
    [potoButton setBackgroundImage:UIImageGetImageFromName(@"potoImagenew_1.png") forState:UIControlStateHighlighted];
    [potoButton setBackgroundImage:UIImageGetImageFromName(@"potoImagenew_1.png") forState:UIControlStateSelected];
    [toolView addSubview:potoButton];

    
    //#
    UIButton * topicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    potoButton.tag = 702;
    [topicButton addTarget:self action:@selector(pressTopicButton:) forControlEvents:UIControlEventTouchUpInside];
    [topicButton setBackgroundImage:UIImageGetImageFromName(@"topicImagenew.png") forState:UIControlStateNormal];
    [topicButton setBackgroundImage:UIImageGetImageFromName(@"topicImagenew_1.png") forState:UIControlStateHighlighted];
    [toolView addSubview:topicButton];
   
    
    //@
    UIButton * atButton = [UIButton buttonWithType:UIButtonTypeCustom];
    atButton.tag = 703;
    [atButton addTarget:self action:@selector(pressAtButton:) forControlEvents:UIControlEventTouchUpInside];
    [atButton setBackgroundImage:UIImageGetImageFromName(@"atButtonnew.png") forState:UIControlStateNormal];
    [atButton setBackgroundImage:UIImageGetImageFromName(@"atButtonnew_1.png") forState:UIControlStateHighlighted];
    [toolView addSubview:atButton];
    
    
    
    //方案
    UIButton * schemeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    schemeButton.tag = 704;
    [schemeButton addTarget:self action:@selector(pressSchemeButton:) forControlEvents:UIControlEventTouchUpInside];
    [schemeButton setBackgroundImage:UIImageGetImageFromName(@"schemeButtonnew.png") forState:UIControlStateNormal];
    [schemeButton setBackgroundImage:UIImageGetImageFromName(@"schemeButtonnew_1.png") forState:UIControlStateHighlighted];
    [toolView addSubview:schemeButton];
    
    
    //表情
    faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    faceButton.tag = 705;
    [faceButton addTarget:self action:@selector(pressFaceButton:) forControlEvents:UIControlEventTouchUpInside];
    [faceButton setBackgroundImage:UIImageGetImageFromName(@"faceButtonnew.png") forState:UIControlStateNormal];
    [faceButton setBackgroundImage:UIImageGetImageFromName(@"faceButtonnew_1.png") forState:UIControlStateHighlighted];
    [faceButton setBackgroundImage:UIImageGetImageFromName(@"faceButtonnew_1.png") forState:UIControlStateSelected];
    [toolView addSubview:faceButton];
    
    
    //分享
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.tag = 706;
    [shareButton addTarget:self action:@selector(pressShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setBackgroundImage:UIImageGetImageFromName(@"shareButtonnew.png") forState:UIControlStateNormal];
    [shareButton setBackgroundImage:UIImageGetImageFromName(@"shareButtonnew_1.png") forState:UIControlStateHighlighted];
    [shareButton setBackgroundImage:UIImageGetImageFromName(@"shareButtonnew_1.png") forState:UIControlStateSelected];
    shareButton.tag = 6;
    [toolView addSubview:shareButton];
    
    
    if (microblogType == NewTopicController && infoShare == NO) {
        
        
        
        if (self.lottery_id) {//邀请他人合买
            
            topicButton.frame = CGRectMake(44, 0, 53, 47);
            atButton.frame = CGRectMake((toolView.frame.size.width - 53)/2, 0, 53, 47);
            faceButton.frame = CGRectMake(223, 0, 53, 47);
            
            schemeButton.frame = CGRectMake(0, 0, 0, 0);
            shareButton.frame = CGRectMake(0, 0, 0, 0);
            potoButton.frame = CGRectMake(0, 0, 0, 0);
            
        }else{
        
            potoButton.frame = CGRectMake(1, 0, 53, 47);
            topicButton.frame = CGRectMake(54, 0, 53, 47);
            atButton.frame = CGRectMake(107, 0, 53, 47);
            schemeButton.frame = CGRectMake(160, 0, 53, 47);
            faceButton.frame = CGRectMake(213, 0, 53, 47);
            shareButton.frame = CGRectMake(266, 0, 53, 47);
        }
        
        
       
    }else if (microblogType == ForwardTopicController || microblogType == CommentTopicController || microblogType == CommentRevert){
    

        topicButton.frame = CGRectMake(10, 0, 53, 47);
        atButton.frame = CGRectMake(68, 0, 53, 47);
        faceButton.frame = CGRectMake(126, 0, 53, 47);
        
        potoButton.frame = CGRectMake(0, 0, 0, 0);
        schemeButton.frame = CGRectMake(0, 0, 0, 0);
        shareButton.frame = CGRectMake(0, 0, 0, 0);
        potoButton.hidden = YES;
        schemeButton.hidden = YES;
        shareButton.hidden = YES;
        
    }else if (microblogType == ShareController || infoShare){
        
        potoButton.frame = CGRectMake(10, 0, 53, 47);
        topicButton.frame = CGRectMake(68, 0, 53, 47);
        atButton.frame = CGRectMake(126, 0, 53, 47);
        faceButton.frame = CGRectMake(184, 0, 53, 47);
        
        schemeButton.frame = CGRectMake(0, 0, 0, 0);
        shareButton.frame = CGRectMake(0, 0, 0, 0);
        schemeButton.hidden = YES;
        shareButton.hidden = YES;
        
        if (detailedBool) {
            potoButton.frame = CGRectMake(0, 0, 0, 0);
            topicButton.frame = CGRectMake(10, 0, 53, 47);
            atButton.frame = CGRectMake(68, 0, 53, 47);
            faceButton.frame = CGRectMake(0, 0, 0, 0);
            
            schemeButton.frame = CGRectMake(0, 0, 0, 0);
            shareButton.frame = CGRectMake(0, 0, 0, 0);
            schemeButton.hidden = YES;
            shareButton.hidden = YES;
            potoButton.hidden = YES;
            faceButton.hidden = YES;
        }
        
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, toolView.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
    [toolView addSubview:lineView];
    [lineView release];
    
    if (microblogType == ForwardTopicController || microblogType == CommentTopicController || microblogType == CommentRevert) {
        
        transmitView = [[UIView alloc] init];
        transmitView.backgroundColor = [UIColor clearColor];
        [self.mainView addSubview:transmitView];
        [transmitView release];
    
        UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+10 + 18, 0, 100, 38)];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        
        if (microblogType == ForwardTopicController) {
            textLabel.text = @"同时评论";
        }else{
            textLabel.text = @"同时转发";
        }
        
        
        [transmitView addSubview:textLabel];
        [textLabel release];
        
        transmitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        transmitButton.selected = YES;
        transmitButton.backgroundColor = [UIColor clearColor];
        transmitButton.frame = CGRectMake(0, 0, 60, 38);
        [transmitButton addTarget:self action:@selector(pressTransmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [transmitView addSubview:transmitButton];
        
        UIImageView * pitchOnImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 18, 18)];
        pitchOnImage.backgroundColor = [UIColor clearColor];
        pitchOnImage.tag = 10;
        pitchOnImage.image = UIImageGetImageFromName(@"weibopitchOn_1.png");
        [transmitButton addSubview:pitchOnImage];
        [pitchOnImage release];
        
        
        
        transmitView.frame = CGRectMake(0, self.mainView.frame.size.height - 47 - 38, self.mainView.frame.size.width, 38);
        
    
    }
    
    
    if (microblogType == NewTopicController || microblogType == ShareController) {
        
        imageButtonPicture = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButtonPicture.backgroundColor = [UIColor clearColor];
        [imageButtonPicture addTarget:self action:@selector(pressImageButtonPicture:) forControlEvents:UIControlEventTouchUpInside];
        imageButtonPicture.frame = CGRectMake(15, self.mainView.frame.size.height - 47 - 38 - 72 - 15, 72, 72);
        [self.mainView addSubview:imageButtonPicture];
        [self.mainView sendSubviewToBack:imageButtonPicture];
        UIImageView * pictureImage = [[UIImageView alloc] initWithFrame:imageButtonPicture.bounds];
        pictureImage.backgroundColor = [UIColor clearColor];
        pictureImage.frame = imageButtonPicture.bounds;
        pictureImage.tag = 74;
        [imageButtonPicture addSubview:pictureImage];
        [pictureImage release];

        if (self.mSelectImage) {
            pictureImage.image = self.mSelectImage;
            if (microblogType == NewTopicController || microblogType == ShareController) {
                
                
                if (IS_IPHONE_5) {
                   
                    
                    if (imageButtonPicture.hidden == NO) {
                        
                        mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height  - toolView.frame.size.height  - imageButtonPicture.frame.size.height- 25);
                        
                    }
                    
                }else{
                    
                    if (imageButtonPicture.hidden == NO) {
                        mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, imageButtonPicture.frame.origin.y - 10);
                    }
                }
                
            }
            potoButton.selected = YES;
        }else{
            imageButtonPicture.hidden = YES;
            
        }
       
       
    }
    
    
}

- (void)pressTransmitButton:(UIButton *)sender{

    UIImageView * pitchOnImage = (UIImageView *)[sender viewWithTag:10];
    
    if (sender.selected) {
        sender.selected = NO;
        pitchOnImage.image = UIImageGetImageFromName(@"weibopitchOn.png");
    }else{
        sender.selected = YES;
        pitchOnImage.image = UIImageGetImageFromName(@"weibopitchOn_1.png");
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    keyArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    rangArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.mainView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(actionBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    
    btnwan = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnwan setBounds:CGRectMake(0, 0, 70, 40)];
//    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
//    imagevi.backgroundColor = [UIColor clearColor];
//    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
//    [btnwan addSubview:imagevi];
//    [imagevi release];
    
    UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 9, 58, 26)];
    lilable.textColor = [UIColor whiteColor];
    lilable.backgroundColor = [UIColor clearColor];
    lilable.textAlignment = NSTextAlignmentCenter;
    lilable.font = [UIFont boldSystemFontOfSize:17];
    lilable.text = @"发送";
    lilable.tag = 10;
    [btnwan addSubview:lilable];
    [lilable release];
    [btnwan addTarget:self action:@selector(actionYanZheng) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnwan];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];
    
   
    
    
    mMessage = [[UITextView alloc] initWithFrame:CGRectMake(15, 0, self.mainView.frame.size.width - 30, self.mainView.frame.size.height - 47)];
    mMessage.backgroundColor = [UIColor clearColor];
    mMessage.font = [UIFont systemFontOfSize:14];
    mMessage.dataDetectorTypes = UIDataDetectorTypeAll;
//    mMessage.inputDelegate = self;
    mMessage.editable = YES;
    mMessage.delegate = self;
    [self.mainView addSubview:mMessage];
    [mMessage release];
    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
    
    myScrollView = [[UIScrollView alloc] init];
    myScrollView.frame = CGRectMake(0, self.mainView.bounds.size.height - 280, self.mainView.frame.size.width, 184);
    myScrollView.hidden = YES;
    myScrollView.scrollsToTop = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.delegate = self;
    myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width * 3, myScrollView.frame.size.height);
    myScrollView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    
    /******* 表情系统相关 ******/
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 3; i++) {
        [tempArray addObject:[NSNull null]];
    }
    self.viewControllers = tempArray;
    [tempArray release];
    
   
    
    
    
    myPageControl = [[UIPageControl alloc] init];
    myPageControl.backgroundColor = [UIColor clearColor];
    myPageControl.hidden = YES;
    myPageControl.frame = CGRectMake(0, self.mainView.bounds.size.height - 36, 320, 36);
    [self.mainView addSubview:myPageControl];
    [myPageControl release];
    
    
    [self toolBarFunc];//工具栏 同时转发 照片
    [self shareViewFunc];//分享按钮里的界面
    
    
    preinstallLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, 130, 30)];// 预留字
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        preinstallLabel.frame = CGRectMake(15, 2, 130, 30);
    }
    else {
        preinstallLabel.frame = CGRectMake(15, 10, 130, 15);
    }
    
    preinstallLabel.backgroundColor = [UIColor clearColor];
    preinstallLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
    [mMessage addSubview:preinstallLabel];
    preinstallLabel.font = [UIFont systemFontOfSize:14];
    
    
    if (microblogType == NewTopicController) {
        self.CP_navigation.title = @"发微博";
        preinstallLabel.text = @"说点什么吧...";
    }else if (microblogType == ForwardTopicController){
        self.CP_navigation.title = @"转发微博";
         preinstallLabel.text = @"说说分享心得...";
    }else if (microblogType == CommentTopicController){
        self.CP_navigation.title = @"评论微博";
        preinstallLabel.text = @"写评论...";
    }else if (microblogType == CommentRevert){
        self.CP_navigation.title = @"回复评论";
         preinstallLabel.text = @"写评论...";
    }else if (microblogType == ShareController){
        self.CP_navigation.title = @"分享微博";
         preinstallLabel.text = @"说点什么吧...";
    }
    
    mTextCount = [UIButton buttonWithType:UIButtonTypeCustom];//字数 按钮
    mTextCount.frame = CGRectMake(self.mainView.frame.size.width - 15 - 75,  toolView.frame.origin.y   - 15 - 30, 75, 30);
    mTextCount.titleLabel.textAlignment = NSTextAlignmentLeft;
    mTextCount.titleLabel.font = [UIFont systemFontOfSize:13];
    mTextCount.titleLabel.frame = CGRectMake(0, 0, 55, 30);
    mTextCount.titleLabel.textColor = [UIColor blackColor];
    [mTextCount setTitle:@"300" forState:UIControlStateNormal];
    [mTextCount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mTextCount addTarget:self action:@selector(pressMtextCount:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:mTextCount];
    
    UIImageView *chaimage = [[UIImageView alloc] initWithFrame:CGRectMake(55, 5, 20, 20)];
    chaimage.backgroundColor = [UIColor clearColor];
    chaimage.image = UIImageGetImageFromName(@"newwebox.png");
    [mTextCount addSubview:chaimage];
    [chaimage release];

    [mMessage becomeFirstResponder];
    
    if (microblogType == ShareController) {
//        if (weiBoContent.length) {
//            mMessage.text = weiBoContent;
//        }else{
            mMessage.text = @"#投注站 iPhone#";
//        }
//#ifdef isCaiPiaoForIPad
//        mMessage.text = @"#投注站 iPad#";
//#endif
        
        mIndex = mMessage.selectedRange;
        [self changeTextCount:mMessage.text];
    }
    
    if(microblogType == NewTopicController)
    {
        
        if ([mStatus.nick_name length] <= 0 || mStatus.nick_name == nil) {
            if (infoShare) {
                mMessage.text = @"分享自#投注站# iPhone版";
                canPublice = YES;
                //            mIndex = NSMakeRange([mMessage.text length], 0);
                mIndex = mMessage.selectedRange;
                [self changeTextCount:mMessage.text];
            }

        }
        if (infoShare) {
            
            if ([self.faxqUlr length] > 0) {
                
                NSArray * urlarr = [self.faxqUlr componentsSeparatedByString:@"~"];
                if ([urlarr count] > 1) {//方案想起分享 带连接 变色
                    
                    [keyArray addObject:[urlarr objectAtIndex:1]];
                    mMessage.text = [NSString stringWithFormat:@"%@%@", [urlarr objectAtIndex:0], [urlarr objectAtIndex:1]];
                    mIndex = mMessage.selectedRange;
                    [self changeTextCount:mMessage.text];
                }
                
                
                
                if (self.lottery_id) {
                    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"yaoqingxinxi"];
                    if (!str) {
                        str = @"一起合买这个方案";
                        
                    }
                    
                    [mMessage setText:[NSString stringWithFormat:@"%@%@", mMessage.text, str]];
                    mIndex = mMessage.selectedRange;
                    [self changeTextCount:str ];
                }
                
                
                
                [rangArray removeAllObjects];
                [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                    [self setupKeywordColorInTextView:mMessage ranges:rangArray];
                }
                
            }else{
                mMessage.text = @"分享自#投注站# iPhone版";
                canPublice = YES;
                //            mIndex = NSMakeRange([mMessage.text length], 0);
                mIndex = mMessage.selectedRange;
                [self changeTextCount:mMessage.text];
            }
           
        }
        
        if (mStatus && mStatus.nick_name) {
            NSString * str = [NSString stringWithFormat:@"%@ ", mStatus.nick_name];
            [mMessage setText:str];
            // NSLog(@"mMessage = %@", mStatus.nick_name);
            mIndex = mMessage.selectedRange;
            [self changeTextCount:str];
            
        }
        
        if (self.lottery_id) {
            if ([self.faxqUlr length] > 0) {
                
                NSArray * urlarr = [self.faxqUlr componentsSeparatedByString:@"~"];
                if ([urlarr count] > 1) {//方案想起分享 带连接 变色
                    
                    [keyArray addObject:[urlarr objectAtIndex:1]];
                    mMessage.text = [NSString stringWithFormat:@"%@%@", [urlarr objectAtIndex:0], [urlarr objectAtIndex:1]];
                    mIndex = mMessage.selectedRange;
                    [self changeTextCount:mMessage.text];
                }
                
                
                
                if (self.lottery_id) {
                    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"yaoqingxinxi"];
                    if (!str) {
                        str = @"一起合买这个方案";
                        
                    }
                    
                    [mMessage setText:[NSString stringWithFormat:@"%@%@", mMessage.text, str]];
                    mIndex = mMessage.selectedRange;
                    [self changeTextCount:str ];
                }
                
                
                
                [rangArray removeAllObjects];
                [rangArray addObjectsFromArray:[self foundAllKeywordRangeInString:mMessage.text usingKeyword:keyArray]];
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
                    [self setupKeywordColorInTextView:mMessage ranges:rangArray];
                }
                
            }
        }
    }
    if (microblogType == NewTopicController||microblogType == CommentTopicController) {
        kefuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        kefuButton.frame = CGRectMake((self.mainView.frame.size.width-89)/2, toolView.frame.origin.y - 57, 89, 57);
        [kefuButton addTarget:self action:@selector(pressKeFuButton:) forControlEvents:UIControlEventTouchUpInside];
        [kefuButton setImage:UIImageGetImageFromName(@"kfbuttonimagen.png") forState:UIControlStateNormal];
        [kefuButton setImage:UIImageGetImageFromName(@"kfbuttonimagen_1.png") forState:UIControlStateHighlighted];
        [self.mainView addSubview:kefuButton];
    }
    
    if (microblogType == ForwardTopicController) {
        if (![mStatus.orignal_id isEqualToString:@"0"]) {
            mMessage.text = [NSString stringWithFormat:@"//@%@:%@",  mStatus.nick_name,mStatus.mcontent];
            mIndex = mMessage.selectedRange;
            [self changeTextCount:mMessage.text];
        }
       
    }
   
    
    if (microblogType != ForwardTopicController ) {
        [self sendEnabledFunc];
    }
    
}

- (void)pressKeFuButton:(UIButton *)sender{
//    [mMessage resignFirstResponder];
//    KFButton * kfb = [[KFButton alloc] init];
//    [kfb kfbuttonbig];
//    [kfb release];
//    
//    NSArray * views = [caiboAppDelegate getAppDelegate].window.subviews;
//    
//    for (int i = 0; i<[views count]; i++) {
//        if ([[views objectAtIndex:i] isKindOfClass:[KFMessageBoxView class]]) {
//            KFMessageBoxView * kfm = [views objectAtIndex:i];
//            kfm.newpost = self;
//            kfm.newpostBool = YES;
//            break;
//        }
//    }
    
    KFMessageViewController *kfmBox=[KFMessageViewController alloc];
    
    kfmBox.showBool = YES;
    
    [kfmBox tsInfo];//调用提示信息
    
    [kfmBox returnSiXinCount];
    
    [self.navigationController pushViewController:kfmBox animated:YES];
    [kfmBox release];

    
}

- (void)pressMtextCount:(UIButton *)sender{
    [mMessage resignFirstResponder];
    CP_LieBiaoView *lb3 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    lb3.delegate = self;
    lb3.tag = 103;
    [lb3 LoadButtonName:[NSArray arrayWithObjects:@"清除文字",nil]];
    [lb3 show];
    [lb3 release];
}

#pragma mark 键盘监听
- (void) keyboardWillShow:(id)sender
{
    
     [self dismissFaceSystem];
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
    
    mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height - keybordHeight - mTextCount.frame.size.height - 10);
    toolView.frame = CGRectMake(toolView.frame.origin.x, self.mainView.frame.size.height - keybordHeight - toolView.frame.size.height, toolView.frame.size.width, toolView.frame.size.height);
    if (microblogType == NewTopicController||microblogType == CommentTopicController) {
        kefuButton.frame = CGRectMake(kefuButton.frame.origin.x, toolView.frame.origin.y - kefuButton.frame.size.height, kefuButton.frame.size.width, kefuButton.frame.size.height);
    }
     mTextCount.frame = CGRectMake(mTextCount.frame.origin.x,  toolView.frame.origin.y - 15 - 30, mTextCount.frame.size.width, mTextCount.frame.size.height);
    if (microblogType == ForwardTopicController || microblogType == CommentTopicController || microblogType == CommentRevert) {
        
        transmitView.frame = CGRectMake(transmitView.frame.origin.x, self.mainView.frame.size.height - keybordHeight - toolView.frame.size.height - transmitView.frame.size.height, transmitView.frame.size.width, transmitView.frame.size.height);
        mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height - keybordHeight - transmitView.frame.size.height - mTextCount.frame.size.height - 10);
    }
    
    if (microblogType == NewTopicController || microblogType == ShareController) {
        
       
        
        if (IS_IPHONE_5) {
             imageButtonPicture.frame = CGRectMake(15, self.mainView.frame.size.height - keybordHeight - toolView.frame.size.height - imageButtonPicture.frame.size.height - 15, 72, 72);
            
            if (imageButtonPicture.hidden == NO) {
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height - keybordHeight - imageButtonPicture.frame.size.height - 25);
            }
            
        }else{
        
             imageButtonPicture.frame = CGRectMake(15, 86, 72, 72);
            
            if (imageButtonPicture.hidden == NO) {
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, imageButtonPicture.frame.origin.y - 10);
            }
        }

    
    }
    shareView.hidden = YES;

    
}
- (void) keyboardWillDisapper:(id)sender
{
    
    CGRect keybordFrame;
    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
    mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height - mTextCount.frame.size.height- 10);
     toolView.frame = CGRectMake(toolView.frame.origin.x, self.mainView.frame.size.height  - toolView.frame.size.height, toolView.frame.size.width, toolView.frame.size.height);
    if (microblogType == NewTopicController||microblogType == CommentTopicController) {
        kefuButton.frame = CGRectMake(kefuButton.frame.origin.x, toolView.frame.origin.y - kefuButton.frame.size.height, kefuButton.frame.size.width, kefuButton.frame.size.height);
    }
    mTextCount.frame = CGRectMake(mTextCount.frame.origin.x,  toolView.frame.origin.y - 15 - 30, mTextCount.frame.size.width, mTextCount.frame.size.height);
    if (microblogType == ForwardTopicController || microblogType == CommentTopicController || microblogType == CommentRevert) {
        
        transmitView.frame = CGRectMake(transmitView.frame.origin.x, self.mainView.frame.size.height  - toolView.frame.size.height - transmitView.frame.size.height, transmitView.frame.size.width, transmitView.frame.size.height);
        
         mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height  - transmitView.frame.size.height - mTextCount.frame.size.height- 10);
    }
    
    if (microblogType == NewTopicController || microblogType == ShareController) {
//        imageButtonPicture.frame = CGRectMake(15, self.mainView.frame.size.height  - toolView.frame.size.height - imageButtonPicture.frame.size.height - 15, 72, 72);
        
        
        if (IS_IPHONE_5) {
            imageButtonPicture.frame = CGRectMake(15, self.mainView.frame.size.height -  - toolView.frame.size.height - imageButtonPicture.frame.size.height - 15, 72, 72);
            
            if (imageButtonPicture.hidden == NO) {
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, self.mainView.frame.size.height - toolView.frame.size.height  - imageButtonPicture.frame.size.height - 25);
            }
            
        }else{
            imageButtonPicture.frame = CGRectMake(15, self.mainView.frame.size.height -  - toolView.frame.size.height - imageButtonPicture.frame.size.height - 15, 72, 72);
//            imageButtonPicture.frame = CGRectMake(15, 86, 72, 72);
            
            if (imageButtonPicture.hidden == NO) {
                mMessage.frame = CGRectMake(mMessage.frame.origin.x, mMessage.frame.origin.y, mMessage.frame.size.width, imageButtonPicture.frame.origin.y - 10);
            }
        }
        
    }
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];


    
}

#pragma mark 发送微博按钮

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *returnStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [mReqUpload clearDelegatesAndCancel];
    if (microblogType == NewTopicController ) {
        NSString *content = [mMessage text];
        if (content == nil || [content length] == 0) {
            content = @"分享图片";
        }
        NSString *shareInfo =nil;
        if (share0) {
            shareInfo = @"share0=1";
            
            if (infoShare) {
                shareInfo = [NSString stringWithFormat:@"share0=%@", self.shareTo];//self.shareTo;
            }
            if (sinaMicroblogButton.selected) {
                shareInfo = @"share0=1";
            }
            else if (qqMicroblogButton.selected) {
                shareInfo = @"share0=2";
            }
            //                else if (Btn3.selected) {
            //                    shareInfo = @"share0=2";
            //                }
            
            
        }
        else {
            shareInfo = @"share0=0";
        }
        
        
        self.mReqUpload = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:content attachType:@"1" attach:returnStr type:@"1" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo shareorderId:lotteryID]];
        [mReqUpload setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mReqUpload setDelegate:self];
        [mReqUpload setTimeOutSeconds:20.0];
        [mReqUpload startAsynchronous];
    }
}

- (void)uploadHeadImage:(NSData*)imageData {//图片上传
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    if (!loadview.superview) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
    }
    NSString *text = @"正在发送微博...";
//    if (publishType == kOpinionFeedBack) {
//        text = @"正在发送意见反馈...";
//    }
    [[ProgressBar getProgressBar] show:text view:self.mainView];
    [ProgressBar getProgressBar].mDelegate = self;
    
//    [self getIPWithHostName:@"t.diyicai.com"];
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
    self.urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    [urlConnection start];
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
//    NSURL *serverURL = [NSURL URLWithString:@"http://t.diyicai.com/servlet/UploadGroupPic"];
//    
//    [mReqData clearDelegatesAndCancel];
//    self.mReqData = [ASIFormDataRequest requestWithURL:serverURL];
//    [mReqData addData:imageData withFileName:@"george.jpg" andContentType:@"image/jpeg" forKey:@"photos"];
//    [mReqData setUsername:@"upload"];
//    [mReqData setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [mReqData setDelegate:self];
//    [mReqData startAsynchronous];
//    NSLog(@"%@", mReqData.url);
}

//验证微博帮顶状态决定跳转
- (void)actionYanZheng {
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    if (!loadview.superview) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
    }
    
//    sinaMicroblogButton
//    qqMicroblogButton
    
    
    
    if (sinaMicroblogButton.selected || qqMicroblogButton.selected) {
        if (sinaMicroblogButton.selected) {
            
            share0 = NO;
            [mRequest clearDelegatesAndCancel];
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"1"]];
            
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDidFinishSelector:@selector(SinaFinish:)];
            [mRequest startAsynchronous];
            
        }
        else if (qqMicroblogButton.selected) {
            share0 = NO;
            [mRequest clearDelegatesAndCancel];
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"2"]];
            
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDidFinishSelector:@selector(qqFinish:)];
            [mRequest startAsynchronous];
            
        }
//        else if (Btn3.selected) {
//            share0 = NO;
//            [mRequest clearDelegatesAndCancel];
//            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"2"]];
//            
//            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//            [mRequest setDelegate:self];
//            [mRequest setTimeOutSeconds:20.0];
//            [mRequest setDidFinishSelector:@selector(qqFinish:)];
//            [mRequest startAsynchronous];
//            
//        }
        return;
    }
    if ([self.shareTo length]) {
        if ([self.shareTo isEqualToString:@"1"]) {
            
            
            [mRequest clearDelegatesAndCancel];
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"1"]];
            
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDidFinishSelector:@selector(SinaFinish:)];
            [mRequest startAsynchronous];
            
        }
        else if ([self.shareTo isEqualToString:@"2"]) {
            share0 = YES;
            [mRequest clearDelegatesAndCancel];
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"2"]];
            
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDidFinishSelector:@selector(qqFinish:)];
            [mRequest startAsynchronous];
        }
        else if ([self.shareTo isEqualToString:@"3"]){
            share0 = YES;
            [mRequest clearDelegatesAndCancel];
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL queryUnionshareBlogStatus:[[Info getInstance]userName] Type:@"3"]];
            
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest setDidFinishSelector:@selector(qqZoneFinish:)];
            [mRequest startAsynchronous];
        }else{
            [self actionPublish:nil];
        }
        return;
    }

    [self actionPublish:nil];
}
- (void)ShareControllerRequest{
    NSString *isComment = @"0";
    NSString *content = [mMessage text];
    if (![mStatus.orignal_id isEqualToString:@"0"]) {// 要转发的微博本身就是一条转发微博
        
        if (transmitButton.selected) {
            isComment = @"1";
        }
    } else {
        
        if (transmitButton.selected) {
            isComment = @"1";
        }
    }
    if ([content length] == 0) {
        content = @"转发微博";
    }
    
    [mRequest clearDelegatesAndCancel];
    NSString *shareInfo =nil;
    if ([shareTo length]) {
        shareInfo = [NSString stringWithFormat:@"share0=%@",shareTo];
    }
    else {
        shareInfo = @"share0=0";
    }
    if (microblogType == ShareController) {
        if ([shareTo length]) {
//            if (weiBoContent.length) {
//                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:weiBoContent attachType:@"0" attach:@"" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo shareorderId:lotteryID]];
//            }else{
                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL sendTopicMessageToMqtopicId:mStatus.topicid ShareSource:shareTo Content:content orderID:lotteryID]];
//            }
        }
        else {
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL sendTopicMessageToMqtopicId:mStatus.topicid ShareSource:@"1" Content:content orderID:lotteryID]];
        }
        
    }
    else {
        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:mStatus.topicid content:content attachType:@"0" attach:@"" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:mStatus.orignal_id is_comment:isComment share:shareInfo shareorderId:lotteryID]];
    }
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setTimeOutSeconds:20.0];
    [mRequest startAsynchronous];
    [[ProgressBar getProgressBar] show:@"正在转发微博..." view:self.mainView];
    [ProgressBar getProgressBar].mDelegate = self;
}
// 发布帖子
- (void)actionPublish:(UIButton *)sender {
    NSLog(@"aaaaaaaa");
    btnwan.enabled =  NO;
    [mMessage resignFirstResponder];
    [MobClick event:@"event_weibofasong"];
    if (microblogType != ForwardTopicController ) {
        NSString * messString = [mMessage.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([messString length] == 0 && mSelectImage == nil) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有发表任何东西" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            
            
//            [[caiboAppDelegate getAppDelegate] showMessage:@"您还没有发表任何东西"];
            
            
            btnwan.enabled = YES;
            [loadview stopRemoveFromSuperview];
            loadview = nil;
            return;
        }
    }
    
    if ([mTextCount.titleLabel.text intValue] < 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容已经超出字数限制" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        btnwan.enabled = YES;
        [loadview stopRemoveFromSuperview];
        loadview = nil;
        return;
    }
    if (microblogType == CommentTopicController) {// 评论微博
        NSString *is_trans_topic = @"0";
        if (transmitButton.selected) {
            is_trans_topic = @"1";
        }
        
        [mRequest clearDelegatesAndCancel];
        if (cpthree) {
            NSString *shareInfo =nil;
            if (share0) {
                if (sinaMicroblogButton.selected) {
                    shareInfo = @"share0=1";
                }
                else if (qqMicroblogButton.selected){
                    shareInfo = @"share0=2";
                }
//                else if (Btn3.selected){
//                    shareInfo = @"share0=2";
//                }
                
            }
            else {
                shareInfo = @"share0=0";
            }
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsaveYtComment:mStatus.topicid content:[mMessage text] userId:[[Info getInstance] userId] is_trans_topic:is_trans_topic source:@"1" share:shareInfo]];
            
            
            //            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CPThreeSendPreditTopicIssue:@"" userid:[[Info getInstance] userId] lotteryId:@"" lotteryNumber:@"" content:[mMessage text]]];
            //            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            //            [mRequest setDelegate:self];
            //            [mRequest setDidFinishSelector:@selector(FaBiaoDidFinishSelector:)];
            //            [mRequest setNumberOfTimesToRetryOnTimeout:2];
            //            [mRequest startAsynchronous];
            
            
        }else{
            NSString *shareInfo =nil;
            if (share0) {
                shareInfo = @"share0=1";
            }
            else {
                shareInfo = @"share0=0";
            }
            
            self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsaveYtComment:mStatus.topicid content:[mMessage text] userId:[[Info getInstance] userId] is_trans_topic:is_trans_topic source:@"1" share:shareInfo]];
            
            [mRequest setUsername:@"comment"];
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest startAsynchronous];
        }
        [[ProgressBar getProgressBar] show:@"发送微博评论..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
        
        return;
    }
    
    if (microblogType == CommentRevert) {// 评论回复
        NSString *totop = @"0";
        if (transmitButton.selected) {
            totop = @"1";
        }
        
        [mRequest clearDelegatesAndCancel];
        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsendComment:[[Info getInstance] userId] content:[mMessage text] topicId:mStatus.topicid source:@"1" totop:totop]];
        [mRequest setUsername:@"comment"];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest startAsynchronous];
        [[ProgressBar getProgressBar] show:@"发送微博评论..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
        return;
    }
    
    if (microblogType == NewTopicController ) {// 新微博和意见反馈
        if (mSelectImage) {
            
//            float width  = mSelectImage.size.width;
//            float height = mSelectImage.size.height;
//            float scale;
//            
//            if (width > height) {
//                scale = 640.0 / width;
//            } else {
//                scale = 480.0 / height;
//            }
            
//            if (scale >= 1.0) {
                [self uploadHeadImage:UIImageJPEGRepresentation(mSelectImage, 1.0)];
//            } else if (scale < 1.0) {
//                [self uploadHeadImage:UIImageJPEGRepresentation([mSelectImage scaleAndRotateImage:640], 1.0)];
//            }
        } else {
            if (microblogType == NewTopicController ) {
                [mRequest clearDelegatesAndCancel];
                
                if (three) {//我来预测
                    
                    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CPThreeSendPreditTopicIssue:@"" userid:[[Info getInstance] userId] lotteryId:caizhong lotteryNumber:@"" content:[mMessage text] endtime:@""]];
                    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [mRequest setDelegate:self];
                    [mRequest setTimeOutSeconds:20.0];
                    [mRequest startAsynchronous];
                    
                    [[ProgressBar getProgressBar] show:@"正在发送微博..." view:self.mainView];
                    [ProgressBar getProgressBar].mDelegate = self;
                }else{
                    NSString *shareInfo =nil;
                    if (share0) {
                        shareInfo = @"share0=1";
                        
                        
                        if (sinaMicroblogButton.selected) {
                            shareInfo = @"share0=1";
                        }
                        else if (qqMicroblogButton.selected) {
                            shareInfo = @"share0=2";
                        }
//                        else if (Btn3.selected) {
//                            shareInfo = @"share0=2";
//                        }
                        
                        
                    }
                    else {
                        shareInfo = @"share0=0";
                    }
                    if (orderID) {
                        if ([[mMessage text] rangeOfString:@"@"].location == NSNotFound) {
                            if (loadview) {
                                [loadview stopRemoveFromSuperview];
                                loadview = nil;
                            }
                            
                            
                            UIImageView *imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"yaqi960.png")];
                            [self.mainView addSubview:imageV];
//#ifdef isCaiPiaoForIPad
//                            
//                            imageV.frame = CGRectMake(170, pzImage.frame.origin.y - 40, 154.5, 42.5);
//#else
                            
                            imageV.frame = CGRectMake(45, toolView.frame.origin.y - 50, 154.5, 42.5);
//#endif
                            
                            [imageV release];
                            UILabel *label = [[UILabel alloc] init];
                            label.font = [UIFont systemFontOfSize:13];
                            label.frame =CGRectMake(0, 0, imageV.frame.size.width, 34);
                            label.text = @"从@里选择要邀请的人";
                            label.textAlignment = NSTextAlignmentCenter;
                            label.textColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1];
                            label.backgroundColor = [UIColor clearColor];
                            [imageV addSubview:label];
                            [label release];
                            [imageV performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
                            btnwan.enabled = YES;
                            
                            return;
                        }
//                        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:[mMessage text] attachType:@"15" attach:@"0" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo orderId:orderID lottery_id:lottery_id play:play]];
                        
                         self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:[mMessage text] attachType:@"0" attach:@"" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo shareorderId:lotteryID]];
                        
                        [[NSUserDefaults standardUserDefaults] setValue:mMessage.text forKey:@"yaoqingxinxi"];
                    }
                    else {
                        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:[mMessage text] attachType:@"0" attach:@"" type:@"0" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo shareorderId:lotteryID]];
                    }
                    
                    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [mRequest setDelegate:self];
                    [mRequest setTimeOutSeconds:20.0];
                    [mRequest startAsynchronous];
                    
                    [[ProgressBar getProgressBar] show:@"正在发送微博..." view:self.mainView];
                    [ProgressBar getProgressBar].mDelegate = self;
                    
                }
            }
//            else if (microblogType == kOpinionFeedBack) {/////////////
//                //　问题反馈
//                NSMutableString *str = [[NSMutableString alloc] initWithCapacity:40];
//                [str appendFormat:@"%@%@",OpinionTEXT,[[Info getInstance] cbVersion]];
//                [str appendFormat:@"%@",[mMessage text]];
//                mMessage.text = str;
//                
//                [mRequest clearDelegatesAndCancel];
//                self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBqA:[[Info getInstance] userId] Content:str AttachType:0 Attach:@""]];
//                [mRequest setUsername:@"opinion"];
//                [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//                [mRequest setDelegate:self];
//                [mRequest setTimeOutSeconds:20.0];
//                [mRequest startAsynchronous];
//                [[ProgressBar getProgressBar] show:@"正在发送..." view:self.mainView];
//                [ProgressBar getProgressBar].mDelegate = self;
//                [str release];
//            }
        }
    } else if (microblogType == ForwardTopicController || microblogType == ShareController) {// 转发微博
        
     
        
        [self ShareControllerRequest];
    }
}



- (void) requestFailed:(ASIHTTPRequest *)request {
    NSString * st = [request responseString];
    NSDictionary * dict = [st JSONValue];
    if ([dict objectForKey:@"security_code"]) {
        if ([[dict objectForKey:@"security_code"] intValue] != 1) {
            [[ProgressBar getProgressBar] dismiss];
            return;
        }
    }
    [[ProgressBar getProgressBar] setTitle:@"请检查您的网络,重新请求"];
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(failedFunc)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)failedFunc{
    btnwan.enabled = YES;
//    [loadview stopRemoveFromSuperview];
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    [[ProgressBar getProgressBar] dismiss];
}

- (void) onTimer : (id) sender {
    btnwan.enabled = YES;
//    [loadview stopRemoveFromSuperview];
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    [[ProgressBar getProgressBar] dismiss];
    [self dismissSelf:YES];
   
}

//-(NSString*)getIPWithHostName:(const NSString*)hostName
//{
//    const char *hostN= [hostName UTF8String];
//    struct hostent* phot;
//    
//    @try {
//        phot = gethostbyname(hostN);
//        
//    }
//    @catch (NSException *exception) {
//        return nil;
//    }
//    
//    struct in_addr ip_addr;
//    memcpy(&ip_addr, phot->h_addr_list[0], 4);
//    char ip[20] = {0};
//    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
//    
//    NSString* strIPAddress = [NSString stringWithUTF8String:ip];
//    return strIPAddress;
//}

#pragma mark 数据请求成功
// 接收服务器返回JSON数据
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    NSLog(@"=======Result：%@", result);
    // 上传图片
    if ([request.username isEqualToString:@"upload"]) {
        
        if (!result) {
            return;
        }
        
        [mReqUpload clearDelegatesAndCancel];
        if (microblogType == NewTopicController ) {
            NSString *content = [mMessage text];
            if (content == nil || [content length] == 0) {
                content = @"分享图片";
            }
            NSString *shareInfo =nil;
            if (share0) {
                shareInfo = @"share0=1";
                
                if (infoShare) {
                    shareInfo = [NSString stringWithFormat:@"share0=%@", self.shareTo];//self.shareTo;
                }
                if (sinaMicroblogButton.selected) {
                    shareInfo = @"share0=1";
                }
                else if (qqMicroblogButton.selected) {
                    shareInfo = @"share0=2";
                }
//                else if (Btn3.selected) {
//                    shareInfo = @"share0=2";
//                }
                
                
            }
            else {
                shareInfo = @"share0=0";
            }
            
            
            self.mReqUpload = [ASIHTTPRequest requestWithURL:[NetURL CBSaveYtTopic:@"" content:content attachType:@"1" attach:result type:@"1" userId:[[Info getInstance] userId] source:@"1" orignalId:@"" is_comment:@"0" share:shareInfo shareorderId:lotteryID]];
            [mReqUpload setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mReqUpload setDelegate:self];
            [mReqUpload setTimeOutSeconds:20.0];
            [mReqUpload startAsynchronous];
        }
//        else if (microblogType == ShareController){
//        
//            [self ShareControllerRequest];
//        
//        }
        
        
        
//        else if (publishType == kOpinionFeedBack) {
//            //　问题反馈
//            NSMutableString *str = [[NSMutableString alloc] initWithCapacity:40];
//            [str appendFormat:@"%@%@",OpinionTEXT,[[Info getInstance] cbVersion]];
//            [str appendFormat:@"%@",[mMessage text]];
//            mMessage.text = str;
//            
//            self.mReqUpload = [ASIHTTPRequest requestWithURL:[NetURL CBqA:[[Info getInstance] userId] Content:str AttachType:1 Attach:result]];
//            [mReqUpload setUsername:@"opinion"];
//            [mReqUpload setDefaultResponseEncoding:NSUTF8StringEncoding];
//            [mReqUpload setDelegate:self];
//            [mReqUpload setTimeOutSeconds:20.0];
//            [mReqUpload startAsynchronous];
//            [str release];
//        }
        return;
    }

    // 评论
    NSDictionary *resultDict = [result JSONValue];
    if ([request.username isEqualToString:@"comment"]) {
        if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [[ProgressBar getProgressBar] setTitle:@"评论成功!"];
        } else if([[resultDict objectForKey:@"code"] isEqualToString:@"0"]){
            [[ProgressBar getProgressBar] setTitle:@"微博发布成功!"];
        }else {
            
            if ([[resultDict objectForKey:@"errorMsg"] length]) {
                [[ProgressBar getProgressBar] setTitle:[resultDict objectForKey:@"errorMsg"]];
            }
            else {
                [[ProgressBar getProgressBar] setTitle:@"微博发布失败!"];
            }
        }
    } else if ([request.username isEqualToString:@"opinion"]) {
        if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [[ProgressBar getProgressBar] setTitle:@"问题反馈成功!"];
        } else {
            [[ProgressBar getProgressBar] setTitle:@"问题反馈失败,请重试!"];
        }
    } else {// 发布和转发
        if (microblogType == ShareController) {
//            if ([weiBoContent length]) {
//                if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
//                    [[ProgressBar getProgressBar] setTitle:@"发布成功!"];
//                }else if([[resultDict objectForKey:@"code"] isEqualToString:@"0"]){
//                    [[ProgressBar getProgressBar] setTitle:@"微博发布成功!"];
//                }else  {
//                    if ([[resultDict objectForKey:@"errorMsg"] length]) {
//                        [[ProgressBar getProgressBar] setTitle:[resultDict objectForKey:@"errorMsg"]];
//                    }
//                    else {
//                        [[ProgressBar getProgressBar] setTitle:@"微博发布失败!"];
//                    }
//                    
//                }
//            }else{
                if([[resultDict objectForKey:@"code"] intValue] == 1){
                    [[ProgressBar getProgressBar] setTitle:@"微博分享成功!"];
                    
                }else  {
                    [[ProgressBar getProgressBar] setTitle:@"微博分享失败!"];
                }
//            }
        }
        else  if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [[ProgressBar getProgressBar] setTitle:@"发布成功!"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeibo" object:nil];
            [[Info getInstance] setIsNeedRefreshHome:YES];
            // 删除草稿
//            if (publishType == kEditTopicController && mDraft) {
//                [Draft deleteDraft:mDraft.mDate];
//            }
        }else if([[resultDict objectForKey:@"code"] isEqualToString:@"0"]){
            [[ProgressBar getProgressBar] setTitle:@"微博发布成功!"];
            
            
        }else  {
            if ([[resultDict objectForKey:@"errorMsg"] length]) {
                [[ProgressBar getProgressBar] setTitle:[resultDict objectForKey:@"errorMsg"]];
            }
            else {
                [[ProgressBar getProgressBar] setTitle:@"微博发布失败!"];
            }
        }
    }
    [NSTimer scheduledTimerWithTimeInterval:0.8
                                     target:self
                                   selector:@selector(onTimer:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)SinaFinish:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSDictionary *dic = [responseString JSONValue];
    btnwan.enabled = YES;
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([[dic objectForKey:@"code"] integerValue] == 1) {
//        Btn1.selected = YES;
        share0 = YES;
        [self actionPublish:nil];
    }
    else {
        
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBBangDing:@"1"];
        NSLog(@"%@",sina.sinaURL);
        sina.title = @"新浪绑定";
        sina.isBangDing = YES;
        sina.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
        //        }
    }
}

- (void)qqZoneFinish:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSDictionary *dic = [responseString JSONValue];
    btnwan.enabled = YES;
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([[dic objectForKey:@"code"] integerValue] == 1) {
//        Btn2.selected = YES;
        share0 = YES;
        [self actionPublish:nil];
    }
    else {
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBBangDing:@"3"];
        NSLog(@"%@",sina.sinaURL);
        sina.title = @"QQ空间绑定";
        sina.isBangDing = YES;
        sina.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
        
    }
}

- (void)qqFinish:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSDictionary *dic = [responseString JSONValue];
    btnwan.enabled = YES;
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([[dic objectForKey:@"code"] integerValue] == 1) {
//        Btn3.selected = YES;
        share0 = YES;
        [self actionPublish:nil];
    }
    else {
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBBangDing:@"2"];
        NSLog(@"%@",sina.sinaURL);
        sina.title = @"腾讯微博绑定";
        sina.isBangDing = YES;
        sina.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
    }
}







- (void)dealloc{
    [self.urlConnection cancel];
    self.faxqUlr = nil;
    [keyArray release];
    self.textString = nil;
    [rangArray release];
    self.myyuce = nil;
    self.weiBoContent = nil;
    self.caizhong = nil;
    self.play = nil;
    self.lottery_id = nil;
    self.orderID = nil;
    [mReqData clearDelegatesAndCancel];
    self.mReqData = nil;
    [mStatus release];
    self.shareTo = nil;
    self.lotteryID = nil;
    [mReqUpload clearDelegatesAndCancel];
    [mReqUpload release];
    [mRequest clearDelegatesAndCancel];
    [mRequest release];
    [viewControllers release];
    [mSelectImage release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 字体变色

- (NSArray *)foundAllKeywordRangeInString:(NSString *)targetString usingKeyword:(NSArray *)keywordArray
{
    NSMutableArray *rangeArray = [NSMutableArray array];
    
    
    
    for (int i = 0; i < [keywordArray count]; i++) {
        NSUInteger textIndex = 0;
        NSRange textRange;
        NSString *subString = targetString;
        NSString * keyword = [keywordArray objectAtIndex:i];
        do {
            textRange = [subString rangeOfString:keyword];
            
            if (textRange.location != NSNotFound) {
                NSUInteger rangeSum = (textRange.location + textRange.length);
                subString = [subString substringWithRange:NSMakeRange(rangeSum, subString.length - rangeSum)];
                textRange.location += textIndex;
                [rangeArray addObject:[NSValue valueWithRange:textRange]];
                textIndex += rangeSum;
            }
        } while (textRange.location != NSNotFound);
    }
    
    
    return rangeArray;
}

- (void)setupKeywordColorInTextView:(UITextView *)textView ranges:(NSArray *)ranges
{
    
   
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textView.text];
    
    for (NSValue *eachValue in ranges) {
        
        
        [attributedString addAttribute:NSFontAttributeName value:mMessage.font range:[eachValue rangeValue]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:141/255.0 blue:254/255.0 alpha:1] range:[eachValue rangeValue]];
    }
    
    textView.attributedText = attributedString;
//    if ([mMessage.text length] >= mIndex.location) {
         mMessage.selectedRange = NSMakeRange(mIndex.location, 0);
//    }
    [attributedString release];
}
- (void)prograssBarBtnDeleate:(NSInteger) type;
{
    [mReqData clearDelegatesAndCancel];
    
    [mRequest clearDelegatesAndCancel];
    
    [mReqUpload clearDelegatesAndCancel];
    
    [[ProgressBar getProgressBar] dismiss];
    
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    