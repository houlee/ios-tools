//
//  DetailedView.m
//  caibo
//
//  Created by jeff.pluto on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailedView.h"
#import "StringUtil.h"
#import "ImageDownloader.h"
#import "ColorLabel.h"
#import "ColorUtils.h"
#import "ForwardView.h"
#import "NewPostViewController.h"
#import "CommentViewController.h"
#import "DetailedViewController.h"
#import "caiboAppDelegate.h"
#import "UIImageExtra.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "MyWebViewController.h"
#import "TouZhuShowView.h"
#import "DataBase.h"
#import "PreJiaoDianTabBarController.h"
#import "NetURL.h"
#import "Info.h"
#import "JSON.h"
#import "ShuangSeQiuInfoViewController.h"
#import "SendMicroblogViewController.h"
//#import "CPPhotoView.h"
#import "SharedDefine.h"

@implementation DetailedView
@synthesize homebool;
@synthesize request;
@synthesize guanliRequest;

@synthesize mStatus,segmentedControl,detaildelegate, passWord;

- (void)zhengwenyttopic:(YtTopic *)stat{
    if (detaildelegate) {
		[detaildelegate zhengwenyttopic:stat];
	}
}

- (void)returnYtTopicData:(YtTopic *)yttopic{
    NSLog(@"ytt = %@", yttopic.nick_name);
    [self zhengwenyttopic:yttopic];
}

// 确定该视图的尺寸，回调设置滚动条视图内容尺寸
- (void) onMeasure {
    int height = 0;
    for (UIView *child in [self subviews]) {
        if ([child isKindOfClass:[GifView class]]) {
            NSLog(@"111");
        }
        height += child.frame.size.height;
    }
//    self.frame = CGRectMake(0, 0, 320, height + [[self subviews] count] * 8);
    self.frame = CGRectMake(0, 0, 320, height + (unsigned long)[[self subviews] count] * 8);
#ifdef isCaiPiaoForIPad
    self.frame = CGRectMake(0, 0, 390, height + (unsigned long)[[self subviews] count] * 8);
#endif
    [self setNeedsLayout];
    [self setNeedsDisplay];
    //    UIScrollView *mScrollView = (UIScrollView *) self.superview;
    //    mScrollView.contentSize = CGSizeMake(320, self.frame.size.height + 1000);
    //    [mScrollView setNeedsLayout];
}

- (void)loadTopic {
	
}

- (void)clikeOrderIdURL:(NSURLRequest *)request1 {
    NSString *url = [NSString stringWithFormat:@"%@",[request1 URL]];
    if ([url hasPrefix:@"http://caipiao365.com"]) {
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
            [request clearDelegatesAndCancel];
            [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:[dic objectForKey:@"wbxq"]]]];
            [request setDefaultResponseEncoding:NSUTF8StringEncoding];
            [request setDelegate:self];
            [request setTimeOutSeconds:20.0];
            [request startAsynchronous];
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
    [my LoadRequst:request1];
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
	if([mStatus isFangan:mStatus.attach_type_ref]&&mStatus.orignalTextBounds.size.height && mStatus.orignalText) {
		[t showTouzhuWithTopicId:mStatus.orignal_id];
	}
	else {
		[t showTouzhuWithTopicId:mStatus.topicid];
	}
	[t release];
}

////单击方法
//-(void)handelSingleTap:(UITapGestureRecognizer*)gestureRecognizer{
//    NSLog(@"aaaaaaaaaaaaaaaaaa111111111111111111111");
//
//}

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

- (void)downLoadChange {
    
}

- (id) initWithMessage:(YtTopic *)message homebol:(BOOL)hobol{
    if ((self = [super init])) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setMStatus:message];
        ColorLabel *mLabel = [[[ColorLabel alloc] initWithText:mStatus.content hombol:hobol] autorelease];
        
//        ColorLabel *mLabel = [[[ColorLabel alloc] initWithText:[NSString stringWithFormat:@"<font size=\"4.5\">%@</font>",mStatus.content] hombol:hobol] autorelease];
        
        mLabel.frame = CGRectMake(WEIBO_ZHENGWEN_X, WEIBO_ZHENGWEN_Y, 290,20);
