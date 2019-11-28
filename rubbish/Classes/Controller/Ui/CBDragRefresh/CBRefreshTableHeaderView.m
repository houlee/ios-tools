//
//  CBRefreshTableHeaderView.m
//  caibo
//
//  Created by jacob on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CBRefreshTableHeaderView.h"
#import "YDUtil.h"
#import "datafile.h"
#import "ColorUtils.h"

// 灰色
#define TEXT_COLOR	 [UIColor colorWithRed:182.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

@interface CBRefreshTableHeaderView (Private)
- (void)setState:(CBPullRefreshState)aState;
@end

@implementation CBRefreshTableHeaderView

@synthesize delegate = _delegate;
@synthesize isChangeRefresh;
@synthesize layer1;
@synthesize _activityView;

- (void)loadingIphone:(CGRect)frame {
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
    
    loadFinish = NO;


//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(102.0f, frame.size.height - 35.0f, 150, 20.0f)];
//    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    label.font = [UIFont systemFontOfSize:10.0f];
//    label.textColor = TEXT_COLOR;
//    
//    label.backgroundColor = [UIColor clearColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:label];
//    _lastUpdatedLabel = label;
//    [label release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(102.0f, frame.size.height - 48.0f, 150, 20.0f)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textColor = [UIColor colorWithRed:154.0/255.0 green:154.0/255.0 blue:154.0/255.0 alpha:1];//TEXT_COLOR;
    //		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _statusLabel = label;
    [label release];
    
//    layer1 = [CALayer layer];
//    layer1.frame = CGRectMake(90.0f, frame.size.height - 48.0f, 19.0f, 19.5f);
//    layer1.contentsGravity = kCAGravityResizeAspect;
//    //layer.contents = (id)UIImageGetImageFromName(@"blueArrow.png").CGImage;
//    layer1.contents = (id)UIImageGetImageFromName(@"XXJT960.png").CGImage;
    
//    NSString *_filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"jiazaidonghua2.gif"];
//    gifProperties = [[NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
//                                                forKey:(NSString *)kCGImagePropertyGIFDictionary]retain];
//    NSData *data = [NSData dataWithContentsOfFile:_filePath];
//    gif = CGImageSourceCreateWithData((CFDataRef) data, (CFDictionaryRef)gifProperties);
//    
//    count = CGImageSourceGetCount(gif);
    
    layer1 = [CALayer layer];
    layer1.frame = CGRectMake(150.5f, frame.size.height - 48.0f, 19.0f, 19.5f);
    layer1.contentsGravity = kCAGravityResizeAspect;
//    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, 0, (CFDictionaryRef)gifProperties);
//    layer1.contents = (id)ref;
//    CFRelease(ref);
    
    imageArray=[[NSMutableArray alloc]initWithCapacity:0];
    int j;
    for(int i=0;i<75;i++)
    {
//        [imageArray addObject:[NSString stringWithFormat:@"yezi_%d.png",i+1]];
        j = i%6;
        [imageArray addObject:[NSString stringWithFormat:@"refresh%d.png",j+1]];
    }
    shuaxinIma=[[UIImageView alloc]init];
//    shuaxinIma.frame=CGRectMake(150.5f-4, frame.size.height - 48.0f-4, 19.0f+8, 19.5f+8);
//    shuaxinIma.frame=CGRectMake(150.5f, frame.size.height - 48.0f - 230, 19.0f, 265.5);
    shuaxinIma.frame=CGRectMake(146.5f, frame.size.height - 48.0f - 240, 27.0f, 275);
    shuaxinIma.backgroundColor=[UIColor clearColor];
    shuaxinIma.tag=123;
    shuaxinIma.image=[UIImage imageNamed:@"refreshChuan.png"];
    [self addSubview:shuaxinIma];
    layer1 = shuaxinIma.layer;
    
    UIImageView *huizhangIma = [[UIImageView alloc]init];
    huizhangIma.frame = CGRectMake(150, shuaxinIma.frame.origin.y + shuaxinIma.frame.size.height-10, 20, 20);
    huizhangIma.backgroundColor = [UIColor clearColor];
    huizhangIma.image = [UIImage imageNamed:@"refreshHuizhang.png"];
    
    
    if (self.isChangeRefresh) {
//        layer1.contents = (id)UIImageGetImageFromName(@"xlRefresh_1.png").CGImage;
        _statusLabel.textColor = [UIColor whiteColor];
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        layer1.contentsScale = [[UIScreen mainScreen] scale];
    }
#endif
    [[self layer] addSublayer:layer1];
    _arrowImage = layer1;
    _activityView = [[UIImageView alloc] init];
//    _activityView.hidden = YES;
//    _activityView.frame = CGRectMake(90.0f, frame.size.height - 48.0f, 19.0f, 19.5f);
//    _activityView.frame = CGRectMake(150.5f, frame.size.height - 48.0f, 19.0f, 19.5f);
    _activityView.frame = CGRectMake((self.frame.size.width-2)/2, huizhangIma.frame.origin.y - 47, 40, 69.0f);
    //layer.contents = (id)UIImageGetImageFromName(@"blueArrow.png").CGImage;
//    _activityView.image = UIImageGetImageFromName(@"XXJT960_2.png");
//    _activityView.image = UIImageGetImageFromName(@"yezi.png");
    _activityView.image = [UIImage imageNamed:[imageArray objectAtIndex:0]];
    if (isChangeRefresh) {
//        _activityView.image = UIImageGetImageFromName(@"refreshing_1.png");
//        _activityView.image = UIImageGetImageFromName(@"yezi.png");
        _activityView.image = [UIImage imageNamed:[imageArray objectAtIndex:0]];
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        _activityView.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
#endif
    [self addSubview:_activityView];
    [_activityView release];
    
    [self addSubview:huizhangIma];
    [huizhangIma release];
    
    [self setState:CBPullRefreshNormal];
}



- (void)loadingIpad:(CGRect)frame {
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
    
    //        UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.bounds];
    //        bgimageview.backgroundColor = [UIColor clearColor];
    //        //bgimageview.image = UIImageGetImageFromName(@"bgxialashuaxin.png");
    //        [self addSubview:bgimageview];
    //        [bgimageview release];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(102.0f+35, frame.size.height - 35.0f, 150, 20.0f)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont systemFontOfSize:10.0f];
    label.textColor = TEXT_COLOR;
    //		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _lastUpdatedLabel = label;
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(102.0f+35, frame.size.height - 48.0f, 150, 20.0f)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:10.0f];
    label.textColor = [UIColor colorWithRed:154.0/255.0 green:154.0/255.0 blue:154.0/255.0 alpha:1];//TEXT_COLOR;
    //		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _statusLabel = label;
    [label release];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(90.0f+35, frame.size.height - 48.0f, 19.0f, 19.5f);
    layer.contentsGravity = kCAGravityResizeAspect;
    //layer.contents = (id)UIImageGetImageFromName(@"blueArrow.png").CGImage;
    layer.contents = (id)UIImageGetImageFromName(@"XXJT960.png").CGImage;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        layer.contentsScale = [[UIScreen mainScreen] scale];
    }
