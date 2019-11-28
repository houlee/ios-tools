//
//  GifView.h
//  GIFViewer
//
//  Created by xToucher04 on 11-11-9.
//  Copyright 2011 Toucher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface GifView : UIView {
	CGImageSourceRef gif;
	NSDictionary *gifProperties;
	size_t index;
	size_t count;
	NSTimer *timer;
    float stopTime;
    
    UIImageView * selfImageView;
    NSArray * changeImageArray;
    int changeCount;
    float changeFps;
    BOOL running;
    
    CFRunLoopRef changeImageRunLoopRef;
    NSInteger maxChangeCount;
}

@property(nonatomic,assign) NSInteger maxChangeCount;

@property(nonatomic,assign)CFRunLoopRef changeImageRunLoopRef;
@property (nonatomic,retain)NSTimer * timer;

@property (nonatomic, assign)BOOL running;
@property (nonatomic, retain)NSArray * changeImageArray;
@property(nonatomic)size_t count;
- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath stop:(float) stop;
- (id)initWithFrame:(CGRect)frame ImageData:(NSData *)_imageData;
- (void)ReLoadImageData:(NSData *)_imageData WithFrame:(CGRect)frame;
- (void)playbyTime;

- (id)initWithFrame:(CGRect)frame defaultImage:(NSString *)defaultImageName ImageArray:(NSArray *)imageArray fps:(float)fps;
-(void)gifRun;
-(void)gifStop;

@end