//        while (mLabel.isHidden) {
//            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[[NSDate date] dateByAddingTimeInterval:10]];
//        }
//        float height = [mLabel getHtmlHeight];
//        CGRect mLabelFrame=CGRectMake(mLabel.frame.origin.x, mLabel.frame.origin.y, mLabel.frame.size.width, height);
//        mLabel.frame=mLabelFrame;
        mLabel.tag = 1111;
//        NSLog(@"%f",mLabel.frame.size.height);
        
        
        [self performSelector:@selector(loadColorLab) withObject:nil afterDelay:0.1];
        
        //        mLabel.scrollView.showsVerticalScrollIndicator = NO;
        //        mLabel.scrollView.exclusiveTouch = NO;
        mLabel.backgroundColor=[UIColor clearColor];
		mLabel.colorLabeldelegate = self;
//        [mLabel setMaxWidth:290];
        [self addSubview:mLabel];
        
        //　原帖
        if ([mStatus.orignal_id isEqualToString:@"0"]) {
            if ([mStatus.attach_type isEqualToString:@"1"] && [mStatus.attach_small length] > 0) {
                
                receiver = [[ImageStoreReceiver alloc] init];
                receiver.imageContainer = self;
                
                mImageViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                if (imageUrl != mStatus.attach) {
                    [imageUrl release];
                }
                imageUrl = [mStatus.attach copy];
                
                UIImage *image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : imageUrl Delegate:receiver DefautImage:nil];
                
//                if (image.size.height > 180 && 180.0*image.size.width/image.size.height <= 150) {
//                    image = [image rescaleImageToSize:CGSizeMake(180.0*image.size.width/image.size.height, 180)];
//                }
//                else if (image.size.width > 150 && 150*image.size.height/image.size.width <= 180 ) {
//                    image = [image rescaleImageToSize:CGSizeMake(150, 150*image.size.height/image.size.width)];
//                }
                image = [image rescaleImageToSize:CGSizeMake(296, 296*image.size.height/image.size.width)];
                NSData *data = [self getImageFromDB:imageUrl];
                if (!gifView) {
                    gifView =[[GifView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height) ImageData:data];
                    [self addSubview:gifView];
                    gifView.hidden = NO;
                    [gifView release];
                }
                else {
                    [gifView ReLoadImageData:data WithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
                    gifView.hidden = NO;
                }
                if (!image) {
                    gifView.frame = CGRectMake(0, 0, 150, 180);
                    jinduImage = [[UIImageView alloc] init];
                    jinduImage.frame = CGRectMake(15, 150, 115.5, 7.5);
                    [mImageViewBtn addSubview:jinduImage];
                    jinduImage.image = UIImageGetImageFromName(@"jinDuImage.png");
                    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(1.5, 1, 5, 5.5)];
                    [jinduImage addSubview:whiteView];
                    whiteView.backgroundColor = [UIColor whiteColor];
                    [mImageViewBtn setImage:UIImageGetImageFromName(@"loadingDefault.png") forState:UIControlStateNormal];
                    jinduImage.backgroundColor = [UIColor clearColor];
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
                    [mImageViewBtn setImage:image forState:(UIControlStateNormal)];
                }
                [mImageViewBtn addTarget:self action:@selector(actionShowPhoto:) forControlEvents:(UIControlEventTouchUpInside)];
                
                if (image != [ImageDownloader defaultProfileImage:YES]) {
                    mImageViewBtn.enabled = YES;
                } else {
                    mImageViewBtn.enabled = NO;
                }
                [gifView addSubview:mImageViewBtn];
            }
        } else {// 转发帖
            if (mStatus.content_ref && [mStatus.content_ref length] > 0) {
				mForwardView = [[ForwardView alloc] initWithMessage:mStatus homebol:hobol];
                mForwardView.delegatea = self;
                mForwardView.butfor.frame = CGRectMake(0, 0, mForwardView.frame.size.width, mForwardView.frame.size.height);
                mForwardView.butfor.hidden = NO;
                
                NSLog(@"%f,%f,%f,%f",mForwardView.frame.origin.x,mForwardView.frame.origin.y,mForwardView.frame.size.width,mForwardView.frame.size.height);
                NSLog(@"%f,%f,%f,%f",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
                
                mForwardView.backgroundColor=[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
                [self addSubview:mForwardView];
            }
        }
		if(([mStatus isFangan:mStatus.attach_type]&&[mStatus isZhiChiBiSai:mStatus.lottery_id])) {
			matchVSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			[matchVSBtn setImage:UIImageGetImageFromName(@"wb_touzhuzhanshi.png") forState:UIControlStateNormal];
			[matchVSBtn addTarget:self action:@selector(sendPreditTopic) forControlEvents:UIControlEventTouchUpInside];
			matchVSBtn.backgroundColor = [UIColor clearColor];
			UIView *btnBack = [[UIView alloc] initWithFrame:CGRectMake(0,  mLabel.frame.size.height + mForwardView.frame.size.height, 280, 47.5)];
            btnBack.tag=123123;
			[btnBack addSubview:matchVSBtn];
			[self addSubview:btnBack];
			[btnBack release];
			matchVSBtn.frame = CGRectMake(70, 0, 130, 47.5);
		}
        
        UIView *huiseView=[[UIView alloc]init];
        huiseView.frame=CGRectMake(0, 0, 320, 10);
        huiseView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [self addSubview:huiseView];
        [huiseView release];
        
        //        UIView *mBtnCon = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 311, 37)] autorelease];
        //        mForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        mCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        // 按钮背景和图片
        //        [mForwardBtn setBackgroundImage:[UIImage imageNamed:@"forward_comment_bg.png"] forState:(UIControlStateNormal)];
        //        [mCommentBtn setBackgroundImage:[UIImage imageNamed:@"forward_comment_bg.png"] forState:(UIControlStateNormal)];
        //        [mForwardBtn setImage:[UIImage imageNamed:@"forward_btn.png"] forState:(UIControlStateNormal)];
        //        [mCommentBtn setImage:[UIImage imageNamed:@"comment_btn.png"] forState:(UIControlStateNormal)];
        //        // 按钮标题和颜色
        //        [mForwardBtn setTitle:mStatus.count_zf forState:(UIControlStateNormal)];
        //        [mCommentBtn setTitle:mStatus.count_pl forState:(UIControlStateNormal)];
        //        [mForwardBtn setTitleColor:[UIColor replyAndCommentInHomeCellColor] forState:(UIControlStateNormal)];
        //        [mCommentBtn setTitleColor:[UIColor replyAndCommentInHomeCellColor] forState:(UIControlStateNormal)];
        //        // 按钮图片和文字内间距
        //        [mForwardBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -38, 0, 0))];
        //        [mCommentBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, -38, 0, 0))];
        //        [mForwardBtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 0))];
        //        [mCommentBtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 0))];
        //        mForwardBtn.frame = CGRectMake(15, 0, 138, 37);
        //        mCommentBtn.frame = CGRectMake(163, 0, 138, 37);
        //        [mForwardBtn addTarget:self action:@selector(actionForward:) forControlEvents:(UIControlEventTouchUpInside)];
        //        [mCommentBtn addTarget:self action:@selector(actionComment:) forControlEvents:(UIControlEventTouchUpInside)];
        //        [mBtnCon addSubview:mForwardBtn];
        //        [mBtnCon addSubview:mCommentBtn];
        //        [self addSubview:mBtnCon];
        
//        // 微博发布时间和来源
//        UILabel *mCreateTime = [[UILabel alloc] init];
//        if (!mStatus.source) {
//            mStatus.source = @"来自第一彩博";
//        }
//        NSString *text = [[mStatus.timeformate stringByAppendingString:@"   "] stringByAppendingString:mStatus.source];
//        [mCreateTime setText:text];
//        [mCreateTime setTextColor:[UIColor TimeTextColor]];
//        [mCreateTime setFont:[UIFont systemFontOfSize:13]];
//        mCreateTime.backgroundColor = [UIColor clearColor];
////        [mCreateTime setFrame: CGRectMake(0, 0, 280, 18)];
//        [mCreateTime setFrame: CGRectMake(0, 0, 280, 0)];
//        [self addSubview:mCreateTime];
//        [mCreateTime release];
//    #ifdef isGuanliyuanBanben
//        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn1.frame = CGRectMake(0, 0, 60, 30);
//        
//        btn1.backgroundColor = [UIColor whiteColor];
//        [btn1 setTitle:@"删除微博" forState:UIControlStateNormal];
//       btn1.titleLabel.font = [UIFont systemFontOfSize:11];
//        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn1 addTarget:self action:@selector(deleteweibo) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn1];
//#endif
//        
//        SegmentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 311, 37)] autorelease];
//        SegmentView.userInteractionEnabled = YES;
//        NSString *tmpStringOne = nil;
//        
//        if (mStatus.count_pl) {
//            NSLog(@"qqq = %@", mStatus.count_pl);
//            tmpStringOne = [NSString stringWithFormat:@"本帖评论 %@",mStatus.count_pl];
//            bentieButton = [UIButton buttonWithType:UIButtonTypeCustom];
////            bentieButton.frame = CGRectMake(40, 10, 100, 30);
//            bentieButton.frame = CGRectMake(120, 10, 100, 30);
//#ifdef isCaiPiaoForIPad
//            bentieButton.frame = CGRectMake(-30, 10, 100+65, 30);
//#endif
////            bentieButton.backgroundColor = [UIColor blackColor];
//            bentieButton.backgroundColor = [UIColor clearColor];
//            bentieButton.userInteractionEnabled = YES;
//            bentieButton.tag = 100;
//            [bentieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
//            [SegmentView addSubview:bentieButton];
//
//#ifdef isCaiPiaoForIPad
//             bentieLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 2, 100, 30)];
//#else
//             bentieLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 30)];
//#endif
//           
//            bentieLabel.backgroundColor = [UIColor clearColor];
//            bentieLabel.text = tmpStringOne;
//            bentieLabel.font = [UIFont systemFontOfSize:13];
//            [bentieButton addSubview:bentieLabel];
//            [bentieLabel release];
//
//        }else
//        {
//            tmpStringOne = [NSString stringWithFormat:@"本帖评论 0"];
//            
//            bentieButton = [UIButton buttonWithType:UIButtonTypeCustom];
////            bentieButton.frame = CGRectMake(40, 10, 100, 30);
//            bentieButton.frame = CGRectMake(120, 10, 100, 30);
//#ifdef isCaiPiaoForIPad
//            bentieButton.frame = CGRectMake(-30, 10, 100+65, 30);
//#endif
////            bentieButton.backgroundColor = [UIColor blackColor];
////            bentieButton.backgroundColor = [UIColor yellowColor];
//            bentieButton.userInteractionEnabled = YES;
//            bentieButton.tag = 100;
//            [bentieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
//            [SegmentView addSubview:bentieButton];
//            
//#ifdef isCaiPiaoForIPad
//            bentieLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 2, 100, 30)];
//#else
//            bentieLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 30)];
//#endif
//            bentieLabel.backgroundColor = [UIColor clearColor];
//            bentieLabel.text = tmpStringOne;
//            bentieLabel.font = [UIFont systemFontOfSize:13];
//            [bentieButton addSubview:bentieLabel];
//            [bentieLabel release];
//
//        }
//        NSString *tmpStringTwo = nil;
//        if (mStatus.count_pl_ref) {
//            tmpStringTwo =[NSString stringWithFormat:@"原帖评论 %@",mStatus.count_pl_ref];
//            
//            xian = [[UIImageView alloc] initWithFrame:CGRectMake(6, 12, 300, 2)];
//            xian.backgroundColor  = [UIColor clearColor];
//            //xian.image = [UIImage imageNamed:@"JTXian960.png"];
//            xian.image = UIImageGetImageFromName(@"SZTG960.png");
//            [SegmentView addSubview:xian];
//            [xian release];
//
//            
//            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(148, 22, 2, 15)];
////            line.image = UIImageGetImageFromName(@"wb39.png");
//            line.backgroundColor = [UIColor clearColor];
//            [SegmentView addSubview:line];
//            [line release];
//
//            yuantieButton = [UIButton buttonWithType:UIButtonTypeCustom];
////            yuantieButton.frame = CGRectMake(170, 10, 100, 30);
//            yuantieButton.frame = CGRectMake(210, 10, 100, 30);
////            yuantieButton.backgroundColor = [UIColor blackColor];
//#ifdef isCaiPiaoForIPad
//            yuantieButton.frame = CGRectMake(170, 10, 100+65, 30);
//#endif
//            yuantieButton.backgroundColor = [UIColor clearColor];
//            yuantieButton.userInteractionEnabled = YES;
//            yuantieButton.tag = 101;
//            [yuantieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
//            [SegmentView addSubview:yuantieButton];
//            
//            yuantieLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 2, 100, 30)];
//            yuantieLabel.backgroundColor = [UIColor clearColor];
//            yuantieLabel.text = tmpStringTwo;
//            yuantieLabel.font = [UIFont systemFontOfSize:13];
//            yuantieLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
//            [yuantieButton addSubview:yuantieLabel];
//            [yuantieLabel release];
//            
//            line2 = [[UIImageView alloc] initWithFrame:CGRectMake(6, 42, 300, 5)];
//            line2.image = UIImageGetImageFromName(@"wb24.png");
//            line2.backgroundColor = [UIColor clearColor];
//            [SegmentView addSubview:line2];
//            [line2 release];
//            
//#ifdef isCaiPiaoForIPad
//            xian.frame = CGRectMake(6-35, 12, 370, 2);
//            line2.frame = CGRectMake(6-35, 42, 370, 5);
//            yuantieButton.frame = CGRectMake(170, 10, 100+65, 30);
//            
//#endif
//
//
//        }
//        else
//        {
//            tmpStringTwo =[NSString stringWithFormat:@"原帖评论 0"];
//            
//            yuantieButton = [UIButton buttonWithType:UIButtonTypeCustom];
////            yuantieButton.frame = CGRectMake(170, 10, 100, 30);
//            yuantieButton.frame = CGRectMake(210, 10, 100, 30);
////            yuantieButton.backgroundColor = [UIColor blackColor];
//#ifdef isCaiPiaoForIPad
//            yuantieButton.frame = CGRectMake(170, 10, 100+65, 30);
//#endif
//            yuantieButton.backgroundColor = [UIColor clearColor];
//            yuantieButton.userInteractionEnabled = YES;
//            yuantieButton.tag = 101;
//            [yuantieButton addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventTouchUpInside];
//            [SegmentView addSubview:yuantieButton];
//            
//            yuantieLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 2, 100, 30)];
//            yuantieLabel.backgroundColor = [UIColor clearColor];
//            yuantieLabel.text = tmpStringTwo;
//            yuantieLabel.font = [UIFont systemFontOfSize:13];
//            [yuantieButton addSubview:yuantieLabel];
//            [yuantieLabel release];
//
//        }
        
        //NSArray *tmpArray = [NSArray arrayWithObjects:tmpStringOne,tmpStringTwo,nil];
        //UISegmentedControl *tmpSegmentedControl = [[UISegmentedControl alloc]initWithItems:tmpArray];
        //[tmpSegmentedControl setFrame:CGRectMake(30, 0, 260, 37)];
        //[SegmentView addSubview:yuantieButton];
        //self.segmentedControl = tmpSegmentedControl;
        //[self.segmentedControl addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
        //[self.segmentedControl setSelectedSegmentIndex:0];
        //[tmpSegmentedControl release];
        
//        [self addSubview:SegmentView];
        
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
    
    if(([mStatus isFangan:mStatus.attach_type]&&[mStatus isZhiChiBiSai:mStatus.lottery_id]))
    {
        UIView *btnBack = (UIView *)[self viewWithTag:123123];
        btnBack.frame =CGRectMake(0,  mLabel.frame.size.height + mForwardView.frame.size.height, 280, 47.5);
    }
    
    [self onMeasure];
//    [self layoutSubviews];
}

- (void)deleteweibo {
//    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(40, 50, 200, 20)];
//    textF.placeholder = @"请输入管理员密码";
//    textF.tag = 201;
//    textF.autocorrectionType = UITextAutocorrectionTypeYes;
//    textF.secureTextEntry = YES;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"要查看删除微博,请输入密码" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
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
            [self.guanliRequest clearDelegatesAndCancel];
            self.guanliRequest = [ASIHTTPRequest requestWithURL:[NetURL deleteTopic:mStatus.topicid Username:[[Info getInstance] userName] Password:self.passWord]];
            [guanliRequest setTimeOutSeconds:20.0];
            [guanliRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [guanliRequest setDidFinishSelector:@selector(recieveDeleteWeiboInfo:)];
            [guanliRequest setDelegate:self];
            [guanliRequest startAsynchronous];
        }
    }
}

