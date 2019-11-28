//
//  GCHeMaiViewController.h
//  caibo
//
//  Created by  on 12-6-25.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CP_TabBarViewController.h"

@interface GCHeMaiViewController : UIViewController <CP_TabBarConDelegate,UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource>{
    UITableView * myTableViewCai;
    UITableView * myTableViewHeFa;
    UIButton * zulancaiBut;
    UIButton * shuzicaiBut;
    UIButton * myhemaiBut;
    NSArray * imageArr;
    NSArray * shuziArr;
    UISearchBar *PKsearchBar;//搜索栏；
	UISearchDisplayController *searchDC;
    NSMutableArray * seachTextListarry;//搜索数组
    BOOL isQuxiao;
    NSString * systimestr;
    CP_TabBarViewController * tabc;

}
@property (nonatomic, retain)NSMutableArray * seachTextListarry;
@property (nonatomic, retain)NSString * systimestr;
@end
