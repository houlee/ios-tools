//
//  ExpertNewMainViewController.m
//  caibo
//
//  Created by cp365dev6 on 2016/12/4.
//
//

#import "ExpertNewMainViewController.h"
#import "SharedMethod.h"
#import "ExpertCollectionViewCell.h"
#import "RequestEntity.h"
#import "ExpertJingjiModel.h"
#import "ExpertMainListModel.h"
#import "MatchVCModel.h"
#import "ExpertMainListTableViewCell.h"
#import "ExpertMatchListTableViewCell.h"
#import "ExpertStarListViewController.h"
#import "ExpertRankListViewController.h"
#import "SMGDetailViewController.h"
#import "MatchDetailVC.h"
#import "ExpertRaceListTableViewCell.h"
#import "LoginViewController.h"
#import "MobClick.h"
#import "ProjectDetailViewController.h"
#import "Expert365Bridge.h"

@interface ExpertNewMainViewController ()

@end

@implementation ExpertNewMainViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
#ifdef CRAZYSPORTS
    [self changeCSTitileColor];
#endif

    mainScro.contentInset = UIEdgeInsetsMake(0, 0.0f, 0.0f, 0.0f);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(goBack)];
    self.CP_navigation.title = @"喂饼预测";
    
    [self loadMainView];
    
    [self noNewRecommandDataUI];
    
    [self getExpertListRequest];//get专家列表
    
    [self getStarExpertRequest];//get明星推荐
    [self getSquareAndRedPersonExpertRequestWithType:@"0"];//get明星推荐
    [self getSquareAndRedPersonExpertRequestWithType:@"1"];//get明星推荐
    
    [self getBasketRequestWithPage:@"1"];//篮彩
    
    [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"0"];//排行榜
    [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"1"];//排行榜
    [self getRankListExpertRequestWithlotteryClassCode:@"201" OrderFlag:@"0"];//排行榜
    
    [self getRaceListExpertRequestWithPage:@"1" WithSource:@"1"];//足彩赛程列表
    
    [self getRaceListExpertRequestWithPage:@"1" WithSource:@"4"];//篮彩赛程列表
    
    [self getExpertHornRequest];//获取喇叭信息
}
-(void)noNewRecommandDataUI
{
    UIImage * image = [UIImage imageNamed:@"暂无最新推荐"];
    _noNewRecommandImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 75)/2.0,44, 75,100)];//
    
    _noNewRecommandImageView.image = image;
}
-(void)loadMainView{
    
    racePage = 1;
    basketPage = 1;
    basPage = 1;
    
    erAgintOrderId = @"";
    disPrice = 0;
    expertListArym = [[NSMutableArray alloc]initWithCapacity:0];
    starExpertArym = [[NSMutableArray alloc]initWithCapacity:0];
    basExpertArym = [[NSMutableArray alloc]initWithCapacity:0];
    rankExpertArym = [[NSMutableArray alloc]initWithCapacity:0];
    matchListArym = [[NSMutableArray alloc]initWithCapacity:0];
    basketListArym = [[NSMutableArray alloc]initWithCapacity:0];
    hornArray = [[NSMutableArray alloc]initWithCapacity:0];
    hornInfoArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(NSInteger i=0;i<3;i++){
        NSMutableArray *ary = [[NSMutableArray alloc]initWithCapacity:0];
        [starExpertArym addObject:ary];
        [rankExpertArym addObject:ary];
    }
    
    _typeNameArray = [[NSArray alloc] initWithObjects:@"喂饼之星",@"篮彩",@"排行榜",@"足彩赛事",@"篮彩赛事", nil];
    
    mainScro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, self.mainView.frame.size.height-49)];
    mainScro.backgroundColor = [UIColor clearColor];
    mainScro.contentSize = CGSizeMake(MyWidth * _typeNameArray.count, 0);
    mainScro.delegate = self;
    mainScro.bounces = NO;
    mainScro.pagingEnabled = YES;
    [self.mainView addSubview:mainScro];
    
    headerTable = [[UITableView alloc] init];
    headerTable.backgroundColor = DEFAULT_BACKGROUNDCOLOR;
    headerTable.delegate = self;
    headerTable.dataSource = self;
    headerTable.scrollEnabled = NO;
    headerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    headerTable.showsHorizontalScrollIndicator = NO;
    headerTable.showsVerticalScrollIndicator = NO;
    [self.mainView addSubview:headerTable];
    
    tableViewHeaderView = [[UIView alloc] init];
    tableViewHeaderView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *starIma = [[UIImageView alloc]init];
    starIma.frame = CGRectMake(15, 10, 17, 17);
    starIma.backgroundColor = [UIColor clearColor];
    starIma.image = [UIImage imageNamed:@"expert_star_image.png"];
    [tableViewHeaderView addSubview:starIma];
    
    UILabel *starLab = [[UILabel alloc]init];
    starLab.frame = CGRectMake(40, 10, 100, 17);
    starLab.backgroundColor = [UIColor clearColor];
    starLab.font = [UIFont systemFontOfSize:12];
    starLab.textColor = BLACK_EIGHTYSEVER;
    starLab.text = @"名人";
    [tableViewHeaderView addSubview:starLab];
    
