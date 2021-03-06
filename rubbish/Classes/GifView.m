//
//  GifView.m
//  GIFViewer
//
//  Created by xToucher04 on 11-11-9.
//  Copyright 2011 Toucher. All rights reserved.
//

#import "GifView.h"
#import <QuartzCore/QuartzCore.h>


@implementation GifView

@synthesize count;
@synthesize changeImageArray;
@synthesize running;
@synthesize timer;
@synthesize changeImageRunLoopRef;
@synthesize maxChangeCount;

float buf[49] = {0.03,0.03,0.03,0.03,0.03,0.03,0.03,0.03,0.03,0.02,0.02,0.02,0.02,0.01,0.01,0.01,0.2,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05};

- (id)initWithFrame:(CGRect)frame defaultImage:(NSString *)defaultImageName ImageArray:(NSArray *)imageArray fps:(float)fps
{
    self = [super initWithFrame:frame];
    if (self) {
        changeCount = 6;
        
        selfImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:selfImageView];
        if (defaultImageName && [defaultImageName length]) {
            selfImageView.image = [UIImage imageNamed:defaultImageName];
        }
        maxChangeCount = imageArray.count;
        self.changeImageArray = imageArray;
        changeFps = fps;
        changeCount = 0;
        running = NO;
    }
    return self;
}

-(void)gifRun
{
    if (!running) {
        changeCount = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/changeFps target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
        running = YES;
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

//        self.changeImageRunLoopRef = CFRunLoopGetCurrent();
//        CFRunLoopRun();
    }
//    [self performSelectorInBackground:@selector(gifRun1) withObject:nil];
}

-(void)gifRun1
{
    @autoreleasepool {
        
    }
}

-(void)gifStop
{
    if (timer) {
        [timer invalidate];
        self.timer = nil;
    }
    
//    if (changeImageRunLoopRef) {
//        CFRunLoopStop(changeImageRunLoopRef);
//        self.changeImageRunLoopRef = nil;
//    }
    
    running = NO;
}

-(void)changeImage
{
    selfImageView.image = [UIImage imageNamed:[changeImageArray objectAtIndex:changeCount]];
    changeCount++;
    
//    NSLog(@"~~~%d~~~",changeCount);
    
    if (changeCount == maxChangeCount) {
        changeCount = 0;
    }
}


- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath stop:(float) stop{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        changeCount = 6;
        
		gifProperties = [[NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
													 forKey:(NSString *)kCGImagePropertyGIFDictionary] retain];
		//gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:_filePath], (CFDictionaryRef)gifProperties);
		NSData *data = [NSData dataWithContentsOfFile:_filePath];
		gif = CGImageSourceCreateWithData((CFDataRef) data, (CFDictionaryRef)gifProperties);
		count =CGImageSourceGetCount(gif);
		if (count >1) {
//			timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(playbyTime) userInfo:nil repeats:NO];
//			[timer fire];
            [self playbyTime];
//            [self performSelector:@selector(playbyTime) withObject:nil afterDelay:buf[index]];
            stopTime = stop;
		}
		else {
			CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
			self.layer.contents = (id)ref;
            CFRelease(ref);
            
		}

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame ImageData:(NSData *)_imageData{
	self = [super initWithFrame:frame];
	if (self) {
        changeCount = 6;
        stopTime = 0;
        if (_imageData) {
            gifProperties = [[NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                         forKey:(NSString *)kCGImagePropertyGIFDictionary] retain];
            gif = CGImageSourceCreateWithData((CFDataRef) _imageData, (CFDictionaryRef)gifProperties);
            count =CGImageSourceGetCount(gif);
            if (count >1) {
                timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(play) userInfo:nil repeats:YES];
                [timer fire];
            }
            else {
                CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
                self.layer.contents = (id)ref;
                CFRelease(ref);
            }
        }
		
	}
	return self;
}

- (void)ReLoadImageData:(NSData *)_imageData WithFrame:(CGRect)frame {
	self.frame = frame;
    stopTime = 0;
	gifProperties = [[NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
												 forKey:(NSString *)kCGImagePropertyGIFDictionary] retain];
	gif = CGImageSourceCreateWithData((CFDataRef) _imageData, (CFDictionaryRef)gifProperties);
	count =CGImageSourceGetCount(gif);
	[timer invalidate];
	timer = nil;
	if (count >1) {
		self.hidden = NO;
		timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(play) userInfo:nil repeats:YES];
		[timer fire];
	}
	else {
		self.hidden = YES;
		CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
		self.layer.contents = (id)ref;
        CFRelease(ref);
	}
}

- (void)stop {
    [timer invalidate];
	timer = nil;
}

- (void)playbyTime {
    index ++;
    index = index%count;
    if (index != 0) {
        CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
        self.layer.contents = (id)ref;
        CFRelease(ref);
        [self performSelector:@selector(playbyTime) withObject:nil afterDelay:buf[index]];
    }
        //timer = [NSTimer scheduledTimerWithTimeInterval:buf[index] target:self selector:@selector(playbyTime) userInfo:nil repeats:NO];
}

-(void)play
{
	index ++;
    if (stopTime != 0 && index%count == 0) {
        [self stop];
//        [self performSelector:@selector(stop) withObject:nil afterDelay:stopTime];

    }
    else {
        index = index%count;
        CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
        self.layer.contents = (id)ref;
        CFRelease(ref);
    }
	
}
-(void)removeFromSuperview
{
	[timer invalidate];
	timer = nil;
	[super removeFromSuperview];
}
- (void)dealloc {
    if (gif) {
        CFRelease(gif);
    }
	
	[gifProperties release];
    [selfImageView release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    