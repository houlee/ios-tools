//
//  ShuangSeQiuCell.h
//  caibo
//
//  Created by yao on 12-5-18.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_LotteryType.h"
#import "CP_PTButton.h"

@protocol ShuangSeQiuCellDelegate

- (void)deleteCell:(UITableViewCell *)shuangseCell;

@end


@interface ShuangSeQiuCell : UITableViewCell {
	CP_PTButton *shanchuBtn;
	UIButton *jianBtn;
	id shuangseqiuCellDelegate;
	UILabel *fuShiLabel;
	UILabel *zhuShuLabel;
    BOOL isDaletou;
    ModeTYPE modeType;
    LotteryTYPE lotteryType;
    UIImageView *backImage;
    
    UIImageView *lineIma;
    
//    CP_PTButton *shanchuButton;
}

- (void)LoadData:(NSString *)info;
@property (nonatomic)ModeTYPE modeType;
@property (nonatomic)LotteryTYPE lotteryType;
@property (nonatomic,assign)id<ShuangSeQiuCellDelegate> shuangseqiuCellDelegate;

@end