//    //创建一个layout布局类
//    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//    //设置布局方向为水平流布局
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    //设置每个item的大小为100*100
//    layout.itemSize = CGSizeMake(70, 90);
//    //创建collectionView 通过一个布局策略layout来创建
//    expertCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, self.mainView.frame.size.width, 90) collectionViewLayout:layout];
//    expertCollection.backgroundColor = [UIColor clearColor];
//    expertCollection.showsHorizontalScrollIndicator = NO;
//    //代理设置
//    expertCollection.delegate=self;
//    expertCollection.dataSource=self;
//    //注册item类型 这里使用系统的类型
//    [expertCollection registerClass:[ExpertCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
//    [tableViewHeaderView addSubview:expertCollection];
    
    UIView *hornBGView = [[UIView alloc]init];
    hornBGView.frame = CGRectMake(0, 120, self.mainView.frame.size.width, 35);
    hornBGView.backgroundColor = [UIColor whiteColor];
    hornBGView.layer.masksToBounds = YES;
    hornBGView.tag = 123123;
    [tableViewHeaderView addSubview:hornBGView];
    
    UIImageView *lineIma = [[UIImageView alloc]init];
    lineIma.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 0.5);
    lineIma.backgroundColor = SEPARATORCOLOR;
    [hornBGView addSubview:lineIma];
    
    UIImageView *hornIma = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 16.5, 12.5)];
    hornIma.image = [UIImage imageNamed:@"CS_GuessHorn.png"];
    [hornBGView addSubview:hornIma];
    
    UILabel *lianzhong = [[UILabel alloc]init];
    lianzhong.frame = CGRectMake(35, 0, 50, 35);
    lianzhong.backgroundColor = [UIColor clearColor];
    lianzhong.text = @"连中消息:";
    lianzhong.textColor = [SharedMethod getColorByHexString:@"ed3f30"];
    lianzhong.font = [UIFont systemFontOfSize:11];
    [hornBGView addSubview:lianzhong];
    
    hornLab1 = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, MyWidth - (ORIGIN_X(hornIma) + 5 + 50), 35)];
    hornLab1.textColor = DEFAULT_TEXTGRAYCOLOR;
    hornLab1.font = [UIFont systemFontOfSize:11];
    [hornBGView addSubview:hornLab1];
    
    hornLab2 = [[UILabel alloc] initWithFrame:CGRectMake(85, hornBGView.frame.size.height, hornLab1.frame.size.width, hornBGView.frame.size.height)];
    hornLab2.textColor = hornLab1.textColor;
    hornLab2.font = hornLab1.font;
    [hornBGView addSubview:hornLab2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hornAction:)];
    [hornBGView addGestureRecognizer:tap];
    
    UIImageView *ima = [[UIImageView alloc]init];
    ima.frame = CGRectMake(0, 155, self.mainView.frame.size.width, 5);
    ima.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    ima.tag = 1231234;
    [tableViewHeaderView addSubview:ima];
    
    tableViewHeaderView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 160);
    headerTable.tableHeaderView = tableViewHeaderView;
    
    _changeTypeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 35)];
    _changeTypeView.backgroundColor = [UIColor whiteColor];
    _changeTypeView.contentSize = CGSizeMake(400, 0);
    _changeTypeView.showsHorizontalScrollIndicator = NO;
    if(MyWidth > 400){
        _changeTypeView.contentSize = CGSizeMake(MyWidth, 0);
    }
    
    for (int i = 0; i < _typeNameArray.count; i++) {
        UIButton * changeTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(i * 80, 0, 80, _changeTypeView.frame.size.height)];
        if(MyWidth > 400){
            changeTypeButton.frame = CGRectMake(i * (_changeTypeView.frame.size.width * 1.0/_typeNameArray.count), 0, _changeTypeView.frame.size.width * 1.0/_typeNameArray.count, _changeTypeView.frame.size.height);
        }
        [changeTypeButton setTitle:[_typeNameArray objectAtIndex:i] forState:UIControlStateNormal];
        [changeTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [changeTypeButton setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateSelected];
        changeTypeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_changeTypeView addSubview:changeTypeButton];
        changeTypeButton.tag = 100 + i;
        [changeTypeButton addTarget:self action:@selector(changeCollectionType:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * redLineView = [[UIView alloc] initWithFrame:CGRectMake((changeTypeButton.frame.size.width - 65)/2.0, changeTypeButton.frame.size.height - 2, 65, 2)];
        redLineView.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
        [changeTypeButton addSubview:redLineView];
        redLineView.tag = 1000;
        redLineView.hidden = YES;
        
        if (i == 0) {
            [self changeCollectionType:changeTypeButton];
        }
    }
    
//    for (int i = 0; i < _typeNameArray.count; i++) {
//        UIButton * changeTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(i * (_changeTypeView.frame.size.width * 1.0/_typeNameArray.count), 0, _changeTypeView.frame.size.width * 1.0/_typeNameArray.count, _changeTypeView.frame.size.height)];
//        [changeTypeButton setTitle:[_typeNameArray objectAtIndex:i] forState:UIControlStateNormal];
//        [changeTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [changeTypeButton setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateSelected];
//        changeTypeButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_changeTypeView addSubview:changeTypeButton];
//        changeTypeButton.tag = 100 + i;
//        [changeTypeButton addTarget:self action:@selector(changeCollectionType:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIView * redLineView = [[UIView alloc] initWithFrame:CGRectMake((changeTypeButton.frame.size.width - 65)/2.0, changeTypeButton.frame.size.height - 2, 65, 2)];
//        redLineView.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
//        [changeTypeButton addSubview:redLineView];
//        redLineView.tag = 1000;
//        redLineView.hidden = YES;
//        
//        if (i == 0) {
//            [self changeCollectionType:changeTypeButton];
//        }
//    }
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, _changeTypeView.frame.size.height - 0.5, _changeTypeView.frame.size.width, 0.5)];
    lineView2.backgroundColor = DEFAULT_BACKGROUNDCOLOR;
    [_changeTypeView addSubview:lineView2];
    
    headerTable.frame = CGRectMake(0, 0, MyWidth, tableViewHeaderView.frame.size.height + _changeTypeView.frame.size.height);
    
    
    starTable = [[UITableView alloc] init];
    starTable.frame = CGRectMake(0, 0, MyWidth, mainScro.frame.size.height);
    starTable.delegate = self;
    starTable.dataSource = self;
    [mainScro addSubview:starTable];
    starTable.backgroundColor = [UIColor clearColor];
    starTable.showsHorizontalScrollIndicator = NO;
    starTable.showsVerticalScrollIndicator = NO;
    starTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    starHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5)];
    starHeaderView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    [starHeaderView addSubview:headerTable];
    
    _homeDataArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    
    basTable = [[UITableView alloc]init];
    basTable.frame = CGRectMake(MyWidth, 0, MyWidth, mainScro.frame.size.height);
    basTable.delegate = self;
    basTable.dataSource = self;
    [mainScro addSubview:basTable];
    basTable.backgroundColor = [UIColor clearColor];
    basTable.showsHorizontalScrollIndicator = NO;
    basTable.showsVerticalScrollIndicator = NO;
    basTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    basHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5)];
    basHeaderView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    
    rankTable = [[UITableView alloc]init];
    rankTable.frame = CGRectMake(MyWidth*2, 0, MyWidth, mainScro.frame.size.height);
    rankTable.delegate = self;
    rankTable.dataSource = self;
    [mainScro addSubview:rankTable];
    rankTable.backgroundColor = [UIColor clearColor];
    rankTable.showsHorizontalScrollIndicator = NO;
    rankTable.showsVerticalScrollIndicator = NO;
    rankTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    rankHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5)];
    rankHeaderView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    
    
    raceTable = [[UITableView alloc]init];
    raceTable.frame = CGRectMake(MyWidth*3, 0, MyWidth, mainScro.frame.size.height);
    raceTable.delegate = self;
    raceTable.dataSource = self;
    [mainScro addSubview:raceTable];
    raceTable.backgroundColor = [UIColor clearColor];
    raceTable.showsHorizontalScrollIndicator = NO;
    raceTable.showsVerticalScrollIndicator = NO;
    raceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    raceHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5)];
    raceHeaderView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    
    basketTable = [[UITableView alloc]init];
    basketTable.frame = CGRectMake(MyWidth*4, 0, MyWidth, mainScro.frame.size.height);
    basketTable.delegate = self;
    basketTable.dataSource = self;
    [mainScro addSubview:basketTable];
    basketTable.backgroundColor = [UIColor clearColor];
    basketTable.showsHorizontalScrollIndicator = NO;
    basketTable.showsVerticalScrollIndicator = NO;
    basketTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    basketHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5)];
    basketHeaderView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    
    
    starTable.tableHeaderView = starHeaderView;
    basTable.tableHeaderView = basHeaderView;
    rankTable.tableHeaderView = rankHeaderView;
    raceTable.tableHeaderView = raceHeaderView;
    basketTable.tableHeaderView = basketHeaderView;
    
    starTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getExpertListRequest];//get专家列表
        
        [self getStarExpertRequest];//get明星推荐
        [self getSquareAndRedPersonExpertRequestWithType:@"0"];//get明星推荐
        [self getSquareAndRedPersonExpertRequestWithType:@"1"];//get明星推荐
        
        [self getExpertHornRequest];//获取喇叭信息
    }];
    basTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getExpertListRequest];//get专家列表
        
        [self getBasketRequestWithPage:@"1"];//篮彩
        
        [self getExpertHornRequest];//获取喇叭信息
    }];
    basTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self getBasketRequestWithPage:[NSString stringWithFormat:@"%ld",(long)basPage]];//篮彩
        
    }];
    rankTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getExpertListRequest];//get专家列表
        
        [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"0"];//排行榜
        [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"1"];//排行榜
        [self getRankListExpertRequestWithlotteryClassCode:@"201" OrderFlag:@"0"];//排行榜
        
        [self getExpertHornRequest];//获取喇叭信息
    }];
    raceTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getExpertListRequest];//get专家列表
        
        racePage = 1;
        [self getRaceListExpertRequestWithPage:@"1" WithSource:@"1"];//足彩赛程列表
        
        [self getExpertHornRequest];//获取喇叭信息
    }];
    raceTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self getRaceListExpertRequestWithPage:[NSString stringWithFormat:@"%ld",(long)racePage] WithSource:@"1"];//足彩赛程列表
    }];
