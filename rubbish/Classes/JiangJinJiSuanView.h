//
//  JiangJinJiSuanView.h
//  caibo
//
//  Created by yaofuyu on 14-3-12.
//
//

#import <UIKit/UIKit.h>

@interface JiangJinJiSuanView : UIView<UITableViewDataSource,UITableViewDelegate> {
    NSDictionary *dataDic;
    UITableView *myTableView;
    NSString *lottoryID;
}
- (void)show;
@property (nonatomic,retain)NSDictionary *dataDic;
@property (nonatomic,retain)NSString *lottoryID;

@end
