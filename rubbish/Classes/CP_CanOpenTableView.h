//
//  CP_CanOpenTableView.h
//  iphone_control
//
//  Created by yaofuyu on 12-12-4.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CP_CanOpenTableView : UITableView {
    int setion[100];
}


- (void)setSetion:(NSInteger)indexSetion withInt:(NSInteger)open;
- (NSInteger)getSetionOpenStatue:(NSInteger)indexSetion;

@end