//    [SharedMethod setRefreshByHeaderOrFooter:raceTable.footer];
    
    basketTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getExpertListRequest];//get专家列表
        
        basketPage = 1;
        [self getRaceListExpertRequestWithPage:@"1" WithSource:@"4"];//篮彩赛程列表
        
        [self getExpertHornRequest];//获取喇叭信息
    }];
    basketTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self getRaceListExpertRequestWithPage:[NSString stringWithFormat:@"%ld",(long)basketPage] WithSource:@"4"];//篮彩赛程列表
    }];
}
//专家view
-(void)loadExpertView{
    
    UIView *view = [tableViewHeaderView viewWithTag:12312345];
    if(view){
        [view removeFromSuperview];
    }
    if(expertListArym.count > 0){
        UIView *expertBGView = [[UIView alloc]init];
        expertBGView.backgroundColor = [UIColor clearColor];
        expertBGView.tag = 12312345;
        [tableViewHeaderView addSubview:expertBGView];
        
        for(NSInteger i=0;i<expertListArym.count;i++){
            
            NSInteger m=i%4;
            NSInteger n=i/4;
            CGFloat width = self.view.frame.size.width / 4.0;
            
            ExpertJingjiModel *expertModel=[expertListArym objectAtIndex:i];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width*m, 75*n, width, 75);
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i;
            [btn addTarget:self action:@selector(manySeniorExpertClick:) forControlEvents:UIControlEventTouchUpInside];
            [expertBGView addSubview:btn];
            
            UIImageView *headIma = [[UIImageView alloc]init];
            headIma.frame = CGRectMake((width - 40)/2.0, 5, 40, 40);
            headIma.backgroundColor = [UIColor clearColor];
            headIma.layer.masksToBounds = YES;
            headIma.layer.cornerRadius = 20;
            headIma.tag = 1;
            [headIma sd_setImageWithURL:[NSURL URLWithString:expertModel.headPortrait] placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
            [btn addSubview:headIma];
            
//            UIImageView *professionalIma = [[UIImageView alloc]init];
//            professionalIma.frame = CGRectMake((width - 52)/2.0, 45, 52, 14);
//            professionalIma.backgroundColor = [UIColor clearColor];
//            professionalIma.tag = 2;
//            professionalIma.image = [UIImage imageNamed:@"zhuanjia_professional.png"];
//            [btn addSubview:professionalIma];
//            UILabel *professionalLab = [[UILabel alloc]init];
//            professionalLab.frame = CGRectMake(0, 0, 52, 14);;
//            professionalLab.text = @"资深专家";
//            if(expertModel.labelName.length && ![expertModel.labelName isEqualToString:@"null"]){
//                
//                professionalLab.text = expertModel.labelName;
//            }
//            professionalLab.textAlignment = NSTextAlignmentCenter;
//            professionalLab.font = [UIFont systemFontOfSize:11];
//            professionalLab.textColor=[UIColor colorWithHexString:@"1588DA"];
//            [professionalIma addSubview:professionalLab];
            
//            UIImageView *miniIma = [[UIImageView alloc]init];
//            miniIma.frame = CGRectMake(ORIGIN_X(professionalIma)-13, professionalIma.frame.origin.y-10, 10, 10);
//            miniIma.backgroundColor = [UIColor clearColor];
//            [miniIma sd_setImageWithURL:[NSURL URLWithString:expertModel.labelPic]];
//            [btn addSubview:miniIma];
            
            UILabel *nameLab = [[UILabel alloc]init];
            nameLab.frame = CGRectMake(0, ORIGIN_Y(headIma)+5, btn.frame.size.width, 15);
            nameLab.font = [UIFont systemFontOfSize:11];
            nameLab.backgroundColor = [UIColor clearColor];
            nameLab.textAlignment = NSTextAlignmentCenter;
            nameLab.text = expertModel.expertsNickName;
            nameLab.tag = 3;
            nameLab.alpha = 0.87;
            [btn addSubview:nameLab];
            
//            UILabel *recordLab = [[UILabel alloc]init];
//            recordLab.frame = CGRectMake(0, ORIGIN_Y(nameLab), btn.frame.size.width, 15);
//            recordLab.font = [UIFont systemFontOfSize:10];
//            recordLab.backgroundColor = [UIColor clearColor];
//            recordLab.textAlignment = NSTextAlignmentCenter;
//            recordLab.text = [NSString stringWithFormat:@"近%@中%@",expertModel.totalNum,expertModel.hitNum];
//            recordLab.tag = 4;
//            recordLab.alpha = 0.7;
//            [btn addSubview:recordLab];
        }
        
        NSInteger rows = expertListArym.count/4;
        if(expertListArym.count%4 > 0){
            rows = rows + 1;
        }
        expertBGView.frame = CGRectMake(0, 30, self.view.frame.size.width, rows*75);
        
        UIView *hornBGView = [tableViewHeaderView viewWithTag:123123];
        hornBGView.frame = CGRectMake(0, rows*75 + 30, self.mainView.frame.size.width, 35);
        UIView *ima = [tableViewHeaderView viewWithTag:1231234];
        ima.frame = CGRectMake(0, rows*75 + 30 + 35, self.mainView.frame.size.width, 5);
        
        tableViewHeaderView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, rows*75 + 30 + 40);
        headerTable.tableHeaderView = tableViewHeaderView;
        
        headerTable.frame = CGRectMake(0, 0, MyWidth, tableViewHeaderView.frame.size.height + _changeTypeView.frame.size.height);
        starHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        basHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        rankHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        raceHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        basketHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        
        starTable.tableHeaderView = starHeaderView;
        basTable.tableHeaderView = basHeaderView;
        rankTable.tableHeaderView = rankHeaderView;
        raceTable.tableHeaderView = raceHeaderView;
        basketTable.tableHeaderView = basketHeaderView;
        
    }else{
        UIView *hornBGView = [tableViewHeaderView viewWithTag:123123];
        hornBGView.frame = CGRectMake(0, 120, self.mainView.frame.size.width, 35);
        UIView *ima = [tableViewHeaderView viewWithTag:1231234];
        ima.frame = CGRectMake(0, 155, self.mainView.frame.size.width, 5);
        
        tableViewHeaderView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 160);
        headerTable.tableHeaderView = tableViewHeaderView;
        
        headerTable.frame = CGRectMake(0, 0, MyWidth, tableViewHeaderView.frame.size.height + _changeTypeView.frame.size.height);
        starHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        basHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        rankHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        raceHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        basketHeaderView.frame = CGRectMake(0, 0, MyWidth,  headerTable.frame.size.height+5);
        
        starTable.tableHeaderView = starHeaderView;
        basTable.tableHeaderView = basHeaderView;
        rankTable.tableHeaderView = rankHeaderView;
        raceTable.tableHeaderView = raceHeaderView;
        basketTable.tableHeaderView = basketHeaderView;
    }
}
-(void)getExpertListRequest{
    
    NSString *type = @"0";
#if defined CRAZYSPORTS
    type = @"1";
#endif
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"getHomeExpertsInfo",@"parameters":@{@"type":type}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[responseJSON valueForKey:@"result"];
            
            [expertListArym removeAllObjects];
            
            if ([result count]!=0) {
//                if (expertListArym.count) {
//                    
//                }
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:[result count]];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
                }
                [expertListArym addObjectsFromArray:mutableArr];
