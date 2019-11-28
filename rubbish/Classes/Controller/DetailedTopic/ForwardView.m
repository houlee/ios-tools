//
//  ForwardView.m
//  caibo
//
//  Created by jeff.pluto on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ForwardView.h"
#import "ColorUtils.h"
#import "ImageDownloader.h"
#import "ImageStoreReceiver.h"
#import "CommentViewController.h"
#import "NewPostViewController.h"
#import "DetailedViewController.h"
#import "caiboAppDelegate.h"
#import "UIImageExtra.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "MyWebViewController.h"
#import "TouZhuShowView.h"
#import "NetURL.h"
#import "JSON.h"
#import "DataBase.h"
#import "PreJiaoDianTabBarController.h"
#import "ShuangSeQiuInfoViewController.h"
#import "SendMicroblogViewController.h"
#import "SharedDefine.h"

@implementation ForwardView

@synthesize mStatus;
@synthesize butfor;
@synthesize mRequest;
@synthesize delegatea;
@synthesize homebool;

// 确定该视图的尺寸，回调设置滚动条视图内容尺寸
- (void) onMeasure {
    int height = 0;
    for (UIView *child in [self subviews]) {
        height += child.frame.size.height;
    }
    
//    self.frame = CGRectMake(0, 0, 290, height + 30);
    self.frame = CGRectMake(0, 0, 320, height + 20);
    [self setNeedsDisplay];
    [self setNeedsLayout];
    
    UIView *mParent = (UIView *) (self.superview);
    if ([mParent respondsToSelector:@selector(onMeasure)]) {
        [mParent performSelector:@selector(onMeasure)];
    }
}

- (void)clikeOrderIdURL:(NSURLRequest *)request1 {
    if ([[NSString stringWithFormat:@"%@",[request1 URL]] hasPrefix:@"http://caipiao365.com"]) {
        NSString *topic = [[NSString stringWithFormat:@"%@",[request1 URL]] stringByReplacingOccurrencesOfString:@"http://caipiao365.com/" withString:@""];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSArray *array = [topic componentsSeparatedByString:@"&"];
        for (int i = 0; i < [array count]; i ++) {
            NSString *st = [array objectAtIndex:i];
            NSArray *array2 = [st componentsSeparatedByString:@"="];
            if ([array2 count] >= 2) {
                [dic setValue:[array2 objectAtIndex:1] forKey:[array2 objectAtIndex:0]];
            }
        }
        if ([dic objectForKey:@"wbxq"]) {
            [mRequest clearDelegatesAndCancel];
            [self setMRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:[dic objectForKey:@"wbxq"]]]];
            [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [mRequest setDelegate:self];
            [mRequest setTimeOutSeconds:20.0];
            [mRequest startAsynchronous];
            return;
        }
        else if ([[dic objectForKey:@"faxq"] length]) {
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.orderId = [dic objectForKey:@"faxq"];
            UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
            [NV setNavigationBarHidden:NO];
            [info.navigationController setNavigationBarHidden:NO];
            if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
                PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
                NSLog(@"%@",VC);
                
                [VC.selectedViewController.navigationController pushViewController:info animated:YES];
            }
            else {
                [NV pushViewController:info animated:YES];
            }
            
            [info release];
            return;
        }
        
    }
    MyWebViewController *my = [[MyWebViewController alloc] init];
	[my LoadRequst:request1];
	[my setHidesBottomBarWhenPushed:YES];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:my animated:YES];
        if (VC.selectedIndex == 0) {
            [my.navigationController setNavigationBarHidden:NO];
        }
    }
    else {
        [NV pushViewController:my animated:YES];
    }
	[my release];
}

- (void)requestFinished:(ASIHTTPRequest *)request1 {
    NSString *result = [request1 responseString];
    YtTopic *mStatus2 = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus2 arrayList] objectAtIndex:0]];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:detailed animated:YES];
    }
    else {
        [NV pushViewController:detailed animated:YES];
    }
    [detailed setHidesBottomBarWhenPushed:YES];
    [detailed release];
    
    [mStatus2 release];
}

