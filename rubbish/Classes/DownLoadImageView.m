//
//  DownLoadImageView.m
//  caibo
//
//  Created by yao on 12-5-3.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "DownLoadImageView.h"
#import "caiboAppDelegate.h"

@implementation DownLoadImageView

@synthesize imageURL = _imageURL;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setImageWithURL:(NSString *)imageURL {
	[self setImageWithURL:imageURL DefautImage:nil];
}

- (void)setImageWithURL:(NSString *)imageURL DefautImage:(UIImage *)image1 {
    if ([imageURL length] < 5) {
        self.image = image1;
        return;
    }
	if (!reciver) {
		reciver = [[ImageStoreReceiver alloc] init];
		reciver.imageContainer = self;
	}
    self.imageURL = imageURL;
//	imageURL = [imageURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//	NSLog(@"%@",imageURL);
	imageURL = [imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	imageURL = [imageURL stringByReplacingOccurrencesOfString:@"%2520" withString:@"%20"];
	self.image = [[caiboAppDelegate getAppDelegate].imageDownloader fetchImage:imageURL Delegate:reciver DefautImage:image1];
}

- (void)updateImage:(UIImage*)image1 {
	self.image = image1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:reciver forURL:self.imageURL];
    reciver.imageContainer = nil;
	[reciver release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    