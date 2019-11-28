//
//  MatchDetailVC.h
//  Experts
//
//  Created by hudong yule on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"
#import "MatchVCModel.h"

@interface MatchDetailVC : V1PinBaseViewContrllor

@property(nonatomic,strong)NSString * playId;
@property(nonatomic,strong)MatchVCModel *matchModel;
@property(nonatomic,strong)MatchDetailVCMdl *matchdetailMdl;
@property(nonatomic,assign)NSInteger currPage;
@property(nonatomic,strong)NSString * personStatusStr;// 判断身份状态
@property(nonatomic,strong)NSString * source;// 判断身份来源
@property(nonatomic,strong)NSString * jc_todayPubNum;
@property(nonatomic,strong)NSString * yp_todayPubNum;
@property(nonatomic,strong)NSString * matchSource;//彩种（-201：竞彩，202：亚盘）
@property(nonatomic,strong)NSString * cId;

@property(nonatomic, assign) BOOL isSdOrNo;

@end
