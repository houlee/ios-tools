//
//  footballLotterData.h
//  caibo
//
//  Created by houchenguang on 13-6-19.
//
//

#import <Foundation/Foundation.h>

@interface footballLotterData : NSObject{
    
    NSString * bifen;//比分
    NSString * matchGuestFull;
    NSString * playid;
    NSString * sp_data;//开奖详情
    NSString * matchHome;//主队
    NSString * matchHomeFull;
    NSString * matchGuest;//从队
    NSString * shortMatchName;//联赛名称
    NSString * matchNo;//序号
    NSString * endTime;//截止日期
    NSString * statatime;//开始时间 按此日期截期
    NSString * rq;//让球
    NSString * stop;//是否结束  1是结束
    
    NSString * weekString;//周几
    NSString * numString;//场号
    NSString * timeString;//时间
    
    NSMutableArray * saveButton;//保存那些按钮
    NSMutableArray * buttonArray;//那几个按钮的数据
    
}

@property (nonatomic, retain)NSString * bifen,* matchGuestFull,* playid,* sp_data,* matchHome,* matchHomeFull,* matchGuest,* shortMatchName,* matchNo,* endTime,* statatime, * weekString,* numString,* timeString, * stop, * rq;
@property (nonatomic, retain)NSMutableArray * buttonArray, *saveButton;
@end
