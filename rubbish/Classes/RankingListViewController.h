//
//  RankingListViewController.h
//  caibo
//
//  Created by houchenguang on 14-3-13.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "ShuangSeQiuInfoViewController.h"

@interface RankingListViewController : CPViewController <ShuangSeQiuInfoDelegate,UITableViewDataSource, UITableViewDelegate>{

    UITableView * myTableview;
    int buffer[4];
    UIImageView * dateSelectImage;
//    UIImageView * countSelectImage;
    ASIHTTPRequest * httpRequest;
    NSMutableDictionary * dateDictionary;
    NSMutableArray * countArray;
    BOOL selectButton;
    NSMutableArray * sortDateArray;
}
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;

@end
