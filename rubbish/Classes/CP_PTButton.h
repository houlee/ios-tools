//
//  CP_PTButton.h
//  iphone_control
//
//  Created by zhang on 12/4/12.
//  Copyright (c) 2012 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CP_PTButton : UIButton{

    UIImageView *buttonImage;
    UILabel *buttonName;
    UIImageView *otherImage;
    UILabel *otherLabel;
    UIImage *selectImage;//选中的时候图片
    UIImage *nomorImage;//默认 正常的
    UIImage *hightImage;//高亮
    
    UIColor *nomorTextColor;
    UIColor *selectTextColor;
    UIColor *highTextColor;//点中颜色
    BOOL showNomore;
    BOOL showShadow;
}
@property(nonatomic,retain)UIImageView *buttonImage;
@property(nonatomic,retain)UILabel *buttonName, *otherLabel;
@property (nonatomic,retain)UIImageView *otherImage;
@property (nonatomic,retain)UIImage *selectImage;
@property (nonatomic,retain)UIImage *nomorImage;
@property (nonatomic,retain)UIImage *hightImage;
@property (nonatomic,retain)UIColor *nomorTextColor;
@property (nonatomic,retain)UIColor *selectTextColor;
@property (nonatomic,retain)UIColor *highTextColor;
@property (nonatomic, assign)BOOL showShadow;

@property (nonatomic)BOOL showNomore;

- (void)loadButonImage:(NSString *)imageName LabelName:(NSString *)labeName;//Button初始化

@end
