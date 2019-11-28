//
//  UIStatisticsView.h
//  caibo
//
//  Created by houchenguang on 14-4-23.
//
//

#import <UIKit/UIKit.h>
#import "ActivateInfoData.h"

@interface UIStatisticsView : UIView{

    ActivateInfoData * infoData;
    NSMutableArray * dataArray;
    NSString * minString;
    NSString * maxString;
}

@property (nonatomic, retain)ActivateInfoData * infoData;
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain) NSString * minString, * maxString;

@end
