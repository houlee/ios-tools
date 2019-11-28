//
//  ExpertHomeViewController.h
//  caibo
//
//  Created by GongHe on 16/8/10.
//
//

#import "V1PinBaseViewContrllor.h"
#import "LunBoView.h"
#import "UpLoadView.h"

@interface ExpertHomeViewController : V1PinBaseViewContrllor <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    UITableView * _mainTableView;
    
    UIScrollView * _lunBoScrollView;
    
    UIView * _navView;
    
    UIView * _mainTableViewHeader;
    
    UIView * _hornView;
    UILabel * _hornLabel;
    
    UICollectionView * _mainCollectionView;
    
    UIButton * _searchButton;
   
    UIView * _sectionHeaderView;
    
    UIButton * _filterBGButton;
    UIButton * _fakeFilterBGButton;
    
    UIView * _fakeHeader;
    
    NSMutableArray * _moduleArray;
    
    NSMutableArray * _photoImageArr;
    
    UIPageControl * _pageControl;
    NSInteger _currentPage;

    UIButton * _backButton;
    
    NSArray * _filterTitleArray;
}

@property(nonatomic,copy)NSString *superType;//专家类型
@property(nonatomic,copy)NSString *lotteyType;//彩种
@property(nonatomic,strong)UIView * noReconView;//暂无推荐
@property(nonatomic,strong)NSString *orderFlag;//排序方式
@property(nonatomic,strong)NSString *jcOrderFlag;//排序方式
@property(nonatomic,strong)NSString *ypOrderFlag;//排序方式
@property(nonatomic,copy)NSMutableArray *jcSuperArr;
@property(nonatomic,copy)NSMutableArray *ypSuperArr;
@property(nonatomic,assign)int jcCurrPage;//当前页
@property(nonatomic,assign)int ypCurrPage;//当前页

@property(nonatomic, assign) NSInteger moduleNumber;

@property(nonatomic, assign) BOOL independentDGQ;

@property(nonatomic,assign) BOOL isfromYiGou;//是否来自已购方案

@end
