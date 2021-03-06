//
//  PopupView.m
//  caibo
//
//  Created by jeff.pluto on 11-8-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CP_PopupView.h"
#import <QuartzCore/QuartzCore.h>
#import "caiboAppDelegate.h"
#import "UIImageExtra.h"
#import "MWPhotoBrowser.h"

@implementation CP_PopupView

@synthesize IsGif;
@synthesize bigImageURL;

- (id) initWithUrl:(NSString *)url {
    if ((self = [super init])) {
        self.backgroundColor = [UIColor clearColor];
        
#ifdef isCaiPiaoForIPad
        
        
        [self setFrame:[caiboAppDelegate getAppDelegate].window.rootViewController.view.bounds];
#else
        [self setFrame:[caiboAppDelegate getAppDelegate].window.bounds];
#endif
        
        
        
        imageView = [[UIImageView alloc] init];
        [imageView setAlpha: 0.0];
        [imageView.layer setCornerRadius: 7.0];
        [imageView.layer setBorderWidth: 7.0];
        [imageView.layer setBorderColor: [[UIColor colorWithRed:152 / 255.0 green:152 / 255.0 blue:152 / 255.0 alpha:0.7] CGColor]];
        [self addSubview:imageView];
        
        receiver = [[ImageStoreReceiver alloc] init];
        receiver.imageContainer = self;
        
        if (imageUrl != url) {
            [imageUrl release];
        }
        imageUrl = [url copy];
        IsGif = NO;
        [self setImage:[[caiboAppDelegate getAppDelegate].imageDownloader fetchImage : imageUrl Delegate:receiver Big:YES]];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    }
    return self;
}

- (void)updateImage:(UIImage *)image {
    [self setImage:image];
}

- (void) setImage:(UIImage *)image {
    image = [UIImage createRoundedRectImage:image size:CGSizeMake(image.size.width - 5, image.size.height - 5)];
    int w = image.size.width;
    int h = image.size.height;
    if (w > 250 && h > 350) {
        image = [image rescaleImageToSize:CGSizeMake(180, 280)];
    } else if (w > 250) {
        image = [image rescaleImageToSize:CGSizeMake(180, h)];
    } else if (h > 350) {
        image = [image rescaleImageToSize:CGSizeMake(w, 280)];
    }
    w = image.size.width;
    h = image.size.height;
    int x = (self.bounds.size.width - w) / 2;
    int y = (self.bounds.size.height - h) / 2;
    [imageView setImage:image];
    [imageView setFrame:CGRectMake(x, y, w, h)];
//    self.layer.contents = (id)image.CGImage;
}

- (void)showGIF {
    if (bigImageURL) {
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:bigImageURL]]];
        MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
        [photoBrowser setPhotoType : kTypeWithURL];
        [photos release];
        
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:photoBrowser];
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

        navController.navigationBarHidden = NO;
        [photoBrowser release];
        if (navController) {
			caiboAppDelegate *delegate = [caiboAppDelegate getAppDelegate];
			UINavigationController *nav = (UINavigationController*)delegate.window.rootViewController;
            [nav presentViewController:navController animated: YES completion:nil];
        }
		
        [navController release];
    }
}

- (void) show {
    caiboAppDelegate *delegate = [caiboAppDelegate getAppDelegate];
    
#ifdef isCaiPiaoForIPad
    UINavigationController *nav = (UINavigationController*)delegate.window.rootViewController;
    NSArray * navarr = nav.viewControllers;
    UIViewController * lastView = [navarr lastObject];
#else
    UINavigationController *nav = (UINavigationController*)delegate.window.rootViewController;
#endif
    
    
	
    if (self.IsGif) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"播放GIF" forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn setImage:UIImageGetImageFromName(@"gifplaybtn.png") forState:UIControlStateNormal];
        [btn setImage:UIImageGetImageFromName(@"gifplaybtn_1.png") forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(showGIF) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(79, 350, 161.5 , 33);
    }
#ifdef isCaiPiaoForIPad
    [lastView.view addSubview:self];
#else
    self.center = nav.view.center;
    [nav.view addSubview:self];
#endif
	
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.60];
    [UIView setAnimationDelegate:self];
    imageView.alpha = 1.0;
    [UIView commitAnimations];
}

- (void) dismiss {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.60];
    imageView.alpha = 0.0;
    [UIView commitAnimations];
    [self removeFromSuperview];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    size_t gradLocationsNum = 2;
//    CGFloat gradLocations[2] = {0.0f, 1.0f};
//    CGFloat gradColors[8] = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.75f};
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
//    CGColorSpaceRelease(colorSpace);
//    
//    CGPoint gradCenter= CGPointMake(320 / 2, 480 / 2);
//
//    float gradRadius = MIN(320 , 480);
//
//    CGContextDrawRadialGradient (context, gradient, gradCenter,
//                                 0, gradCenter, gradRadius,
//                                 kCGGradientDrawsAfterEndLocation);
//    CGGradientRelease(gradient);
//    
////    CGContextClosePath(context);
//    CGContextFillPath(context);
//}

- (void)dealloc {
    receiver.imageContainer = nil;
    [[caiboAppDelegate getAppDelegate].imageDownloader removeDelegate:receiver forURL:imageUrl];
    [imageUrl release];
    [receiver release];
    [imageView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    