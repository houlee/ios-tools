//
//  BallDetailViewController.m
//  Experts
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "BallDetailViewController.h"
#import "BallCell.h"
#import "Expert365Bridge.h"

#import "caiboAppDelegate.h"
#import "UpLoadView.h"

@interface BallDetailViewController (){
    UpLoadView *loadview;
}

@property(nonatomic,strong)NSString *isnew;//0 老版本;1 新版本

@end

@implementation BallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title_nav = @"方案详情";
    [self creatNavView];
    [self createBallTabView];
    
    self.countDataArr = [NSMutableArray array];
    self.rowCountArr = [NSMutableArray array];
    self.rowCountAtrArr = [[NSMutableArray alloc] initWithCapacity:0];

    [self requestCountLotteryData];
}

-(void)createBallTabView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = V2FACEBG_COLOR;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return [self.ballCodeArr count];
    }else if (section ==2) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height;
    if (indexPath.section == 0) {
        return 126;
    }else if(indexPath.section == 1){
        return 45;
    }else if(indexPath.section ==2){
        if (self.countDataArr != nil &&self.countDataArr.count  != 0) {
            GameDetailMdl *gameDetlMdl = (GameDetailMdl *) [self.countDataArr objectAtIndex:indexPath.row];
            CompPlanInfoMdl *plainModel = [[CompPlanInfoMdl alloc]init];
            NSDictionary *plainInfoDic = gameDetlMdl.planInfo;
            [plainModel setValuesForKeysWithDictionary:plainInfoDic];
            
            NSString *remmodContent = plainModel.recommendExplain;
            
            CGSize remmodContentSize = [PublicMethod setNameFontSize:remmodContent andFont:[UIFont systemFontOfSize:14] andMaxSize:CGSizeMake(MyWidth - 60./3, 3000)];
            //[remmodContent boundingRectWithSize:CGSizeMake(MyWidth - 60./3, 3000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            height = remmodContentSize.height+50+20+10+60;
        }
        return height;
    }else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *identifier=@"cell";
        HeadCell *cell=(HeadCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell=[[HeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.countDataArr != nil &&self.countDataArr.count  != 0) {
            GameDetailMdl *gameDetlMdl = [[GameDetailMdl alloc]init];
            gameDetlMdl  = [self.countDataArr objectAtIndex:indexPath.row];
            [cell setDataModel:gameDetlMdl lotterystr:self.caiZhongType time:self.qiHao];
        }
        return cell;
    }else if(indexPath.section == 1){
        NSString *identifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
        BallCell * cell = (BallCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.ballNameLab.text = [self.ballCodeArr objectAtIndex:indexPath.row];
        cell.countNameLab.textColor = BLACK_FIFITYFOUR;
        if([self.rowCountArr count]!=0){
            if (self.bonusNumber.length == 0) {
                cell.countNameLab.text = [NSString stringWithFormat:@"%@",[self.rowCountArr objectAtIndex:indexPath.row]];
            }else{
                if (self.rowCountAtrArr.count != 0) {
                    cell.countNameLab.attributedText = [self.rowCountAtrArr objectAtIndex:indexPath.row];
                }
            }
        }
        if ([UIDevice currentDevice].systemVersion.floatValue >7.0&&[UIDevice currentDevice].systemVersion.floatValue<8.0) {
            if (indexPath.row == [self.ballCodeArr count]-1) {
                UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10.0, 44.0, MyWidth-20.0, 1)];
                lab.backgroundColor = [UIColor lightGrayColor];
                [cell addSubview:lab];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 2){
        static NSString *identifier=@"cell";
        BetCell *cell=(BetCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell=[[BetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.countDataArr != nil &&self.countDataArr.count  != 0) {
            GameDetailMdl *gameDetlMdl = [[GameDetailMdl alloc]init];
            gameDetlMdl  = [self.countDataArr objectAtIndex:indexPath.row];
            [cell setDataModel:gameDetlMdl];
        }
        [cell.goBetBtn addTarget:self action:@selector(btnGoToBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

#pragma mark -------------请求方案详情---------------
-(void)requestCountLotteryData
{
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"erAgintOrderId": self.planId,@"loginUserName":[[Info getInstance] userName],@"levelType":@"1"}];
    
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"expertService",@"methodName":@"getPlanInfo",@"parameters":parametersDic}];
    
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSDictionary *dataDic = respondObject;
        NSLog(@"数字===%@",respondObject);
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary *bigDic = dataDic[@"result"];
            GameDetailMdl *gameDetlMdl = [[GameDetailMdl alloc]init];
            if ([dataDic count] != 0) {
                NSDictionary  *ballDic = dataDic[@"result"][@"planInfo"][@"contentInfo"];
                [gameDetlMdl setValuesForKeysWithDictionary:bigDic];
                [self.countDataArr addObject:gameDetlMdl];
                self.caiZhongType = dataDic[@"result"][@"planInfo"][@"lotteryClassCode"];
                self.bonusNumber = dataDic[@"result"][@"planInfo"][@"bonusNumber"];
                self.isnew=dataDic[@"result"][@"planInfo"][@"isNew"];
                if ([self.isnew isEqualToString:@"1"]) {
                    if ([self.caiZhongType isEqualToString:@"001"]){
                        self.ballCodeArr = @[@"红球\n20码",@"红球\n12码",@"红球\n3胆",@"红球\n独胆",@"红球\n杀6码",@"龙头",@"凤尾",@"蓝球\n3码",@"蓝球\n杀3码",@"12+3\n复式单"];
                    }else if([self.caiZhongType isEqualToString:@"113"]){
                        self.ballCodeArr = @[@"前区\n20码",@"前区\n10码",@"前区\n3胆",@"前区\n独胆",@"前区\n杀6码",@"龙头",@"凤尾",@"后区\n3码",@"后区\n杀6码",@"10+3\n复式单"];
                    }else if([self.caiZhongType isEqualToString:@"002"]||[self.caiZhongType isEqualToString:@"108"]){
                        self.ballCodeArr = @[@"独胆",@"双胆",@"三胆",@"杀一码",@"五码\n组选",@"六码\n组选",@"三跨度",@"5码定位\n(百位)",@"5码定位\n(十位)",@"5码定位\n(个位)",@"和值",@"包星"];
                    }
                }else if ([self.isnew isEqualToString:@"0"]){
                    if ([self.caiZhongType isEqualToString:@"001"]){
                        self.ballCodeArr = @[@"红球\n25码",@"红球\n20码",@"红球\n12码",@"红球\n3胆",@"红球\n杀3码",@"红球\n杀6码",@"蓝球\n4码",@"蓝球\n2码",@"蓝球\n杀3码"];
                    }else if([self.caiZhongType isEqualToString:@"113"]){
                        self.ballCodeArr = @[@"前区\n25码",@"前区\n20码",@"前区\n10码",@"前区\n3胆",@"前区\n杀3码",@"前区\n杀6码",@"后区\n6码",@"后区\n3码",@"后区\n杀3码"];
                    }else if([self.caiZhongType isEqualToString:@"002"]||[self.caiZhongType isEqualToString:@"108"]){
                        self.ballCodeArr = @[@"独胆",@"双胆",@"三胆",@"杀一码",@"杀三码",@"五码\n组选",@"六码\n组选",@"三和尾",@"三跨度",@"5码\n定位"];
                    }
                }
                if ([self.caiZhongType isEqualToString:@"001"]) {//双色球
                    if ([self.isnew isEqualToString:@"1"]) {
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_20_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_12_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_3_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_DU_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_SHA_6_MA"]];
                        [self.rowCountArr addObject:ballDic[@"LONG_TOU"]];
                        [self.rowCountArr addObject:ballDic[@"FENG_WEI"]];
                        [self.rowCountArr addObject:ballDic[@"LAN_QIU_3_MA"]];
                        [self.rowCountArr addObject:ballDic[@"LAN_QIU_SHA_3_MA"]];
                        NSString *fushi=ballDic[@"FU_SHI_12_3"];
                        [self.rowCountArr addObject:[fushi stringByReplacingOccurrencesOfString:@"*" withString:@"+"]];
                    }else if([self.isnew isEqualToString:@"0"]){
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_25_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_20_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_12_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_3_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_SHA_3_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HONG_QIU_SHA_6_MA"]];
                        [self.rowCountArr addObject:ballDic[@"LAN_QIU_4_MA"]];
                        [self.rowCountArr addObject:ballDic[@"LAN_QIU_2_MA"]];
                        [self.rowCountArr addObject:ballDic[@"LAN_QIU_SHA_3_MA"]];
                    }
                    [self selectRewardRedCount:self.rowCountArr difLotteryType:self.caiZhongType];
                }else if ([self.caiZhongType isEqualToString:@"113"]){//大乐透
                    if ([self.isnew isEqualToString:@"1"]) {
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_20_MA"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_10_MA"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_3_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_DU_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_SHA_6_MA"]];
                        [self.rowCountArr addObject:ballDic[@"LONG_TOU"]];
                        [self.rowCountArr addObject:ballDic[@"FENG_WEI"]];
                        [self.rowCountArr addObject:ballDic[@"HOU_QU_3_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HOU_QU_SHA_6_MA"]];
                        NSString *fushi=ballDic[@"FU_SHI_10_3"];
                        [self.rowCountArr addObject:[fushi stringByReplacingOccurrencesOfString:@"*" withString:@"+"]];
                    }else if([self.isnew isEqualToString:@"0"]){
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_25_MA"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_20_MA"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_10_MA"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_3_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_SHA_3_MA"]];
                        [self.rowCountArr addObject:ballDic[@"QIAN_QU_SHA_6_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HOU_QU_6_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HOU_QU_3_MA"]];
                        [self.rowCountArr addObject:ballDic[@"HOU_QU_SHA_3_MA"]];
                    }
                    [self selectRewardRedCount:self.rowCountArr difLotteryType:self.caiZhongType];
                }else if ([self.caiZhongType isEqualToString:@"108"]||[self.caiZhongType isEqualToString:@"002"]){
                    if ([self.isnew isEqualToString:@"1"]) {
                        [self.rowCountArr addObject:ballDic[@"DU_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"SHUANG_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"SAN_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"SHA_1_MA"]];
                        [self.rowCountArr addObject:ballDic[@"WU_MA_ZU_XUAN"]];
                        [self.rowCountArr addObject:ballDic[@"LIU_MA_ZU_XUAN"]];
                        [self.rowCountArr addObject:ballDic[@"SAN_KUA_DU"]];
                        NSString *fiveDefineStr = ballDic[@"WU_MA_DING_WEI"];
                        if (fiveDefineStr.length == 44) {//服务器返回的数据有时为00，有时为0，请区分
                            NSString *fiveHundStr = [fiveDefineStr substringWithRange:NSMakeRange(0, 14)];
                            NSString *fiveTensStr = [fiveDefineStr substringWithRange:NSMakeRange(15, 14)];
                            NSString *fiveUintStr = [fiveDefineStr substringWithRange:NSMakeRange(30, 14)];
                            [self.rowCountArr addObject:fiveHundStr];
                            [self.rowCountArr addObject:fiveTensStr];
                            [self.rowCountArr addObject:fiveUintStr];
                        }else{
                            NSString *fiveHundStr = [fiveDefineStr substringWithRange:NSMakeRange(0, 9)];
                            NSString *fiveTensStr = [fiveDefineStr substringWithRange:NSMakeRange(10, 9)];
                            NSString *fiveUintStr = [fiveDefineStr substringWithRange:NSMakeRange(20, 9)];
                            [self.rowCountArr addObject:fiveHundStr];
                            [self.rowCountArr addObject:fiveTensStr];
                            [self.rowCountArr addObject:fiveUintStr];
                        }
                        [self.rowCountArr addObject:ballDic[@"HE_ZHI"]];
                        [self.rowCountArr addObject:ballDic[@"BAO_XING"]];
                    }else if([self.isnew isEqualToString:@"0"]){
                        [self.rowCountArr addObject:ballDic[@"DU_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"SHUANG_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"SAN_DAN"]];
                        [self.rowCountArr addObject:ballDic[@"SHA_1_MA"]];
                        [self.rowCountArr addObject:ballDic[@"SHA_3_MA"]];
                        [self.rowCountArr addObject:ballDic[@"WU_MA_ZU_XUAN"]];
                        [self.rowCountArr addObject:ballDic[@"LIU_MA_ZU_XUAN"]];
                        [self.rowCountArr addObject:ballDic[@"SAN_HE_WEI"]];
                        [self.rowCountArr addObject:ballDic[@"SAN_KUA_DU"]];
                        [self.rowCountArr addObject:ballDic[@"WU_MA_DING_WEI"]];
                        NSString *fiveDefineStr = ballDic[@"WU_MA_DING_WEI"];
                        if (fiveDefineStr.length == 44) {//服务器返回的数据有时为00，有时为0，请区分
                            NSString *fiveUintStr = [fiveDefineStr substringWithRange:NSMakeRange(0, 14)];
                            NSString *fiveTensStr = [fiveDefineStr substringWithRange:NSMakeRange(15, 14)];
                            NSString *fiveHundStr = [fiveDefineStr substringWithRange:NSMakeRange(30, 14)];
                            NSString *fiveCountDefineStr = [NSString stringWithFormat:@"百位%@    十位%@     个位%@",fiveHundStr,fiveTensStr,fiveUintStr];
                            [self.rowCountArr addObject:fiveCountDefineStr];
                        }else{
                            NSString *fiveUintStr = [fiveDefineStr substringWithRange:NSMakeRange(0, 9)];
                            NSString *fiveTensStr = [fiveDefineStr substringWithRange:NSMakeRange(10, 9)];
                            NSString *fiveHundStr = [fiveDefineStr substringWithRange:NSMakeRange(20, 9)];
                            NSString  *fiveCountDefineStr = [NSString  stringWithFormat:@"百位%@    十位%@     个位%@",fiveHundStr,fiveTensStr,fiveUintStr];
                            [self.rowCountArr addObject:fiveCountDefineStr];
                        }
                    }
                    [self selectRewardRedCount:self.rowCountArr difLotteryType:@"arrange"];
                }
            }
        }else{
            [_tableView removeFromSuperview];
        }
    } failure:^(NSError *error) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        [_tableView removeFromSuperview];
    }];
}

