//
//  ExpertNewMainViewController.h
//  caibo
//
//  Created by cp365dev6 on 2016/12/4.
//
//

#import "CPViewController.h"

@interface ExpertNewMainViewController : CPViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIScrollView *mainScro;
    UITableView *headerTable;
    UITableView *starTable;
    UITableView *basTable;//第二个  篮彩
    UITableView *rankTable;
    UITableView *raceTable;
    UITableView *basketTable;//第五个  篮彩赛事
    
    UIView *starHeaderView;
    UIView *basHeaderView;
    UIView *rankHeaderView;
    UIView *raceHeaderView;
    UIView *basketHeaderView;
    
    
//    UIView * _changeTypeView;//切换列表按钮所在
    UIScrollView * _changeTypeView;//切换列表按钮所在
    
    NSArray * _typeNameArray;
    NSMutableArray * _homeDataArray;//全部商品数据
    
    NSMutableArray * _willLotteryDataArray;//即将开奖数据
    
    NSMutableArray * _winnersArray;
    
    BOOL _refresh;

    UICollectionView *expertCollection;
    
    NSMutableArray *expertListArym;//头部专家
    NSMutableArray *starExpertArym;//明星
    NSMutableArray *basExpertArym;//篮彩
    NSMutableArray *rankExpertArym;//榜单
    NSMutableArray *matchListArym;//赛事
    NSMutableArray *basketListArym;//篮彩赛事
    NSMutableArray *hornArray;//喇叭
    NSMutableArray *hornInfoArray;//喇叭
    
    int hornCount;
    UILabel *hornLab1;//
    UILabel *hornLab2;//
    
    BOOL starScrollType;
    BOOL basScrollType;
    BOOL rankScrollType;
    BOOL raceScrollType;
    BOOL basketScrollType;
    
    NSString *erAgintOrderId;
    CGFloat disPrice;
    
    NSInteger racePage;
    NSInteger basPage;//篮彩  第二个
    NSInteger basketPage;//篮彩赛事  第五个
    
    UIView * tableViewHeaderView;
    
    UIImageView *_noNewRecommandImageView;
    
    BOOL isBasket;
}
-(void)scroToChannelWithType:(NSString *)type;//1--喂饼之星  2--排行榜  3--赛程
@end