//                [expertCollection reloadData];
                [self loadExpertView];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
    }];
}
-(void)getStarExpertRequest{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"expertClassCode":@"001",
                                                                                       @"lotteryClassCode":@"",
                                                                                       @"curPage":@"1",
                                                                                       @"pageSize":@"3"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportExpertsPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:0];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                }
                [starExpertArym replaceObjectAtIndex:0 withObject:mutableArr];
                [starTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                [basTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                if(starScrollType){
                    starScrollType = NO;
//                    [starTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    [self performSelector:@selector(scrollToTopWithTableView:) withObject:starTable afterDelay:0.1];
                }
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
    }];
}
-(void)getSquareAndRedPersonExpertRequestWithType:(NSString *)type{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"userName":@"",
                                                                                       @"expertClassCode":@"001",//竞彩001  写死
                                                                                       @"lotteyClassCode":@"",
                                                                                       @"type":type,//0广场 1红人
                                                                                       @"orderFlag":@"1",//首页传1
                                                                                       @"currPage":@"1",
                                                                                       @"pageSize":@"3"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportMasterPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:0];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                }
                if([type isEqualToString:@"0"]){
                    [starExpertArym replaceObjectAtIndex:1 withObject:mutableArr];
                    [starTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                }else if([type isEqualToString:@"1"]){
                    [starExpertArym replaceObjectAtIndex:2 withObject:mutableArr];
                    [starTable reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
    }];
}
-(void)getBasketRequestWithPage:(NSString *)page{
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"zjtjIndexService" forKey:@"serviceName"];
    [bodyDic setObject:@"getMasterPlanList" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"userName":nameSty,@"expertClassCode":@"001",@"lotteyClassCode":@"204",@"orderFlag":@"",@"curPage":page,@"pageSize":@"20",@"levelType":@"1",@"sid":[[Info getInstance] cbSID]};
    
    [bodyDic setObject:parametersDic forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
        if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *result=responseJSON[@"result"][@"data"];
            
            if([page isEqualToString:@"1"]){
                [basExpertArym removeAllObjects];
            }
            
            if ([result count]!=0) {
                
                basPage += 1;
                NSMutableArray * mulArr=[NSMutableArray array];
                for (NSDictionary * dic in result) {
                    [mulArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
                }
                [basExpertArym addObjectsFromArray:mulArr];
                [basTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                if(basScrollType){
                    basScrollType = NO;
                    [self performSelector:@selector(scrollToTopWithTableView:) withObject:basTable afterDelay:0.1];
                }
            } else {
                
            }
            if(basExpertArym.count > 0){
                if(_noNewRecommandImageView.superview){
                    [_noNewRecommandImageView removeFromSuperview];
                }
            }
            [basTable reloadData];
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
        
    } failure:^(NSError * error) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
    }];
}
-(void)getRankListExpertRequestWithlotteryClassCode:(NSString *)lotteryClassCode OrderFlag:(NSString *)orderFlag{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"userName":@"",
                                                                                       @"expertClassCode":@"001",//竞彩001  写死
                                                                                       @"lotteryClassCode":lotteryClassCode,
                                                                                       @"orderFlag":orderFlag,
                                                                                       @"currPage":@"1",
                                                                                       @"pageSize":@"3"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportExpertsRankPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:0];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                }
                if([lotteryClassCode isEqualToString:@"-201"]){
                    if([orderFlag isEqualToString:@"0"]){
                        [rankExpertArym replaceObjectAtIndex:0 withObject:mutableArr];
                        [rankTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                        if(rankScrollType){
                            rankScrollType = NO;
//                            [rankTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                            [self performSelector:@selector(scrollToTopWithTableView:) withObject:rankTable afterDelay:0.1];
                        }
                    }else if([orderFlag isEqualToString:@"1"]){
                        [rankExpertArym replaceObjectAtIndex:1 withObject:mutableArr];
                        [rankTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }else if([lotteryClassCode isEqualToString:@"201"]){
                    [rankExpertArym replaceObjectAtIndex:2 withObject:mutableArr];
                    [rankTable reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
    }];
}
-(void)getRaceListExpertRequestWithPage:(NSString *)page WithSource:(NSString *)source{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"sMGExpertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getLeastMatchList" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"currPage":page,@"pageSize":@"50",@"sid":[[Info getInstance] cbSID],@"source":source,@"sdFlag":@"0"};
    
    [bodyDic setObject:parametersDic forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary * bodyData=[responseJSON valueForKey:@"result"];
            NSArray * dataArr = [bodyData objectForKey:@"data"];
            
            if([source isEqualToString:@"1"]){
                if([page isEqualToString:@"1"]){
                    [matchListArym removeAllObjects];
                }
            }else if ([source isEqualToString:@"4"]){
                if([page isEqualToString:@"1"]){
                    [basketListArym removeAllObjects];
                }
            }
            
            if ([dataArr count]!=0) {
                
                if([source isEqualToString:@"1"]){//足彩赛事
                    racePage += 1;
                    NSMutableArray * mulArr=[NSMutableArray array];
                    for (NSDictionary * dic in dataArr) {
                        [mulArr addObject:[MatchVCModel MatchVCModelWithDic:dic]];
                    }
                    [matchListArym addObjectsFromArray:mulArr];
                    [raceTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                    if(raceScrollType){
                        raceScrollType = NO;
                        [self performSelector:@selector(scrollToTopWithTableView:) withObject:raceTable afterDelay:0.1];
                    }
                }else if ([source isEqualToString:@"4"]){//篮彩赛事
                    basketPage += 1;
                    NSMutableArray * mulArr=[NSMutableArray array];
                    for (NSDictionary * dic in dataArr) {
                        [mulArr addObject:[MatchVCModel MatchVCModelWithDic:dic]];
                    }
                    [basketListArym addObjectsFromArray:mulArr];
                    [basketTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                    if(basketScrollType){
                        basketScrollType = NO;
                        [self performSelector:@selector(scrollToTopWithTableView:) withObject:basketTable afterDelay:0.1];
                    }
                }
            } else {
                
            }
            if([source isEqualToString:@"1"]){
                if(matchListArym.count > 0){
                    if(_noNewRecommandImageView.superview){
                        [_noNewRecommandImageView removeFromSuperview];
                    }
                }
            }else if ([source isEqualToString:@"4"]){
                if(basketListArym.count > 0){
                    if(_noNewRecommandImageView.superview){
                        [_noNewRecommandImageView removeFromSuperview];
                    }
                }
            }
        } else {
        }
    } failure:^(NSError * error) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
    }];
}
-(void)getExpertHornRequest{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"zjtjIndexService" forKey:@"serviceName"];
    [bodyDic setObject:@"getCrazySportExpertsContinuousHitUsers" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"currPage":@"1",@"pageSize":@"5",@"lotteryClassCode":@"-201"};
    
    [bodyDic setObject:parametersDic forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary * bodyData=[responseJSON valueForKey:@"result"];
            NSArray * dataArr = [bodyData objectForKey:@"data"];
            if ([dataArr count]!=0) {
                [hornArray removeAllObjects];
                [hornInfoArray removeAllObjects];
                [hornInfoArray addObjectsFromArray:dataArr];
                for (int i = 0; i < dataArr.count; i++) {
                    NSDictionary * dataDic = [dataArr objectAtIndex:i];
                    
                    NSString *level = @"大神";
                    NSString *name = [dataDic valueForKey:@"EXPERTS_NICK_NAME"];
                    NSString *lianzhong = [dataDic valueForKey:@"CONTINUES_HIT"];
                    
                    NSString * hornString = [NSString stringWithFormat:@"恭喜%@%@%@连中",level,name,lianzhong];
                    
//                    NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:hornString];
//                    
//                    [aString setAttributes:@{NSForegroundColorAttributeName:[SharedMethod getColorByHexString:@"ed3f30"],NSFontAttributeName:[UIFont systemFontOfSize:11]} range:[hornString rangeOfString:@"连中消息:"]];
//                    [aString setAttributes:@{NSForegroundColorAttributeName:DEFAULT_TEXTGRAYCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(5, hornString.length-5)];
//                    if (aString && aString.length) {
//                        [hornArray addObject:aString];
//                    }
                    if (hornString && hornString.length) {
                        [hornArray addObject:hornString];
                    }
                }
                
                hornCount = 0;
                
                [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hornLabelRun) object:nil];
                
                if (hornArray && hornArray.count) {
//                    hornLab1.attributedText = [hornArray objectAtIndex:0];
                    hornLab1.text = [hornArray objectAtIndex:0];
                    if (hornArray.count > 1) {
                        [self performSelector:@selector(hornLabelRun) withObject:nil afterDelay:2];
                    }
                }
            } else {
                
            }
        } else {
        }
    } failure:^(NSError * error) {
        [starTable.header endRefreshing];
        [basTable.header endRefreshing];
        [basTable.footer endRefreshing];
        [rankTable.header endRefreshing];
        [raceTable.header endRefreshing];
        [raceTable.footer endRefreshing];
        [basketTable.header endRefreshing];
        [basketTable.footer endRefreshing];
    }];
}
#pragma mark -------------UICollectionViewDelegate--------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return expertListArym.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cellid";
    ExpertCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"-----------------");
    }
    ExpertJingjiModel *model = [expertListArym objectAtIndex:indexPath.row];
    
    [cell.headIma sd_setImageWithURL:[NSURL URLWithString:model.headPortrait] placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    cell.nameLab.text = model.expertsNickName;
    cell.desLab.text = [NSString stringWithFormat:@"近%@中%@",model.totalNum,model.hitNum];
    
    UIImage *image = cell.headIma.image;
    cell.headIma.layer.contents = (__bridge id)image.CGImage;
    cell.headIma.layer.contentsGravity = kCAGravityResizeAspectFill;
    cell.headIma.layer.contentsScale = image.scale;
    cell.headIma.layer.masksToBounds = YES;
    cell.headIma.layer.cornerRadius = 20;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 90);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertJingjiModel *model = [expertListArym objectAtIndex:indexPath.row];
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSString *lotteryClassCode = model.lotteryClassCode;
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":model.expertsName,@"expertsClassCode":model.expertsClassCode,@"loginUserName":nameSty,@"erAgintOrderId":@"",@"type":@"0",@"sdStatus":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":lotteryClassCode} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
        NSArray *arr=responseJSON[@"result"][@"historyPlanList"];
        NSMutableArray *historyArr=[NSMutableArray arrayWithCapacity:[arr count]];
        for (NSDictionary *dicHistoryPlan in arr) {
            HistoryPlanList *hisPlanList=[HistoryPlanList historyPlanListWithDic:dicHistoryPlan];
            [historyArr addObject:hisPlanList];
        }
        dic=responseJSON[@"result"][@"leastTenInfo"];
        LeastTenInfo *leastTenInfo=[LeastTenInfo leastTenInfoWithDic:dic];
        arr=responseJSON[@"result"][@"newPlanList"];
        NSMutableArray *newPlanArr=[NSMutableArray arrayWithCapacity:[arr count]];
        for (NSDictionary *dicNewPlan in arr) {
            NewPlanList *newPlanList=[NewPlanList newPlanListWithDic:dicNewPlan];
            if ([newPlanList.closeStatus isEqualToString:@"1"]) {
                [newPlanArr addObject:newPlanList];
            }
        }
        vc.historyPlanArr=historyArr;
        vc.leastTenInfo=leastTenInfo;
        vc.npList=newPlanArr;
        vc.exBaseInfo=exBase;
        vc.hidesBottomBarWhenPushed=YES;
        vc.segmentOnClickIndexFlags=YES;
        vc.planIDStr=@"";
        vc.jcyplryType=lotteryClassCode;//
        vc.isSdOrNo=NO;//
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * error) {
    }];
}
-(void)manySeniorExpertClick:(UIButton *)button{
    
    ExpertJingjiModel *model = [expertListArym objectAtIndex:button.tag];
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSString *lotteryClassCode = model.lotteryClassCode;
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":model.expertsName,@"expertsClassCode":model.expertsClassCode,@"loginUserName":nameSty,@"erAgintOrderId":@"",@"type":@"0",@"sdStatus":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":lotteryClassCode} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
        NSArray *arr=responseJSON[@"result"][@"historyPlanList"];
        NSMutableArray *historyArr=[NSMutableArray arrayWithCapacity:[arr count]];
        for (NSDictionary *dicHistoryPlan in arr) {
            HistoryPlanList *hisPlanList=[HistoryPlanList historyPlanListWithDic:dicHistoryPlan];
            [historyArr addObject:hisPlanList];
        }
        dic=responseJSON[@"result"][@"leastTenInfo"];
        LeastTenInfo *leastTenInfo=[LeastTenInfo leastTenInfoWithDic:dic];
        arr=responseJSON[@"result"][@"newPlanList"];
        NSMutableArray *newPlanArr=[NSMutableArray arrayWithCapacity:[arr count]];
        for (NSDictionary *dicNewPlan in arr) {
            NewPlanList *newPlanList=[NewPlanList newPlanListWithDic:dicNewPlan];
            if ([newPlanList.closeStatus isEqualToString:@"1"]) {
                [newPlanArr addObject:newPlanList];
            }
        }
        vc.historyPlanArr=historyArr;
        vc.leastTenInfo=leastTenInfo;
        vc.npList=newPlanArr;
        vc.exBaseInfo=exBase;
        vc.hidesBottomBarWhenPushed=YES;
        vc.segmentOnClickIndexFlags=YES;
        vc.planIDStr=@"";
        vc.jcyplryType=lotteryClassCode;//
        vc.isSdOrNo=NO;//
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * error) {
    }];
}
#pragma mark 查看是否变盘接口
-(void)getChangeSPRequest{
    
    NSString *message = [NSString stringWithFormat:@"您购买的推荐与当前盘口不符，是否确认支付(%.2f元)购买此方案内容",disPrice];
//#ifdef CRAZYSPORTS
//    message = [NSString stringWithFormat:@"您购买的推荐与当前盘口不符，是否确认支付(%.0f金币)购买此方案内容",disPrice];
//#endif
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:@{@"erAgintOrderId":erAgintOrderId}];
    NSMutableDictionary *bodDic4=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPlanSpIsChange",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        
        if([[JSON valueForKey:@"resultCode"] isEqualToString:@"0000"]){
            NSDictionary *dic=JSON[@"result"];
            NSString *changeStatus = [dic valueForKey:@"changeStatus"];
            if([changeStatus isEqualToString:@"1"]){//1变盘
                CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付提示"
                                                         message:message
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
                
                
                _cpAlert.alertTpye=purchasePaln;
                _cpAlert.tag=601;
                [_cpAlert show];
            }else{
                [self addDealPurchaseTicket:disPrice tag:601];
            }
            
        }else{
            
        }
        
    } failure:^(NSError * error) {
        
    }];
}
#pragma mark -------------UITableViewDelegate--------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == headerTable){
        return 0;
    }
    if(tableView == starTable){
        NSArray *ary = [starExpertArym objectAtIndex:section];
        
        return ary.count;
    }
    if(tableView == basTable){
        return basExpertArym.count;
    }
    if(tableView == rankTable){
        NSArray *ary = [rankExpertArym objectAtIndex:section];
        
        return ary.count;
    }if(tableView == raceTable){
        
        return matchListArym.count;
    }
    if(tableView == basketTable){
        
        return basketListArym.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == headerTable){
        return 1;
    }
    if(tableView == starTable){
        
        return starExpertArym.count;
    }
    if(tableView == basTable){
        
        return 1;
    }
    if(tableView == rankTable){
        
        return rankExpertArym.count;
    }if(tableView == raceTable || tableView == basketTable){
        
        return 1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == headerTable){
        return 35;
    }
    if(tableView == starTable){
        
        return 30;
    }
    if(tableView == rankTable ){
        
        return 30;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == headerTable){
        return _changeTypeView;
    }
    if(tableView == starTable || tableView == rankTable){
        NSArray *ary;
        NSInteger index = 0;
        if(tableView == starTable){
            ary = [NSArray arrayWithObjects:@"名人推荐",@"喂饼广场",@"蹿红新秀", nil];
        }
        if(tableView == rankTable){
            ary = [NSArray arrayWithObjects:@"命中榜",@"回报榜",@"串关榜", nil];
            index = 10;
        }
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, 320, 30);
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(15, 0, 100, 30);
        lab.backgroundColor = [UIColor clearColor];
        lab.text = [ary objectAtIndex:section];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = BLACK_EIGHTYSEVER;
        [view addSubview:lab];
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(self.mainView.frame.size.width-60, 0, 60, 30);
        moreBtn.backgroundColor = [UIColor clearColor];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        moreBtn.tag = section + 10 + index;
        [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        [moreBtn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
        [view addSubview:moreBtn];
        
        UIImageView *lineIma = [[UIImageView alloc]init];
        lineIma.frame = CGRectMake(0, 29.5, self.mainView.frame.size.width, 0.5);
        lineIma.backgroundColor = SEPARATORCOLOR;
        [view addSubview:lineIma];
        
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == starTable){
//        return 95;
        NSArray *ary = [starExpertArym objectAtIndex:indexPath.section];
        ExpertMainListModel *model = [ary objectAtIndex:indexPath.row];
        if(indexPath.section == 0){
            if([model.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
                return 135;
            }
            return 95;
        }else{
            if([model.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
                return 150;
            }
            return 110;
        }
    }else if (tableView == basTable){
        return 75;
    }else if (tableView == rankTable){
        NSArray *ary = [rankExpertArym objectAtIndex:indexPath.section];
        ExpertMainListModel *model = [ary objectAtIndex:indexPath.row];
        if([model.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
            return 150;
        }
        return 110;
    }else if (tableView == raceTable){
        return 55;
    }else if (tableView ==  basketTable){
        return 55;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == headerTable){
        NSString * cellID = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }else if (tableView == starTable){
        
        NSString * starCell = @"starCell";
        ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:starCell];
        if (!cell) {
            cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:starCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *ary = [starExpertArym objectAtIndex:indexPath.section];
        ExpertMainListModel *model = [ary objectAtIndex:indexPath.row];
        
        cell.isZhuanjia = NO;
        if(indexPath.section == 0){
            cell.isZhuanjia = YES;
        }
        __block ExpertNewMainViewController * newSelf = self;
        cell.buttonAction = ^(UIButton *button) {
            
            [newSelf getIsBuyInfoWithOrderID:model];
        };
        
        [cell loadAppointInfo:model];
        
        return cell;
    }else if (tableView == basTable){
        
        NSString * basCell = @"basCell";
        ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:basCell];
        if (!cell) {
            cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:basCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        ExpertJingjiModel *model = [basExpertArym objectAtIndex:indexPath.row];
        
        __block ExpertNewMainViewController * newSelf = self;
        cell.buttonAction = ^(UIButton *button) {
            
            [newSelf getBasketIsBuyInfoWithOrderID:model];
        };
        
        [cell loadCSBasketExpertListInfo:model];
        
        return cell;
    }else if (tableView == rankTable){
        
        static NSString * rankCell = @"rankCell";
        ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rankCell];
        if (!cell) {
            cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rankCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *ary = [rankExpertArym objectAtIndex:indexPath.section];
        ExpertMainListModel *model = [ary objectAtIndex:indexPath.row];
        cell.isZhuanjia = NO;
        cell.rankingIma.hidden = YES;
        [cell loadAppointInfo:model];
        
        __block ExpertNewMainViewController * newSelf = self;
        cell.buttonAction = ^(UIButton *button) {
            
            [newSelf getIsBuyInfoWithOrderID:model];
        };
        
        return cell;
    }else if (tableView == raceTable){
        
        NSString * raceCell = @"raceCell";
        ExpertRaceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:raceCell];
        if (!cell) {
            cell = [[ExpertRaceListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:raceCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MatchVCModel *model=[matchListArym objectAtIndex:indexPath.row];
        [cell loadAppointInfo:model];
        return cell;
    }
    else if (tableView == basketTable){
        
        NSString * basketCell = @"basketCell";
        ExpertRaceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:basketCell];
        if (!cell) {
            cell = [[ExpertRaceListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:basketCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MatchVCModel *model=[basketListArym objectAtIndex:indexPath.row];
        [cell loadAppointInfo:model];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == raceTable){
        
        MatchDetailVC * vc=[[MatchDetailVC alloc] init];
        MatchVCModel *model;
        model=[matchListArym objectAtIndex:indexPath.row];
        
        vc.playId=[model playId];
        vc.matchModel=model;
        vc.matchSource=@"-201";//新版全部是竞彩   没有亚盘
        vc.source = model.source;
        vc.isSdOrNo=NO;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tableView == basketTable){
        MatchDetailVC * vc=[[MatchDetailVC alloc] init];
        MatchVCModel *model;
        model=[basketListArym objectAtIndex:indexPath.row];
        
        vc.playId=[model playId];
        vc.matchModel=model;
        vc.matchSource=@"204";//篮彩
        vc.source = model.source;
        vc.isSdOrNo=NO;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tableView == starTable || tableView == rankTable || tableView == basTable){
        
        NSLog(@"单击了某个方案响应函数");
        ExpertMainListModel *model;
        if(tableView == starTable){
            model = [[starExpertArym objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }else if (tableView == basTable){
            model = [basExpertArym objectAtIndex:indexPath.row];
        }
        else{
            model = [[rankExpertArym objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }
//        if(tableView == basTable){
//            ExpertJingjiModel *basModel = [basExpertArym objectAtIndex:indexPath.row];
//            model.EXPERTS_NAME = basModel.EXPERTS_NAME;
//            model.EXPERTS_CLASS_CODE = basModel.EXPERTS_CLASS_CODE;
//            model.ER_AGINT_ORDER_ID = basModel.ER_AGINT_ORDER_ID;
//            model.LOTTEY_CLASS_CODE = basModel.LOTTEY_CLASS_CODE;
//        }
        
        Info *info = [Info getInstance];
        NSString *nameSty=@"";
        if ([info.userId intValue]) {
            nameSty=[[Info getInstance] userName];
        }
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"expertsName":model.EXPERTS_NAME,@"expertsClassCode":model.EXPERTS_CLASS_CODE,@"loginUserName":nameSty,@"erAgintOrderId":model.ER_AGINT_ORDER_ID,@"type":@"0",@"sdStatus":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":model.LOTTEY_CLASS_CODE} forKey:@"parameters"];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"responseJSON=%@",responseJSON);
            SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
            NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
            ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
            NSArray *arr=responseJSON[@"result"][@"historyPlanList"];
            NSMutableArray *historyArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary *dicHistoryPlan in arr) {
                HistoryPlanList *hisPlanList=[HistoryPlanList historyPlanListWithDic:dicHistoryPlan];
                [historyArr addObject:hisPlanList];
            }
            dic=responseJSON[@"result"][@"leastTenInfo"];
            LeastTenInfo *leastTenInfo=[LeastTenInfo leastTenInfoWithDic:dic];
            arr=responseJSON[@"result"][@"newPlanList"];
            NSMutableArray *newPlanArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary *dicNewPlan in arr) {
                NewPlanList *newPlanList=[NewPlanList newPlanListWithDic:dicNewPlan];
                if ([newPlanList.closeStatus isEqualToString:@"1"]) {
                    [newPlanArr addObject:newPlanList];
                }
            }
            vc.historyPlanArr=historyArr;
            vc.leastTenInfo=leastTenInfo;
            vc.npList=newPlanArr;
            vc.exBaseInfo=exBase;
            vc.hidesBottomBarWhenPushed=YES;
            vc.segmentOnClickIndexFlags=YES;
            vc.planIDStr=model.ER_AGINT_ORDER_ID;
            vc.jcyplryType=model.LOTTEY_CLASS_CODE;//
            vc.isSdOrNo=NO;//
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError * error) {
        }];
    }
}
-(void)changeCollectionType:(UIButton *)button
{
    for (int i = 0; i < _typeNameArray.count; i++) {
        UIButton * typeButton = [_changeTypeView viewWithTag:100 + i];
        UIView * redLineView = [typeButton viewWithTag:1000];
        if (typeButton == button) {
            typeButton.selected = YES;
            redLineView.hidden = NO;
            if (mainScro.contentOffset.x != MyWidth * (button.tag - 100)) {
                [mainScro setContentOffset:CGPointMake(MyWidth * (button.tag - 100), mainScro.contentOffset.y) animated:YES];
            }
        }else{
            typeButton.selected = NO;
            redLineView.hidden = YES;
        }
    }
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"~~~~~~1");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"~~~~~~2");
    if (scrollView == mainScro) {
    }
    else if (scrollView == starTable || scrollView == basTable || scrollView == rankTable || scrollView == raceTable || scrollView == basketTable) {
        if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
            if (scrollView == starTable) {
                [starHeaderView addSubview:headerTable];
            }
            else if (scrollView == basTable) {
                [basHeaderView addSubview:headerTable];
            }
            else if (scrollView == rankTable) {
                [rankHeaderView addSubview:headerTable];
            }
            else if (scrollView == raceTable) {
                [raceHeaderView addSubview:headerTable];
            }
            else if (scrollView == basketTable) {
                [basketHeaderView addSubview:headerTable];
            }
            headerTable.frame = CGRectMake(headerTable.frame.origin.x, 0, headerTable.frame.size.width, headerTable.frame.size.height);
        }
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"~~~~~~4");
    
    if (scrollView == mainScro) {
        
        if(mainScro.contentOffset.x < MyWidth*2){
            _changeTypeView.contentOffset = CGPointMake(0, 0);
        }
        if(mainScro.contentOffset.x > MyWidth*2){
            _changeTypeView.contentOffset = CGPointMake(80, 0);
        }
        
        UIButton *  button = [_changeTypeView viewWithTag:100 + scrollView.contentOffset.x/MyWidth];
        
        for (int i = 0; i < _typeNameArray.count; i++) {
            UIButton * typeButton = [_changeTypeView viewWithTag:100 + i];
            UIView * redLineView = [typeButton viewWithTag:1000];
            if (typeButton == button) {
                typeButton.selected = YES;
                redLineView.hidden = NO;
            }else{
                typeButton.selected = NO;
                redLineView.hidden = YES;
            }
        }
        
        [self setNoInfoViewWithScrollview:scrollView];
        
        if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
            if (scrollView.contentOffset.x/MyWidth == 0) {
                [starHeaderView addSubview:headerTable];
            }
            else if (scrollView.contentOffset.x/MyWidth == 1) {
                [basHeaderView addSubview:headerTable];
            }
            else if (scrollView.contentOffset.x/MyWidth == 2) {
                [rankHeaderView addSubview:headerTable];
            }
            else if (scrollView.contentOffset.x/MyWidth == 3) {
                [raceHeaderView addSubview:headerTable];
            }
            else if (scrollView.contentOffset.x/MyWidth == 4) {
                [basketHeaderView addSubview:headerTable];
            }
            headerTable.frame = CGRectMake(headerTable.frame.origin.x, 0, headerTable.frame.size.width, headerTable.frame.size.height);
        }
    }
    else if (scrollView == starTable || scrollView == basTable || scrollView == rankTable || scrollView == raceTable || scrollView == basketTable) {
        if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
            if (scrollView == starTable) {
                [starHeaderView addSubview:headerTable];
            }
            else if (scrollView == basTable) {
                [basHeaderView addSubview:headerTable];
            }
            else if (scrollView == rankTable) {
                [rankHeaderView addSubview:headerTable];
            }
            else if (scrollView == raceTable) {
                [raceHeaderView addSubview:headerTable];
            }
            else if (scrollView == basketTable) {
                [basketHeaderView addSubview:headerTable];
            }
            headerTable.frame = CGRectMake(headerTable.frame.origin.x, 0, headerTable.frame.size.width, headerTable.frame.size.height);
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollView.contentOffset.y==%f",scrollView.contentOffset.y);
    if (scrollView == starTable || scrollView == basTable || scrollView == rankTable || scrollView == raceTable || scrollView == basketTable) {
        if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
            if (scrollView == starTable) {
                if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
                    basTable.contentOffset = CGPointMake(0, starTable.contentOffset.y);
                    rankTable.contentOffset = CGPointMake(0, starTable.contentOffset.y);
                    raceTable.contentOffset = CGPointMake(0, starTable.contentOffset.y);
                    basketTable.contentOffset = CGPointMake(0, starTable.contentOffset.y);
                }
            }
            else if (scrollView == basTable) {
                if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
                    starTable.contentOffset = CGPointMake(0, basTable.contentOffset.y);
                    rankTable.contentOffset = CGPointMake(0, basTable.contentOffset.y);
                    raceTable.contentOffset = CGPointMake(0, basTable.contentOffset.y);
                    basketTable.contentOffset = CGPointMake(0, basTable.contentOffset.y);
                }
            }
            else if (scrollView == rankTable) {
                if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
                    starTable.contentOffset = CGPointMake(0, rankTable.contentOffset.y);
                    basTable.contentOffset = CGPointMake(0, rankTable.contentOffset.y);
                    raceTable.contentOffset = CGPointMake(0, rankTable.contentOffset.y);
                    basketTable.contentOffset = CGPointMake(0, rankTable.contentOffset.y);
                }
            }
            else if (scrollView == raceTable) {
                if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
                    starTable.contentOffset = CGPointMake(0, raceTable.contentOffset.y);
                    basTable.contentOffset = CGPointMake(0, raceTable.contentOffset.y);
                    rankTable.contentOffset = CGPointMake(0, raceTable.contentOffset.y);
                    basketTable.contentOffset = CGPointMake(0, raceTable.contentOffset.y);
                }
            }
            else if (scrollView == basketTable) {
                if (headerTable.frame.origin.y > -_changeTypeView.frame.origin.y) {
                    starTable.contentOffset = CGPointMake(0, basketTable.contentOffset.y);
                    basTable.contentOffset = CGPointMake(0, basketTable.contentOffset.y);
                    rankTable.contentOffset = CGPointMake(0, basketTable.contentOffset.y);
                    raceTable.contentOffset = CGPointMake(0, basketTable.contentOffset.y);
                }
            }
        }
        
        if (scrollView.contentOffset.y == 0) {
            [self performSelector:@selector(changeRefreshType) withObject:nil afterDelay:0.4];
        }
        if (starTable.header.state == MJRefreshStateRefreshing || rankTable.header.state == MJRefreshStateRefreshing || raceTable.header.state == MJRefreshStateRefreshing || basketTable.header.state == MJRefreshStateRefreshing || basTable.header.state == MJRefreshStateRefreshing) {
            _refresh = YES;
        }
        
        NSLog(@"^^^^^^^^^^^^^^%f~~~~~~~~%f~~~~~%d-------%f",-scrollView.contentOffset.y,headerTable.frame.origin.y,[self.mainView.subviews containsObject:headerTable],scrollView.contentInset.top);
        if (!_refresh) {
            [self.mainView addSubview:headerTable];
            
            if (scrollView.contentOffset.y > headerTable.frame.size.height - _changeTypeView.frame.size.height) {
                headerTable.frame = CGRectMake(headerTable.frame.origin.x, _changeTypeView.frame.size.height - headerTable.frame.size.height, headerTable.frame.size.width, headerTable.frame.size.height);
            }else{
                headerTable.frame = CGRectMake(headerTable.frame.origin.x, -scrollView.contentOffset.y , headerTable.frame.size.width, headerTable.frame.size.height);
            }
            
        }
    }
    else if (scrollView == mainScro) {
        
        if (scrollView.contentOffset.y >= 0) {
            [self.mainView addSubview:headerTable];
            
            if (headerTable.frame.origin.y <= -_changeTypeView.frame.origin.y) {
                headerTable.frame = CGRectMake(headerTable.frame.origin.x, _changeTypeView.frame.size.height - headerTable.frame.size.height, headerTable.frame.size.width, headerTable.frame.size.height);
            }else{
                headerTable.frame = CGRectMake(headerTable.frame.origin.x, -starTable.contentOffset.y, headerTable.frame.size.width, headerTable.frame.size.height);
            }
        }
        
        [self setNoInfoViewWithScrollview:scrollView];
    }
}
-(void)changeRefreshType
{
    _refresh = NO;
}
-(void)setNoInfoViewWithScrollview:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x/MyWidth == 1) {
        if(basExpertArym.count == 0){
            _noNewRecommandImageView.frame = CGRectMake((self.view.frame.size.width-75)/2.0, basTable.frame.size.height-150, 75, 100);
            [basTable addSubview:_noNewRecommandImageView];
        }else if(_noNewRecommandImageView.superview){
            [_noNewRecommandImageView removeFromSuperview];
        }
    }
    else if (scrollView.contentOffset.x/MyWidth == 3) {
        if(matchListArym.count == 0){
            _noNewRecommandImageView.frame = CGRectMake((self.view.frame.size.width-75)/2.0, basTable.frame.size.height-150, 75, 100);
            [raceTable addSubview:_noNewRecommandImageView];
        }else if(_noNewRecommandImageView.superview){
            [_noNewRecommandImageView removeFromSuperview];
        }
    }
    else if (scrollView.contentOffset.x/MyWidth == 4) {
        if(basketListArym.count == 0){
            _noNewRecommandImageView.frame = CGRectMake((self.view.frame.size.width-75)/2.0, basTable.frame.size.height-150, 75, 100);
            [basketTable addSubview:_noNewRecommandImageView];
        }else if(_noNewRecommandImageView.superview){
            [_noNewRecommandImageView removeFromSuperview];
        }
    }
}
-(void)hornLabelRun
{
    int nextTag = hornCount + 1;
    if (nextTag == hornArray.count) {
        nextTag = 0;
    }
//    hornLab1.attributedText = [hornArray objectAtIndex:hornCount];
//    hornLab2.attributedText = [hornArray objectAtIndex:nextTag];
    hornLab1.text = [hornArray objectAtIndex:hornCount];
    hornLab2.text = [hornArray objectAtIndex:nextTag];
    
    [UIView animateWithDuration:1 animations:^{
        hornLab1.mj_y = -35;
        hornLab2.mj_y = 0;
    } completion:^(BOOL finished) {
        
        hornLab1.mj_y = 0;
        hornLab2.mj_y = 35;
//        hornLab1.attributedText = [hornArray objectAtIndex:nextTag];
        hornLab1.text = [hornArray objectAtIndex:nextTag];
        
        [self performSelector:@selector(hornLabelRun) withObject:nil afterDelay:2];
        hornCount++;
        if (hornCount == hornArray.count) {
            hornCount = 0;
        }
    }];
}
-(void)hornAction:(UITapGestureRecognizer *)tap{
    if(hornCount < hornInfoArray.count){
        NSDictionary *dict = [hornInfoArray objectAtIndex:hornCount];
        NSString *name = [dict valueForKey:@"EXPERTS_NAME"];
        
        Info *info = [Info getInstance];
        NSString *nameSty=@"";
        if ([info.userId intValue]) {
            nameSty=[[Info getInstance] userName];
        }
        NSString *lotteryClassCode = @"";
        NSString *EXPERTS_CLASS_CODE = @"";
        
        if([[dict valueForKey:@"LOTTERY_CLASS_CODE"] length] > 0 && ![[dict valueForKey:@"LOTTERY_CLASS_CODE"] isEqualToString:@"null"]){
            lotteryClassCode = [dict valueForKey:@"LOTTERY_CLASS_CODE"];
        }
        if([[dict valueForKey:@"EXPERTS_CLASS_CODE"] length] > 0 && ![[dict valueForKey:@"EXPERTS_CLASS_CODE"] isEqualToString:@"null"]){
            EXPERTS_CLASS_CODE = [dict valueForKey:@"EXPERTS_CLASS_CODE"];
        }
        
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"expertsName":name,@"expertsClassCode":EXPERTS_CLASS_CODE,@"loginUserName":nameSty,@"erAgintOrderId":@"",@"type":@"0",@"sdStatus":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":lotteryClassCode} forKey:@"parameters"];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"responseJSON=%@",responseJSON);
            SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
            NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
            ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
            NSArray *arr=responseJSON[@"result"][@"historyPlanList"];
            NSMutableArray *historyArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary *dicHistoryPlan in arr) {
                HistoryPlanList *hisPlanList=[HistoryPlanList historyPlanListWithDic:dicHistoryPlan];
                [historyArr addObject:hisPlanList];
            }
            dic=responseJSON[@"result"][@"leastTenInfo"];
            LeastTenInfo *leastTenInfo=[LeastTenInfo leastTenInfoWithDic:dic];
            arr=responseJSON[@"result"][@"newPlanList"];
            NSMutableArray *newPlanArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary *dicNewPlan in arr) {
                NewPlanList *newPlanList=[NewPlanList newPlanListWithDic:dicNewPlan];
                if ([newPlanList.closeStatus isEqualToString:@"1"]) {
                    [newPlanArr addObject:newPlanList];
                }
            }
            vc.historyPlanArr=historyArr;
            vc.leastTenInfo=leastTenInfo;
            vc.npList=newPlanArr;
            vc.exBaseInfo=exBase;
            vc.hidesBottomBarWhenPushed=YES;
            vc.segmentOnClickIndexFlags=YES;
            vc.planIDStr=@"";
            vc.jcyplryType=lotteryClassCode;//
            vc.isSdOrNo=NO;//
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError * error) {
        }];
    }
}
-(void)moreAction:(UIButton *)button{
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]){
        [self toLogin];
        return;
    }
    NSLog(@"morebutton%ld",(long)button.tag);
    if(button.tag == 10 || button.tag == 11 || button.tag == 12){
        ExpertStarListViewController *vc = [[ExpertStarListViewController alloc]init];
        if(button.tag == 10){
            vc.expertType = expertStarType;
        }else if (button.tag == 11){
            vc.expertType = expertSquareType;
        }else if (button.tag == 12){
            vc.expertType = expertRedType;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 20 || button.tag == 21 || button.tag == 22){
        ExpertRankListViewController *vc = [[ExpertRankListViewController alloc]init];
        if(button.tag == 20){
            vc.expertType = expertMingzhongType;
        }else if (button.tag == 21){
            vc.expertType = expertHuibaoType;
        }else if (button.tag == 22){
            vc.expertType = expertChuanguanType;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)scroToChannelWithType:(NSString *)type{
    
    UIButton * typeButton;
    if([type isEqualToString:@"1"]){
        typeButton = [_changeTypeView viewWithTag:100];
        [self changeCollectionType:typeButton];
        NSArray *ary = [starExpertArym objectAtIndex:0];
        if(!ary.count){
            starScrollType = YES;
        }else{
            [starTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }else if ([type isEqualToString:@"5"]){
        typeButton = [_changeTypeView viewWithTag:101];
        [self changeCollectionType:typeButton];
        NSArray *ary = [starExpertArym objectAtIndex:0];
        if(!ary.count){
            basScrollType = YES;
        }else{
            [basTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }else if ([type isEqualToString:@"2"]){
        typeButton = [_changeTypeView viewWithTag:102];
        [self changeCollectionType:typeButton];
        NSArray *ary = [rankExpertArym objectAtIndex:0];
        if(!ary.count){
            rankScrollType = YES;
        }else{
            [rankTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }else if ([type isEqualToString:@"3"]){
        typeButton = [_changeTypeView viewWithTag:103];
        [self changeCollectionType:typeButton];
        if(!matchListArym.count){
            raceScrollType = YES;
        }else{
            [raceTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }else if ([type isEqualToString:@"4"]){
        typeButton = [_changeTypeView viewWithTag:104];
        [self changeCollectionType:typeButton];
        if(!matchListArym.count){
            basketScrollType = YES;
        }else{
            [basketTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}
-(void)scrollToTopWithTableView:(UITableView *)tableview{
    [tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)getBasketIsBuyInfoWithOrderID:(ExpertJingjiModel *)data{//获取是否购买
    
    isBasket = NO;
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]){
        [self toLogin];
        return;
    }
    erAgintOrderId = data.ER_AGINT_ORDER_ID;
    disPrice = data.GOLDDISCOUNTPRICE / 10.0;
//    disPrice = data.PRICE;
//#ifdef CRAZYSPORTS
//    disPrice = data.GOLDDISCOUNTPRICE;
//#endif
    [MobClick event:@"Zj_fangan_20161014_jingcai_fangan" label:[NSString stringWithFormat:@"%@VS%@",data.HOME_NAME,data.AWAY_NAME]];
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"verifyIsBuyPlanByUserNameErAgintOrderId" forKey:@"methodName"];
    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"er_agint_order_id":data.ER_AGINT_ORDER_ID} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        NSDictionary *dict = responseJSON[@"result"];//返回编码: 0000：已经购买; 0400:没有购买
        if ([[dict valueForKey:@"code"] isEqualToString:@"0000"]) {
            
            ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
            proVC.erAgintOrderId=data.ER_AGINT_ORDER_ID;
            proVC.pdLotryType = @"-201";
            if([data.LOTTEY_CLASS_CODE isEqualToString:@"204"]){
                proVC.pdLotryType=@"204";
            }
            proVC.isSdOrNo=NO;
            [self.navigationController pushViewController:proVC animated:YES];
            
        }else if([[dict valueForKey:@"code"] isEqualToString:@"0400"]){
            isBasket = YES;
            [self getChangeSPRequest];
//            [self addDealPurchaseTicket:disPrice tag:601];
        }
    } failure:^(NSError * error) {
        
    }];
}
-(void)getIsBuyInfoWithOrderID:(ExpertMainListModel *)data{//获取是否购买
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]){
        [self toLogin];
        return;
    }
    erAgintOrderId = data.ER_AGINT_ORDER_ID;
    disPrice = data.DISCOUNTPRICE;
//#ifdef CRAZYSPORTS
//    disPrice = [data.GOLDDISCOUNTPRICE floatValue];
//#endif
    [MobClick event:@"Zj_fangan_20161014_jingcai_fangan" label:[NSString stringWithFormat:@"%@VS%@",data.HOME_NAME1,data.AWAY_NAME1]];
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"verifyIsBuyPlanByUserNameErAgintOrderId" forKey:@"methodName"];
    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"er_agint_order_id":data.ER_AGINT_ORDER_ID} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        NSDictionary *dict = responseJSON[@"result"];//返回编码: 0000：已经购买; 0400:没有购买
        if ([[dict valueForKey:@"code"] isEqualToString:@"0000"]) {
            
            ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
            proVC.erAgintOrderId=data.ER_AGINT_ORDER_ID;
            proVC.pdLotryType = @"-201";
            proVC.isSdOrNo=NO;
            [self.navigationController pushViewController:proVC animated:YES];
            
        }else if([[dict valueForKey:@"code"] isEqualToString:@"0400"]){
            [self addDealPurchaseTicket:disPrice tag:601];
        }
    } failure:^(NSError * error) {
        
    }];
}
- (void)addDealPurchaseTicket:(float)str tag:(NSInteger)tag{
//#ifdef CRAZYSPORTS
//    int jinbibeishu = 10;//金币和钱比例
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
//        jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
//    }
//    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
//                                                             message:[NSString stringWithFormat:@"您将支付(%.0f金币)购买此方案内容",str]
//                                                            delegate:self
//                                                   cancelButtonTitle:@"取消"
//                                                   otherButtonTitles:@"确定", nil];
//#else
//    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
//                                                             message:[NSString stringWithFormat:@"您将支付(%.2f元)购买此推荐",str]
//                                                            delegate:self
//                                                   cancelButtonTitle:@"取消"
//                                                   otherButtonTitles:@"确定", nil];
//#endif
    
    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
                                                             message:[NSString stringWithFormat:@"您将支付(%.2f元)购买此方案内容",str]
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定", nil];
    _cpAlert.alertTpye=purchasePaln;
    _cpAlert.tag=tag;
    [_cpAlert show];
}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message
{
    if (buttonIndex==1&&(alertView.tag==601||alertView.tag==604)) {
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getLoginUserInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName]} forKey:@"parameters"];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"responseJSON=%@",responseJSON);
            if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]) {
                NSDictionary * resultDic = [responseJSON objectForKey:@"result"];
                float balance=[[resultDic objectForKey:@"userValidFee"] floatValue];
                if (0 && disPrice>balance) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您的余额不足请及时充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag=602;
                    [alert show];
                }else{
                    
                    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
                    [bodyDic setObject:@"commonExpertService" forKey:@"serviceName"];
                    [bodyDic setObject:@"buyPlan" forKey:@"methodName"];
#ifdef CRAZYSPORTS
                    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":erAgintOrderId,@"orderSource":@"10002000",@"payType":@"1",@"clientType":@"2",@"publishVersion":APPVersion,@"isNew":@"1"} forKey:@"parameters"];
#else
                    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":erAgintOrderId,@"orderSource":@"10002000",@"clientType":@"2",@"publishVersion":APPVersion,@"isNew":@"1"} forKey:@"parameters"];
#endif
                    
                    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
                        NSLog(@"responseJSON=%@",responseJSON);
                        if([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]){
                            if([[[responseJSON objectForKey:@"result"] objectForKey:@"code"] isEqualToString:@"0000"]){
                                [MobClick event:@"Zj_fangan_20161014_jingcai_ok" label:nil];
                                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"支付成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                alert.tag=603;
                                [alert show];
                            }
                            else if([[[responseJSON objectForKey:@"result"] objectForKey:@"code"] isEqualToString:@"0301"]){
                                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您的余额不足请及时充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                alert.tag=602;
                                [alert show];
                            }
                            else{
                                [MobClick event:@"Zj_fangan_20161014_jingcai_loss" label:[[responseJSON objectForKey:@"result"] objectForKey:@"info"]];
                                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[[responseJSON objectForKey:@"result"] objectForKey:@"info"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                        }else{
                            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    } failure:^(NSError * error) {
                        
                    }];
                }
            }
        } failure:^(NSError * error) {
            
        }];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==602){
        if (buttonIndex==1) {
            Expert365Bridge * bridge = [[Expert365Bridge alloc] init];
            [bridge toRechargeFromController:self];
        }
    }else if (alertView.tag==603) {
        
        ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
        proVC.erAgintOrderId=erAgintOrderId;
        proVC.pdLotryType=@"201";
        if(isBasket){
            proVC.pdLotryType=@"204";
        }
        proVC.isSdOrNo=NO;
        //        _nPlanBtn.paidStatus=@"1";
        [self.navigationController pushViewController:proVC animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    