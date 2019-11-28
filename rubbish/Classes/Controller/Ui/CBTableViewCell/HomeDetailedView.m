//
//  HomeDetailedView.m
//  caibo
//
//  Created by jacob on 11-6-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeDetailedView.h"
#import "caiboAppDelegate.h"
#import "UIImageExtra.h"
#import "ColorUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "datafile.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "DetailedViewController.h"
#import "TouZhuShowView.h"
#import "SharedMethod.h"
#import "SharedDefine.h"
#import "MyWebViewController.h"

@implementation HomeDetailedView

@synthesize status,/* imageTag, reply_bg_Top, reply_bg_Cen, reply_bg_Bot, replyImg, commentImg, */ caiboImage,matchVSBtn;
//@synthesize contentView;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor whiteColor];
        receiver = [[ImageStoreReceiver alloc] init];
        receiver.imageContainer = self;
        
//        ytImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        ytImage.backgroundColor = [SharedMethod getColorByHexString:@"f2f2f2"];
//        ytImage.userInteractionEnabled = YES;
//        [self addSubview:ytImage];
//        [ytImage release];
        
        UIButton * orignalButton = [[[UIButton alloc] initWithFrame:CGRectZero] autorelease];
        orignalButton.tag = weiBo_GuangChang_YuanTieButtonTag;
        orignalButton.backgroundColor = WEIBO_YUANTIE_BGCOLOR;
        [orignalButton addTarget:self action:@selector(touchOrignal) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:orignalButton];
        
        UIImageView * faxqImageView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"WeiBo_FAXQ_Mark.png")] autorelease];
        faxqImageView.tag = weiBo_GuangChang_YuanTieFAXQTag;
        [orignalButton addSubview:faxqImageView];
        
        caiboImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [caiboImageBtn setAdjustsImageWhenHighlighted:NO];
        [caiboImageBtn addTarget:self action:@selector(didTouchImageButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:caiboImageBtn];
        
		UIImageView *imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"gif.png")];
		imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
		[caiboImageBtn addSubview:imageV];
		imageV.tag = 10001;
		imageV.hidden = YES;
		[imageV release];
        
        ColorLabel * coloview = [[ColorLabel alloc] initWithText:status.content hombol:YES];
        coloview.tag = weiBo_GuangChang_ZhengWenTag;
        [coloview setBackgroundColor:[UIColor clearColor]];
        coloview.colorLabeldelegate = self;
        [self addSubview:coloview];
        [coloview release];
        
        ColorLabel * orignalText = [[ColorLabel alloc] initWithText:status.orignalText hombol:YES];
        orignalText.tag = weiBo_GuangChang_YuanTieTag;
        [orignalText setBackgroundColor:[UIColor clearColor]];
        orignalText.colorLabeldelegate = self;
        [self addSubview:orignalText];
        [orignalText release];
        
		self.matchVSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[matchVSBtn setImage:UIImageGetImageFromName(@"wb_touzhuzhanshi.png") forState:UIControlStateNormal];
		[matchVSBtn addTarget:self action:@selector(sendPreditTopic) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:matchVSBtn];
		matchVSBtn.backgroundColor = [UIColor clearColor];
  
    }
    return self;
}

- (void)clikeOrderIdURL:(NSURLRequest *)request1 {
    MyWebViewController *my = [[MyWebViewController alloc] init];
    [my setHidesBottomBarWhenPushed:YES];
    [my LoadRequst:request1];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    [NV pushViewController:my animated:YES];
    [my release];
    
}

// 请求投注详情
- (void)sendPreditTopic {
	
	TouZhuShowView *t = [[TouZhuShowView alloc] init];
	if([status isFangan:status.attach_type_ref]&&status.orignalTextBounds.size.height && status.orignalText) {
		[t showTouzhuWithTopicId:status.orignal_id];
	}
	else {
		[t showTouzhuWithTopicId:status.topicid];
	}
	[t release];
}