// alete代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
//        UITextField *text = (UITextField *)[alertView viewWithTag:201];
        if ([self.passWord length] == 0) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入密码"];
            return;
        }
        if (alertView.tag == 111) {
            [self.guanliRequest clearDelegatesAndCancel];
            self.guanliRequest = [ASIHTTPRequest requestWithURL:[NetURL deleteTopic:mStatus.topicid Username:[[Info getInstance] userName] Password:self.passWord]];
            [guanliRequest setTimeOutSeconds:20.0];
            [guanliRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [guanliRequest setDidFinishSelector:@selector(recieveDeleteWeiboInfo:)];
            [guanliRequest setDelegate:self];
            [guanliRequest startAsynchronous];
        }
    }
}

- (void)recieveDeleteWeiboInfo:(ASIHTTPRequest *)request2 {
    NSDictionary *dic = [[request2 responseString] JSONValue];
    [[caiboAppDelegate getAppDelegate] showMessage:[dic objectForKey:@"msg"]];
}

- (void)requestFailed:(ASIHTTPRequest *)request2
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

// 响应转发
- (void) actionForward:(UIButton *)sender {
#ifdef isCaiPiaoForIPad

    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kForwardTopicController mStatus:mStatus];
    
   
#else
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    publishController.mStatus = mStatus;
//    publishController.publishType = kForwardTopicController;// 转发
//
//        [[DetailedViewController getShareDetailedView].navigationController pushViewController:publishController animated:YES];
//
//	[publishController release];
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.mStatus = mStatus;
    publishController.microblogType = ForwardTopicController;// 转发
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [[DetailedViewController getShareDetailedView] presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
#endif
}
- (void)segmentedAction:(UIButton *)sender
{
    if (sender.tag == 100) {
        
                
        bentieLabel.textColor = [UIColor blackColor];
        yuantieLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        line2.image = UIImageGetImageFromName(@"wb24.png");
		if (detaildelegate) {
			[detaildelegate showSegmentOneAction];
		}
        
    }else
    {
    
                
        yuantieLabel.textColor = [UIColor blackColor];
        bentieLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2];
        line2.image = UIImageGetImageFromName(@"JTXian960.png");
        if (detaildelegate) {
			[detaildelegate showSegmentTwoAction];
		}

    }
    
}