// 请求投注详情
- (void)sendPreditTopic {
	
	TouZhuShowView *t = [[TouZhuShowView alloc] init];
	if([mStatus isFangan:mStatus.attach_type_ref]&&[mStatus isZhiChiBiSai:mStatus.lottery_id_ref]&&mStatus.orignalTextBounds.size.height && mStatus.orignalText) {
		[t showTouzhuWithTopicId:mStatus.orignal_id];
	}
	else {
		[t showTouzhuWithTopicId:mStatus.topicid];
	}
	[t release];
}

- (void)returnYtTopicData:(YtTopic *)yttopic{
    if ([delegatea respondsToSelector:@selector(returnYtTopicData:)]) {
        [delegatea returnYtTopicData:yttopic];
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
 NSLog(@"aaaaaaaaaaaaaaaaddddddddddddddddd111111111111111111111");
    [mRequest clearDelegatesAndCancel];
    NSLog(@"soldddddddddddddaaaaaaaaaaaaa= %@", mStatus.orignal_id);
    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:mStatus.orignal_id]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(unReadPushNumData:)];
    [mRequest setNumberOfTimesToRetryOnTimeout:2];
    [mRequest setShouldContinueWhenAppEntersBackground:YES];
    [mRequest startAsynchronous];
    
}
- (void)unReadPushNumData:(ASIHTTPRequest *)mrequest{
    NSString *result = [mrequest responseString];
    YtTopic *mStatuss = [[YtTopic alloc] initWithParse:result];
    YtTopic *mStatuss2 = [mStatuss.arrayList objectAtIndex:0];
    

    
    
  
   
 
//    [[NSUserDefaults standardUserDefaults] setValue:tatus forKey:@"zhengwenuser"];
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"zhengwenhanshu" object:tatus];
    [self returnYtTopicData:mStatuss2];
    [mStatuss release];
    
  
}

//获取图片
- (NSData *)getImageFromDB:(NSString*)url {
    NSData *data = nil;
    static Statement *stmt1 = nil;
    if (stmt1 == nil) {
        stmt1 = [DataBase statementWithQuery:"SELECT image FROM images WHERE url=?"];
        [stmt1 retain];
    }
    // SELECT image FROM images... ---> 返回的表中image排第一位(0),url(1)排第二位;没有DATA_TIME
    [stmt1 bindString:url forIndex:1];
    if ([stmt1 step] == SQLITE_ROW) {
        data = [stmt1 getData:0];
    }
	[stmt1 reset];
	return data;
}

