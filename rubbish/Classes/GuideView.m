//
//  GuideView.m
//  caibo
//
//  Created by yao on 12-1-5.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GuideView.h"
#import "NetURL.h"
#import "JSON.h"
#import "Info.h"

@implementation GuideView

@synthesize myScrollView;
@synthesize myPageCotntrol;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		disMiss = YES;
		//[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
		myScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
		myScrollView.pagingEnabled = YES;
		myPageCotntrol = [[YH_PageControl alloc] initWithFrame:CGRectMake(80, 410, 160, 30)];
		myScrollView.delegate = self;
		myScrollView.showsVerticalScrollIndicator = NO;
		myScrollView.showsHorizontalScrollIndicator = NO;
		myScrollView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
		self.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"Guidebg.jpg")];
		[self addSubview:myScrollView];
		[self addSubview:myPageCotntrol];
		UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 415, 20, 18)];
		imageView1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zuoshou.png" ofType:nil]];
		imageView1.tag = 1001;
		[self addSubview:imageView1];
		imageView1.hidden = YES;
		[imageView1 release];
		UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 415, 20, 18)];
		imageView2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"youshou.png" ofType:nil]];
		imageView2.tag = 1002;
		[self addSubview:imageView2];
		[imageView2 release];
    }
    return self;
}
-(void)LoadImageArray:(NSArray *)imageArray {
    for (UIView *v in myScrollView.subviews) {
		[v removeFromSuperview];
	}
	totlePage= [imageArray count];
	myPageCotntrol.numberOfPages = totlePage;
	myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width * totlePage, myScrollView.frame.size.height);
    for (int i = 0; i <[imageArray count]; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 * i, 0, self.bounds.size.width, self.bounds.size.height)];
		if (i <[imageArray count]) {
			imageView.image = UIImageGetImageFromName([imageArray objectAtIndex:i]);
		}
		[myScrollView addSubview:imageView];
		[imageView release];
	}
    myPageCotntrol.currentPage = 0;
	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(320 * (totlePage -1) +80, 370, 160, 36)];
	[btn setImage:UIImageGetImageFromName(@"beginbtn1.png") forState:UIControlStateNormal];
	[btn setImage:UIImageGetImageFromName(@"beginbtn2.png") forState:UIControlStateHighlighted];
	[btn addTarget:self action:@selector(removeself) forControlEvents:UIControlEventTouchUpInside];
	[myScrollView addSubview:btn];
	[btn release];
}

-(void)LoadPageCount:(NSInteger)page {
	for (UIView *v in myScrollView.subviews) {
		[v removeFromSuperview];
	}
	totlePage= page;
	myPageCotntrol.numberOfPages = page;
	myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width * page, myScrollView.frame.size.height);
	NSArray *array = [[NSArray alloc] initWithObjects:@"Guidebg1.png",@"Guidebg2.png",@"Guidebg3.png",nil];
	for (int i = 0; i <3; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 * i+36, 30, 248, 355)];
		if (i <[array count]) {
			imageView.image = UIImageGetImageFromName([array objectAtIndex:i]);
		}
		[myScrollView addSubview:imageView];
		[imageView release];
	}
	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(320 * (page -1) +80, 370, 160, 36)];
	[btn setImage:UIImageGetImageFromName(@"beginbtn1.png") forState:UIControlStateNormal];
	[btn setImage:UIImageGetImageFromName(@"beginbtn2.png") forState:UIControlStateHighlighted];
	[btn addTarget:self action:@selector(removeself) forControlEvents:UIControlEventTouchUpInside];
	[myScrollView addSubview:btn];
	[btn release];
    [array release];
}

- (void)removeself {
	[self removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGFloat pageWidth = scrollView.frame.size.width;
	if (scrollView.contentOffset.x > 320*totlePage -260) {
		//[self removeself];
		if (disMiss) {
			[self performSelector:@selector(removeself) withObject:nil afterDelay:0.2];
			disMiss = NO;
		}
		return;
	}
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	if(page > pageNum){
		pageNum = page;
		UIView *v1 = [self viewWithTag:1001];
		v1.hidden = NO;
		if (pageNum == totlePage - 1) {
			UIView *v = [self viewWithTag:1002];
			v.hidden = YES;
		}
		else {
			UIView *v = [self viewWithTag:1002];
			v.hidden = NO;
		}

		myPageCotntrol.currentPage = pageNum;
	}
	else if(page < pageNum){
        pageNum = page;
		myPageCotntrol.currentPage = pageNum; 
		UIView *v1 = [self viewWithTag:1002];
		v1.hidden = NO;
		if (pageNum == 0) {
			UIView *v = [self viewWithTag:1001];
			v.hidden = YES;
		}
		else {
			UIView *v = [self viewWithTag:1001];
			v.hidden = NO;
		}		
	}

}

- (void)touchImageView:(UIImageView *)_imageView {
	TouchImageView *v = (TouchImageView *)_imageView;
	if (v.isSelect) {
		UIImageView *v2 = (UIImageView *)[myScrollView viewWithTag:v.tag +1000];
		v2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GuideSelect.png" ofType:nil]];
	}
	else {
		UIImageView *v2 = (UIImageView *)[myScrollView viewWithTag:v.tag +1000];
		v2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GuideNoSelect.png" ofType:nil]];
	}
}
- (void)BtnClicke:(UIButton *)sender {
	TouchImageView *v = (TouchImageView *)[myScrollView viewWithTag:sender.tag -2000];
	if (!v.isSelect) {
		v.isSelect = YES;
		UIImageView *v2 = (UIImageView *)[myScrollView viewWithTag:v.tag +1000];
		v2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GuideSelect.png" ofType:nil]];
	}
	else {
		v.isSelect = NO;
		UIImageView *v2 = (UIImageView *)[myScrollView viewWithTag:v.tag +1000];
		v2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GuideNoSelect.png" ofType:nil]];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[myPageCotntrol release];
	[myScrollView release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    