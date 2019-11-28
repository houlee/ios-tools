//
//  MWPhotoBrowser.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 14/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import "MWPhotoBrowser.h"
#import "ZoomingScrollView.h"
#import "Info.h"
#import "caiboAppDelegate.h"

#define PADDING 10

// Handle depreciations and supress hide warnings
@interface UIApplication (DepreciationWarningSuppresion)
- (void)setStatusBarHidden:(BOOL)hidden animated:(BOOL)animated;
@end

// MWPhotoBrowser
@implementation MWPhotoBrowser

@synthesize photoType, controller;
@synthesize delegate;
@synthesize kefubool;

- (id)initWithPhotos:(NSArray *)photosArray {
	if ((self = [super init])) {
		
		// Store photos
		photos = [photosArray retain];
		
        // Defaults
		self.wantsFullScreenLayout = YES;
        self.hidesBottomBarWhenPushed = YES;
		currentPageIndex = 0;
		performingLayout = NO;
		rotating = NO;
		
	}
	return self;
}

#pragma mark -
#pragma mark Memory

- (void)didReceiveMemoryWarning {
	
	// Release any cached data, images, etc that aren't in use.
	
	// Release images
	[photos makeObjectsPerformSelector:@selector(releasePhoto)];
	[recycledPages removeAllObjects];
	NSLog(@"didReceiveMemoryWarning");
	
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
}

// Release any retained subviews of the main view.
- (void)viewDidUnload {
    [super viewDidUnload];
	currentPageIndex = 0;
    [pagingScrollView release], pagingScrollView = nil;
    [visiblePages release], visiblePages = nil;
    [recycledPages release], recycledPages = nil;
    [toolbar release], toolbar = nil;
    [previousButton release], previousButton = nil;
    [nextButton release], nextButton = nil;
}

- (void)dealloc {
//    [self.navigationController.navigationBar setAlpha:1];
#ifndef isHaoLeCai
    [UIApplication sharedApplication].statusBarHidden = NO;
#endif
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
	[photos release];
    [controller release];
	[pagingScrollView release];
	[visiblePages release];
	[recycledPages release];
	[toolbar release];
	[previousButton release];
	[nextButton release];
    [super dealloc];
}
-(void)longPress:(UILongPressGestureRecognizer *)tap
{
    if(tap.state == UIGestureRecognizerStateBegan && save)
    {
        NSLog(@"long");
        UIView *backView=[[UIView alloc]init];
        backView.frame=[UIScreen mainScreen].bounds;
        backView.backgroundColor=[UIColor blackColor];
        backView.alpha=0.5;
        backView.tag=321;
        [self.view addSubview:backView];
        [backView release];
        
        UIView *saveView=[[UIView alloc]init];
        saveView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-154, 320, 154);
        saveView.backgroundColor=[UIColor whiteColor];
        saveView.alpha=0.9;
        saveView.tag=123;
        [self.view addSubview:saveView];
        
        UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.frame=CGRectMake(22, 22, 320-44, 44);
        saveBtn.backgroundColor=[UIColor clearColor];
        [saveBtn setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
        [saveBtn setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateHighlighted];
        saveBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [saveBtn setTitle:@"保 存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
        saveBtn.tag=1;
        [saveView addSubview:saveBtn];
        UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame=CGRectMake(22, 88, 320-44, 44);
        cancelBtn.backgroundColor = [UIColor colorWithRed:151/255.0 green:153/255.0 blue:158/255.0 alpha:1];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.tag=2;
        cancelBtn.layer.masksToBounds=YES;
        cancelBtn.layer.cornerRadius=4;
        [saveView addSubview:cancelBtn];
        
        [saveView release];
        save = NO;
    }
}
-(void)saveClick:(UIButton *)button
{
    //保存
    if(button.tag==1)
    {
        [self actionSave:nil];
    }
    UIView *saveView=[self.view viewWithTag:123];
    [saveView removeFromSuperview];
    UIView *backView=[self.view viewWithTag:321];
    [backView removeFromSuperview];
    save = YES;
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [self actionBack:nil];
}
#pragma mark -
#pragma mark View
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (id view in [scrollView subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            return view;
        }
    }
    return  nil;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// View
    
    
	self.view.backgroundColor = [UIColor blackColor];
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    app.window.backgroundColor = [UIColor blackColor];
//    UIView * bgview = [[UIView alloc] init];
//     bgview.frame = CGRectMake(0,  self.view.frame.size.height - app.window.frame.size.height , self.view.frame.size.width, app.window.frame.size.height);
//    bgview.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:bgview];
//    [bgview release];
    
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration=1;
    [self.view addGestureRecognizer:longPress];
    [longPress release];
    save = YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
	
	// Setup paging scrolling view
	CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
	pagingScrollView = [[UIScrollView alloc] initWithFrame:pagingScrollViewFrame];
	pagingScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	pagingScrollView.pagingEnabled = YES;
	pagingScrollView.delegate = self;
    pagingScrollView.maximumZoomScale=2.0f;
	pagingScrollView.showsHorizontalScrollIndicator = NO;
	pagingScrollView.showsVerticalScrollIndicator = NO;
	pagingScrollView.backgroundColor = [UIColor clearColor];
    pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
	pagingScrollView.contentOffset = [self contentOffsetForPageAtIndex:currentPageIndex];
	[self.view addSubview:pagingScrollView];
	
	// Setup pages
	visiblePages = [[NSMutableSet alloc] init];
	recycledPages = [[NSMutableSet alloc] init];
	[self tilePages];
    
    // Navigation bar
    self.navigationController.navigationBar.tintColor = nil;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    //    UIBarButtonItem *leftItem = [Info itemInitWithTitle:@"返 回" Target:self action:@selector(actionBack:)];
    
    
    
    
    UIButton*  exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitLoginButton setBounds:CGRectMake(0, 0, 70, 40)];
    
    
    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [exitLoginButton addSubview:imagevi];
    [imagevi release];
    
    UILabel *beginLabel = [[UILabel alloc] initWithFrame:exitLoginButton.bounds];
    beginLabel.backgroundColor = [UIColor clearColor];
    beginLabel.textColor = [UIColor whiteColor];
    
    beginLabel.font = [UIFont systemFontOfSize:12];
    beginLabel.textAlignment = NSTextAlignmentCenter;
    [exitLoginButton addSubview:beginLabel];
    [beginLabel release];
    