- (id)initWithMessage:(YtTopic *)message homebol:(BOOL)hobol{
    if ((self = [super init])) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setMStatus:message];
        if ([mStatus.oriDelFlag intValue] == 2) {
            self.userInteractionEnabled = NO;
        }
        if (mStatus.content_ref) {
            NSMutableString *buffer = [[[NSMutableString alloc] init] autorelease];
            [buffer appendString:@"<a href='?wd="];
			if (mStatus.nick_name_ref) {
				[buffer appendString:mStatus.nick_name_ref];
				[buffer appendString:@"+'"];
			}
            [buffer appendString:@" style='text-decoration:none'>"];
			if (mStatus.nick_name_ref) {
				[buffer appendString:mStatus.nick_name_ref];
				[buffer appendString:@"："];
			}
            [buffer appendString:@"</a>"];
            [buffer appendString:mStatus.content_ref];
            
            ColorLabel *mLabel = [[[ColorLabel alloc] initWithText:buffer hombol:hobol] autorelease];
//            ColorLabel *mLabel = [[[ColorLabel alloc] initWithText:[NSString stringWithFormat:@"<font size=\"4.5\">%@</font>",buffer] hombol:hobol] autorelease];
            
            mLabel.frame = CGRectMake(WEIBO_ZHENGWEN_X, WEIBO_ZHENGWEN_Y, 290,20);
            mLabel.tag = 1111;
            [self performSelector:@selector(loadColorLab) withObject:nil afterDelay:0.1];
//            while (mLabel.isHidden) {
//                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[[NSDate date] dateByAddingTimeInterval:10]];
//            }
//            float height = [mLabel getHtmlHeight];
//            CGRect mLabelFrame=CGRectMake(mLabel.frame.origin.x, mLabel.frame.origin.y, mLabel.frame.size.width, height);
//            mLabel.frame=mLabelFrame;
//            NSLog(@"%f",mLabel.frame.size.height);
//            
//            NSLog(@"bool = %d", hobol);
//            [mLabel setMaxWidth:290];
            mLabel.backgroundColor=[UIColor clearColor];
            mLabel.userInteractionEnabled = NO;
			mLabel.colorLabeldelegate = self;
            
            [self addSubview:mLabel];
        }
        
        //        butfor = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [butfor addTarget:self action:@selector(pressButtonFor:) forControlEvents:UIControlEventTouchUpInside];
        //        butfor.hidden = YES;
        //        [self addSubview:butfor];
        
        
        // 有图片
        if ([mStatus.attach_type_ref isEqualToString:@"1"] && [mStatus.attach_small_ref length] > 0) {
            
            receiver = [[ImageStoreReceiver alloc] init];
            receiver.imageContainer = self;
            
            mImageViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [mImageViewBtn.layer setBorderWidth:1.0];
            [mImageViewBtn.layer setCornerRadius:0.0];
            [mImageViewBtn.layer setBorderColor:[UIColor userMailListTimeColor].CGColor];
            [mImageViewBtn.layer setMasksToBounds:YES];
            [mImageViewBtn setBackgroundColor: [UIColor clearColor]];
            mImageViewBtn.tag = 100;// 标记为显示图片按钮
            
            // 下载图片
            if (imageUrl != mStatus.attach_ref) {
                [imageUrl release];
            }
            imageUrl = [mStatus.attach_ref copy];
            
            UIImage *image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : imageUrl Delegate:receiver DefautImage:nil];
//            if (image.size.height > 180 && 180.0*image.size.width/image.size.height <= 150) {
//                image = [image rescaleImageToSize:CGSizeMake(180.0*image.size.width/image.size.height, 180)];
//            }
//            else if (image.size.width > 150 && 150*image.size.height/image.size.width <= 180 ) {
//                image = [image rescaleImageToSize:CGSizeMake(150, 150*image.size.height/image.size.width)];
//            }
            image = [image rescaleImageToSize:CGSizeMake(266, 266*image.size.height/image.size.width)];
            NSData *data = [self getImageFromDB:imageUrl];
            if (!gifView) {
                gifView =[[GifView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height) ImageData:data];
                gifView.tag = 100;
                [self addSubview:gifView];
                [gifView release];
            }
            else {
                [gifView ReLoadImageData:data WithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
            }
            if (!image) {
                gifView.frame = CGRectMake(0, 0, 150, 180);
                jinduImage = [[UIImageView alloc] init];
                jinduImage.frame = CGRectMake(15, 150, 115.5, 7.5);
                [mImageViewBtn addSubview:jinduImage];
                                    [mImageViewBtn setImage:UIImageGetImageFromName(@"loadingDefault.png") forState:UIControlStateNormal];
                jinduImage.backgroundColor = [UIColor clearColor];
                UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(1.5, 1, 5, 5.5)];
                [jinduImage addSubview:whiteView];
                whiteView.backgroundColor = [UIColor whiteColor];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:2.0f];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                whiteView.frame = CGRectMake(1.5, 1, 100, 5.5);
                [UIView commitAnimations];
                [jinduImage release];
                [whiteView release];
            }
            
            mImageViewBtn.frame = gifView.bounds;
            if (gifView.count == 1) {
                [mImageViewBtn setImage:[image rescaleImageToSize:CGSizeMake(image.size.width - 5, image.size.height - 5)] forState:(UIControlStateNormal)];
            }
            [mImageViewBtn addTarget:self action:@selector(actionShowPhoto:) forControlEvents:(UIControlEventTouchUpInside)];
            if (image != [ImageDownloader defaultProfileImage:YES]) {
                mImageViewBtn.enabled = YES;
            } else {
                mImageViewBtn.enabled = NO;
            }
            [gifView addSubview:mImageViewBtn];
        }
        if([mStatus isFangan:mStatus.attach_type_ref]&&[mStatus isZhiChiBiSai:mStatus.lottery_id_ref]&&mStatus.orignalTextBounds.size.height && mStatus.orignalText){
			UIView *btnBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 47.5)];
			UIButton *matchVSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			[matchVSBtn addTarget:self action:@selector(sendPreditTopic) forControlEvents:UIControlEventTouchUpInside];
			matchVSBtn.frame = CGRectMake(40, 0, 130, 47.5);
			[matchVSBtn setImage:UIImageGetImageFromName(@"wb_touzhuzhanshi.png") forState:UIControlStateNormal];
			[btnBack addSubview:matchVSBtn];
			[self addSubview:btnBack];
			btnBack.backgroundColor = [UIColor clearColor];
			[btnBack release];
			matchVSBtn.backgroundColor = [UIColor clearColor];
		}
		