- (void)showGIf{
    UIImageView *imageV = nil;
    imageV = (UIImageView *)[caiboImageBtn viewWithTag:10001];
    imageV.hidden = YES;
    if (![status.orignal_id isEqualToString:@"0"]) {
        if ([status.attach_ref length] >3 && [[[status.attach_ref substringFromIndex:[status.attach_ref length]-3] lowercaseString] isEqualToString:@"gif"]) {
            
            if (!imageV) {
                imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"gif.png")];
                imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
                [caiboImageBtn addSubview:imageV];
                imageV.tag = 10001;
                [imageV release];
            }
            else {
                imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
                imageV.hidden = NO;
            }
        }
        return;
    }
    if ([status.attach length] >3 && [[[status.attach substringFromIndex:[status.attach length]-3] lowercaseString] isEqualToString:@"gif"]) {
        if (!imageV) {
            imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"gif.png")];
            imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
            [caiboImageBtn addSubview:imageV];
            imageV.tag = 10001;
            [imageV release];
        }
        else {
            imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
            imageV.hidden = NO;
        }
    }
}

// 接收网络图片
- (void)updateImage:(UIImage*)image {
    if (image) {
        self.caiboImage = [image getWeiBoImage];
        [caiboImageBtn setImage:caiboImage forState:(UIControlStateNormal)];
        
        [super setNeedsDisplay];

		[self showGIf];
    }
}

- (void) getImage : (NSString *) url {
    if (imageUrl != url) {
        [imageUrl release];
    }
    imageUrl = [url copy];
    
    UIImage *image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : url Delegate:receiver Big:YES];
    self.caiboImage = [image getWeiBoImage];
    [caiboImageBtn setImage:caiboImage forState:(UIControlStateNormal)];
    
	UIImageView *imageV = nil;
	imageV = (UIImageView *)[caiboImageBtn viewWithTag:10001];
	imageV.hidden = YES;
	if (![status.orignal_id isEqualToString:@"0"]) {
		if ([status.attach_ref length] >3 && [[[status.attach_ref substringFromIndex:[status.attach_ref length]-3] lowercaseString] isEqualToString:@"gif"]) {
			
			if (!imageV) {
				imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"gif.png")];
				imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
				[caiboImageBtn addSubview:imageV];
				imageV.tag = 10001;
				[imageV release];
			}
			else {
				imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
				imageV.hidden = NO;
			}
		}
		return;
	}
	if ([status.attach length] >3 && [[[status.attach substringFromIndex:[status.attach length]-3] lowercaseString] isEqualToString:@"gif"]) {
        if (!imageV) {
			imageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"gif.png")];
			imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
			imageV.tag = 10001;
			[caiboImageBtn addSubview:imageV];
			[imageV release];
		}
		else {
			imageV.frame = CGRectMake(caiboImageBtn.frame.size.width -40, caiboImageBtn.frame.size.height -13, 40, 13);
			imageV.hidden = NO;
		}
    }
}

