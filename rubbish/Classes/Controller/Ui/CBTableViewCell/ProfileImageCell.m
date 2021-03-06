//
//  ProfileImageCell.m
//  caibo
//
//  Created by jacob on 11-6-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfileImageCell.h"
#import <QuartzCore/QuartzCore.h>
#import "caiboAppDelegate.h"
#import "ImageDownloader.h"
#import "UIImageExtra.h"
#import "caiboAppDelegate.h"

@implementation ProfileImageCell

@synthesize imageButton, pImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        receiver = [[ImageStoreReceiver alloc] init];
        
        imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [imageButton.layer setMasksToBounds:YES];
        [imageButton setAdjustsImageWhenHighlighted:NO];
        [imageButton addTarget:self action:@selector(didTouchHeadImageButton:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:imageButton];
		
		UIImageView *pView = [[UIImageView alloc] init];
		pView.frame = CGRectMake(0, 0, 0, 0);
		[pView setImage: UIImageGetImageFromName(@"V.png")];
		pView.backgroundColor = [UIColor clearColor];
		self.pImageView = pView;
		[pView release];
		[imageButton addSubview:self.pImageView];

    }
    return self;
}

// 点击用户头像 --- 由具体之类实现
- (void)didTouchHeadImageButton:(id)sender
{
}

// 图片下载完成后回调更新图片
- (void)updateImage:(UIImage*)image {
    if ([caiboAppDelegate getAppDelegate].isBubbleTheme) {
        [imageButton.layer setBorderWidth:1.0];
        [imageButton.layer setCornerRadius:0.0];
        [imageButton setBackgroundColor: [UIColor whiteColor]];
        image = [image rescaleImageToSize:CGSizeMake(36, 36)];
    } else {
        [imageButton.layer setBorderWidth:0.0];
        [imageButton.layer setCornerRadius:5.0];
        [imageButton setBackgroundColor: [UIColor clearColor]];
        image = [image rescaleImageToSize:CGSizeMake(40, 40)];
    }
    [imageButton setImage:image forState:UIControlStateNormal];
}

// 下载头像图片
- (void) fetchProfileImage:(NSString *)url {
    if (imageUrl != url) {
        [imageUrl release];
    }
    imageUrl = [url copy];
    
    ImageDownloader *store = [caiboAppDelegate getAppDelegate].imageDownloader;
    UIImage *image = [store fetchImage:imageUrl Delegate:receiver Big:NO];
    receiver.imageContainer = self;
    
    if ([caiboAppDelegate getAppDelegate].isBubbleTheme) {
        [imageButton.layer setBorderWidth:1.0];
        [imageButton.layer setCornerRadius:0.0];
        [imageButton setBackgroundColor: [UIColor whiteColor]];
        image = [image rescaleImageToSize:CGSizeMake(36, 36)];
    } else {
        [imageButton.layer setBorderWidth:0.0];
        [imageButton.layer setCornerRadius:5.0];
        [imageButton setBackgroundColor: [UIColor clearColor]];
        image = [image rescaleImageToSize:CGSizeMake(40, 40)];
    }
    [imageButton setImage:image forState:(UIControlStateNormal)];
}
 
// if the cell is reusable (has a reuse identifier), 
//this is called just before the cell is returned from the table view method dequeueReusableCellWithIdentifier:.
//If you override, you MUST call super.
- (void)prepareForReuse
{
    [super prepareForReuse];
    ImageDownloader *store = [caiboAppDelegate getAppDelegate].imageDownloader;
    [store removeDelegate:receiver forURL:imageUrl];
    receiver.imageContainer = nil;
}

- (void)dealloc {
    receiver.imageContainer = nil;
    ImageDownloader *store = [caiboAppDelegate getAppDelegate].imageDownloader;
    [store removeDelegate:receiver forURL:imageUrl];
    [imageUrl release];
    [receiver release];
    [pImageView release];
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    