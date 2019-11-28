//
//  AddressView.h
//  caibo
//
//  Created by Kiefer on 11-6-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"

@interface AddressView : UIView<UIPickerViewDataSource, UIPickerViewDelegate, PassValueDelegate>
{
    NSDictionary *dict;
    NSArray *provinces;
    NSArray *citys;
    NSArray *citystart;
    
    //需要保存的省份名和城市名
    NSString *provinceName;
    NSString *cityName;
    //需要请求的省份id和城市id
    NSInteger provinceId;
    NSInteger cityId;
    
    NSObject<PassValueDelegate> *delegate;
}

@property(nonatomic, assign) NSObject<PassValueDelegate> *delegate;

// 单例
+ (AddressView*)getInstance;
// 参数初始化
- (void)parameterInit;
// 地址选择器弹出
- (void)show;
// 地址选择器关闭
- (void)dimiss;
// 完成
- (void)doFinish;
// 根据返回的省份id和城市id取得地址
- (void)getAddressWithId:(NSInteger)pId :(NSInteger)cId;

@end