#endif
    [[self layer] addSublayer:layer];
    _arrowImage = layer;
    
    _activityView = [[UIImageView alloc] init];
//    _activityView.hidden = YES;
    _activityView.frame = CGRectMake(90.0f, frame.size.height - 48.0f, 19.0f, 19.5f);
    //layer.contents = (id)UIImageGetImageFromName(@"blueArrow.png").CGImage;
    _activityView.image = UIImageGetImageFromName(@"XXJT960_2.png");
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        _activityView.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
#endif
    [self addSubview:_activityView];
    [_activityView release];
    
    [self setState:CBPullRefreshNormal];

}



- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
#ifdef isCaiPiaoForIPad
        
        if (frame.size.width <= 748 && frame.size.width != 390) {
            [self loadingIphone:frame];
        }else{
             [self loadingIpad:frame];
        }
        
       
        
#else
        [self loadingIphone:frame];
#endif
    
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame andIsChangeRefresh:(BOOL)_ischangerefresh
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.isChangeRefresh = _ischangerefresh;
#ifdef isCaiPiaoForIPad
        
        if (frame.size.width <= 748 && frame.size.width != 390) {
            [self loadingIphone:frame];
        }else{
            [self loadingIpad:frame];
        }
        
        
        
#else
        [self loadingIphone:frame];
#endif
        
    }
    return self;
}
#pragma mark -
#pragma mark Setters

// 更新 最后最新时间
- (void)refreshLastUpdatedDate 
{	
	if ([_delegate respondsToSelector:@selector(CBRefreshTableHeaderDataSourceLastUpdated:)]) 
    {
		NSDate *date = [_delegate CBRefreshTableHeaderDataSourceLastUpdated:self];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"最后更新: %@", [formatter stringFromDate:date]];
		[formatter release];
	} 
    else 
    {
		_lastUpdatedLabel.text = @"最后更新: 从未";
	}
}


