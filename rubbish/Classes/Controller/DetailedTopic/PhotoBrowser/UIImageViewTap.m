//
//  UIImageViewTap.m
//  Momento
//
//  Created by Michael Waterfall on 04/11/2009.
//  Copyright 2009 d3i. All rights reserved.
//

#import "UIImageViewTap.h"
#import "DataBase.h"
#import "Statement.h"
#import "caiboAppDelegate.h"


@implementation UIImageViewTap

@synthesize tapDelegate;
@synthesize imageURL;

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

- (void) getImageAgain {
	if (self.imageURL && [[[imageURL substringFromIndex:[imageURL length]-3] lowercaseString] isEqualToString:@"gif"]){
		NSData *data = [self getImageFromDB:self.imageURL];
		if (data) {
			if (!myGifView) {
				myGifView =[[GifView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) ImageData:data];
				[self addSubview:myGifView];
				[myGifView release];
			}
			else {
				[myGifView ReLoadImageData:data WithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
			}
//			if (myGifView.count <2) {
//				[myGifView removeFromSuperview];
//			}
//			else {
				if (![self.image isEqual:UIImageGetImageFromName(@"blackBack.png")]) {
					self.image = UIImageGetImageFromName(@"blackBack.png");
				}
				[myGifView setHidden:NO];
//			}
			return;
		}
		else {
			//[[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : imageURL Delegate:self Big:YES];
			[self performSelector:@selector(getImageAgain) withObject:nil afterDelay:1];
		}
	}
}

- (void)setImage:(UIImage *)_image{
	[super setImage:_image];
	//self.userInteractionEnabled = YES;
	[myGifView setHidden:YES];
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = YES;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GIFImageURL:) name:@"GIFImageURL" object:nil];
	}
	return self;
}

- (void)GIFImageURL:(NSNotification *)notification {
	self.imageURL = (NSString *)[notification object];
}

- (void)setFrame:(CGRect)_frame {
	[super setFrame:_frame];
	myGifView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (id)initWithImage:(UIImage *)image {
	if ((self = [super initWithImage:image])) {
		self.userInteractionEnabled = YES;
	}
	return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
	if ((self = [super initWithImage:image highlightedImage:highlightedImage])) {
		self.userInteractionEnabled = YES;
	}
	return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	NSUInteger tapCount = touch.tapCount;
	switch (tapCount) {
		case 1:
			[self handleSingleTap:touch];
			break;
		case 2:
			[self handleDoubleTap:touch];
			break;
		case 3:
			[self handleTripleTap:touch];
			break;
		default:
			break;
	}
	// Doesnt work in iOS 3
//	switch (tapCount) {
//		case 1:
//			[self performSelector:@selector(handleSingleTap:) withObject:touch afterDelay:0.2];
//			break;
//		case 2:
//			[NSObject cancelPreviousPerformRequestsWithTarget:self];
//			[self performSelector:@selector(handleDoubleTap:) withObject:touch afterDelay:0.2];
//			break;
//		case 3:
//			[NSObject cancelPreviousPerformRequestsWithTarget:self];
//			[self performSelector:@selector(handleTripleTap:) withObject:touch afterDelay:0.2];
//			break;
//		default:
//			break;
//	}
	[[self nextResponder] touchesEnded:touches withEvent:event];
}

- (void)handleSingleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:singleTapDetected:)])
		[tapDelegate imageView:self singleTapDetected:touch];
}

- (void)handleDoubleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:doubleTapDetected:)])
		[tapDelegate imageView:self doubleTapDetected:touch];
}

- (void)handleTripleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:tripleTapDetected:)])
		[tapDelegate imageView:self tripleTapDetected:touch];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"GIFImageURL" object:nil];
	self.imageURL = nil;
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    