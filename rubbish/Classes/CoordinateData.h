//
//  CoordinateData.h
//  CPgaopin
//
//  Created by houchenguang on 13-11-20.
//
//

#import <Foundation/Foundation.h>

@interface CoordinateData : NSObject{//保存坐标中心点

    float x;
    float y;
    NSString * dataNumber;//当前的数字
    NSString * sameNumber;
}

@property (nonatomic, assign)float x;
@property (nonatomic, assign)float y;
@property (nonatomic, retain)NSString * dataNumber;
@property (nonatomic, retain)NSString * sameNumber;
@end