//        UIView *mBtnCon = [[[UIView alloc] initWithFrame:CGRectMake(135, 0, 250, 14)] autorelease];
//        mForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [mForwardBtn setAdjustsImageWhenHighlighted:YES];
//        mCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        mForwardBtn.tag = 1;
//        //[mForwardBtn setImage:UIImageGetImageFromName(@"zhuanfaimage.png") forState:(UIControlStateNormal)];
//        UIImageView *zfImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 12, 12)];
////        zfImage.image = UIImageGetImageFromName(@"zhuanfaimage.png");
//        zfImage.backgroundColor = [UIColor clearColor];
//        [mForwardBtn addSubview:zfImage];
//        [zfImage release];
//        //[mCommentBtn setImage:UIImageGetImageFromName(@"pinglunimage.png") forState:(UIControlStateNormal)];
//        UIImageView *plImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 12, 12)];
////        plImage.image = UIImageGetImageFromName(@"pinglunimage.png");
//        plImage.backgroundColor = [UIColor clearColor];
//        [mCommentBtn addSubview:plImage];
//        [plImage release];
//        // 按钮标题和颜色
////        [mForwardBtn setTitle:mStatus.count_zf_ref forState:(UIControlStateNormal)];
////        [mCommentBtn setTitle:mStatus.count_pl_ref forState:(UIControlStateNormal)];
//        [mForwardBtn setTitleColor:[UIColor replyAndCommentInHomeCellColor] forState:(UIControlStateNormal)];
//        [mCommentBtn setTitleColor:[UIColor replyAndCommentInHomeCellColor] forState:(UIControlStateNormal)];
//        [[mForwardBtn titleLabel] setFont:[UIFont systemFontOfSize:12]];
//        [[mCommentBtn titleLabel] setFont:[UIFont systemFontOfSize:12]];
//        // 按钮图片和文字内间距
//        [mForwardBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 0))];
//        [mCommentBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 0))];
//        mForwardBtn.frame = CGRectMake(195, 0, 50, 20);
//        mCommentBtn.frame = CGRectMake(233, 0, 50, 20);
////		if (![mStatus.oriDelFlag isEqualToString:@"2"]) {
////			[mForwardBtn addTarget:self action:@selector(actionOrignalForward:) forControlEvents:(UIControlEventTouchUpInside)];
////			[mCommentBtn addTarget:self action:@selector(actionOrignalComment:) forControlEvents:(UIControlEventTouchUpInside)];
////		}
//        [mBtnCon addSubview:mForwardBtn];
//        [mBtnCon addSubview:mCommentBtn];
//
//		
//        [self addSubview:mBtnCon];
        
        [self onMeasure];
        [self layoutSubviews];
        

        
    }
    return self;

}
-(void)loadColorLab
{
    ColorLabel * mLabel = (ColorLabel *)[self viewWithTag:1111];
    
    while (mLabel.isHidden) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[[NSDate date] dateByAddingTimeInterval:10]];
    }
    float height = [mLabel getHtmlHeight];
    mLabel.frame=CGRectMake(mLabel.frame.origin.x, mLabel.frame.origin.y, mLabel.frame.size.width, height);
    NSLog(@"%f",mLabel.frame.size.height);
    
    [self onMeasure];
    [self layoutSubviews];
}
- (id) initWithMessage:(YtTopic *)message {
    if ((self = [super init])) {
        self.backgroundColor = [UIColor clearColor];

        [self setMStatus:message];
        if ([mStatus.oriDelFlag intValue] == 2) {
            self.userInteractionEnabled = NO;
        }
        if (mStatus.content_ref) {
            NSMutableString *buffer = [[[NSMutableString alloc] init] autorelease];
            [buffer appendString:@"<a href='?wd="];
			if (mStatus.nick_name_ref) {
				[buffer appendString:mStatus.nick_name_ref];
				[buffer appendString:@"+'"];
			}
            [buffer appendString:@" style='text-decoration:none'>"];
			if (mStatus.nick_name_ref) {
				[buffer appendString:mStatus.nick_name_ref];
				[buffer appendString:@"："];
			}
            [buffer appendString:@"</a>"];
            [buffer appendString:mStatus.content_ref];
            
            ColorLabel *mLabel = [[[ColorLabel alloc] initWithText:buffer] autorelease];
            
            [mLabel setMaxWidth:280];
            mLabel.userInteractionEnabled = NO;
			mLabel.colorLabeldelegate = self;
            [self addSubview:mLabel];
        }
        
//        butfor = [UIButton buttonWithType:UIButtonTypeCustom];
//        [butfor addTarget:self action:@selector(pressButtonFor:) forControlEvents:UIControlEventTouchUpInside];
//        butfor.hidden = YES;
//        [self addSubview:butfor];
        
        
        // 有图片
        if ([mStatus.attach_type_ref isEqualToString:@"1"] && [mStatus.attach_small_ref length] > 0) {
            
            receiver = [[ImageStoreReceiver alloc] init];
            receiver.imageContainer = self;
            
            mImageViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [mImageViewBtn.layer setBorderWidth:1.0];
            [mImageViewBtn.layer setCornerRadius:0.0];
            [mImageViewBtn.layer setBorderColor:[UIColor userMailListTimeColor].CGColor];
            [mImageViewBtn.layer setMasksToBounds:YES];
            [mImageViewBtn setBackgroundColor: [UIColor whiteColor]];
            mImageViewBtn.tag = 100;// 标记为显示图片按钮
            
            // 下载图片
            if (imageUrl != mStatus.attach_small_ref) {
                [imageUrl release];
            }
            imageUrl = [mStatus.attach_small_ref copy];
            
            UIImage *image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : imageUrl Delegate:receiver Big:YES];
            if (image.size.width > 150 && image.size.height > 180) {
                image = [image rescaleImageToSize:CGSizeMake(150, 180)];
            }
            
            mImageViewBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            [mImageViewBtn setImage:[image rescaleImageToSize:CGSizeMake(image.size.width - 5, image.size.height - 5)] forState:(UIControlStateNormal)];
            [mImageViewBtn addTarget:self action:@selector(actionShowPhoto:) forControlEvents:(UIControlEventTouchUpInside)];
            if (image != [ImageDownloader defaultProfileImage:YES]) {
                mImageViewBtn.enabled = YES;
            } else {
                mImageViewBtn.enabled = NO;
            }
           // [self addSubview:mImageViewBtn];
        }
        if([mStatus isFangan:mStatus.attach_type_ref]&&[mStatus isZhiChiBiSai:mStatus.lottery_id_ref]&&mStatus.orignalTextBounds.size.height && mStatus.orignalText){
			UIView *btnBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 47.5)];
			UIButton *matchVSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			[matchVSBtn addTarget:self action:@selector(sendPreditTopic) forControlEvents:UIControlEventTouchUpInside];
			matchVSBtn.frame = CGRectMake(40, 0, 130, 47.5);
			[matchVSBtn setImage:UIImageGetImageFromName(@"wb_touzhuzhanshi.png") forState:UIControlStateNormal];
			[btnBack addSubview:matchVSBtn];
			[self addSubview:btnBack];
			btnBack.backgroundColor = [UIColor clearColor];
			[btnBack release];
			matchVSBtn.backgroundColor = [UIColor clearColor];
		}
		
        UIView *mBtnCon = [[[UIView alloc] initWithFrame:CGRectMake(135, 0, 250, 14)] autorelease];
        mForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mForwardBtn setAdjustsImageWhenHighlighted:YES];
        mCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        mForwardBtn.tag = 1;
        //[mForwardBtn setImage:UIImageGetImageFromName(@"replysmall.png") forState:(UIControlStateNormal)];
        //[mForwardBtn setImage:UIImageGetImageFromName(@"zhuanfaimage.png") forState:UIControlStateNormal];
        UIImageView *zfImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 12, 12)];
        zfImage.image = UIImageGetImageFromName(@"zhuanfaimage.png");
        zfImage.backgroundColor = [UIColor clearColor];
        [mForwardBtn addSubview:zfImage];
        [zfImage release];
        //[mCommentBtn setImage:UIImageGetImageFromName(@"commentsmall.png") forState:(UIControlStateNormal)];
        //[mCommentBtn setImage:UIImageGetImageFromName(@"pinglunimage.png") forState:UIControlStateNormal];
        UIImageView *plImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 12, 12)];
        plImage.image = UIImageGetImageFromName(@"pinglunimage.png");
        plImage.backgroundColor = [UIColor clearColor];
        [mCommentBtn addSubview:plImage];
        [plImage release];

        // 按钮标题和颜色
        [mForwardBtn setTitle:mStatus.count_zf_ref forState:(UIControlStateNormal)];
        [mCommentBtn setTitle:mStatus.count_pl_ref forState:(UIControlStateNormal)];
        [mForwardBtn setTitleColor:[UIColor replyAndCommentInHomeCellColor] forState:(UIControlStateNormal)];
        [mCommentBtn setTitleColor:[UIColor replyAndCommentInHomeCellColor] forState:(UIControlStateNormal)];
        [[mForwardBtn titleLabel] setFont:[UIFont systemFontOfSize:12]];
        [[mCommentBtn titleLabel] setFont:[UIFont systemFontOfSize:12]];
        // 按钮图片和文字内间距
        [mForwardBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 0))];
        [mCommentBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 0))];
        mForwardBtn.frame = CGRectMake(165, 0, 50, 20);
        mCommentBtn.frame = CGRectMake(203, 0, 50, 20);
