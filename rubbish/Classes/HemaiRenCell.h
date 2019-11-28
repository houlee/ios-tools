//
//  HemaiRenCell.h
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-8-30.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DownLoadImageView.h"
#import "HeMaiCanYuJieXI.h"

@interface HemaiRenCell : UITableViewCell {
    UILabel *nameLabel;             //名字
    UILabel *timeLabel;             //时间
    UILabel *PaiJiangLabel;         //派奖金额
    UILabel *PaiJiangQianLabel;     //派奖文字
    UILabel *PaiJiangHouLabel;      //派奖元
    UILabel *fenshuLabel;           //购买份数
    UILabel *fenLabel;              //份字
//    DownLoadImageView *heardImageView;  //头像
    CanYuRen *InfoData;             //数据源；
}

@property (nonatomic,retain)CanYuRen *InfoData;

- (void)LoadData:(CanYuRen *)_InfoData;

@end
