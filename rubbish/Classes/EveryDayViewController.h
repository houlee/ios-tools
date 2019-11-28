//
//  EveryDayViewController.h
//  caibo
//
//  Created by GongHe on 13-12-30.
//
//

#import "CPViewController.h"
#import "EveryDayTableViewCell.h"

@class EveryDayCellModel;
@class ASIHTTPRequest;
@interface EveryDayViewController : CPViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIView * blackView;//期数选择黑背景
    UIImageView *backImageV;//期数选择背景
    
    ASIHTTPRequest * contentRequest;//内容
    ASIHTTPRequest * issueRequest;//期次
    ASIHTTPRequest * niceWeiBoRequest;//天天好单微博
    
    NSString * curIssue;//当前期次
    NSString * curIssue1;//请求回来前暂时保存当前期次
    NSMutableArray * allIssueArray;//所有期次;
        
    UITableView * mainTableView;
    EveryDayCellModel * cellModel;
}

@property (nonatomic, retain)ASIHTTPRequest * contentRequest;
@property (nonatomic, retain)ASIHTTPRequest * issueRequest;
@property (nonatomic, retain)ASIHTTPRequest * niceWeiBoRequest;

- (id)initWithIssue:(NSString *)issue;

@end