// 评论
- (void) actionComment : (UIButton *) sender {
    //    CommentViewController *commentController = [[CommentViewController alloc] initWithMessage:mStatus];
    //    [[DetailedViewController getShareDetailedView].navigationController pushViewController:commentController animated:YES];
    //    [commentController release];
#ifdef isCaiPiaoForIPad
    
    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kCommentTopicController mStatus:mStatus];
    
    
#else
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.mStatus = mStatus;
    publishController.microblogType = CommentTopicController;// 
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [[DetailedViewController getShareDetailedView] presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
    
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    publishController.mStatus = mStatus;
//    publishController.publishType = kCommentTopicController;// 评论
//
//        [[DetailedViewController getShareDetailedView].navigationController pushViewController:publishController animated:YES];
//
//
//	[publishController release];
#endif
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
        image = [image rescaleImageToSize:CGSizeMake(296, 296*image.size.height/image.size.width)];
        if (image) {
            NSData *data = [self getImageFromDB:imageUrl];
            if (!gifView) {
                gifView =[[GifView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height) ImageData:data];
                [self addSubview:gifView];
                [gifView release];
            }
            else {
                [gifView ReLoadImageData:data WithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
            }
        }
        gifView.hidden = NO;
//        [mImageViewBtn setImage:image forState:(UIControlStateNormal)];
        [mImageViewBtn addTarget:self action:@selector(actionShowPhoto:) forControlEvents:(UIControlEventTouchUpInside)];
        if (gifView.count == 1) {
            [mImageViewBtn setImage:image forState:(UIControlStateNormal)];
        }
        else {
            [mImageViewBtn setImage:nil forState:(UIControlStateNormal)];
        }
        mImageViewBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        mImageViewBtn.enabled = YES;
        [self onMeasure];
    }
}

