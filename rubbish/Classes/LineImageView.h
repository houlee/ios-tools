//
//  LineImageView.h
//  caibo
//
//  Created by yao on 12-6-12.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LineImageView : UIView {
	NSMutableArray *dataArray;
}

@property (nonatomic,retain)NSMutableArray *dataArray;

- (void)myScrolChange:(NSArray *)array IsHome:(BOOL)ishome TeamID:(NSInteger)ID;

@end
