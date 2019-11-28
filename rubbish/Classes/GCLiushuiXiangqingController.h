//
//  GCLiushuiXiangqingController.h
//  caibo
//
//  Created by  on 12-5-23.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
typedef enum{
    xiangqingquanbu,
    xiangqingchongzhi,
    xiangqingdongjie,
    xiangqingtixian
}XiangQing; 
@interface GCLiushuiXiangqingController : CPViewController{
    XiangQing xiangqingtype;
    NSArray * allarray;
}
@property (nonatomic,assign)XiangQing xiangqingtype;
@property (nonatomic, retain)NSArray * allarray;
@end
