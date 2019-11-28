//
//  AsEuCell.h
//  caibo //欧赔，亚赔，大小
//
//  Created by yao on 12-5-5.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsEuCell : UITableViewCell {
    UIImageView *backImageV;
	UILabel *nameLabel;//公司
	UILabel *nowWinLabel;//即时胜；
	UILabel *nowPingLabel;//即时平；
	UILabel *nowLostLabel;//即时负；
	UILabel *beginWinLabel;//初盘胜；
	UILabel *beginPingLabel;//初盘平；
	UILabel *beginLostLabel;//初盘负；
    UILabel *bianhuaLable;
	UIImageView *imageV1;
	UIImageView *imageV2;
    UIImageView *imageV3;
    UIImageView *imageV4;
    BOOL isLanQiu;
    BOOL isOuPei;
    BOOL isBafangYuceLanqiu;//八方预测篮球
}

-(void)LoadData:(NSDictionary *)dic isTitle:(BOOL)istitile;//八方预测加载方法
- (void)LoadData:(NSArray *)array isTitle:(BOOL)istitile CId:(NSString *)cid isFoot:(BOOL) isFoot isBianHua:(BOOL )isbianhua;//篮球比分直播加载详情
- (void)LoadBianHuaData:(NSArray *)array isTitle:(BOOL)istitile CId:(NSString *)cid isFoot:(BOOL)isFoot;//加载篮球赔率变化
@property (nonatomic) BOOL isLanQiu,isOuPei,isBafangYuceLanqiu;

@end