- (void)setStatus:(YtTopic*)value
{
	UIImageView *imageV = (UIImageView *)[caiboImageBtn viewWithTag:10001];
	imageV.hidden = YES;
    if (status != value) {
		[status release];
		status = [value retain];
	}
    
    // 预览图模式
    if (![[caiboAppDelegate getAppDelegate].readingMode isEqualToString:PREVIEW_MODEL] || !status.hasImage) {
        [caiboImage release];
        caiboImage = nil;
    } else {
        if (status.hasImage) {
            if ([status.orignal_id isEqualToString:@"0"]) {
                [self getImage:status.attach_small];
            } else {
                [self getImage:status.attach_small_ref];
            }
        }
    }
    
    ColorLabel *coloview = (ColorLabel *)[self viewWithTag:weiBo_GuangChang_ZhengWenTag];
    [coloview setText:status.content hombol:YES ytTopic:status];

//    if (status.caiboType == CAIBO_TYPE_COMMENT) {

    
    ColorLabel * orignalColorLabel = (ColorLabel *)[self viewWithTag:weiBo_GuangChang_YuanTieTag];

    [orignalColorLabel setText:status.orignalText hombol:YES ytTopic:status];
    orignalColorLabel.frame = status.orignalTextBounds;
    
    [super setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // 昵称
    
    if ([status.vip isEqualToString:@"2"]) {
        [[UIColor redColor] set];
    }else{
         [[UIColor nickNameColor] set];
    }
   
    [status.nick_name drawInRect:CGRectMake(WEIBO_USERNAME_X, WEIBO_USERNAME_Y, NICKMAME_WIDTH, WEIBO_USERNAME_HEIGHT) withFont:WEIBO_USERNAME_FONT];
    
    // 发布时间
    WEIBO_TIME_COLOR;
    CGSize timeSize = [status.timeformate sizeWithFont:WEIBO_TIME_FONT constrainedToSize:CGSizeMake(150, INT_MAX)];
	[status.timeformate drawInRect:CGRectMake(WEIBO_USERNAME_X, WEIBO_TIME_Y, timeSize.width, WEIBO_TIME_HEIGHT) withFont:WEIBO_TIME_FONT];
    
    //来源小图标
    if ([status.source rangeOfString:@"iPhone"].location != NSNotFound) {
        UIImage * image = [UIImage imageNamed:@"IOS_Mark.png"];
        [image drawInRect:CGRectMake(WEIBO_USERNAME_X + timeSize.width + 10, WEIBO_TIME_Y, 10, 11)];
    }else if ([status.source rangeOfString:@"Android"].location != NSNotFound) {
        UIImage * image = [UIImage imageNamed:@"Android_Mark.png"];
        [image drawInRect:CGRectMake(WEIBO_USERNAME_X + timeSize.width + 10, WEIBO_TIME_Y, 10, 11)];
    }else{
        float fromWidth = [@"来自彩民微博" sizeWithFont:WEIBO_ZHUANFA_FONT].width;
        [@"来自彩民微博" drawInRect:CGRectMake(WEIBO_USERNAME_X + timeSize.width + 10, WEIBO_TIME_Y, fromWidth, 10) withFont:[UIFont systemFontOfSize:10]];
    }

    if ([status.content rangeOfString:@"http://caipiao365.com/faxq="].location !=NSNotFound) {
        UIImage * image = [UIImage imageNamed:@"WeiBo_FAXQ_Mark.png"];
        [image drawInRect:CGRectMake(12, status.textBounds.origin.y, 60, 60)];
    }
    
    //原帖
    ColorLabel * contentColorLabel = (ColorLabel *)[self viewWithTag:weiBo_GuangChang_ZhengWenTag];
//    CGRect contentRect = CGRectMake(status.textBounds.origin.x, status.textBounds.origin.y, status.textBounds.size.width, status.textBounds.size.height);
    contentColorLabel.frame = status.textBounds;
    
    //转发帖
    ColorLabel * orignalColorLabel = (ColorLabel *)[self viewWithTag:weiBo_GuangChang_YuanTieTag];
    
    // 微博图片
    if (caiboImage || status.hasImage) {
        CGSize imageSize = [SharedMethod getSizeByWeiBoImage:caiboImage];
        if (status.orignalTextBounds.size.height && status.orignalText) {
            caiboImageBtn.frame = CGRectMake(12, ORIGIN_Y(orignalColorLabel) + WEIBO_YUANTIE_TOP, imageSize.width, imageSize.height);
        }else{
            caiboImageBtn.frame = CGRectMake(12, ORIGIN_Y(contentColorLabel) + WEIBO_LINESPACE, imageSize.width, imageSize.height);
        }
    } else {
        caiboImageBtn.frame = CGRectZero;
    }
    
    UIButton * orignalButton = (UIButton *)[self viewWithTag:weiBo_GuangChang_YuanTieButtonTag];
    UIImageView * faxqImageView = (UIImageView *)[self viewWithTag:weiBo_GuangChang_YuanTieFAXQTag];

	if(status.orignalTextBounds.size.height && status.orignalText) {
        CGRect rect;
        if (caiboImageBtn.frame.size.height) {
            rect = CGRectMake(0, status.orignalTextBounds.origin.y - WEIBO_YUANTIE_TOP, 320, status.orignalTextBounds.size.height + WEIBO_YUANTIE_TOP * 2 + WEIBO_IMAGE_MAX + WEIBO_YUANTIE_TOP);
        }else{
            rect = CGRectMake(0, status.orignalTextBounds.origin.y - WEIBO_YUANTIE_TOP, 320, status.orignalTextBounds.size.height + WEIBO_YUANTIE_TOP * 2);
        }
        orignalButton.frame = rect;
        if ([status.orignalText rangeOfString:@"http://caipiao365.com/faxq="].location !=NSNotFound) {
            faxqImageView.frame = CGRectMake(12, WEIBO_YUANTIE_TOP, 60, 60);
        }else{
            faxqImageView.frame = CGRectZero;
        }
    }else{
        orignalButton.frame = CGRectZero;
        faxqImageView.frame = CGRectZero;
    }
    

    if([status isFangan:status.attach_type]&&[status isZhiChiBiSai:status.lottery_id]) {
//		matchVSBtn.frame = CGRectMake(20, y0-5, 130, 47.5);
//		y0 += 47.5;
	}
	else if([status isFangan:status.attach_type_ref]&&[status isZhiChiBiSai:status.lottery_id_ref]) {
//		matchVSBtn.frame = CGRectMake(20, y0-10, 130, 47.5);
//		y0 += 47.5;
	}
	else {
		matchVSBtn.frame = CGRectZero;
	}

    if (!status.isAuto && status.caiboType != CAIBO_TYPE_COMMENT) {
        WEIBO_ZHUANFA_COLOR;
        float forwardW = 0;
        if ([status.count_zf integerValue]) {
            forwardW = [status.count_zf sizeWithFont:WEIBO_ZHUANFA_FONT].width;
            [status.count_zf drawInRect:CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - forwardW - 13 - 5)/2 + 13 + 5, status.cellHeight - WEIBO_BOTTOMBUTTON_HEIGHT, forwardW, WEIBO_BOTTOMBUTTON_HEIGHT) withFont:WEIBO_ZHUANFA_FONT];
        }else{
            forwardW = [@"转发" sizeWithFont:WEIBO_ZHUANFA_FONT].width;
            [@"转发" drawInRect:CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - forwardW - 13 - 5)/2 + 13 + 5, status.cellHeight - WEIBO_BOTTOMBUTTON_HEIGHT, forwardW, WEIBO_BOTTOMBUTTON_HEIGHT) withFont:WEIBO_ZHUANFA_FONT];
        }
        
        UIImage * forwardImage = UIImageGetImageFromName(@"WeiBo_Forward.png");
        [forwardImage drawInRect:CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - forwardW - 13 - 5)/2, self.frame.size.height - WEIBO_BOTTOMBUTTON_HEIGHT + (WEIBO_BOTTOMBUTTON_HEIGHT - 11.5)/2, 13, 11.5)];
        
        UIImage * buttonLine = UIImageGetImageFromName(@"WeiBo_ButtonLine.png");
        [buttonLine drawInRect:CGRectMake(WEIBO_BOTTOMBUTTON_WIDTH, self.frame.size.height - WEIBO_BOTTOMBUTTON_HEIGHT , 0.5, WEIBO_BOTTOMBUTTON_HEIGHT)];
        
        float commentW = 0;
        if ([status.count_pl integerValue]) {
            commentW = [status.count_pl sizeWithFont:WEIBO_ZHUANFA_FONT].width;
            [status.count_pl drawInRect:CGRectMake(WEIBO_BOTTOMBUTTON_WIDTH + (WEIBO_BOTTOMBUTTON_WIDTH - commentW - 13 - 5)/2 + 13 + 5, status.cellHeight - WEIBO_BOTTOMBUTTON_HEIGHT, commentW, WEIBO_BOTTOMBUTTON_HEIGHT) withFont:WEIBO_ZHUANFA_FONT];
        }else{
            commentW = [@"评论" sizeWithFont:WEIBO_ZHUANFA_FONT].width;
            [@"评论" drawInRect:CGRectMake(WEIBO_BOTTOMBUTTON_WIDTH + (WEIBO_BOTTOMBUTTON_WIDTH - commentW - 13 - 5)/2 + 13 + 5, status.cellHeight - WEIBO_BOTTOMBUTTON_HEIGHT, commentW, WEIBO_BOTTOMBUTTON_HEIGHT) withFont:WEIBO_ZHUANFA_FONT];
        }
        
        UIImage * commentImage = UIImageGetImageFromName(@"WeiBo_Comment.png");
        [commentImage drawInRect:CGRectMake(WEIBO_BOTTOMBUTTON_WIDTH + (WEIBO_BOTTOMBUTTON_WIDTH - commentW - 13 - 5)/2, self.frame.size.height - WEIBO_BOTTOMBUTTON_HEIGHT + (WEIBO_BOTTOMBUTTON_HEIGHT - 11.5)/2, 13, 11.5)];
        
        UIImage * buttonLine1 = UIImageGetImageFromName(@"WeiBo_ButtonLine.png");
        [buttonLine1 drawInRect:CGRectMake(WEIBO_BOTTOMBUTTON_WIDTH * 2, self.frame.size.height - WEIBO_BOTTOMBUTTON_HEIGHT , 0.5, WEIBO_BOTTOMBUTTON_HEIGHT)];

    }
    
    [self showGIf];
}