//		if (![mStatus.oriDelFlag isEqualToString:@"2"]) {
//			[mForwardBtn addTarget:self action:@selector(actionOrignalForward:) forControlEvents:(UIControlEventTouchUpInside)];
//			[mCommentBtn addTarget:self action:@selector(actionOrignalComment:) forControlEvents:(UIControlEventTouchUpInside)];
//		}
        [mBtnCon addSubview:mForwardBtn];
        [mBtnCon addSubview:mCommentBtn];
		
		
        [self addSubview:mBtnCon];
        
        [self onMeasure];
        [self layoutSubviews];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //CGContextRef context = UIGraphicsGetCurrentContext();
//    float x = rect.origin.x ;
//    float y = rect.origin.y ;
//    float w = rect.size.width ;
//    float h = rect.size.height ;
//    //float r = 5.0;// 圆角
//    [[UIImageGetImageFromName(@"wb40.png") stretchableImageWithLeftCapWidth:40 topCapHeight:20] drawInRect:CGRectMake(x, y,w, h)];
    
    
//    ytImage.frame = CGRectMake(x, y, w, h);
//    CGMutablePathRef path = CGPathCreateMutable();
    // 矩形
//    CGPathMoveToPoint(path, NULL, x, y + r);
//    CGPathAddArcToPoint(path, NULL, x, y + h, x + r, y + h, r);
//    CGPathAddArcToPoint(path, NULL, x + w, y + h, x + w, y + h - r, r);
//    CGPathAddArcToPoint(path, NULL, x + w, y, x + w - r, y, r);
//    CGPathAddArcToPoint(path, NULL, x, y, x, y + r,r);
//    
//    // 箭头
//    CGPathMoveToPoint(path, NULL, x + r + 10.0, y);
//    CGPathAddLineToPoint(path, NULL, x + r + 15.0, y - 6);
//    CGPathAddLineToPoint(path, NULL, x + r + 21.0, y);
//    
//    // 边框
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    CGFloat borderColour[4] = {180.0/255.0, 180.0/255.0, 180.0/255.0, 1.0};
//    CGContextSetLineWidth(context, 1.0);
//    CGContextAddPath(context, path);
//    //CGContextSetStrokeColorSpace(context, CGColorSpaceCreateDeviceRGB());
//    CGContextSetStrokeColor(context, borderColour);
//    CGContextStrokePath(context);
//    
//    CGSize shadowOffset = CGSizeMake(0, 0);
//    CGContextSaveGState(context);
//    CGContextSetShadow (context, shadowOffset, 5);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    CGFloat shadowColour[4] = {120.0/255.0, 120.0/255.0, 120.0/255.0, 0.3};
//    CGContextSetLineWidth(context, 2.0);
//    CGContextAddPath(context, path);
//    //CGContextSetStrokeColorSpace(context, CGColorSpaceCreateDeviceRGB());
//    CGContextSetStrokeColor(context, shadowColour);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
//    
//    // 填充矩形内部颜色
//    CGContextAddPath(context, path);
////    CGContextSetFillColorSpace(context, CGColorSpaceCreateDeviceRGB());
//    CGFloat fillColour[4] = {229.0/255.0, 229.0/255.0, 231.0/255.0, 1};
//    CGContextSetFillColor(context, fillColour);
//    CGContextEOFillPath(context);
//    // 释放内存
//    CFRelease(path);
}

