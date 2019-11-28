//
//  FAQView.h
//  caibo
//
//  Created by zhang on 5/27/13.
//
//

#import <UIKit/UIKit.h>

typedef enum {

    Zhongjiang, //中奖如何提现
    Weichupiao,// 未出票
    Paijiangqian,//派奖
    Chongzhi,//充值
    JiangJinYouHua,//奖金优化
    JiangJinJiSuan,//奖金计算
    jiangLiHuoDong,//奖励活动
    dongJie,
    Other
}Faqtishi;

@class KFMessageBoxView;

@interface FAQView : UIView<UIActionSheetDelegate,UIWebViewDelegate,UIScrollViewDelegate> {

    
    Faqtishi faqdingwei;
    UILabel *dingwei;
    UIScrollView * clearScrollView;
    
    KFMessageBoxView * kFMessageBoxView;
}
@property (nonatomic,assign)Faqtishi faqdingwei;
- (void)Show;
- (void)Show:(UIViewController *)showView;

- (id)initWithFrame:(CGRect)frame superView:(KFMessageBoxView *)superView;

@end
