//
//  LineScrollView.h
//  caibo
//
//  Created by yao on 12-6-12.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineImageView.h"

@interface LineScrollView : UIScrollView {
	NSArray *array;
	NSInteger ID;
	BOOL ishome;
	LineImageView *imageV;
}

- (void)myScrolChange:(NSArray *)dataarray IsHome:(BOOL)dataishome TeamID:(NSInteger)dataID;

@end
