//
//  ShuZiBetsView.h
//  caibo
//
//  Created by GongHe on 14-10-23.
//
//

#import <UIKit/UIKit.h>
#import "GCBallView.h"

@protocol ShuZiBetsViewDelegate <NSObject>

-(void)clearFinished;

@end

@class GifButton;

@interface ShuZiBetsView : UIView
{
    UIImageView * titleImage;//标题图片
    GifButton * trashCanButton;//垃圾桶
    UIImageView * louImageView;//遗漏值图片
    
    id<ShuZiBetsViewDelegate>delegate;
}

//controller     它的controller
//balls     总共多少球
//columns       分多少列
//title     左上标题
//description       标题旁描述
//showYiLouImage        遗漏值图标显不显示
//firstNumber       球上的数字从几开始
//hasZero       球上带不带0
//lineSpace     行距 值为0时为自适应
//ballType      球的类型
//ballFrame     最左边球的x、y，球的大小

- (id)initWithFrame:(CGRect)frame controller:(id)controller numberOfBalls:(int)balls numberOfColumns:(int)columns title:(NSString *)title description:(NSString *)description showYiLouImage:(BOOL)showYiLouImage firstNumber:(int)firstNumber hasZero:(BOOL)hasZero lineSpace:(float)lineSpace ballType:(GCBallViewColorType)ballType ballFrame:(CGRect)ballFrame;

-(void)clearSelectedBallView;

@property (nonatomic, retain)UIImageView * titleImage;
@property (nonatomic, retain)GifButton * trashCanButton;
@property (nonatomic, retain)UIImageView * louImageView;

@property (nonatomic, assign)id<ShuZiBetsViewDelegate>delegate;

@end