// 接收网络图片
- (void)updateImage:(UIImage*)image {
    if (image) {
        jinduImage.hidden = YES;
//        if (image.size.height > 180 && 180.0*image.size.width/image.size.height <= 150) {
//            image = [image rescaleImageToSize:CGSizeMake(180.0*image.size.width/image.size.height, 180)];
//        }
//        else if (image.size.width > 150 && 150*image.size.height/image.size.width <= 180 ) {
//            image = [image rescaleImageToSize:CGSizeMake(150, 150*image.size.height/image.size.width)];
//        }
        image = [image rescaleImageToSize:CGSizeMake(266, 266*image.size.height/image.size.width)];
        if (image) {
            NSData *data = [self getImageFromDB:imageUrl];
            if (!gifView) {
                gifView =[[GifView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height) ImageData:data];
                [self addSubview:gifView];
                gifView.tag = 100;
                [gifView release];
            }
            else {
                [gifView ReLoadImageData:data WithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
                gifView.hidden = NO;
            }
        }
        gifView.hidden = NO;
        if (gifView.count == 1) {
            [mImageViewBtn setImage:[image rescaleImageToSize:CGSizeMake(image.size.width - 5, image.size.height - 5)] forState:(UIControlStateNormal)];
        }
        else {
            [mImageViewBtn setImage:nil forState:(UIControlStateNormal)];
        }
        mImageViewBtn.enabled = YES;
        mImageViewBtn.frame = gifView.bounds;
        [self onMeasure];
        [self layoutSubviews];
    }
}

// 响应查看图片
- (void) actionShowPhoto:(id)sender {    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    if ([mStatus.attach_type isEqualToString:@"1"]) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:mStatus.attach]]];
    } else if ([mStatus.attach_type_ref isEqualToString:@"1"]) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:mStatus.attach_ref]]];
    } else {
        [photos addObject:[MWPhoto photoWithImage:mImageViewBtn.imageView.image]];
    }
    
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    [photoBrowser setPhotoType : kTypeWithURL];
    [photos release];
    
