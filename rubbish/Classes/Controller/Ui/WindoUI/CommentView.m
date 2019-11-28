//
//  CommentView.m
//  caibo
//
//  Created by jeff.pluto on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CommentView.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "NetURL.h"
#import "JSON.h"
#import "NSStringExtra.h"

@implementation CommentView

static UIImage *commentImg = nil;
@synthesize mComment;
@synthesize myRequest;
@synthesize passWord;
@synthesize mutableArray;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
#ifdef isGuanliyuanBanben
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(240, 20, 60, 30);
    [self addSubview:btn1];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"删除评论" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:11];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(deleteComment) forControlEvents:UIControlEventTouchUpInside];
#endif
    
    return self;
}

- (CGSize) getTextSize : (NSString *) text {
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(285, 1000);
    CGSize labelsize = [text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}

//删除评论
- (void)deleteComment {
//    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(40, 50, 200, 20)];
//    textF.placeholder = @"请输入管理员密码";
//    textF.tag = 201;
//    textF.autocorrectionType = UITextAutocorrectionTypeYes;
//    textF.secureTextEntry = YES;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"要删除评论,请输入密码" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//    alert.tag = 111;
//    [alert show];
//    [alert addSubview:textF];
//    textF.backgroundColor = [UIColor whiteColor];
//    [alert release];
    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请输入管理员密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertTpye = passWordType;
    alert.tag = 111;
    [alert show];
    [alert release];
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{

    if (buttonIndex == 1) {
        self.passWord = message;
//        UITextField *text = (UITextField *)[alertView viewWithTag:201];
        if ([self.passWord length] == 0) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入密码"];
            return;
        }
        if (alertView.tag == 111) {
            [self.myRequest clearDelegatesAndCancel];
            self.myRequest = [ASIHTTPRequest requestWithURL:[NetURL deleteCommon:mComment.ycid Username:[[Info getInstance] userName] Password:self.passWord]];
            [myRequest setTimeOutSeconds:20.0];
            [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [myRequest setDidFinishSelector:@selector(recievedeleteCommetInfo:)];
            [myRequest setDelegate:self];
            [myRequest startAsynchronous];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
//        UITextField *text = (UITextField *)[alertView viewWithTag:201];
        if ([self.passWord length] == 0) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入密码"];
            return;
        }
        if (alertView.tag == 111) {
            [self.myRequest clearDelegatesAndCancel];
            self.myRequest = [ASIHTTPRequest requestWithURL:[NetURL deleteCommon:mComment.ycid Username:[[Info getInstance] userName] Password:self.passWord]];
            [myRequest setTimeOutSeconds:20.0];
            [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [myRequest setDidFinishSelector:@selector(recievedeleteCommetInfo:)];
            [myRequest setDelegate:self];
            [myRequest startAsynchronous];
        }
    }
}

- (void)recievedeleteCommetInfo:(ASIHTTPRequest *)request {
    NSDictionary *dic = [[request responseString] JSONValue];
    [[caiboAppDelegate getAppDelegate] showMessage:[dic objectForKey:@"msg"]];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSString * st = [request responseString];
    NSDictionary * dict = [st JSONValue];
    if ([dict objectForKey:@"security_code"]) {
        if ([[dict objectForKey:@"security_code"] intValue] != 1) {
            return;
        }
    }
    [[caiboAppDelegate getAppDelegate] showMessage:@"请求失败"];
}

+ (UIImage *) getCommentImage {
    if (commentImg == nil) {
        commentImg = [UIImageGetImageFromName(@"comment.png") retain];
    }
    return commentImg;
}
-(void)textChangeToArray:(NSString *)text
{
    if(!text || [text isEqualToString:@""])
        return;
    NSRange rangeLeft = [text rangeOfString:@"["];
    NSRange rangRight = [text rangeOfString:@"]"];
    
    if(rangeLeft.location != NSNotFound && rangRight.location != NSNotFound)
    {
        NSString *tmpString = nil;
        if([text hasPrefix:@"["])
        {
            tmpString = [text substringToIndex:rangRight.location];
            text = [text substringFromIndex:rangRight.location+1];

        }
        else
        {
            tmpString = [text substringToIndex:rangeLeft.location];
            text = [text substringFromIndex:rangeLeft.location];

        }
        
        [self.mutableArray addObject:tmpString];
        [self textChangeToArray:text];
        

    }
    if(rangeLeft.location != NSNotFound && rangRight.location == NSNotFound)
    {
        NSString *tmpString = [text substringToIndex:rangeLeft.location];
        [self.mutableArray addObject:tmpString];
        NSString *tmpString1= [text substringFromIndex:rangeLeft.location];
        [self.mutableArray addObject:tmpString1];
    }
    if(rangeLeft.location == NSNotFound && rangRight.location == NSNotFound){
    
        [self.mutableArray addObject:text];
    }
}
- (void)drawRectIphone:(CGRect)rect{
    
    if (mComment.nickName) {
//        mComment.vip = @"2";
        if ([mComment.vip isEqualToString:@"2"]) {
            [[UIColor redColor] set];
        }else{
            [[UIColor blackColor] set];
        }
    }
   
    
    [mComment.nickName drawInRect:CGRectMake(10, 5, 220, 22) withFont:[UIFont boldSystemFontOfSize:16]];
    
    [[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1] set];
    
    if ([mComment.nickName hasPrefix:@"我 回复"]) {
//        [mComment.createtime drawAtPoint:CGPointMake(150, 5) withFont:[UIFont systemFontOfSize:13]];
        [mComment.createtime drawAtPoint:CGPointMake(200-10, 5) withFont:[UIFont systemFontOfSize:10]];
    } else {
//        [mComment.createtime drawAtPoint:CGPointMake(150, 5) withFont:[UIFont systemFontOfSize:13]];
        [mComment.createtime drawAtPoint:CGPointMake(200-10, 5) withFont:[UIFont systemFontOfSize:10]];
    }
    NSLog(@"louceng = %@", mComment.louceng);
    
    CGSize  size33 = CGSizeMake(100, 20);
//    CGSize labelSize33 = [mComment.louceng sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:size33 lineBreakMode:UILineBreakModeWordWrap];
    CGSize labelSize33 = [mComment.louceng sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:size33 lineBreakMode:UILineBreakModeWordWrap];
    
//    [mComment.louceng drawAtPoint:CGPointMake(300-labelSize33.width, 5) withFont:[UIFont systemFontOfSize:13]];
    [mComment.louceng drawAtPoint:CGPointMake(300-labelSize33.width, 5) withFont:[UIFont systemFontOfSize:10]];
    
    CGSize size = [self getTextSize:mComment.content];
    
    if(!self.mutableArray)
    {
        mutableArray = [[NSMutableArray alloc] initWithCapacity:0];
      
    }
    if ([self.mutableArray count] == 0) {
          [self textChangeToArray:mComment.content];
    }
    
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    
    CGFloat x = 10;
    CGFloat y = 30;
    
    if(self.mutableArray && self.mutableArray.count >=1)
    {
        for(int i = 0;i<[self.mutableArray count];i++)
        {
            NSString *emoji = [self.mutableArray objectAtIndex:i];

            NSRange rang = [emoji rangeOfString:@"["];
            if(rang.location == NSNotFound)
            {
                [[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1] set];
            }
            else
            {
                [[UIColor colorWithRed:16/255.0 green:124/255.0 blue:163/255.0 alpha:1] set];

            }
            NSString *tem = [[emoji stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]"withString:@""];
            NSString *imageN = [NSString stringWithFormat:@"%@.png",tem];
            UIImage *image = UIImageGetImageFromName(imageN);
            size = [tem sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
            //NSLog(@"----------->>>>> size.width %f size.height %f",size.width,size.height);
//            if (x >= self.frame.size.width-size.width)
//            {
//                x = 10;
//                y += size.height;
//            }
            if (image) {
                [image drawInRect:CGRectMake(x, y, 22, 22)];
            }
            else {
                NSString *imageName = [tem stringToFace];
                imageName = [NSString stringWithFormat:@"%@.png",imageName];
                UIImage *imageNew = UIImageGetImageFromName(imageName);
                size = [tem sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
                if (imageNew) {
                    [imageNew drawInRect:CGRectMake(x, y, 22, 22)];
                }
                else {
                    for (int j = 0; j < [emoji length]; j++)
                    {
                        NSString *tem = [emoji substringWithRange:NSMakeRange(j, 1)];
                        NSLog(@"~~~~~~~~~~~tem~~~~~~~~~~~~%@",tem);
                        size = [tem sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
                        //NSLog(@"----------->>>>> size.width %f size.height %f",size.width,size.height);
                        if (x >= self.frame.size.width - 28 - size.width)
                        {
                            x = 10;
                            y += size.height;
                        }
                        
                        [tem drawInRect:CGRectMake(x, y, size.width, size.height) withFont:font];
                        
                        x += size.width;
                        //NSLog(@"x %f y %f",x,y);
                    }
                }
                

            }
            
            
            x += size.width;
        }
        
        [mutableArray release];
        mutableArray = nil;

    }
    else
    {
        [[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1] set];
        [mComment.content drawInRect:CGRectMake(10, 30, 285, size.height) withFont:[UIFont systemFontOfSize:14]];
    }



    UIImage *img = [CommentView getCommentImage];
    [img drawInRect:CGRectMake(280, (rect.size.height - img.size.height) / 2, img.size.width, img.size.height)];
}

- (void)drawRectIpad:(CGRect)rect{
    [mComment.nickName drawInRect:CGRectMake(10, 5, 220, 22) withFont:[UIFont boldSystemFontOfSize:16]];
    
    [[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1] set];
    if ([mComment.nickName hasPrefix:@"我 回复"]) {
        [mComment.createtime drawAtPoint:CGPointMake(150+18, 5) withFont:[UIFont systemFontOfSize:13]];
    } else {
        [mComment.createtime drawAtPoint:CGPointMake(150+18, 5) withFont:[UIFont systemFontOfSize:13]];
    }
    NSLog(@"louceng = %@", mComment.louceng);
    
    CGSize  size33 = CGSizeMake(100, 20);
    CGSize labelSize33 = [mComment.louceng sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:size33 lineBreakMode:UILineBreakModeWordWrap];
    
    [mComment.louceng drawAtPoint:CGPointMake(370-labelSize33.width, 5) withFont:[UIFont systemFontOfSize:13]];
    CGSize size = [self getTextSize:mComment.content];
	[[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1] set];
    [mComment.content drawInRect:CGRectMake(10, 30, 355, size.height) withFont:[UIFont systemFontOfSize:14]];
    
    UIImage *img = [CommentView getCommentImage];
    [img drawInRect:CGRectMake(350, (rect.size.height - img.size.height) / 2, img.size.width, img.size.height)];
}

- (void)drawRect:(CGRect)rect {
    
    
    
    
#ifdef isCaiPiaoForIPad
    [self drawRectIpad:rect];
    
#else
    [self drawRectIphone:rect];
#endif
    
}

- (void)dealloc {
    [self.myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    [mComment release];
    [super dealloc];
    
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    