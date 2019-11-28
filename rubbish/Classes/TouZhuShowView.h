//
//  TouZhuShowView.h
//  caibo
//
//  Created by yao on 12-5-7.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "GC_BetRecordDetail.h"

typedef enum {
	TouZhuShowTypeZC,//足彩
	TouZhuShowTypeSPF,//胜平负
	TouZhuShowTypeRQSPF,//让球胜平负
	TouZhuShowType4JQ,//四场进球彩
	TouZhuShowType6JQ,//6场进球彩
    TouZhuShowTypeLanqiuRangFenShengFu,//篮球让分胜负
    TouZhuShowTypeLanqiuDaXiaoFen,//篮球大小分
    TouZhuShowTypeLanqiuShengfu,//篮球胜负
    TouZhuShowTypeLanqiuShengfencha,//胜分差
}TouZhuShowType;

@interface TouZhuShowView : UIView<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate> {
	UILabel *issLabel;
	UITableView *myTableView;
	NSDictionary *dataDic;
	TouZhuShowType touZhuShowType;
	ASIHTTPRequest *myrequest;
    ASIHTTPRequest * httprequest;
    GC_BetRecordDetail *BetDetailInfo;//彩票详细信息
    NSMutableDictionary * zhushuDic;
    NSMutableArray * cellarray;
    NSString * maxmoney;
    NSString * minmoney;
    UIView *tableViewBackView;
}
@property (nonatomic, retain)GC_BetRecordDetail *BetDetailInfo;//彩票详细信息
@property (nonatomic,retain)ASIHTTPRequest *myrequest, *httprequest;
- (void)showTouzhuWithData:(NSDictionary *)dic;
- (void)showTouzhuWithTopicId:(NSString *)topicId;

@end
