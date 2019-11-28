//
//  PKNewUserHelpViewController.h
//  caibo
//
//  Created by cp365dev6 on 15/1/19.
//
//

#import "CPViewController.h"
#import "Info.h"
#import "CP_CanOpenTableView.h"
#import "PKTableViewCell.h"
#import "NetURL.h"
#import "JSON.h"
#import "PermutationAndCombination.h"
#import "PKDetailViewController.h"

@interface PKNewUserHelpViewController : CPViewController<UITableViewDelegate,UITableViewDataSource,PK_NewTableCellDelegate>

{
    CP_CanOpenTableView * myTableView;
    UIView * tabView;
    UILabel * oneLabel;
    UILabel * twoLabel;
    UIButton * chuanButton1;
    UILabel *labelch;
    int one;
    int two;
    
    ASIHTTPRequest * request;
    NSMutableArray * dataArray;//保存数据的数组
    NSMutableDictionary * zhushuDic;
    
    UIView *firstView;
    UIScrollView *scroView;
    
    UIView *footerView;
    UIView *erchuanView;
    UIView *sanchuanView;
    
    NSMutableArray *cellarray;
    NSMutableArray * chuantype;
    int buf[160];
    NSInteger addchuan;
    
    UILabel *erChuanLab;
    UILabel *sanChuanLab;
    NSMutableArray *erChaifenArym;
    NSMutableArray *sanChaifenArym;
    
    long long erchuanChai;
    long long sanchuanChai;
    NSMutableArray *chuanfaArym;
    NSInteger qipao;
    UIImageView *huadongIma;
    UILabel *huadongLab;
    UIButton *castButton;
    
    BOOL isUp;
    UIButton *huadongBtn;
}
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)ASIHTTPRequest * request;
- (void)tabBarView;
@end
