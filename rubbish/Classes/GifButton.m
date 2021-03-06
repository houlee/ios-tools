//
//  GifButton.m
//  caibo
//
//  Created by GongHe on 14-7-7.
//
//

#import "GifButton.h"
#import "GCBallView.h"

@implementation GifButton
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
        gifProperties = [[NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
													 forKey:(NSString *)kCGImagePropertyGIFDictionary] retain];

		NSData *data = [NSData dataWithContentsOfFile:_filePath];
        gif = CGImageSourceCreateWithData((CFDataRef) data, (CFDictionaryRef)gifProperties);
		
        count = CGImageSourceGetCount(gif);
        
        _gifView = [[[UIView alloc] initWithFrame:CGRectMake(9, 0, 27, 38)] autorelease];
        _gifView.backgroundColor = [UIColor clearColor];
        _gifView.userInteractionEnabled = NO;
        [self addSubview:_gifView];
        
        CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, count - 1, (CFDictionaryRef)gifProperties);
        _gifView.layer.contents = (id)ref;
        CFRelease(ref);

        [self addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)play
{
    index ++;
    index = index%count;
    if (index != 0) {
        CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
        _gifView.layer.contents = (id)ref;
        CFRelease(ref);
        [self performSelector:@selector(play) withObject:nil afterDelay:0.07];
    }else{
        self.hidden = YES;
        for (GCBallView *ball in self.superview.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                ball.selected = NO;
            }
        }
        if (delegate && [delegate respondsToSelector:@selector(animationCompleted:)]) {
            [delegate animationCompleted:self];
        }
    }
}

-(id)initTrashCanWithFrame:(CGRect)frame
{
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TrashCan.gif"];
    return [self initWithFrame:CGRectMake(frame.origin.x, frame.origin.y - 8, 36, 45) filePath:path];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    