#ifdef isCaiPiaoForIPad
    
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    
    
    [NV pushViewController:photoBrowser animated:NO];
    [photoBrowser release];
#else
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] >= 6) {
        [navController.navigationBar setBackgroundImage:[UIImageGetImageFromName(@"SDH960.png") stretchableImageWithLeftCapWidth:7 topCapHeight:20] forBarMetrics:UIBarMetricsDefault];
    }
    navController.navigationBarHidden = NO;
    [photoBrowser release];
    if (navController) {
        [[DetailedViewController getShareController] presentViewController:navController animated: YES completion:nil];
    }
    [navController release];
#endif
    
   
}

// 响应转发/评论
- (void) actionOrignalForward:(UIButton *)sender {
#ifdef isCaiPiaoForIPad
    YtTopic *mOrignal = [[YtTopic alloc] init];
    mOrignal.nick_name = mStatus.nick_name_ref;
    mOrignal.content = mStatus.content_ref;
    mOrignal.topicid = mStatus.orignal_id;
    mOrignal.orignal_id = @"0";
    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kForwardTopicController mStatus:mOrignal];
    [mOrignal release];
    
#else
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    YtTopic *mOrignal = [[YtTopic alloc] init];
//    mOrignal.nick_name = mStatus.nick_name_ref;
//    mOrignal.content = mStatus.content_ref;
//    mOrignal.topicid = mStatus.orignal_id;
//    mOrignal.orignal_id = @"0";
//    publishController.mStatus = mOrignal;
//    publishController.publishType = kForwardTopicController;// 转发
//    [[DetailedViewController getShareController].navigationController  pushViewController:publishController animated:YES];
//    [mOrignal release];
//	[publishController release];
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    YtTopic *mOrignal = [[YtTopic alloc] init];
    mOrignal.nick_name = mStatus.nick_name_ref;
    mOrignal.content = mStatus.content_ref;
    mOrignal.topicid = mStatus.orignal_id;
    mOrignal.orignal_id = @"0";
    publishController.mStatus = mOrignal;
    [mOrignal release];
    publishController.microblogType = ForwardTopicController;// 转发
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [[DetailedViewController getShareController] presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
#endif
}

