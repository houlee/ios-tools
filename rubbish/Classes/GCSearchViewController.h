//
//  GCSearchViewController.h
//  caibo
//
//  Created by houchenguang on 12-11-22.
//
//

#import <UIKit/UIKit.h>


@interface GCSearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>{
    UITableView * myTableView;
    UISearchBar *PKsearchBar;//搜索栏；
    UISearchDisplayController *searchDC;
    NSMutableArray * seachTextListarry;//搜索数组
    BOOL isQuxiao;
    BOOL Cancelbool;
    BOOL backBool;
}
@property (nonatomic, retain)NSMutableArray * seachTextListarry;
@property  (nonatomic, retain)UISearchBar *PKsearchBar;//搜索栏；
- (void)searchbegin;
@end