- (void)requestReceivedResponseHeaders:(ASIHTTPRequest *)newHeaders {
	if ([[newHeaders.responseHeaders objectForKey:@"Content-Length"] intValue] >GIFDATALength) {
		if ([status.orignal_id isEqualToString:@"0"]) {
            imageView = [[CP_PopupView alloc] initWithUrl:status.attach_small];
            imageView.bigImageURL = status.attach;
        } else {
            imageView = [[CP_PopupView alloc] initWithUrl:status.attach_small_ref];
            imageView.bigImageURL = status.attach_ref;
        }
        [imageView show];
	}
	else {
		NSString *imageURL= nil;
        NSString *smallImageURL = nil;
		if ([status.orignal_id isEqualToString:@"0"]) {
			imageURL = status.attach;
            smallImageURL = status.attach_small;
		}
		else {
			imageURL = status.attach_ref;
            smallImageURL = status.attach_small_ref;
		}
        imageView = [[CP_PopupView alloc] initWithUrl:smallImageURL];
        imageView.bigImageURL = imageURL;
        imageView.IsGif = YES;
        [imageView show];
//		NSMutableArray *photos = [[NSMutableArray alloc] init];
//        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:imageURL]]];
//        MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
//        [photoBrowser setPhotoType : kTypeWithURL];
//        [photos release];
//        
//        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
//        navController.navigationBarHidden = NO;
//        [photoBrowser release];
//        if (navController) {
//			caiboAppDelegate *delegate = [caiboAppDelegate getAppDelegate];
//			UINavigationController *nav = (UINavigationController*)delegate.window.rootViewController;
//            [nav presentViewController:navController animated: YES completion:nil];
//        }
//		
//        [navController release];		
	}
	[newHeaders clearDelegatesAndCancel];
}

