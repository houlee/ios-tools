//
//  IntegralAlertView.h
//  caibo
//
//  Created by houchenguang on 14-5-26.
//
//

#import <UIKit/UIKit.h>

@interface IntegralAlertView : UIView<UITableViewDataSource, UITableViewDelegate>{

    NSInteger alertType;
    UITableView * myTableView;
    NSDictionary * dataDictionary;
    UILabel * teamLabel;
    UIImageView * bgImageView;
    NSString * interalString;
    NSInteger showType;
}
@property (nonatomic, retain) NSDictionary * dataDictionary;
@property (nonatomic, retain)NSString * interalString;
- (void)show;

- (id)initWithType:(NSInteger)type showType:(NSInteger)showtype;//1为联赛积分榜  2为球队积分榜  showType 1为排名 默认为弹窗

@end