- (void)requestReceivedResponseHeaders:(ASIHTTPRequest *)newHeaders {
    if (newHeaders == guanliRequest) {
        return;
    }
	if ([[newHeaders.responseHeaders objectForKey:@"Content-Length"] intValue] >GIFDATALength) {
		NSMutableArray *photos = [[NSMutableArray alloc] init];
		[photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:mStatus.attach_small]]];
		MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
		[photoBrowser setPhotoType : kTypeWithURL];
		[photos release];
		
		UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
		navController.navigationBarHidden = NO;
        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
        NSString * diyistr = [devicestr substringToIndex:1];
        if ([diyistr intValue] >= 6) {
#ifdef isCaiPiaoForIPad
           [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
            
#else
            [navController.navigationBar setBackgroundImage:[UIImageGetImageFromName(@"SDH960.png") stretchableImageWithLeftCapWidth:7 topCapHeight:20] forBarMetrics:UIBarMetricsDefault];
#endif
            
        }
        if (navController) {
			[[DetailedViewController getShareController] presentViewController:navController animated: YES completion:nil];
//            [[DetailedViewController getShareDetailedView].navigationController pushViewController:photoBrowser animated:YES];
		}
        [photoBrowser release];
		[navController release];
	}
	else {
		NSMutableArray *photos = [[NSMutableArray alloc] init];
		[photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:mStatus.attach]]];
		MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
		[photoBrowser setPhotoType : kTypeWithURL];
		[photos release];
		
		UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
		navController.navigationBarHidden = NO;
        NSString * devicestr = [[UIDevice currentDevice] systemVersion];
        NSString * diyistr = [devicestr substringToIndex:1];
        if ([diyistr intValue] >= 6) {
#ifdef isCaiPiaoForIPad
            [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
            
#else
            [navController.navigationBar setBackgroundImage:[UIImageGetImageFromName(@"SDH960.png") stretchableImageWithLeftCapWidth:7 topCapHeight:20] forBarMetrics:UIBarMetricsDefault];
#endif
//            [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
        }
//		[photoBrowser release];
		if (navController) {
			[[DetailedViewController getShareController] presentViewController:navController animated: YES completion:nil];
            [navController release];
//            [[DetailedViewController getShareDetailedView].navigationController pushViewController:photoBrowser animated:YES];
		}
		[photoBrowser release];
	}
	[request clearDelegatesAndCancel];
}


