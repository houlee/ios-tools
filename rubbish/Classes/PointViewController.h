//
//  PointViewController.h
//  caibo
//
//  Created by cp365dev on 14-5-9.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ColorView.h"
#import "ASIHTTPRequest.h"
#import "MoreLoadCell.h"
#import "GC_WinningInfoList.h"
#import "CP_UIAlertView.h"
#import "ChoujiangJieXi.h"
#import "CP_TabBarViewController.h"
@interface PointViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,CP_UIAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate,CP_TabBarConDelegate>
{
    UIScrollView *myScrollView;
    UITableView *myTableView;
    BOOL isLottery;
    UIImageView *btnBackImage;
    UIButton *choujiangBtn;
    UIButton *zhongjiangBtn;
    
    ColorView *infoLabel;//抽奖次数Label
    UILabel *jifenLabel;//剩余积分
    
    ASIHTTPRequest *myRequest;//抽奖
    ASIHTTPRequest *myRequest2;// 中奖名单
    ASIHTTPRequest *myRequest3;// 抽奖次数
    ASIHTTPRequest *myRequest4;// 完善地址
    
    
    MoreLoadCell *moreCell;  //加载更多
    
    GC_WinningInfoList *ZhongJiang; //中奖名单
    
    UIImageView *biankuangImage;   //蓝色选中边框
    
    UIImageView *backgroundView;
    
    
    NSMutableArray *mouthArray; //中奖名单日期-月
    NSMutableArray *dayArray;   //中奖名单日期-日
    NSMutableArray *rectArray;   //随机抽奖所有的frame
    
    UIView *jiangpinView;
    
//    BOOL isRangChouJiang; //是否随机抽奖
    
    UIButton *duihuanBtn; //兑换彩金Btn

    NSArray *btnName;
    ColorView *xiaohaoLabel;
    UIButton *myPointBtn;
    UIImageView *myjifenImage;
    
    BOOL choujFinished; //抽奖完成(表示请求回抽奖数据或者请求失败)
    BOOL chouJFailed; //抽奖失败，立即停止
    
    ChoujiangJieXi *choujiangMes;
    
    int needPianyi;//用于抽奖动画停止偏移量
    int btnTag;
    
    int haveMouth;//控制中奖列表列线
    
    int preTag;
//    int curTag;

}

@property (nonatomic,retain)ASIHTTPRequest *myRequest,*myRequest2,*myRequest3,*myRequest4;
@property (nonatomic,retain)GC_WinningInfoList *ZhongJiang;
@property (nonatomic, retain) NSArray *btnName;
@property (nonatomic, retain) ChoujiangJieXi *choujiangMes;
@property (nonatomic) int preTag;
@end
