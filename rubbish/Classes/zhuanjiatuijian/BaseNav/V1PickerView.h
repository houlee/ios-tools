//
//  V1PickerView.h
//
//  Created by v1pin on 15/5/28.
//  Copyright (c) 2015年 v1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickViewSelectedWithSureBtn)(NSString *text);

@protocol V1PickerViewDelegate <NSObject>

@optional

- (void)sure:(id)sender;

- (void)cancle:(id)sender;

@end

@interface V1PickerView : UIView<V1PickerViewDelegate>

@property (nonatomic, strong)UIPickerView *pickerView;
@property (nonatomic, strong)UILabel *titLab;
@property (nonatomic, weak)id<V1PickerViewDelegate> delegate;

@property (nonatomic, copy) PickViewSelectedWithSureBtn selectedWithSure;

@end
