//
//  HeaderLabel.h
//  LabelTest
//
//  Created by cp365dev on 14-5-6.
//  Copyright (c) 2014年 cp365dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderLabel : UIView
{
    BOOL Horizontal; //水平

}
@property (nonatomic, assign) BOOL Horizontal;

- (id)initWithFrame:(CGRect)frame andLabel1Text:(NSString *)text1 andLabelWed:(int)onwFrame andLabel2Text:(NSString *)text2 andLabel2Wed:(int)twoFrame andLabelText3:(NSString *)text3 andLabel3Wed:(int)thrFrame andLaelText4:(NSString *)texr4 andLabel4Frame:(int)fouFrame isJiangJiDouble:(BOOL)isDouble;

@end