// 三种状态
- (void)setState:(CBPullRefreshState)aState
{
	switch (aState) 
    {
		case CBPullRefreshPulling:
        {
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
//			_statusLabel.text = @"释放即可刷新...";
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
//			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
            loadFinish = NO;
        }
			break;
		case CBPullRefreshNormal:
        {
			if (_state == CBPullRefreshPulling) 
            {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
            loadFinish = YES;
//			_statusLabel.text = @"下拉即可刷新...";
//			[_activityView stopAnimating];
//            _activityView.hidden = YES;
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
//			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
        }
			break;
		case CBPullRefreshLoading:
        {
//			_statusLabel.text = @"加载中...";
//            _activityView.hidden = NO;
//            _arrowImage.hidden = YES;
            [_activityView.layer removeAllAnimations];
//            CABasicAnimation* rotationAnimation =
//            
//            [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//            
//            rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * -M_PI) * 20 +arc4random()%4];
//            
//            
//            rotationAnimation.duration = 20.0f;
//            
//            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//            [_activityView.layer addAnimation:rotationAnimation forKey:@"run"];
//            _activityView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0); //
            
            imaCount = 0;
            [self playNew:nil];
        }
			break;
		default:
			break;
	}
	
	_state = aState;
}

#pragma mark -
#pragma mark ScrollView Methods
//  向下 向上 拉动 过程 
- (void)CBRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSet =scrollView.contentOffset.y * -1;
    if(offSet >= 35 && offSet <= 200)
    {
        
//        num = (offSet - 35)/2;//14
//        [self play:num];
//        imaCount = (offSet - 35)/2.5;
//        [shuaxinIma setImage:[UIImage imageNamed:[imageArray objectAtIndex:imaCount]]];
        
    }
	if (_state == CBPullRefreshLoading)
    {
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
//        CGFloat offSet =scrollView.contentOffset.y * -1;
//        NSLog(@"scrollView.contentOffset.y=======%f",scrollView.contentOffset.y);
//        if(offSet >= 35 && offSet <= 70)
//        {
//            
//            num = (offSet - 35)/3;
//            [self play:num];
//        }
        
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(CBRefreshTableHeaderDataSourceIsLoading:)]) 
        {
			_loading = [_delegate CBRefreshTableHeaderDataSourceIsLoading:self];
		}
		
		if (_state == CBPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
				// 播放声音
			
		    NSString  *sound=[datafile getDataByKey:KEY_SWITCH_TONE];
			// 播放声音 sound=时，默认第一次 启动程序，默认 开关为 “开”
			if (sound == nil || [sound isEqualToString:SWITCH_TONE_ON]) 
            {
				[YDUtil playSound:@"pull_pull"];
			}
			
			[self setState:CBPullRefreshNormal];
			
		} else if (_state == CBPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading) {
			
			 NSString  *sound=[datafile getDataByKey:KEY_SWITCH_TONE];
			// 播放声音 sound=时，默认第一次 启动程序，默认 开关为 “开”
			if (sound==nil||[sound isEqualToString:SWITCH_TONE_ON]) {
				
				[YDUtil playSound:@"pull_pull"];
				
			}				
			[self setState:CBPullRefreshPulling];
		}
		
		if (scrollView.contentInset.top != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
	}
	
}

// 下拉完成动作 停在更新状态
- (void)CBRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView 
{
	BOOL _loading = NO;
	
	if ([_delegate respondsToSelector:@selector(CBRefreshTableHeaderDataSourceIsLoading:)]) 
    {
		_loading = [_delegate CBRefreshTableHeaderDataSourceIsLoading:self];
	}
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) 
    {
		 NSString *sound = [datafile getDataByKey:KEY_SWITCH_TONE];
		// 播放声音 sound=时，默认第一次 启动程序，默认 开关为 “开”
		if (sound == nil || [sound isEqualToString:SWITCH_TONE_ON]) {
			[YDUtil playSound:@"pull_ok"];
		}
		
		if ([_delegate respondsToSelector:@selector(CBRefreshTableHeaderDidTriggerRefresh:)]) {
			[_delegate CBRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		[self setState:CBPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}

// 完成刷新，动画隐藏刷新空间
- (void)CBRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView 
{
//    [self play:0];
//    [shuaxinIma setImage:[UIImage imageNamed:[imageArray objectAtIndex:0]]];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:CBPullRefreshNormal];
}

//- (void)play:(size_t)pic
//{
//    index = pic%count;
//    NSLog(@"indexindex==%zu   index2index2==%zu",index,index3);
//    if (index != index3) {
//        index3 = index;
//        NSLog(@"indexindex==%zu   index2index2==%zu",index,index3);
//        CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
//        layer1.contents = (id)ref;
//        CFRelease(ref);
//    }else{
//        
//    }
//    NSLog(@"index~~~~~~~~index====%zu",index);
//}
-(void)playNew:(NSInteger)indexPath
{
    imaCount ++;
    if(imaCount < imageArray.count)
    {
        _activityView.image = [UIImage imageNamed:[imageArray objectAtIndex:imaCount]];
        if(!loadFinish)
        {
            [self performSelector:@selector(playNew:) withObject:self afterDelay:0.1];
        }
        NSLog(@"%@",[imageArray objectAtIndex:imaCount]);
    }
    
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc 
{	
	_delegate = nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    