#pragma mark 提交去按钮
-(void)btnGoToBtn
{
    Expert365Bridge  *experVC = [[Expert365Bridge alloc]init];
    [experVC betShuZiFromController:self lotteryID:self.caiZhongType];
}

#pragma mark ------------中奖号码注红--------------
-(void)selectRewardRedCount:(NSMutableArray *)arr difLotteryType:(NSString *)difStr
{
    NSLog(@"seld.bonun==%@",self.bonusNumber);
    if (self.bonusNumber.length == 0) {
        [_tableView reloadData];
        return;
    }else{
        if ([difStr isEqualToString:@"001"]){//双色球
            NSArray *strArr = [self.bonusNumber componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",+"]];
            for (NSString *str in strArr) {
                NSLog(@"str:%@",str);
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSArray *jiaArr = [self.bonusNumber componentsSeparatedByString:@"+"];//接口有时返回数据会用“+”区分前区与后区（红球与篮球）
                    NSString *addQian=@"";
                    NSString *addHou=@"";
                    if (jiaArr.count == 1) {
                        addQian = jiaArr[0];
                    }else{
                        addQian = jiaArr[0];
                        addHou = jiaArr[1];
                    }
                    BOOL hlL = YES;
                    NSString *winNum=@"";
                    if ([self.isnew isEqualToString:@"1"]) {
                        if (idx == 7||idx ==8) {
                            switch (idx) {
                                case 8:
                                    hlL = NO;
                                    break;
                            }
                            winNum=addHou;
                        } else if(idx!=9){
                            switch (idx) {
                                case 4:
                                    hlL = NO;
                                    break;
                            }
                            winNum=addQian;
                        }else if(idx==9){
                            NSArray *nineStrArr = [obj componentsSeparatedByString:@"+"];
                            NSMutableAttributedString *astr0 = (NSMutableAttributedString *)[self attributedString:[nineStrArr objectAtIndex:0]  substring:addQian color:[UIColor redColor] highlighted:hlL];
                            NSAttributedString *astr1 = [self attributedString:[nineStrArr objectAtIndex:1]  substring:addHou color:[UIColor redColor] highlighted:hlL];
                            NSAttributedString *astr2=[[NSAttributedString alloc] initWithString:@"+"];
                            [astr0 appendAttributedString:astr2];
                            [astr0 appendAttributedString:astr1];
                            [self.rowCountAtrArr addObject:astr0];
                        }
                    }else if([self.isnew isEqualToString:@"0"]){
                        if (idx == 6||idx == 7||idx ==8) {
                            switch (idx) {
                                case 8:
                                    hlL = NO;
                                    break;
                            }
                            winNum=addHou;
                        }else {
                            switch (idx) {
                                case 4:
                                case 5:
                                    hlL = NO;
                                    break;
                            }
                            winNum=addQian;
                        }
                    }
                    if ([self.isnew isEqualToString:@"1"]&&idx==9) {
                        return;
                    }
                    NSAttributedString *astr = [self attributedString:obj  substring:winNum color:[UIColor redColor] highlighted:hlL];
                    [self.rowCountAtrArr addObject:astr];
                }];
            }
        }else if ([difStr isEqualToString:@"113"]){//大乐透
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray *jiaArr = [self.bonusNumber componentsSeparatedByString:@"+"];
                NSString *addQian;
                NSString *addHou = @"";
                if (jiaArr.count == 1) {
                    addQian = jiaArr[0];
                }else{
                    addQian = jiaArr[0];
                    addHou = jiaArr[1];
                }
                BOOL hlL = YES;
                NSString *winNum=@"";
                if ([self.isnew isEqualToString:@"1"]) {
                    if (idx == 7||idx == 8) {
                        switch (idx) {
                            case 8:
                                hlL = NO;
                                break;
                        }
                        winNum=addHou;
                    } else if(idx!=9){
                        switch (idx) {
                            case 4:
                                hlL = NO;
                                break;
                        }
                        winNum=addQian;
                    }else if(idx==9){
                        NSArray *nineStrArr = [obj componentsSeparatedByString:@"+"];
                        NSMutableAttributedString *astr0 = (NSMutableAttributedString *)[self attributedString:[nineStrArr objectAtIndex:0]  substring:addQian color:[UIColor redColor] highlighted:hlL];
                        NSAttributedString *astr1 = [self attributedString:[nineStrArr objectAtIndex:1]  substring:addHou color:[UIColor redColor] highlighted:hlL];
                        NSAttributedString *astr2=[[NSAttributedString alloc] initWithString:@"+"];
                        [astr0 appendAttributedString:astr2];
                        [astr0 appendAttributedString:astr1];
                        [self.rowCountAtrArr addObject:astr0];
                    }
                }else if ([self.isnew isEqualToString:@"0"]){
                    if (idx == 6||idx == 7||idx == 8) {
                        switch (idx) {
                            case 8:
                                hlL = NO;
                                break;
                        }
                        winNum=addHou;
                    }else {
                        switch (idx) {
                            case 4:
                            case 5:
                                hlL = NO;
                                break;
                        }
                        winNum=addQian;
                    }
                }
                if ([self.isnew isEqualToString:@"1"]&&idx==9) {
                    return;
                }
                NSAttributedString *astr = [self attributedString:obj  substring:winNum color:[UIColor redColor] highlighted:hlL];
                [self.rowCountAtrArr addObject:astr];
            }];
        }else{//排列三、3D
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BOOL hlL = YES;
                if ([self.isnew isEqualToString:@"1"]) {
                    if(idx == 6){
                        NSArray *subs = [self.bonusNumber componentsSeparatedByString:@","];
                        int max=0;
                        int min=0;
                        for(int i=0;i<[subs count];i++){
                            NSString *str = [subs objectAtIndex:i];
                            if (max<[str intValue]) {
                                max=[str intValue];
                            }
                            if (i==0) {
                                min=[str intValue];
                            }else{
                                if (min>[str intValue]) {
                                    min=[str intValue];
                                }
                            }
                        }
                        NSString * yuCount=[NSString stringWithFormat:@"%d",max-min];//三跨度（最大值减去最小值）
                        NSAttributedString *astr = [self attributedString:obj  substring:yuCount color:[UIColor redColor] highlighted:hlL];
                        [self.rowCountAtrArr addObject:astr];
                    }else if(idx==7||idx==8||idx==9) {
                        NSArray *bonusArr=[self.bonusNumber componentsSeparatedByString:@","];
                        NSInteger i=0;
                        if(idx == 8){
                            i=1;
                        }else if(idx == 9){
                            i=2;
                        }
                        NSAttributedString *astr = [self attributedString:obj  substring:[bonusArr objectAtIndex:i] color:[UIColor redColor] highlighted:hlL];
                        [self.rowCountAtrArr addObject:astr];
                    }else if(idx == 10){
                        NSArray *subs = [self.bonusNumber componentsSeparatedByString:@","];
                        int count=0;
                        for(int i=0;i<[subs count];i++){
                            NSString *str = [subs objectAtIndex:i];
                            count=count+[str intValue];
                        }
                        NSAttributedString *astr = [self attributedString:obj  substring:[NSString stringWithFormat:@"%d",count] color:[UIColor redColor] highlighted:hlL];
                        [self.rowCountAtrArr addObject:astr];
                    } else {
                        switch (idx) {
                            case 3:
                                hlL = NO;
                                break;
                        }
                        NSAttributedString *astr = [self attributedString:obj  substring:self.bonusNumber color:[UIColor redColor] highlighted:hlL];
                        [self.rowCountAtrArr addObject:astr];
                    }
                }else if([self.isnew isEqualToString:@"0"]){
                    if(idx == 7){
                        NSArray *subs = [self.bonusNumber componentsSeparatedByString:@","];
                        int count=0;
                        for(int i=0;i<[subs count];i++){
                            NSString *str = [subs objectAtIndex:i];
                            count=count+[str intValue];
                        }
                        NSString * yuCount=[NSString stringWithFormat:@"%d",count%10];//三和尾（三个数相加所得和的个位数）
                        NSAttributedString *astr = [self attributedString:obj  substring:yuCount color:[UIColor redColor] highlighted:hlL];
                        [self.rowCountAtrArr addObject:astr];
                    }else if(idx == 8){
                        NSArray *subs = [self.bonusNumber componentsSeparatedByString:@","];
                        int max=0;
                        int min=0;
                        for(int i=0;i<[subs count];i++){
                            NSString *str = [subs objectAtIndex:i];
                            if (max<[str intValue]) {
                                max=[str intValue];
                            }
                            if (i==0) {
                                min=[str intValue];
                            }else{
                                if (min>[str intValue]) {
                                    min=[str intValue];
                                }
                            }
                        }
                        NSString * yuCount=[NSString stringWithFormat:@"%d",max-min];//三跨度（最大值减去最小值）
                        NSAttributedString *astr = [self attributedString:obj  substring:yuCount color:[UIColor redColor] highlighted:hlL];
                        [self.rowCountAtrArr addObject:astr];
                    }else if(idx == 9) {
                        NSString *str = obj;
                        NSRange rang=[str rangeOfString:@"*"];
                        if (rang.length>0) {
                            NSArray *strs = [str componentsSeparatedByString:@"*"];
                            NSMutableArray *array = [NSMutableArray array];
                            NSArray *subs = [self.bonusNumber componentsSeparatedByString:@","];
                            for (int i=0; i<[subs count]; i++) {
                                NSAttributedString *astr = [self attributedString:strs[i]  substring:subs[i] color:[UIColor redColor] highlighted:hlL];
                                [array addObject:astr];
                            }
                            
                            NSMutableAttributedString *s = [[NSMutableAttributedString alloc]init];
                            [s appendAttributedString:[[NSAttributedString alloc] initWithString:@"百位"]];
                            [s appendAttributedString:array[0]];
                            [s appendAttributedString:[[NSAttributedString alloc] initWithString:@"     十位"]];
                            [s appendAttributedString:array[1]];
                            [s appendAttributedString:[[NSAttributedString alloc] initWithString:@"     个位"]];
                            [s appendAttributedString:array[2]];
                            [self.rowCountAtrArr addObject:s];
                        }
                    }else {
                        switch (idx) {
                            case 3:
                            case 4:
                                hlL = NO;
                                break;
                        }
                        NSAttributedString *astr = [self attributedString:obj  substring:self.bonusNumber color:[UIColor redColor] highlighted:hlL];
                        [self.rowCountAtrArr addObject:astr];
                    }
                }
            }];
        }
        [_tableView reloadData];
    }
}
- (CGFloat)Calculating_Text_Height_2_Width:(CGFloat)width WithString:(NSAttributedString *)string {
    CGRect frame = [string boundingRectWithSize:CGSizeMake(width, FLT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil];
    NSLog(@"2:%@", NSStringFromCGRect(frame));
    return frame.size.height;
}

- (CGFloat)Calculating_Text_Height_3_Width:(CGFloat)width WithString:(NSAttributedString *)string {
    NSTextStorage *textStorage = [[NSTextStorage alloc] init];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(width, FLT_MAX)];
    [textContainer setLineFragmentPadding:0.0];
    [layoutManager addTextContainer:textContainer];
    [textStorage setAttributedString:string];
    [layoutManager glyphRangeForTextContainer:textContainer];
    CGRect frame = [layoutManager usedRectForTextContainer:textContainer];
    NSLog(@"3:%@", NSStringFromCGRect(frame));
    return frame.size.height;
}
/**
 * @brief 创建 NSAttributedString
 * @param string 原始 NSString 数组
 * @param substr 对比 NSString 数组
 * @param color 高亮颜色
 * @param highlighted YES：strs 中包含 subs 的字符串高亮，NO：strs 中不包含 subs 的字符串高亮
 */