// 评论
- (void) actionOrignalComment : (UIButton *) sender {
    YtTopic *mOrignal = [[YtTopic alloc] init];
    mOrignal.nick_name = mStatus.nick_name_ref;
    mOrignal.content = mStatus.content_ref;
    mOrignal.topicid = mStatus.orignal_id;
    mOrignal.orignal_id = @"0";
    CommentViewController *commentController = [[CommentViewController alloc] initWithMessage:mOrignal];
    [[DetailedViewController getShareDetailedView].navigationController pushViewController:commentController animated:YES];
    [mOrignal release];
    [commentController release];
}

- (void) actionRefresh:(YtTopic *) status {
    [self setMStatus:status];
//    [mForwardBtn setTitle:mStatus.count_zf_ref forState:(UIControlStateNormal)];
//    [mCommentBtn setTitle:mStatus.count_pl_ref forState:(UIControlStateNormal)];
}

- (void) layoutSubviews {
    int left = self.bounds.origin.x;
    int top = self.bounds.origin.y + 8;
    int right = self.bounds.size.width;
    int bottom = self.bounds.size.height;
    
    NSArray *childArray = [self subviews];
    for(UIView *child in childArray) {
        if(child.hidden == YES){
            continue;
        }
        if(bottom - top <= 0) {
            child.frame = CGRectMake(left, top, 0, 0);
            continue;
        }
        int pw = child.frame.size.width;
        int ph = child.frame.size.height;
//        int px = left;
        int px = left+15;
        if (child.tag == 100) {// 图片按钮
            px = (right - pw) / 2;
        }
        child.frame = CGRectMake(px, top, pw, ph);
        top += (ph + 5);// mGap
    }
}

- (void)dealloc {
    [mRequest clearDelegatesAndCancel];
    [mRequest release];
    receiver.imageContainer = nil;
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:imageUrl];
    [imageUrl release];
    [receiver release];
    
    [mStatus release];
    
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    