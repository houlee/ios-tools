//
//  singletonData.h
//  caibo
//
//  Created by houchenguang on 13-7-2.
//
//

#import <Foundation/Foundation.h>

@interface singletonData : NSObject{

    NSMutableArray * allDataArray;//保存数据 数组包数组 直播中
    NSInteger selectTile;//当前title的状态
    NSMutableArray * myAllDataArray;//保存数据 我的关注 数组
    NSMutableArray * endAllDataArray;//保存数据 已结束的 数组
    
    NSInteger myTitle;
    NSInteger endTitle;
    NSInteger liveTitle;
    
    NSString * liveIssue;
    NSString * myIssue;
    NSString * endIssue;
    NSMutableArray * allIussueArray;//直播期号
    NSMutableArray * endIussueArray;//结束的期号
}

@property (nonatomic, retain)NSMutableArray * myAllDataArray;
@property (nonatomic, retain)NSMutableArray * endAllDataArray;
@property (nonatomic, retain) NSMutableArray * allDataArray;
@property (nonatomic, assign)NSInteger selectTile;
@property (nonatomic, assign)NSInteger myTitle, endTitle,liveTitle;
@property (nonatomic, retain)NSString * liveIssue, * myIssue, * endIssue;
@property (nonatomic, retain)NSMutableArray * allIussueArray, * endIussueArray;
+ (id)getInstance;

@end
