//
//  FaceSystem.m
//  caibo
//
//  Created by jeff.pluto on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FaceSystem.h"
#import "NSStringExtra.h"
#import "NewPostViewController.h"

@implementation FaceSystem

@synthesize faceArray;
@synthesize touchTimer;

// 点击开始——０.５秒后打开放大镜
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
//                                                       target:self
//                                                     selector:@selector(addMagnifierView)
//                                                     userInfo:nil
//                                                      repeats:NO];
//    
//	if(loop == nil){
//		loop = [[MagnifierView alloc] init];
//		loop.viewToMagnify = self;
//	}
//	
//	UITouch *touch = [touches anyObject];
//	loop.touchPoint = [touch locationInView:self];
//	[loop setNeedsDisplay];
}

// 在此视图的基础上加入放大镜视图
- (void)addMagnifierView {
//	[self.superview addSubview:loop];
}

// 移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self handleAction:touches];
}

- (void)handleAction:(id)timerObj {
//	NSSet *touches = timerObj;
//	UITouch *touch = [touches anyObject];
//	loop.touchPoint = [touch locationInView:self];
//	[loop setNeedsDisplay];
}

// 释放——移除放大镜视图
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self.touchTimer invalidate];
//	self.touchTimer = nil;
//	[loop removeFromSuperview];
}

- (id)init {
    /*
	if (self == [super init]) {
        faceArray = [[NSArray alloc] initWithObjects:
        @"f01.png",@"f02.png",@"f03.png",@"f04.png",@"f05.png",
        @"f06.png",@"f07.png",@"f08.png",@"f09.png",@"f10.png",
        @"f11.png",@"f12.png",@"f13.png",@"f14.png",@"f15.png",
        @"f16.png",@"f17.png",@"f18.png",@"f19.png",@"f20.png",
        @"f21.png",@"f22.png",@"f23.png",@"f24.png",@"f25.png",
        @"f26.png",@"f27.png",@"f28.png",@"f29.png",@"f30.png",
        @"f31.png",@"f32.png",@"f33.png",@"f34.png",@"f35.png",
        @"f36.png",@"f37.png",@"f38.png",@"f39.png",@"f40.png",
        @"f41.png",@"f42.png",@"f43.png",@"f44.png",@"f45.png",
        @"f46.png",@"f47.png",@"f48.png",@"f49.png",@"f50.png",
        @"f51.png",@"f52.png",@"f53.png",@"f54.png",@"f55.png",
        @"f56.png",@"f57.png",@"f58.png",@"f59.png",@"f60.png",
        @"f61.png",@"f62.png",@"f63.png",@"f64.png",@"f65.png",
        @"f66.png",@"f67.png",@"f68.png",@"f69.png",@"f70.png",
        @"f71.png",@"f72.png",nil];
	}
     */
    self = [super init];
    if (self) {
        faceArray = [[NSArray alloc] initWithObjects:
                     @"F45.png",@"F47.png",@"F79.png",@"F78.png",@"F74.png",
                     @"F75.png",@"F73.png",@"F76.png",@"F77.png",@"F80.png",
                     @"F81.png",@"F71.png",@"F42.png",@"F41.png",@"F61.png",
                     @"F01.png",@"F10.png",@"F26.png",@"F21.png",@"F17.png",
                     @"F06.png",@"F07.png",@"F13.png",@"F23.png",@"F15.png",
                     @"F09.png",@"F18.png",@"F32.png",@"F12.png",@"F60.png",
                     @"F14.png",@"F05.png",@"F22.png",@"F11.png",@"F20.png",
                     @"F29.png",@"F24.png",@"F03.png",@"F25.png",@"F02.png",
                     @"F04.png",@"F08.png",@"F16.png",@"F19.png",@"F27.png",
                     @"F28.png",@"F30.png",@"F31.png",@"F44.png",@"F33.png",
                     @"F35.png",@"F36.png",@"F37.png",@"F68.png",@"F34.png",
                     @"F39.png",@"F40.png",@"F46.png",@"F48.png",@"F49.png",
                     @"F51.png",@"F52.png",@"F53.png",@"F54.png",@"F55.png",
                     @"F56.png",@"F65.png",@"F66.png",@"F67.png",@"F82.png",
                     @"F69.png",@"F70.png",@"F72.png",@"F59.png",@"F62.png",
                     @"F63.png",@"F64.png",@"F38.png",@"F83.png",@"F50.png",
                     @"F84.png",@"F43.png",@"F57.png",@"F58.png",nil];
	}


    
	return self;
}

- (id) initWithPageNumber:(int)page row:(int)row col:(int)col {
    if ((self = [self init])) {
        
        self.backgroundColor = [UIColor clearColor];
        
        mHgap = 8;// 水平间距
        mVgap = 10;// 垂直间距
        mRows = row;// 行数
        mCols = col;// 列数
        
        pageNumber = page;
        
        [self addFaces];
    }
    return self;
}

- (void) setController:(UIViewController *)controller {
    if (mController == nil) {
        mController = controller;
    }
}

