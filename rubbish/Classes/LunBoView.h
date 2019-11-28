//
//  LunBoView.h
//  caibo
//
//  Created by GongHe on 13-12-26.
//
//

#import <UIKit/UIKit.h>
#import "GC_LotteryType.h"
#import "MyWebViewController.h"
@class ASIHTTPRequest;
@class DownLoadImageView;
@class YH_PageControl;
@class NewsViewController;
@interface LunBoView : UIView<UIScrollViewDelegate,MyWebViewDelegate>
{
//    NSMutableArray * myLunBoArray;
    YH_PageControl * pageControl;
    UILabel * titleLabel;//标题
    NSMutableArray * titleArray;//标题数组
    UIScrollView * mainScrollView;//轮播
    NSMutableArray * lunBoArray;//轮播图图片数组
    NSMutableArray * lunBoImageArray;//轮播图image数组
    DownLoadImageView * lastImageView;//取数组最后一张图片 放在第0页
    DownLoadImageView * firstImageView;//取数组第一张图片 放在最后1页
    BOOL isFirst;
    int second;//滑动计时
//    int scrollViewPage;//滑动页数
    BOOL scrollLeft;//判断scrollview滑动方向；yes往左划
    CFRunLoopRef lunBoRunLoopRef;//倒计时用的runloop
    NSTimer * myTimer;
    
    ASIHTTPRequest * weiBoRequest;
    NewsViewController * myNewsViewController;
    
    UIViewController *myControllter;
    
    
    BOOL isAnother;//非微博预测页
    BOOL isShuZiInfo;//数字彩页(包含魔法球同时轮播)
    BOOL hiddenGrayTitleImage;
    UIImageView * titleBGImageView;
    
    NSMutableArray *flagArray;
    NSMutableArray *typeArray;
    NSMutableArray *lotteryidArray;
    NSMutableArray *playidArray;
    NSMutableArray *betidArray;
    
    ModeTYPE modetype;
    LotteryTYPE lotteryType;
}

@property (nonatomic, retain)ASIHTTPRequest * weiBoRequest;
@property(nonatomic,assign)CFRunLoopRef lunBoRunLoopRef;
@property (nonatomic, assign) BOOL isAnother ,isShuZiInfo,hiddenGrayTitleImage;

- (id)initWithFrame:(CGRect)frame newsViewController:(UIViewController *)newsViewController;

-(void)setImageWithArray:(NSArray *)imageArray;

-(void)createTimer;
-(void)createTimer1;

@end
