//
//  StartYindaoView.h
//  caibo
//
//  Created by cp365dev6 on 15/1/5.
//
//

#import <UIKit/UIKit.h>

#define YiDongJuLi 6
#define TiaoYueDa 8
#define TiaoYueXiao 3
#define YanChiTime 0.4
#define I6 [[[UIDevice currentDevice] systemVersion] floatValue]<7.0

@interface StartYindaoView : UIView<UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    UIImageView *baImaView1;
    UIImageView *baImaView2;
    UIImageView *baImaView3;
    UIImageView *firstIma1;
    UIImageView *firstIma2;
    UIImageView *firstIma3;
    UIImageView *secondIma1;
    UIImageView *secondIma2;
    UIImageView *secondIma3;
    UIImageView *thirdIma1;
    UIImageView *thirdIma2;
    UIImageView *thirdIma3;
    UIImageView *thirdIma4;
    CGFloat jiluSize;
    BOOL openAnimated;
    BOOL isUp;
    UIImageView *jiantouIma1;
    UIImageView *jiantouIma2;
    UIImageView *jiantouIma3;
    NSTimer *myTimer;
    
    CGFloat autoSize;
    id delegate;
}

@property (nonatomic,assign) id delegate;

@end

@protocol StartYindaoViewDelegate

- (void)disMissFromSuperView:(StartYindaoView *)yidaoView withBtnIndex:(NSInteger)index;


@end
