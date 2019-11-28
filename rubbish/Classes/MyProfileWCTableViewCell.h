//
//  MyProfileWCTableViewCell.h
//  caibo
//
//  Created by GongHe on 14-5-29.
//
//

#import <UIKit/UIKit.h>
#import "ColorView.h"

@interface MyProfileWCTableViewCell : UITableViewCell
{
    UIImageView * cupImageView;//大力神杯图片
    UILabel * cupNameLabel;//大力神杯名字
    ColorView * flagNumberColorView;//几枚国旗
    ColorView * flagContentColorView;//亲，您。。。
    UIButton * listButton;//获奖名单
    UIButton * howButton;//如何收集国旗？
    
    UILabel * caiJinLabel;//抢彩金
    ColorView * countdownColorView;//倒计时
    UIButton * signUpButton;//我要报名
    UIButton * questionMarkButton;//问题
    UIImageView * faceImageView;
    UIImageView * faceImageView1;
}

@property (nonatomic, retain)UIImageView * cupImageView;
@property (nonatomic, retain)UILabel * cupNameLabel;
@property (nonatomic, retain)ColorView * flagNumberColorView;
@property (nonatomic, retain)ColorView * flagContentColorView;
@property (nonatomic, retain)UIButton * listButton;
@property (nonatomic, retain)UIButton * howButton;

@property (nonatomic, retain)UILabel * caiJinLabel;
@property (nonatomic, retain)ColorView * countdownColorView;
@property (nonatomic, retain)UIButton * signUpButton;
@property (nonatomic, retain)UIButton * questionMarkButton;
@property (nonatomic, retain)UIImageView * faceImageView;
@property (nonatomic, retain)UIImageView * faceImageView1;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(int)type;

@end
