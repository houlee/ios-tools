//
//  YCMatchViewController.h
//  caibo
//
//  Created by houchenguang on 14-5-24.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "UpLoadView.h"

@interface YCMatchViewController : CPViewController<UITableViewDataSource, UITableViewDelegate>{

    UITableView * myTableView;
    NSMutableArray * buffer;
    ASIHTTPRequest * httpRequest;
    NSDictionary * analyzeDictionary;
    NSMutableDictionary * dataDictionary;
    UpLoadView * loadview;
}
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain)NSDictionary * analyzeDictionary;

@end