// 响应查看图片
- (void) actionShowPhoto:(id)sender {
    if (mStatus.attach) {
		if ([mStatus.attach length] >3 && [[[mStatus.attach substringFromIndex:[mStatus.attach length]-3] lowercaseString] isEqualToString:@"gif"]) {
			self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:mStatus.attach]];
			[request setDelegate:self];
			//[request setNumberOfTimesToRetryOnTimeout:<#(int)#>]
			[request setDidReceiveResponseHeadersSelector:@selector(requestReceivedResponseHeaders:)];
			[request startAsynchronous];
		}
		else {
            
            
            
            
            
			NSMutableArray *photos = [[NSMutableArray alloc] init];
			[photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:mStatus.attach]]];
            
            
//            CPPhotoView * photoView = [[CPPhotoView alloc] initWithUrl:photos];
            
            MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
            [photoBrowser setPhotoType : kTypeWithURL];
            [photos release];
            
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
            NSString * devicestr = [[UIDevice currentDevice] systemVersion];
            NSString * diyistr = [devicestr substringToIndex:1];
            
            if ([diyistr floatValue] >= 5) {
#ifdef isCaiPiaoForIPad
                [nvc.navigationBar setBackgroundImage:UIImageGetImageFromName(@"daohangimage.png") forBarMetrics:UIBarMetricsDefault];
#else
                // ***NavBackImage.png
                [navController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
#endif
                
            }
            
            navController.navigationBarHidden = NO;
            [photoBrowser release];
            if (navController) {
                [[DetailedViewController getShareController] presentViewController:navController animated: YES completion:nil];
            }
            [navController release];

            
            
            
            
            
//			MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
//			[photoBrowser setPhotoType : kTypeWithURL];
//			[photos release];
//#ifdef isCaiPiaoForIPad
//            UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
//            
//           
//            [NV pushViewController:photoBrowser animated:NO];
//            [photoBrowser release];
//#else
//            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
//			navController.navigationBarHidden = NO;
//            NSString * devicestr = [[UIDevice currentDevice] systemVersion];
//            NSString * diyistr = [devicestr substringToIndex:1];
//            if ([diyistr intValue] >= 6) {
//                [navController.navigationBar setBackgroundImage:[UIImageGetImageFromName(@"SDH960.png") stretchableImageWithLeftCapWidth:7 topCapHeight:20] forBarMetrics:UIBarMetricsDefault];
//            }
//			
//			if (navController) {
//				[[DetailedViewController getShareController] presentViewController:navController animated: YES completion:nil];
//                [navController release];
////                [[DetailedViewController getShareDetailedView].navigationController pushViewController:photoBrowser animated:YES];
//			}
//			[photoBrowser release];
//#endif
			
			
		}
    }
}

