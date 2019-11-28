//
//  JinPinTuiJianData.h
//  caibo
//
//  Created by zhang on 1/10/13.
//
//

#import <Foundation/Foundation.h>

@interface JinPinTuiJianData : NSObject {

    NSString *appName;//应用程序名称
    NSString *reMark;//应用程序简介
    NSString *rewardFee;//赠送彩币数
    NSString *logoMidPath;//中图地址
    NSString *appInfoId;//应用id
    NSString *appFileSize;//应用大小
    NSString *appPath;//下载地址
}
@property (nonatomic, retain) NSString *appName;
@property (nonatomic, retain) NSString *reMark;
@property (nonatomic, retain) NSString *rewardFee;
@property (nonatomic, retain) NSString *logoMidPath;
@property (nonatomic, retain) NSString *appInfoId;
@property (nonatomic, retain) NSString *appFileSize;
@property (nonatomic, retain) NSString *appPath;

@end
