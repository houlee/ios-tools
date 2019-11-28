//
//  ExpertMainCollectionViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/22.
//
//

#import <UIKit/UIKit.h>
#import "ExpertMainListTableViewCell.h"

typedef void(^RefreshHeader)(UITableView * tableView);
typedef void(^RefreshFooter)(UITableView * tableView);
typedef void(^DidSelectRow)(UITableView * tableView, NSIndexPath * indexPath);
typedef void(^SelectedCoinButton)(NSIndexPath *index);

@interface ExpertMainCollectionViewCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArym;
}
@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, copy) RefreshHeader refreshHeader;
@property (nonatomic, copy) RefreshFooter refreshFooter;
@property (nonatomic, copy) DidSelectRow didSelectRow;
@property (nonatomic, copy) SelectedCoinButton buttonAction;
-(void)loadAppointInfo:(NSArray *)ary;

@end
