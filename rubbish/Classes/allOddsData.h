//
//  allOddsData.h
//  caibo
//
//  Created by houchenguang on 13-6-20.
//
//

#import <Foundation/Foundation.h>

@interface allOddsData : NSObject{//按钮上 所有赔率 彩果 数据类

    NSString * caiguo;//彩果
    NSString * peilv;//赔率
    NSString * savepei;//保存当前按钮的赔率
}

@property (nonatomic, retain)NSString * caiguo, * peilv, * savepei;

@end
