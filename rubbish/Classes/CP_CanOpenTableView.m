//
//  CP_CanOpenTableView.m
//  iphone_control
//
//  Created by yaofuyu on 12-12-4.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import "CP_CanOpenTableView.h"

@implementation CP_CanOpenTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Action

- (void)setSetion:(NSInteger)indexSetion withInt:(NSInteger)open {
    setion[indexSetion] = (int)open;
}

- (NSInteger)getSetionOpenStatue:(NSInteger)indexSetion {
    if (indexSetion < 100) {
        return setion[indexSetion];
    }
    return 0;
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    