- (void) addFaces {
    int pagefaceCount = mRows * mCols;// 预定义表情总数
    int faceCount = (int)[faceArray count];// 本地实际表情总数
    int tmpCount = 0;
    int start =0 ;
    int end = 0;
    switch (pageNumber) {
        case 0:
            if (pagefaceCount > faceCount) {
                pagefaceCount = faceCount;
            }
            start = 0;
            end = pagefaceCount;
           // tmpCount = pagefaceCount;
            break;
        case 1:
            if (pagefaceCount*2 > faceCount) {
                pagefaceCount = faceCount;
            }else
            {
            tmpCount = pagefaceCount;
            pagefaceCount = pagefaceCount*2;
            }
            start = tmpCount;
            end = pagefaceCount;
            break;
        case 2:
            if (pagefaceCount*3 > faceCount) {
				tmpCount = pagefaceCount*2;
                pagefaceCount = faceCount;
            }else
            {
            tmpCount = pagefaceCount*2;
            pagefaceCount = pagefaceCount*3;
            }
            start =tmpCount;
            end = pagefaceCount;
            break;
        default:
            break;
    }
    for (int i = start; i < end; i++) {
        UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
        face.frame = CGRectMake(0, 0, 35, 35);
        [face setTag:i + 1];
        
        [face setImage:UIImageGetImageFromName([faceArray objectAtIndex:i]) forState:(UIControlStateNormal)];
        [face addTarget:self action:@selector(actionFace:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:face];
    }
    [self layoutSubviews];
}

- (void) actionFace:(UIButton *)sender {
    if ([mController respondsToSelector:@selector(clickFace:)]) {
      /* NSString *face = @"F";
        if (sender.tag < 10) {
            face = [face stringByAppendingFormat:@"0%d", sender.tag];
        } else {
            face = [face stringByAppendingFormat:@"%d", sender.tag];
        }
      */  
        NSString * str = [faceArray objectAtIndex:sender.tag - 1];
        
        NSLog(@"str face = %@", str);
        NSArray * ary = [str componentsSeparatedByString:@"."];
        NSString * face = [ary objectAtIndex:0];
        NSLog(@"face = %@", face);
        
        face = [face faceTestChange];
        
        NSMutableString *buffer = [[NSMutableString alloc] init];
        [buffer appendString:@"["];
        [buffer appendString:face];
        [buffer appendString:@"]"];
        NSLog(@"buffer = %@", buffer);
        [mController performSelector:@selector(clickFace:) withObject:buffer];
        [buffer release];
    }
}

- (void) layoutSubviews {
    int left = self.bounds.origin.x;
    int top  = self.bounds.origin.y + 5;
    int right =  self.frame.size.width;
    int bottom = self.frame.size.height;
    
    int gridW = ( (right - left)  - (mCols - 1) * mHgap ) / mCols;
    int gridH = ( (bottom - top) - (mRows - 1) * mVgap ) / mRows;
    
    int componentCount = (int)[[self subviews] count];
    for (int i = 0; i < mRows; i++) {
        if(i * mCols >= componentCount){
            break;
        }
        for (int j = 0; j < mCols; j++) {
            int index  = i * mCols + j;
            if(index < componentCount) {
                int x = left + (j * (gridW + mHgap));
                int y = top + (i * (gridH + mVgap));
                UIView *comp = [[self subviews] objectAtIndex:index];
                
                int pw = comp.frame.size.width;
                int ph = comp.frame.size.height;

                comp.frame = CGRectMake(x, y, pw, ph);
            } else {
                break;
            }
        }
    }
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    int width = self.frame.size.width;
    int height = self.frame.size.height;
	int gridW = 40;
    int gridH = 46;
    
    // 列
    for(int i = 1; i < mCols; i++) {// 第一列和最后一列线不画
		CGContextSetGrayStrokeColor(context, 0.7, 1);// mGray, alpha
		CGContextMoveToPoint(context, i * gridW, 3);// x, y
		CGContextAddLineToPoint(context, i * gridW, height + 3);// x, y
		CGContextStrokePath(context);
        
		CGContextSetGrayStrokeColor(context, 0.9, 1);// mGray, alpha
		CGContextMoveToPoint(context, i * gridW + 1, 3);// x, y
		CGContextAddLineToPoint(context, i * gridW + 0.5, height + 3);// x, y
		CGContextStrokePath(context);
	}

    // 行
	for(int i = 1; i <= mRows; i++) {
        CGContextSetGrayStrokeColor(context, 0.7, 1);
		CGContextMoveToPoint(context, 3, i * gridH);
		CGContextAddLineToPoint(context, width + 3, i * gridH);
		CGContextStrokePath(context);
        
		CGContextSetGrayStrokeColor(context, 0.9, 1);
		CGContextMoveToPoint(context, 3, i * gridH + 1);
		CGContextAddLineToPoint(context, width + 3, i * gridH + 0.5);
		CGContextStrokePath(context);
	}
}

- (void)dealloc {
    mController = nil;
    [faceArray release];
    
    [loop release];
	loop = nil;
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    