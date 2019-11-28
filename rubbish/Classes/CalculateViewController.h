//
//  CalculateViewController.h
//  caibo
//
//  Created by houchenguang on 12-11-2.
//
//

#import <UIKit/UIKit.h>
#import "calculateCell.h"
#import "GC_BetInfo.h"
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "CP_SWButton.h"
#import "CP_UIAlertView.h"
#import "CP_PTButton.h"
#import "GC_UIkeyView.h"

@protocol calculateDelegate <NSObject>
@optional
- (void)returnBetInfoData:(GC_BetInfo *)gcbetinfo;
- (void)returnPop:(NSMutableArray *)gcbet;
@end

typedef enum

{
	GouCaiShuZiInfoTypeShuangSeqiuJiSuan,
	GouCaiShuZiInfoTypeShiXuanWuJiSuan,
    GouCaiShuZiInfoTypeDaleTouJiSuan,
    GouCaiShuZiInfoTypeFuCai3DJiSuan,
    GouCaiShuZiInfoTypePaiLie5JiSuan,
    GouCaiShuZiInfoTypeQiXingCaiJiSuan,
    GouCaiShuZiInfoType22Xuan5JiSuan,
    GouCaiShuZiInfoTypeQiLeCaiJiSuan,
	GouCaiShuZiInfoTypeShiShiCaiJiSuan,
    
    GouCaiShuZiInfoTypePaiLie3JiSuan,
    GouCaiShuZiInfoTypeHappyTenJiSuan,
    GouCaiShuZiInfoTypeKuaiSanJiSuan,
    GouCaiShuZiInfoTypeKuaiLePukeJiSuan,
    GouCaiShuZiInfoTypeGDShiXuanWuJiSuan,
    GouCaiShuZiInfoTypeCQShiShiCaiJiSuan,
    GouCaiShuZiInfoTypeJXShiXuanWuJiSuan,
    GouCaiShuZiInfoTypeHBShiXuanWuJiSuan,
    GouCaiShuZiInfoTypeShanXiShiXuanWuJiSuan,
    
}GouCaiShuZiInfoTypeJiSuan;

@interface CalculateViewController : CPViewController<GC_UIkeyViewDelegate,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate,calculateCellDelegate>{
    id<calculateDelegate>delegate;
    UILabel * countTextField;
    BOOL isTingZhui;
    UIImageView * jiantouima;
    UITextField * baifenTextField;
    UIImageView * zhanbgimage;
    UILabel * tourula;
    UILabel * shoula;
    UIImageView * textimage1;
    UILabel * baifenla;
    UIButton * jisuanbut;
    UILabel * jilabel;
    UITableView * myTableView;
    BOOL yorn;
    GouCaiShuZiInfoTypeJiSuan jisuanType;
    GC_BetInfo *betInfo;
    ASIHTTPRequest * httpRequest;
    NSMutableArray * issuearr;
    NSString * morenbeishu;
    UILabel * jinela;
    UILabel * yuanla;
    UIButton * shouyibut;
    int zongzhu;
    NSInteger tourubeishu ;//投入倍数
    float benqitouru ;//本期投入
    float leijitouru ;//累计投入
    NSInteger jiangjinshu ;
    NSInteger benqishoyi;//本期收益
    float leijishouyi;//累计收益
    NSInteger shouyilv;//收益率
    NSMutableArray * baocunarr;
    NSInteger countjisuan;
    BOOL panduanling;
    CP_SWButton *sw;
    float keyhiegh;//保存键盘的高
    GC_BetInfo * betinfocopy;//备份一份
    BOOL zhuijiabool;
    UIImageView * upimage;//上面显示的一块
    UILabel * leijila;//累计奖金label
    UIImageView * upbgImage;
    UIImageView * imageViewkey;//键盘
    UIImageView * quanchengView;
    UIImageView * belowImage;//下面列表背景
    UIButton * helpButton;//如何计算 按钮
    UIButton * zhuiQiButton;
    BOOL keyboardShowBool;//键盘是否出现
    UIImageView * shouyiImage;
    BOOL sylBool;//收益率为负的时候 不显示收益率
    
    NSMutableArray * markArray;//打开键盘标记数组
    int mark;//已打开键盘标记
    GC_UIkeyView * gckeyView;
    BOOL gckeyShowKey;
    NSMutableArray * buttonBoolArray;

//    BOOL isConfirm;
}
@property (nonatomic, assign)GouCaiShuZiInfoTypeJiSuan jisuanType;
@property (nonatomic, assign)BOOL zhuijiabool;
@property (nonatomic, retain)GC_BetInfo *betInfo;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain)NSMutableArray * issuearr;
@property (nonatomic, retain)NSString * morenbeishu;
@property (nonatomic, assign)id<calculateDelegate>delegate;
@property (nonatomic, assign)BOOL isTingZhui;
//@property (nonatomic, assign)BOOL isConfirm;
- (void)pressjianbutton:(UIButton *)sender;
- (void)pressaddbutton:(UIButton *)sender;
- (void)returnBetInfoData:(GC_BetInfo *)gcbetinfo;
- (void)returnPop:(NSMutableArray *)gcbet;
- (void)updateData;
@end
