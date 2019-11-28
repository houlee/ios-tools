//
//  Xieyi365ViewController.h
//  caibo
//
//  Created by yao on 12-5-10.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "TouzhujiqiaoViewController.h"
typedef enum {
    ShuangSeQiu,
    ErErXuan5,
    QiXinCai,
    RenXuanJiu,
    ShenFuCai,
    QiLeCai,
    DaLeTou,
    FuCai3D,
    BeiJingDanChang,
    JingCaiZuQiu,
    JingCaiLanQiuDXF,
    JingCaiLanQiuSFC,
    JingCaiLanQiuRFSF,
    JingCaiLanQiuSF,
    JingCaiZuQiuZJQS,
    JingCaiZuQiuBCSPF,
    JingCaiZuQiuBF,
    JingCaiZuQiuRQSPF,
    ShiYiXuan5,
    ShiShiCai,
    ChongQShiShiCai, //重庆时时彩
    HeMai,
    Pai3,
    Pai5,
    KuaiLeShiFen,
    Xieyi,
    Kuai3,
    huntou,
    PKSai,
    hunTouErXuanYi,
    lanqiuhuntouwf,
    bdzongjinqiu,
    bdshangxiadanshuang,
    bdbifen,
    bdbanquanchang,
    kuailepuke,
    GDShiYiXuan5,
    JSKuai3,
    HBKuai3,
    SendAwardTime,
    beidanshengfu,
    guanjunwanfaxy,
    guanyajunwanfaxy,
    JXShiYiXuan5,
    JLKuai3,
    Horse,
    HBShiYiXuan5,
    ShanXiShiYiXuan5,
    AHKuai3,
}WanFa;

@interface Xieyi365ViewController : CPViewController <UITableViewDataSource,UITableViewDelegate>{
	UITextView *infoText;
    WanFa ALLWANFA;
    UITableView *myTableView;
    NSArray *cell1Array;
    //彩种技巧
    Caizhong caizhongJQ;
}

@property (nonatomic,retain)UITextView *infoText;
@property (nonatomic, assign)WanFa ALLWANFA;
@property (nonatomic, assign)Caizhong caizhongJQ;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSArray *cell1Array;

@end
