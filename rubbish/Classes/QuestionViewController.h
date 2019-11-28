//
//  QuestionViewController.h
//  caibo
//
//  Created by cp365dev6 on 14-8-11.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"

typedef enum{

    ZhongjiangType, //中奖如何提现
    WeichupiaoType,// 未出票
    PaijiangqianType,//派奖
    ChongzhiType,//充值
    JiangJinYouHuaType,//奖金优化
    JiangJinJiSuanType,//奖金计算
    jiangLiHuoDongType,//奖励活动
    dongJieType,//冻结
    OtherType

}QuestionType;

@interface QuestionViewController : CPViewController<UIActionSheetDelegate,UIWebViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *headerTextAry;
    NSArray *contentAry;
    NSMutableArray * isExpandedAry;
    
    QuestionType question;
}
@property (nonatomic, strong) UITableView *tableView;
@property (assign) BOOL dingwei;

@property (nonatomic, assign) QuestionType question;
@end
