//
//  OddsTableViewCell.h
//  caibo
//
//  Created by houchenguang on 14-5-23.
//
//

#import <UIKit/UIKit.h>

@protocol OddsTableViewCellDelegate <NSObject>
@optional
- (void)OddsTableViewCellDelegateButtonTag:(NSInteger)tag indexPath:(NSIndexPath *)indexPath;//1是分析中心 2是赔率中心
@end

@interface OddsTableViewCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>{

    UILabel * macthLabel;//竞彩官方 还是10bet等等
    UILabel * oneLabel;//胜 大
    UILabel * twoLabel;//平 盘
    UILabel * threeLabel;//负 小
    ///第一行的三个赔率
    UILabel * oneShengLable;
    UILabel * onePingLable;
    UILabel * oneFuLable;
    //第二行的三个赔率
    UILabel * twoShengLable;
    UILabel * twoPingLable;
    UILabel * twoFuLable;
    //箭头
    UIImageView * jianImageOne;
    UIImageView * jianImageTwo;
    UIImageView * jianImageThree;
    
    UIImageView * openImage;
    
    UITableView * myTabelView;
    UIImageView * openView;//展开的view
    id<OddsTableViewCellDelegate>delegate;
    NSIndexPath * indexOdds;
    BOOL opencellBool;
    NSMutableDictionary * oddsDictionary;
    NSInteger oddsInteger;
    UIButton * openButton ;
}

@property (nonatomic, assign)id<OddsTableViewCellDelegate>delegate;
@property (nonatomic, retain)NSIndexPath * indexOdds;
@property (nonatomic, assign)BOOL opencellBool;
@property (nonatomic, retain)NSMutableDictionary * oddsDictionary;
@property (nonatomic, assign)NSInteger oddsInteger;

@end
