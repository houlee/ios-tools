//
//  CheDanZhuiViewController.h
//  caibo
//
//  Created by houchenguang on 13-12-13.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "zhuiHaoData.h"
#import "MoreLoadCell.h"
#import "UpLoadView.h"
#import "ColorView.h"
#import "CP_PTButton.h"
#import "CP_UIAlertView.h"
#import "ShuangSeQiuInfoViewController.h"
@protocol CheDanZhuiDelegate <NSObject>

- (void)returnTypeAnswer:(NSInteger)answer;

@end
@interface CheDanZhuiViewController : CPViewController<ShuangSeQiuInfoDelegate,UITableViewDataSource, UITableViewDelegate, CP_UIAlertViewDelegate>{

    UITableView * myTableView;
    zhuiHaoData * zhuihaodata;
    ASIHTTPRequest * httpRequest;
     UpLoadView * loadview;
    MoreLoadCell *moreCell;
    NSString * schemeID;
    CP_PTButton *Btn;//撤单按钮
    ColorView *changciView2;//当前剩余多少期
    UIImageView * jiluImage;//无相关记录图片
    UILabel * jiluLabel;//无相关记录文字
    NSInteger typeAnswer;//是否撤单成功
    id<CheDanZhuiDelegate>delegate;
    
}
@property (nonatomic, retain)zhuiHaoData * zhuihaodata;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic,retain)MoreLoadCell *moreCell;
@property (nonatomic, assign)id<CheDanZhuiDelegate>delegate;
@property (nonatomic, retain)NSString * schemeID;
@end