- (NSAttributedString *)attributedString:(NSString *)string substring:(NSString *)substr color:(UIColor *)color highlighted:(BOOL)highlighted {
    NSMutableDictionary *hls = [NSMutableDictionary dictionary];
    NSArray *strs = [string componentsSeparatedByString:@","];
    NSArray *subs = [substr componentsSeparatedByString:@","];
    for (NSString *str in strs) {
        NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@"*"];
        NSString *sstr=[str stringByTrimmingCharactersInSet:set];
        if ([subs containsObject:sstr]) {
            [hls setObject:@(highlighted) forKey:str];
        } else {
            [hls setObject:@(!highlighted) forKey:str];
        }
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    NSMutableString *fstr = [NSMutableString string];
    for (NSString *str in strs) {
        NSRange range = NSMakeRange(0, str.length);
        if (fstr.length == 0) {
            [fstr appendString:str];
        } else {
            range.location = fstr.length + 1;
            [fstr appendFormat:@",%@", str];
        }
        if ([hls[str] boolValue]) {
            [attributes setObject:@{NSForegroundColorAttributeName:color}
                           forKey:NSStringFromRange(range)];
        }
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:fstr];
    NSArray *keys = [attributes allKeys];
    for (NSString *key in keys) {
        NSRange range = NSRangeFromString(key);
        NSDictionary *attr = [attributes objectForKey:key];
        [attrStr setAttributes:attr range:range];
        
    }
    return attrStr;
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    