//
//  GC_TopUpViewController.h
//  caibo
//
//  Created by houchenguang on 13-5-31.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "CP_UIAlertView.h"
#import "GC_UPMPViewController.h"
#import "ColorView.h"
#import "RechargeSequenceData.h"

@interface GC_TopUpViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,CP_UIAlertViewDelegate>{
    
    ASIHTTPRequest * httpRequest;
    
    NSMutableArray *  rechargeSequenceArray; //充值序列 1_2_3
    NSMutableArray * allowUseYHMSequenceArray;//允许使用优惠码 14_1
    NSMutableArray * allH5SequenceArray;//允许跳H5页面的；
    UITableView * topUpTableView;
    
    NSArray * title;
    NSMutableArray * title1;
    NSMutableArray * detail;
    NSArray * logoName;
    
    UIButton * moreButton;
    
    ChongZhiType chongZhiType;
    CP_UIAlertView *mAlert;
    UITextField * moneyTextField;
    UIView *BGView;
    UIImageView *alertBGView;
    ColorView *moneyText;
    ASIHTTPRequest *orderRequest;
    ASIHTTPRequest *accountRequest;
    UILabel * msgLabel;
    ColorView * colorLabel;
    UIScrollView * myScrollView;
    ASIHTTPRequest * boxRequest;
    RechargeSequenceData *rechargeSequence;
}
@property (nonatomic,copy)NSString *selectType,*passWord;
@property (nonatomic,retain)RechargeSequenceData *rechargeSequence;

@property (nonatomic, retain)ASIHTTPRequest * httpRequest,*orderRequest,*accountRequest, * boxRequest;

@end
