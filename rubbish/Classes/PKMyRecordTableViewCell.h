//
//  PKMyRecordTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 15/1/23.
//
//

#import <UIKit/UIKit.h>
#import "ColorView.h"
#import "GC_BetRecord.h"
#import "MyHeMaiList.h"
#import "zhuiHaoData.h"

@interface PKMyRecordTableViewCell : UITableViewCell

{
    UILabel * lotteryName;//彩票名字
    UILabel * minName;//彩票的分种
    UILabel * lotteryState;//彩票的状态
    UILabel * moneyLabel;//投入的钱数
    UILabel * yuanLabel;//投入钱数的元字
    UILabel * zhongMoney;//中奖钱数
    UILabel * zhongYuan;//中奖元字
    UILabel * issueLabel;//期号label
    UIImageView * zhongjiangIamge;//中奖图标
    UIImageView * suoImage;//锁图标
    UIImageView * heimage;//合买图标
    UIImageView * faimage;//发起图标
    UIImageView * zhuiImge;//追图标
    UIImageView * shengyinimage;//声音图片
    UIImageView *JLimage;//领取奖励图标
    
    BetRecordInfor *betRecordInfo;
    // 合买cell
    BetHeRecordInfor *hemaiInfo;
    BOOL isHemai;
    UILabel * miaoshuLabel;
    UIImageView * baodiImage;
    UIImageView * scheduleImage;//进度条下面的图片
    UIImageView * shengyinimageUp;//进度条上面的图片
    UILabel * percentageLabel;//几分之几
    UILabel * awardAmount;//中多少期
    zhuiHaoDataInfo * zhuihaoinfo;//追号列表传的参数
    zhuiHaoDataInfo * infoListData;//详情列表传的参数
    zhuiHaoData * infoData;//详情列表传的参数
    UIView *cellXian;
    //    NSInteger countCell;
    //    NSIndexPath * lotteryIndex;
    UILabel *xuniLab;
}

@property (nonatomic,retain)BetRecordInfor *betRecordInfo;
@property (nonatomic,retain)BetHeRecordInfor *hemaiInfo;
@property (nonatomic, retain)zhuiHaoDataInfo * zhuihaoinfo, * infoListData;
@property (nonatomic, retain) zhuiHaoData * infoData;
@property (nonatomic, retain) UIView *cellXian;
//@property (nonatomic, retain)NSIndexPath * lotteryIndex;
//@property (nonatomic, assign)NSInteger countCell;

- (void)LoadData:(BetRecordInfor *)info;
- (void)LoadHemaiData:(BetHeRecordInfor *)info;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndex:(NSIndexPath *)lotteryIndex withCellCount:(NSInteger)countCell;
@end
