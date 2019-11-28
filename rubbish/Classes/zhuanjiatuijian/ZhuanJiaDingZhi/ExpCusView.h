//
//  ExpCusView.h
//  Experts
//
//  Created by v1pin on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpCusView : UIView

@property (nonatomic,strong) UIImageView *potratView;
@property (nonatomic,strong) UILabel *charatLab;
@property (nonatomic,strong) UIImageView *markView;
//@property (nonatomic,strong) UIImageView *markImgView;

- (void)creatView;

- (void)setPortImg:(NSString *)img charaName:(NSString *)name hasFocus:(NSInteger)hasFocus;

@end