- (void)didTouchImageButton:(id)sender {
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    if ([status.attach_type isEqualToString:@"1"]) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:status.attach]]];
    } else if ([status.attach_type_ref isEqualToString:@"1"]) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:status.attach_ref]]];
    }
    
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

//    if (imageView) {
//        [imageView release];
//        imageView = nil;
//    }
//	if (![status.orignal_id isEqualToString:@"0"]) {
//		if ([status.attach_ref length] >3 && [[[status.attach_ref substringFromIndex:[status.attach_ref length]-3] lowercaseString] isEqualToString:@"gif"]) {
//			ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:status.attach_ref]];
//			[request setDelegate:self];
//			[request setDidReceiveResponseHeadersSelector:@selector(requestReceivedResponseHeaders:)];
//			[request startAsynchronous];
//		}
//		else {
//			imageView = [[PopupView alloc] initWithUrl:status.attach_small_ref];
//                imageView.bigImageURL = status.attach_ref;
//			[imageView show];
//		}
//
//		return;
//	}
//	if ([status.attach length] >3 && [[[status.attach substringFromIndex:[status.attach length]-3] lowercaseString] isEqualToString:@"gif"]) {
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:status.attach]];
//		[request setDelegate:self];
//		[request setDidReceiveResponseHeadersSelector:@selector(requestReceivedResponseHeaders:)];
//		[request startAsynchronous];
//    }
//    else if (status.hasImage) {
//        if ([status.orignal_id isEqualToString:@"0"]) {
//            imageView = [[PopupView alloc] initWithUrl:status.attach_small];
//            imageView.bigImageURL = status.attach;
//        } else {
//            imageView = [[PopupView alloc] initWithUrl:status.attach_small_ref];
//            imageView.bigImageURL = status.attach_ref;
//        }
//        if (([status.attach length] >3 && [[[status.attach substringFromIndex:[status.attach length]-3] lowercaseString] isEqualToString:@"gif"])||([status.attach_ref length] >3 && [[[status.attach_ref substringFromIndex:[status.attach_ref length]-3] lowercaseString] isEqualToString:@"gif"])){
//            imageView.IsGif = YES;
//        }
//        [imageView show];
//    }
}

- (void)dealloc {
//    [contentView release];
    [status release];
//    [imageTag release];
//    [reply_bg_Top release];
//    [reply_bg_Cen release];
//    [reply_bg_Bot release];
//    [replyImg release];
//    [commentImg release];
    
    [contentLabel release];
    
    [imageView release];
    [matchVSBtn release];
    [caiboImage release];
    receiver.imageContainer = nil;
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:imageUrl];
    [imageUrl release];
    [receiver release];
    
    [super dealloc];
}

-(void)touchOrignal
{
    if ([delegate respondsToSelector:@selector(touchWebViewByYtTopic:)]) {
        [delegate touchWebViewByYtTopic:status];
    }
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    