//    UIBarButtonItem *barBtnItem = [[[UIBarButtonItem alloc] initWithCustomView:exitLoginButton] autorelease];
    
    
    
    
//    UIBarButtonItem *rightItem;
    if (photoType == kTypeWithUIImage) {// 从写微博界面跳转过来,修改右边按钮为删除该图片按钮
        //        rightItem = [Info itemInitWithTitle:@"删 除" Target:self action:@selector(actionDelete:)];
        
        [exitLoginButton addTarget:self action:@selector(actionDelete:) forControlEvents:UIControlEventTouchUpInside];
        beginLabel.text = @"删 除";
    } else if (photoType == kTypeWithURL){
        MWPhoto *mphoto = [photos objectAtIndex:0];;
        NSString *string = [NSString stringWithFormat:@"%@",[mphoto getPhotoURL]];
        NSLog(@"%@",string);
        if ([string length] >3 && [[[string substringFromIndex:[string length]-3] lowercaseString] isEqualToString:@"gif"])
        {
            //                    rightItem = [Info itemInitWithTitle:@"保 存" Target:self action:@selector(actionSave:)];
            //                    rightItem.enabled = NO;
            
            [exitLoginButton addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
            beginLabel.text = @"保 存";
            exitLoginButton.enabled = NO;
            
        }
        else {
            //                    rightItem = [Info itemInitWithTitle:@"保 存" Target:self action:@selector(actionSave:)];
            [exitLoginButton addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
            beginLabel.text = @"保 存";
        }
    } else {
//        rightItem = [Info itemInitWithTitle:@"Error" Target:self action:nil];
    }
    //    [self.navigationItem setLeftBarButtonItem:leftItem];
    self.navigationItem.leftBarButtonItem = [Info backItemTarget:self action:@selector(actionBack:)];
    
    if (!kefubool) {
        
        
        
//        self.navigationItem.rightBarButtonItem = barBtnItem;
        
        
        
        
        //        [self.navigationItem setRightBarButtonItem:rightItem];
    }
    
    
	
    // Only show toolbar if there's more that 1 photo
    if (photos.count > 1) {
        
        // Toolbar
        toolbar = [[UIToolbar alloc] initWithFrame:[self frameForToolbarAtOrientation:self.interfaceOrientation]];
        toolbar.tintColor = nil;
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:toolbar];
        
        // Toolbar Items
        previousButton = [[UIBarButtonItem alloc] initWithImage:UIImageGetImageFromName(@"UIBarButtonItemArrowLeft.png") style:UIBarButtonItemStylePlain target:self action:@selector(gotoPreviousPage)];
        nextButton = [[UIBarButtonItem alloc] initWithImage:UIImageGetImageFromName(@"UIBarButtonItemArrowRight.png") style:UIBarButtonItemStylePlain target:self action:@selector(gotoNextPage)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:space];
        if (photos.count > 1) [items addObject:previousButton];
        [items addObject:space];
        if (photos.count > 1) [items addObject:nextButton];
        [items addObject:space];
        [toolbar setItems:items];
        [items release];
        [space release];
        
    }
    
	// Super
    [super viewDidLoad];
	
}

