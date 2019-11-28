//
//  FaceSystem.h
//  caibo
//
//  Created by jeff.pluto on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagnifierView.h"

@interface FaceSystem : UIView {
    NSArray *faceArray;
    int mHgap;
	int mVgap;
	int mRows;
	int mCols;
    int pageNumber;
    
    id mController;
    
    NSTimer *touchTimer;
	MagnifierView *loop;
}

@property (retain) NSArray *faceArray;
@property (nonatomic, retain) NSTimer *touchTimer;

- (id)initWithPageNumber:(int)page row : (int) row col : (int) col;
- (void) addFaces;
- (void) setController : (UIViewController *) controller;

- (void)addMagnifierView;
- (void)handleAction:(id)timerObj;

@end