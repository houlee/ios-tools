//
//  UserSimpleInterest.m
//  Experts
//
//  Created by V1pin on 15/11/9.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "UserSimpleInterest.h"

@implementation UserSimpleInterest

static UserSimpleInterest * _userSimpleInterest = nil;

+(UserSimpleInterest *)standardSimpleInterest{
    @synchronized(self) {
        if (!_userSimpleInterest) {
            _userSimpleInterest = [[self alloc]init];
        }
    }
    return _userSimpleInterest;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    