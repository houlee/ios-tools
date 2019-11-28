//
//  footButtonData.h
//  caibo
//
//  Created by houchenguang on 13-6-20.
//
//

#import <Foundation/Foundation.h>
#import "footButtonData.h"

@interface footButtonData : NSObject{//一个按钮的数据类

    NSString * matchHome;//主队
    NSString * matchGuest;//从队
    NSString * bifen;//比分
    NSString * peilv;//赔率
    
    NSMutableArray * footButtonArray;
    
}

@property (nonatomic, retain)NSString * matchHome,* matchGuest,* bifen,* peilv;
@property (nonatomic, retain)NSMutableArray * footButtonArray;


@end