// 刷新
- (void) actionRefresh:(YtTopic *) status {
    if (!status) {
        //        [mForwardBtn setTitle:@"..." forState:(UIControlStateNormal)];
        //        [mCommentBtn setTitle:@"..." forState:(UIControlStateNormal)];
        //        [self.segmentedControl setTitle:@"..." forSegmentAtIndex:0];
        //        [self.segmentedControl setTitle:@"..." forSegmentAtIndex:1];
        return;
    }
    [self setMStatus:status];
    if (mStatus.count_pl) {
        NSLog(@"wwww = %@", mStatus.count_pl);
        [self returnYtTopic:mStatus];
        
    }
    if (![mStatus.orignal_id isEqualToString:@"0"]) {
        [mForwardView actionRefresh:status];
    }
}

// 对容器内所有组件布局
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
        int px = (right - pw) / 2;
        child.frame = CGRectMake(px, top, pw, ph);
        top += (ph + 5);// mGap
    }
	if (detaildelegate) {
		[detaildelegate reloadDataView:self];
	}
}

- (void)returnYtTopic:(YtTopic *)sstatuss{
    
    
    if (detaildelegate) {
		[detaildelegate returnYtTopic:mStatus];
	}
    
}

- (void)dealloc {
    [self.guanliRequest clearDelegatesAndCancel];
    self.guanliRequest = nil;
    [self.request clearDelegatesAndCancel];
    self.request = nil;
    receiver.imageContainer = nil;
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:imageUrl];
    [imageUrl release];
    [receiver release];
    [segmentedControl release];
    [mStatus release];
    [mForwardView release];
    
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    