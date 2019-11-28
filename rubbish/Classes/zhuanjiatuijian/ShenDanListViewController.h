//
//  ShenDanListViewController.h
//  caibo
//
//  Created by yaofuyu on 16/8/11.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"

@interface ShenDanListViewController : CPViewController {
    UITableView *myTableView;
}
@property (nonatomic,retain)NSMutableArray *dataArray;

@end