//////////////////////////////////////////

- (void)returnMWPhotoBrowserDelegate{
    
}
- (void) actionBack:(id)sender {
    
    if ([delegate respondsToSelector:@selector(returnMWPhotoBrowserDelegate)]) {
        [delegate returnMWPhotoBrowserDelegate];
    }
    

    [self.navigationController popViewControllerAnimated:NO];

    [self dismissViewControllerAnimated: YES completion: nil];
    
}

- (void) actionDelete:(id)sender {
    if ([self imageAtIndex:currentPageIndex]) {
        if (controller) {
            if ([controller respondsToSelector:@selector(deleteImage)]) {
                [self dismissViewControllerAnimated: YES completion: nil];
                [controller performSelector:@selector(deleteImage)];
            }
        }
    }
}

- (void) actionSave:(id)sender {
    if ([self imageAtIndex:currentPageIndex]) {
        UIImageWriteToSavedPhotosAlbum([self imageAtIndex:currentPageIndex], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo {
    if (error != NULL) {
        NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
													   message:@"图片保存失败,请重试!"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    } else {// No errors
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"图片保存成功!"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
///////////////////////////////////////////////


- (void)viewWillAppear:(BOOL)animated {
    
	// Super
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
	// Layout
	[self performLayout];
    
    // Set status bar style to black translucent
#ifdef isCaiPiaoForIPad
#else
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
#endif
	
    
	// Navigation
	[self updateNavigation];
	[self hideControlsAfterDelay];
	[self didStartViewingPageAtIndex:currentPageIndex]; // initial
	
}

- (void)viewWillDisappear:(BOOL)animated {
	
	// Super
	[super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
	// Cancel any hiding timers
	[self cancelControlHiding];
    
#ifdef isHaoLeCai
    [UIApplication sharedApplication].statusBarHidden = YES;
#else
    [UIApplication sharedApplication].statusBarHidden = YES;
#endif
    
    
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    app.window.backgroundColor = [UIColor whiteColor];
	
}

#pragma mark -
#pragma mark Layout

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

// Layout subviews
- (void)performLayout {
	
	// Flag
	performingLayout = YES;
	
	// Toolbar
	toolbar.frame = [self frameForToolbarAtOrientation:self.interfaceOrientation];
	
	// Remember index
	NSUInteger indexPriorToLayout = currentPageIndex;
	
	// Get paging scroll view frame to determine if anything needs changing
	CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
    
	// Frame needs changing
	pagingScrollView.frame = pagingScrollViewFrame;
	
	// Recalculate contentSize based on current orientation
	pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
	
	// Adjust frames and configuration of each visible page
	for (ZoomingScrollView *page in visiblePages) {
		page.frame = [self frameForPageAtIndex:page.index];
		[page setMaxMinZoomScalesForCurrentBounds];
	}
	
	// Adjust contentOffset to preserve page location based on values collected prior to location
	pagingScrollView.contentOffset = [self contentOffsetForPageAtIndex:indexPriorToLayout];
	
	// Reset
	currentPageIndex = indexPriorToLayout;
	performingLayout = NO;
    
}

#pragma mark -
#pragma mark Photos

// Get image if it has been loaded, otherwise nil
- (UIImage *)imageAtIndex:(NSUInteger)index {
	if (photos && index < photos.count) {
        
		// Get image or obtain in background
		MWPhoto *photo = [photos objectAtIndex:index];
		if ([photo isImageAvailable]) {
			return [photo image];
		} else {
			[photo obtainImageInBackgroundAndNotify:self];
		}
	}
	return nil;
}

#pragma mark -
#pragma mark MWPhotoDelegate

- (void)photoDidFinishLoading:(MWPhoto *)photo {
	NSUInteger index = [photos indexOfObject:photo];
	if (index != NSNotFound) {
		if ([self isDisplayingPageForIndex:index]) {
			
			// Tell page to display image again
			ZoomingScrollView *page = [self pageDisplayedAtIndex:index];
			if (page) [page displayImage];
			
		}
	}
}

- (void)photoDidFailToLoad:(MWPhoto *)photo {
	NSUInteger index = [photos indexOfObject:photo];
	if (index != NSNotFound) {
		if ([self isDisplayingPageForIndex:index]) {
			
			// Tell page it failed
			ZoomingScrollView *page = [self pageDisplayedAtIndex:index];
			if (page) [page displayImageFailure];
			
		}
	}
}

#pragma mark -
#pragma mark Paging

- (void)tilePages {
	
	// Calculate which pages should be visible
	// Ignore padding as paging bounces encroach on that
	// and lead to false page loads
	CGRect visibleBounds = pagingScrollView.bounds;
	int iFirstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+PADDING*2) / CGRectGetWidth(visibleBounds));
	int iLastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-PADDING*2-1) / CGRectGetWidth(visibleBounds));
    if (iFirstIndex < 0) iFirstIndex = 0;
    if (iFirstIndex > (int)photos.count - 1) iFirstIndex = (int)photos.count - 1;
    if (iLastIndex < 0) iLastIndex = 0;
    if (iLastIndex > (int)photos.count - 1) iLastIndex = (int)photos.count - 1;
	
	// Recycle no longer needed pages
	for (ZoomingScrollView *page in visiblePages) {
		if (page.index < (NSUInteger)iFirstIndex || page.index > (NSUInteger)iLastIndex) {
			[recycledPages addObject:page];
			/*NSLog(@"Removed page at index %i", page.index);*/
			page.index = NSNotFound; // empty
			[page removeFromSuperview];
		}
	}
	[visiblePages minusSet:recycledPages];
	
	// Add missing pages
	for (NSUInteger index = (NSUInteger)iFirstIndex; index <= (NSUInteger)iLastIndex; index++) {
		if (![self isDisplayingPageForIndex:index]) {
			ZoomingScrollView *page = [self dequeueRecycledPage];
			if (!page) {
				page = [[[ZoomingScrollView alloc] init] autorelease];
				page.photoBrowser = self;
			}
			[self configurePage:page forIndex:index];
			[visiblePages addObject:page];
			[pagingScrollView addSubview:page];
			/*NSLog(@"Added page at index %i", page.index);*/
		}
	}
	
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index {
	for (ZoomingScrollView *page in visiblePages)
		if (page.index == index) return YES;
	return NO;
}

- (ZoomingScrollView *)pageDisplayedAtIndex:(NSUInteger)index {
	ZoomingScrollView *thePage = nil;
	for (ZoomingScrollView *page in visiblePages) {
		if (page.index == index) {
			thePage = page; break;
		}
	}
	return thePage;
}

- (void)configurePage:(ZoomingScrollView *)page forIndex:(NSUInteger)index {
	page.frame = [self frameForPageAtIndex:index];
	page.index = index;
}

- (ZoomingScrollView *)dequeueRecycledPage {
	ZoomingScrollView *page = [recycledPages anyObject];
	if (page) {
		[[page retain] autorelease];
		[recycledPages removeObject:page];
	}
	return page;
}

// Handle page changes
- (void)didStartViewingPageAtIndex:(NSUInteger)index {
    NSUInteger i;
    if (index > 0) {
        
        // Release anything < index - 1
        for (i = 0; i < index-1; i++) { [(MWPhoto *)[photos objectAtIndex:i] releasePhoto]; /*NSLog(@"Release image at index %i", i);*/ }
        
        // Preload index - 1
        i = index - 1;
        if (i < photos.count) { [(MWPhoto *)[photos objectAtIndex:i] obtainImageInBackgroundAndNotify:self]; /*NSLog(@"Pre-loading image at index %i", i);*/ }
        
    }
    if (index < photos.count - 1) {
        
        // Release anything > index + 1
        for (i = index + 2; i < photos.count; i++) { [(MWPhoto *)[photos objectAtIndex:i] releasePhoto]; /*NSLog(@"Release image at index %i", i);*/ }
        
        // Preload index + 1
        i = index + 1;
        if (i < photos.count) { [(MWPhoto *)[photos objectAtIndex:i] obtainImageInBackgroundAndNotify:self]; /*NSLog(@"Pre-loading image at index %i", i);*/ }
        
    }
}

#pragma mark -
#pragma mark Frame Calculations

- (CGRect)frameForPagingScrollView {
    CGRect frame = self.view.bounds;// [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return frame;
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    // We have to use our paging scroll view's bounds, not frame, to calculate the page placement. When the device is in
    // landscape orientation, the frame will still be in portrait because the pagingScrollView is the root view controller's
    // view, so its frame is in window coordinate space, which is never rotated. Its bounds, however, will be in landscape
    // because it has a rotation transform applied.
    CGRect bounds = pagingScrollView.bounds;
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    return pageFrame;
}

- (CGSize)contentSizeForPagingScrollView {
    // We have to use the paging scroll view's bounds to calculate the contentSize, for the same reason outlined above.
    CGRect bounds = pagingScrollView.bounds;
    return CGSizeMake(bounds.size.width * photos.count, bounds.size.height);
}

- (CGPoint)contentOffsetForPageAtIndex:(NSUInteger)index {
	CGFloat pageWidth = pagingScrollView.bounds.size.width;
	CGFloat newOffset = index * pageWidth;
	return CGPointMake(newOffset, 0);
}

- (CGRect)frameForNavigationBarAtOrientation:(UIInterfaceOrientation)orientation {
	CGFloat height = UIInterfaceOrientationIsPortrait(orientation) ? 44 : 32;
	return CGRectMake(0, 20, self.view.bounds.size.width, height);
}

- (CGRect)frameForToolbarAtOrientation:(UIInterfaceOrientation)orientation {
	CGFloat height = UIInterfaceOrientationIsPortrait(orientation) ? 44 : 32;
	return CGRectMake(0, self.view.bounds.size.height - height, self.view.bounds.size.width, height);
}

#pragma mark -
#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (performingLayout || rotating) return;
	
	// Tile pages
	[self tilePages];
	
	// Calculate current page
	CGRect visibleBounds = pagingScrollView.bounds;
	int index = (int)(floorf(CGRectGetMidX(visibleBounds) / CGRectGetWidth(visibleBounds)));
    if (index < 0) index = 0;
	if (index > photos.count - 1) index = (int)photos.count - 1;
	NSUInteger previousCurrentPage = currentPageIndex;
	currentPageIndex = index;
	if (currentPageIndex != previousCurrentPage) {
        [self didStartViewingPageAtIndex:index];
    }
	
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	// Hide controls when dragging begins
	[self setControlsHidden:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	// Update nav when page changes
	[self updateNavigation];
}

#pragma mark -
#pragma mark Navigation

- (void)updateNavigation {
    
	// Title
	if (photos.count > 1) {
		NSString *title = [NSString stringWithFormat:@"第 %i 张", (int)currentPageIndex + 1];
        self.title = [title stringByAppendingFormat:@" (共 %i 张)", (int)photos.count];
	} else {
		self.title = nil;
	}
	
	// Buttons
	previousButton.enabled = (currentPageIndex > 0);
	nextButton.enabled = (currentPageIndex < photos.count-1);
	
}

- (void)jumpToPageAtIndex:(NSUInteger)index {
	
	// Change page
	if (index < photos.count) {
		CGRect pageFrame = [self frameForPageAtIndex:index];
		pagingScrollView.contentOffset = CGPointMake(pageFrame.origin.x - PADDING, 0);
		[self updateNavigation];
	}
	
	// Update timer to give more time
	[self hideControlsAfterDelay];
	
}

- (void)gotoPreviousPage { [self jumpToPageAtIndex:currentPageIndex-1]; }
- (void)gotoNextPage { [self jumpToPageAtIndex:currentPageIndex+1]; }

#pragma mark -
#pragma mark Control Hiding / Showing

- (void)setControlsHidden:(BOOL)hidden {
	
	// Get status bar height if visible
	CGFloat statusBarHeight = 0;
	if (![UIApplication sharedApplication].statusBarHidden) {
		CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
		statusBarHeight = MIN(statusBarFrame.size.height, statusBarFrame.size.width);
	}
	
	// Status Bar
	if ([UIApplication instancesRespondToSelector:@selector(setStatusBarHidden:withAnimation:)]) {
#ifdef isCaiPiaoForIPad
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
#else
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
#endif
		
	} else {
        //3.2以后支持上一个方法了		[[UIApplication sharedApplication] setStatusBarHidden:hidden animated:YES];
	}
	
	// Get status bar height if visible
	if (![UIApplication sharedApplication].statusBarHidden) {
		CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
		statusBarHeight = MIN(statusBarFrame.size.height, statusBarFrame.size.width);
	}
	
	// Set navigation bar frame
	CGRect navBarFrame = self.navigationController.navigationBar.frame;
	navBarFrame.origin.y = statusBarHeight;
#ifdef isCaiPiaoForIPad
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
    if (self.navigationController.navigationBar.alpha == 1) {
        [self.navigationController.navigationBar setAlpha:0];
    }else{
        [self.navigationController.navigationBar setAlpha: 1];
    }
	
	[toolbar setAlpha:hidden ? 0 : 1];
	[UIView commitAnimations];
    
    
    
#else
    NSLog(@"hidden = %d", hidden);
//    self.navigationController.navigationBar.frame = navBarFrame;
//    [UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.35];
//	[self.navigationController.navigationBar setAlpha:hidden ? 0 : 1];
//	[toolbar setAlpha:hidden ? 0 : 1];
//	[UIView commitAnimations];
    
#endif
	
	// Bars
    
	// Control hiding timer
	// Will cancel existing timer but only begin hiding if
	// they are visible
	[self hideControlsAfterDelay];
	
}

- (void)cancelControlHiding {
	// If a timer exists then cancel and release
	if (controlVisibilityTimer) {
		[controlVisibilityTimer invalidate];
		[controlVisibilityTimer release];
		controlVisibilityTimer = nil;
	}
}

// Enable/disable control visiblity timer
- (void)hideControlsAfterDelay {
	[self cancelControlHiding];
	if (![UIApplication sharedApplication].isStatusBarHidden) {
		controlVisibilityTimer = [[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hideControls) userInfo:nil repeats:NO] retain];
	}
}

- (void)hideControls { [self setControlsHidden:YES]; }
- (void)toggleControls {
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
//        [self setControlsHidden:NO];
//    }else{
//        [self setControlsHidden:![UIApplication sharedApplication].isStatusBarHidden];
//    }
    

    
//    if (self.navigationController.navigationBar.alpha == 0) {
//        [self setControlsHidden:NO];
//    }
//    else{
//        [self setControlsHidden:YES];
//    }
}

#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
	// Remember page index before rotation
	pageIndexBeforeRotation = currentPageIndex;
	rotating = YES;
	
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	// Perform layout
	currentPageIndex = pageIndexBeforeRotation;
	[self performLayout];
	
	// Delay control holding
	[self hideControlsAfterDelay];
	
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	rotating = NO;
}

#pragma mark -
#pragma mark Properties

- (void)setInitialPageIndex:(NSUInteger)index {
	if (![self isViewLoaded]) {
		if (index >= photos.count) {
			currentPageIndex = 0;
		} else {
			currentPageIndex = index;
		}
	}
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    