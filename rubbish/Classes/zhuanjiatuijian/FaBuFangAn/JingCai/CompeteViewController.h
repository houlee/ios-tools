//
//  CompeteViewController.h
//  Experts
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"
#import "V1PickerView.h"
#import "MatchVCModel.h"
#import "GameDetailMdl.h"

@interface CompeteViewController : V1PinBaseViewContrllor<UITextViewDelegate,UIGestureRecognizerDelegate,V1PickerViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)NSString *jc_TdPubNo;//普通今日竞彩发布次数
@property(nonatomic,strong)NSString *yp_TdPubNo;//普通今日亚盘发布次数
@property(nonatomic,strong)NSString *sd_jc_TdPubNo;//神单今日竞彩发布次数
@property(nonatomic,strong)NSString *sd_yp_TdPubNo;//神单今日亚盘发布次数

@property(nonatomic,strong)MatchDetailVCMdl *matchM;//赛事方案传参
@property(nonatomic,strong)GameDetailMdl *gameDeteilMdl;//已发方案传参
@property(nonatomic,strong)CompMdl *compMdl;//已发方案传参

@property(nonatomic,strong)NSString *lotrySource;//彩种标记(-201：竞彩，202：亚盘)

@property(nonatomic,strong)NSString *asianSp;//亚盘胜负率
@property(nonatomic,strong)NSString *ypRq;//亚盘让球数

@property(nonatomic,strong)NSString *playType;//方案的玩法(//01让球胜平负、10胜平负)
@property(nonatomic,strong)NSString *matchIdSelected;

@property(nonatomic,strong)NSString *selectLeagueName;//联赛名称
@property(nonatomic,strong)NSString *homeName;//主队名称
@property(nonatomic,strong)NSString *guestName;//客队名称
@property(nonatomic,strong)NSString *playID;
@property(nonatomic,strong)NSString *matchStatus;

@property(nonatomic,strong)NSString *selectDate;//选中联赛时间
@property(nonatomic,strong)NSString *selectTime;//选中比赛时间

@property(nonatomic,strong)NSString *eventId;//赛场编号("周三001")
@property(nonatomic,assign)NSInteger eventSelRow;//赛场index

@property(nonatomic,strong)NSString *rqOddStr;//让球胜平负赔率
@property(nonatomic,strong)NSString *oddsStr;//胜平负赔率

@property(nonatomic,strong)NSString *rqNo;//让球数

@property(nonatomic,strong)NSString *supportStr;//支持玩法(1:支持胜平负；0:不支持)

@property(nonatomic,strong)NSString *nameAndTimeStr;//比赛名称与时间

@property(nonatomic,strong)NSString *supportOrNo;//1、参加不中退款,0、不参加不中退款

@property(nonatomic,strong)NSString *tjsd;//推荐神单(1:是,0:否);


@end
