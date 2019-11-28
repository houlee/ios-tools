//
//  DrawalMessageViewController.h
//  caibo
//
//  Created by cp365dev on 14-8-11.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"

@interface DrawalMessageViewController : CPViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    
    NSArray *titleArray;
    
    NSArray * infoArray;
}
@property (nonatomic, retain) NSArray *titleArray;

@property (nonatomic, retain) NSArray *infoArray;
@end
