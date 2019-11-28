//
//  RankListVc.m
//  caibo
//
//  Created by zhoujunwang on 15/12/29.
//
//

#import "RankListVc.h"
#import "MLNavigationController.h"
#import "RankListCell.h"
#import "ClassifyCell.h"
#import "RankListM.h"
#import "SMGDetailViewController.h"
#import "SharedMethod.h"
#import "MobClick.h"
#import "ExpertMainListModel.h"
#import "ExpertMainListTableViewCell.h"

#define NORMALCOLOR [UIColor colorWithRed:170.0/255 green:218.0/255 blue:252.0/255 alpha:1.0]
#define SELECTCOLOR [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]

@interface RankListVc ()<UITableViewDataSource,UITableViewDelegate>{
@private NSInteger rankLisTag;//根据命中率、热度、回报率显示表格
@private NSInteger selectClassifyTag;//选中分类tag
@private NSInteger jCutPage;
@private NSInteger yCutPage;
}

@property(nonatomic,strong)UIButton *jingPaiHBBtn;//竞彩Btn
@property(nonatomic,strong)UIButton *yapanPaiHBBtn;//亚盘Btn

@property(nonatomic,strong)UIScrollView *rankScroll;

@property(nonatomic,strong)UITableView *jcRkTable;//专家列表
@property(nonatomic,strong)UITableView *ypRkTable;//专家列表

@property(nonatomic,strong)UITableView *classifyTable;//分类列表
@property(nonatomic,strong)ClassifyCell *selectCell;//选中的行

@property(nonatomic,strong)UIButton *firstBtn;//命中率Btn
@property(nonatomic,strong)UIButton *secondBtn;//周期Btn
@property(nonatomic,strong)UIButton *thirdBtn;//全选或单选Btn
@property(nonatomic,strong)UIButton *fourthBtn;//命中率Btn
@property(nonatomic,strong)UIButton *fifBtn;//周期Btn

@property(nonatomic,strong)UIImageView *firstLine;
@property(nonatomic,strong)UIImageView *secondLine;
@property(nonatomic,strong)UIImageView *thirdLine;

@property(nonatomic,strong)UIImageView *touYing;

@property(nonatomic,strong)UIButton *selectBtn;//选中的button

@property(nonatomic,strong)NSMutableArray *classyArr;//分类数组

@property(nonatomic,strong)NSMutableArray *jcRkArr;//获取的排行榜专家数据
@property(nonatomic,strong)NSMutableArray *ypRkArr;

@property(nonatomic,strong)NSString *expertsType;//专家类型选择
@property(nonatomic,strong)NSString *weekListType;//周榜选择
@property(nonatomic,strong)NSString *choiceType;//选球类型选择

@property(nonatomic,strong)NSString *selectedBtnStr;//选中btn的title

@property(nonatomic,strong) UIView *noRankView;

@end

@implementation RankListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#if !defined YUCEDI && !defined DONGGEQIU
    [self creatNavView];
    [self.popBackBtn setFrame:CGRectMake(0, 0, 48, 64)];
    [self.popBackBtn setImageEdgeInsets:UIEdgeInsetsMake(HEIGHTBELOESYSSEVER+15, 15, 14, 21)];
#endif
    
    rankLisTag=HITAG;
    selectClassifyTag=601;
    _weekListType=@"1";
    _expertsType=@"-201";
    _choiceType=@"1";
    jCutPage=1;
    yCutPage=2;
    
    [self selectSort];
    
    [self creatRankListTable];//创建排行榜列表
    
    [self creatClassifyTable];//创建分类列表
    
    [self requestRankList:1];//请求接口
}

- (void)selectSort{
    
    NSString *btnText=@"";
    UIButton *btn;
    for (int i=0; i<2; i++) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(27+(MyWidth-62)/2*i, HEIGHTBELOESYSSEVER, (MyWidth-62)/2, 44)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:170.0/255.0 green:218.0/255.0 blue:252.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        if (i==0) {
            btn.selected=YES;
            _jingPaiHBBtn=btn;
            btnText=@"竞足";
        }else if(i==1){
            _yapanPaiHBBtn=btn;
//            btnText=@"亚盘";
            btnText=@"二串一";
        }
        [btn setTitle:btnText forState:UIControlStateNormal];
        [btn setTitle:btnText forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnPaiHBClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=FONTTHIRTY;
        [self.navView addSubview:btn];
        
        _rankScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44-49)];
        _rankScroll.backgroundColor=[UIColor clearColor];
        _rankScroll.showsHorizontalScrollIndicator=NO;
        _rankScroll.showsVerticalScrollIndicator=NO;
        _rankScroll.contentSize=CGSizeMake(2*MyWidth, MyHight-HEIGHTBELOESYSSEVER-44-49);
        _rankScroll.delegate=self;
        _rankScroll.bounces=NO;
        [self.view addSubview:_rankScroll];
    }
    
    //    float orgin=0.0;
    //    UIButton *hitRateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    [hitRateBtn setFrame:CGRectMake(64*MyWidth/320, HEIGHTBELOESYSSEVER+12, 60*MyWidth/320, 24)];
    //    hitRateBtn.tag=HITAG;
    //    [hitRateBtn setTitle:@"命中率" forState:UIControlStateNormal];
    //    [hitRateBtn setTitleColor:SELECTCOLOR forState:UIControlStateNormal];
    //    [hitRateBtn setTitleColor:NORMALCOLOR forState:UIControlStateSelected];
    //    [hitRateBtn.titleLabel setFont:FONTTHIRTY];
    //    hitRateBtn.backgroundColor=[UIColor clearColor];
    //    [hitRateBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navView addSubview:hitRateBtn];
    //
    //    CGSize btnsize=[PublicMethod setNameFontSize:@"命中率" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //    CGRect rect=hitRateBtn.frame;
    //    rect.origin.x=64*MyWidth/320-(rect.size.width-btnsize.width)/2;
    //    orgin=64*MyWidth/320+btnsize.width+53*MyWidth/320;
    ////    rect.size.width=btnsize.width;
    ////    rect.size.height=btnsize.height;
    ////    rect.origin.y=42-btnsize.height/2;
    //    [hitRateBtn setFrame:rect];
    //
    //    UIButton *degreeHeatBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    [degreeHeatBtn setFrame:CGRectMake(CGRectGetMaxX(hitRateBtn.frame)+53*MyWidth/320, HEIGHTBELOESYSSEVER+12, 60*MyWidth/320, 24)];
    //    degreeHeatBtn.tag=HEATAG;
    //    [degreeHeatBtn setTitle:@"热度" forState:UIControlStateNormal];
    //    [degreeHeatBtn setTitleColor:NORMALCOLOR forState:UIControlStateNormal];
    //    [degreeHeatBtn setTitleColor:SELECTCOLOR forState:UIControlStateSelected];
    //    [degreeHeatBtn.titleLabel setFont:FONTTHIRTY];
    //    [degreeHeatBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    degreeHeatBtn.backgroundColor=[UIColor clearColor];
    //    [self.navView addSubview:degreeHeatBtn];
    //
    //    btnsize=[PublicMethod setNameFontSize:@"热度" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //    rect=degreeHeatBtn.frame;
    //    rect.origin.x=orgin-(rect.size.width-btnsize.width)/2;
    //    orgin=orgin+btnsize.width+53*MyWidth/320;
    ////    rect.size.width=btnsize.width;
    ////    rect.size.height=btnsize.height;
    ////    rect.origin.y=42-btnsize.height/2;
    //    [degreeHeatBtn setFrame:rect];
    //
    //    UIButton *returnRateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    [returnRateBtn setFrame:CGRectMake(CGRectGetMaxX(degreeHeatBtn.frame)+53*MyWidth/320, HEIGHTBELOESYSSEVER+12, 60*MyWidth/320, 24)];
    //    returnRateBtn.tag=RETURNTAG;
    //    [returnRateBtn setTitle:@"回报率" forState:UIControlStateNormal];
    //    [returnRateBtn setTitleColor:NORMALCOLOR forState:UIControlStateNormal];
    //    [returnRateBtn setTitleColor:SELECTCOLOR forState:UIControlStateSelected];
    //    [returnRateBtn.titleLabel setFont:FONTTHIRTY];
    //    [returnRateBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    returnRateBtn.backgroundColor=[UIColor clearColor];
    //    [self.navView addSubview:returnRateBtn];
    //
    //    btnsize=[PublicMethod setNameFontSize:@"回报率" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //    rect=returnRateBtn.frame;
    //    rect.origin.x=orgin-(rect.size.width-btnsize.width)/2;
    ////    rect.size.width=btnsize.width;
    ////    rect.size.height=btnsize.height;
    ////    rect.origin.y=42-btnsize.height/2;
    //    [returnRateBtn setFrame:rect];
    
//    for (int i=0; i<5; i++) {
    for (int i=0; i<3; i++) {
        CGFloat xloc=0;
        CGFloat width=MyWidth/3;
        if (i>=3) {
            width=MyWidth/2;
        }
        NSString *tit=@"";
        if (i==0) {
            tit=@"命中率";
        }else if(i==1){
            xloc=MyWidth/3;
            tit=@"近7天";
        }else if(i==2){
            xloc=MyWidth*2/3;
            tit=@"全部";
        }else if(i==3){
            xloc=MyWidth;
            tit=@"命中率";
        }else if(i==4){
            xloc=MyWidth*3/2;
            tit=@"近7天";
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(xloc, 0, width, 35)];
        [btn setTitle:tit forState:UIControlStateNormal];
        [btn setTitle:tit forState:UIControlStateSelected];
        [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        btn.titleLabel.font=FONTTWENTY_FOUR;
        CGSize btnsize=[PublicMethod setNameFontSize:tit andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(12, width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
        btn.backgroundColor=[UIColor whiteColor];
        btn.tag=100+i;
        [btn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rankScroll addSubview:btn];
        
        if (i==0||i==1||i==3) {
            UIImageView *intervalView=[[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width-0.5, 6.5, 0.5, 22)];
            intervalView.image=[UIImage imageNamed:@"intervalLine"];
            [btn addSubview:intervalView];
            if (i==0) {
                _firstLine=intervalView;
                _firstBtn=btn;
            }else if(i==1){
                _secondLine=intervalView;
                _secondBtn=btn;
            }else if(i==3){
                _thirdLine=intervalView;
                _fourthBtn=btn;
            }
        }else if (i==2) {
            _thirdBtn=btn;
        }else if (i==4) {
            _fifBtn=btn;
        }
        
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
        imgView.image=[UIImage imageNamed:@"排行榜下箭头"];
        imgView.tag=200+i;
        [btn addSubview:imgView];
    }
    
//    _touYing=[[UIImageView alloc]initWithFrame:CGRectMake(0, 35, MyWidth*2, 2.5)];
    _touYing=[[UIImageView alloc]initWithFrame:CGRectMake(0, 35, MyWidth, 2.5)];
    _touYing.image=[UIImage imageNamed:@"touying"];
    [_rankScroll addSubview:_touYing];
}

//创建排行榜列表
- (void)creatRankListTable{
    _jcRkTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 37.5, MyWidth, MyHight-150.5)];
    _jcRkTable.delegate=self;
    _jcRkTable.dataSource=self;
    _jcRkTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _jcRkTable.tag=401;
    [_rankScroll addSubview:_jcRkTable];
    
//    _ypRkTable=[[UITableView alloc] initWithFrame:CGRectMake(MyWidth, 37.5, MyWidth, MyHight-150.5)];
    _ypRkTable=[[UITableView alloc] initWithFrame:CGRectMake(MyWidth, 0, MyWidth, MyHight-113)];
    _ypRkTable.delegate=self;
    _ypRkTable.dataSource=self;
    _ypRkTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _ypRkTable.tag=402;
    [_rankScroll addSubview:_ypRkTable];
}

//创建分类列表
- (void)creatClassifyTable{
    _classifyTable=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _classifyTable.backgroundColor=[UIColor whiteColor];
    _classifyTable.dataSource=self;
    _classifyTable.delegate=self;
    _classifyTable.hidden=YES;
    _classifyTable.scrollEnabled=YES;
    _classifyTable.separatorColor=SEPARATORCOLOR;
    _classifyTable.tag=501;
    [self.view addSubview:_classifyTable];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 0.5)];
    view.backgroundColor=SEPARATORCOLOR;
    [_classifyTable addSubview:view];
    
    [self setupRefresh];
}

- (void)backClick:(id)sender{
    if ([self.navigationController isKindOfClass:[MLNavigationController class]]) {
        MLNavigationController *nlnav=(MLNavigationController *)self.navigationController;
        nlnav.canDragBack=YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backaction" object:self];
}

- (void)btnPaiHBClick:(UIButton *)btn{
    if(_noRankView){
        [_noRankView removeFromSuperview];
        _noRankView=nil;
    }
    btn.selected=YES;
    [MobClick event:@"Zj_paihangbang_20161014_caizhong" label:[btn titleForState:UIControlStateNormal]];
    if (btn==_jingPaiHBBtn) {
        _expertsType=@"-201";
        _yapanPaiHBBtn.selected=NO;
        [_rankScroll setContentOffset:CGPointMake(0, 0) animated:YES];
        if (!_jcRkArr) {
            jCutPage=1;
            [self requestRankList:1];
        }
        
//        CGRect rect=_secondBtn.frame;
//        rect.size.width=MyWidth/3;
//        [_secondBtn setFrame:rect];
//        
//        CGSize btnsize=[PublicMethod setNameFontSize:_secondBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//        [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, _secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, _secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
//        
//        for (UIView *view in [_secondBtn subviews]) {
//            if ([view isKindOfClass:[UIImageView class]]) {
//                UIImageView *pointImgV=(UIImageView *)view;
//                if (pointImgV.tag==201) {
//                    [pointImgV setFrame:CGRectMake(_secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
//                }
//            }
//        }
//        [_secondLine setFrame:CGRectMake(_secondBtn.frame.size.width-0.5, 6.5, 0.5, 22)];
//        
//        rect=_thirdBtn.frame;
//        rect.origin.x=MyWidth*2/3;
//        rect.size.width=MyWidth/3;
//        [_thirdBtn setFrame:rect];
//        
//        btnsize=[PublicMethod setNameFontSize:_thirdBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//        [_thirdBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, _thirdBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, _thirdBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
//        
//        for (UIView *view in [_thirdBtn subviews]) {
//            if ([view isKindOfClass:[UIImageView class]]) {
//                UIImageView *pointImgV=(UIImageView *)view;
//                if (pointImgV.tag==202) {
//                    [pointImgV setFrame:CGRectMake(_thirdBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
//                }
//            }
//        }
        
    }else if(btn==_yapanPaiHBBtn){
        _expertsType=@"201";
        _jingPaiHBBtn.selected=NO;
        [_rankScroll setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
        if (!_ypRkArr) {
            yCutPage=1;
            [self requestRankList:1];
        }
        
//        CGRect rect=_secondBtn.frame;
//        rect.size.width=MyWidth*2/3;
//        [_secondBtn setFrame:rect];
//        
//        CGSize btnsize=[PublicMethod setNameFontSize:_secondBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//        [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, _secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, _secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
//        
//        for (UIView *view in [_secondBtn subviews]) {
//            if ([view isKindOfClass:[UIImageView class]]) {
//                UIImageView *pointImgV=(UIImageView *)view;
//                if (pointImgV.tag==201) {
//                    [pointImgV setFrame:CGRectMake(_secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
//                }
//            }
//        }
//        
//        [_secondLine setFrame:CGRectMake(_secondBtn.frame.size.width, 6.5, 0, 22)];
//        
//        rect=_thirdBtn.frame;
//        rect.origin.x=MyWidth;
//        rect.size.width=0;
//        [_thirdBtn setFrame:rect];
//        
//        for (UIView *view in [_thirdBtn subviews]) {
//            if ([view isKindOfClass:[UIImageView class]]) {
//                UIImageView *pointImgV=(UIImageView *)view;
//                if (pointImgV.tag==202) {
//                    [pointImgV setFrame:CGRectMake(_thirdBtn.frame.origin.x, 15, 0, 0)];
//                }
//            }
//        }
    }
    [self clearShadow];
}

//#pragma mark --------导航栏选项--------
//
//- (void)clickBtn:(UIButton *)btn
//{
//    btn.selected=YES;
//    selectClassifyTag=601;
//    [_classifyTable setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+79, MyWidth, 0)];
//    _classifyTable.hidden=YES;
//    [_classifyTable reloadData];
//    _rankLisTable.alpha=1.0;
//    self.view.backgroundColor=TEXTWITER_COLOR;
//
//    rankLisTag=btn.tag;
//    for (UIView * view in [self.navView subviews]) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *normalBtn=(UIButton *)view;
//            if ((btn.tag==HITAG&&(normalBtn.tag==HEATAG||normalBtn.tag==RETURNTAG))||(btn.tag==HEATAG&&(normalBtn.tag==HITAG||normalBtn.tag==RETURNTAG))||(btn.tag==RETURNTAG&&(normalBtn.tag==HEATAG||normalBtn.tag==HITAG))) {
//                normalBtn.selected=NO;
//            }
//        }
//    }
//    for(UIView *view in [self.view subviews]){
//        if([view isKindOfClass:[UIImageView class]]&&(view.tag==200||view.tag==201||view.tag==202)){
//            UIImageView *imgV=(UIImageView *)view;
//            imgV.image=[UIImage imageNamed:@"排行榜下箭头"];
//        }
//    }
//
//    for(UIView *view in [self.view subviews]){
//        UIButton *currentBtn;
//        UIImageView *imgV;
//        CGSize btnsize;
//        if([view isKindOfClass:[UIButton class]]){
//            currentBtn=(UIButton *)view;
//            if (currentBtn.tag==100||currentBtn.tag==101||currentBtn.tag==102) {
//                currentBtn.selected=NO;
//                if(currentBtn.tag==100){
//                    [currentBtn setTitle:@"命中率" forState:UIControlStateNormal];
//                    [currentBtn setTitle:@"命中率" forState:UIControlStateSelected];
//                }else if(currentBtn.tag==101){
//                    [currentBtn setTitle:@"近7天" forState:UIControlStateNormal];
//                    [currentBtn setTitle:@"近7天" forState:UIControlStateSelected];
//                    _weekListType=@"1";
//                }else if(currentBtn.tag==102){
//                    [currentBtn setTitle:@"全部" forState:UIControlStateNormal];
//                    [currentBtn setTitle:@"全部" forState:UIControlStateSelected];
//                    _choiceType=@"1";
//                }
//                btnsize=[PublicMethod setNameFontSize:currentBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//            }
//        }
//        if ([view isKindOfClass:[UIImageView class]]&&(view.tag==200||view.tag==201||view.tag==202)) {
//            imgV=(UIImageView *)view;
//        }
//
//        CGFloat xloc=0;
//        CGFloat width=MyWidth/2;
//        CGFloat btnDistance=width/2-(btnsize.width+6*MyWidth/320+10)/2;
//
//         if (btn.tag==HEATAG) {
//            if (currentBtn.tag==100) {
//                xloc=0;
//                width=MyWidth;
//            }else if(currentBtn.tag==101){
//                xloc=MyWidth;
//                width=0;
//            }
//            btnDistance=MyWidth/2-(btnsize.width+6*MyWidth/320+10)/2;
//        }else if(btn.tag==HITAG||btn.tag==RETURNTAG){
//            if (currentBtn.tag==100) {
//                xloc=0;
//            }else if(currentBtn.tag==101){
//                xloc=MyWidth/2;
//            }
//        }
//        [currentBtn setFrame:CGRectMake(xloc, HEIGHTBELOESYSSEVER+44, width, 35)];
//        UIEdgeInsets edgeInset=UIEdgeInsetsMake(12, btnDistance, 12, btnDistance+10+6*MyWidth/320);
//        if (btn.tag==HEATAG&&currentBtn.tag==101) {
//            edgeInset=UIEdgeInsetsMake(0, 0, 0, 0);
//        }
//        [currentBtn setTitleEdgeInsets:edgeInset];
//        if (btn.tag==HEATAG) {
//            if (imgV.tag==200) {
//                [imgV setFrame:CGRectMake(btnDistance+btnsize.width+6*MyWidth/320, HEIGHTBELOESYSSEVER+15+44.0, 10, 5)];
//            }else if(imgV.tag==201){
//                [imgV setFrame:CGRectMake(btnDistance+btnsize.width+6*MyWidth/320+MyWidth, HEIGHTBELOESYSSEVER+15+44.0, 0, 0)];
//            }
//            if (currentBtn.tag==100) {
//                [_firstLine setFrame:CGRectMake(currentBtn.frame.size.width, 0, 0, currentBtn.frame.size.height)];
//            }
//        }else if(btn.tag==HITAG||btn.tag==RETURNTAG){
//            [imgV setFrame:CGRectMake(btnDistance+btnsize.width+6*MyWidth/320+width*(imgV.tag-200), HEIGHTBELOESYSSEVER+15+44.0, 10, 5)];
//            if (currentBtn.tag==100) {
//                [_firstLine setFrame:CGRectMake(currentBtn.frame.size.width-0.5, 0, 0.5, currentBtn.frame.size.height)];
//            }
//        }
//
//    }
//    [_rankLisTable setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+81.5, MyWidth, MyHight-150.5)];
//    [_rankLisTable reloadData];
//
//    currentPage=1;
//    [self requestRankList:currentPage];
//}

#pragma mark ---------二级分类选项---------

- (void)clearShadow{
    _selectBtn.selected=NO;
    _ypRkTable.alpha=1.0;
    _jcRkTable.alpha=1.0;
    if(_noRankView){
        _noRankView.alpha=1.0;
    }
    _rankScroll.scrollEnabled=YES;
    _jcRkTable.userInteractionEnabled=YES;
    _ypRkTable.userInteractionEnabled=YES;
    self.view.backgroundColor=TEXTWITER_COLOR;
    
    for(UIView *view in [_selectBtn subviews]){
        if([view isKindOfClass:[UIImageView class]]){
            UIImageView *imgV=(UIImageView *)view;
            if (view.tag==_selectBtn.tag+100) {
                imgV.image=[UIImage imageNamed:@"排行榜下箭头"];
            }
        }
    }
    _classifyTable.hidden=YES;
    [_classifyTable setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+79, MyWidth, 0)];
    selectClassifyTag=601;
}

- (void)selectClick:(UIButton *)btn{
    if (selectClassifyTag==btn.tag) {
        [self clearShadow];
        return;
    }else{
        selectClassifyTag=btn.tag;
        _selectBtn=btn;
        _rankScroll.scrollEnabled=NO;
    }
    
    if (_classyArr) {
        [_classyArr removeAllObjects];
        _classyArr=nil;
    }
    if(_noRankView){
        _noRankView.alpha=0.1;
    }
    self.view.backgroundColor=[UIColor blackColor];
    if ([_expertsType isEqualToString:@"-201"]) {
        _jcRkTable.alpha=0.6;
        _jcRkTable.userInteractionEnabled=NO;
    }else if ([_expertsType isEqualToString:@"201"]) {
        _ypRkTable.alpha=0.6;
        _ypRkTable.userInteractionEnabled=NO;
    }
    _classifyTable.hidden=NO;
    
    btn.selected=YES;
    for(UIView *view in [btn subviews]){
        if([view isKindOfClass:[UIImageView class]]){
            UIImageView *imgV=(UIImageView *)view;
            if (view.tag==btn.tag+100) {
                imgV.image=[UIImage imageNamed:@"排行榜上箭头"];
            }
        }
    }
    for(UIView *view in [_rankScroll subviews]){
        if([view isKindOfClass:[UIButton class]]){
            UIButton *currentBtn=(UIButton *)view;
            if (currentBtn!=btn) {
                currentBtn.selected=NO;
                for(UIView *view in [currentBtn subviews]){
                    if([view isKindOfClass:[UIImageView class]]){
                        UIImageView *imgV=(UIImageView *)view;
                        if (view.tag==currentBtn.tag+100) {
                            imgV.image=[UIImage imageNamed:@"排行榜下箭头"];
                        }
                    }
                }
            }
        }
    }
    
    _selectedBtnStr = btn.titleLabel.text;
    float classyHight=0.0;
    
    if ([_expertsType isEqualToString:@"-201"]) {
        if (btn.tag==100) {
            _classyArr=[NSMutableArray arrayWithObjects:@"命中率",@"热度",@"回报率",nil];
            classyHight=120.0;
        }else if (btn.tag==101) {
            _classyArr=[NSMutableArray arrayWithObjects:@"近7天",@"周榜",@"月榜",nil];
            classyHight=120.0;
        }else if(btn.tag==102){
            _classyArr=[NSMutableArray arrayWithObjects:@"全部",@"单选",nil];
            classyHight=80.0;
        }
        jCutPage=1;
    }else if ([_expertsType isEqualToString:@"201"]){
        if (btn.tag==103) {
            _classyArr=[NSMutableArray arrayWithObjects:@"命中率",@"热度",@"回报率",nil];
            classyHight=120.0;
        }else if (btn.tag==104) {
            _classyArr=[NSMutableArray arrayWithObjects:@"近7天",@"周榜",@"月榜",nil];
            classyHight=120.0;
        }
        yCutPage=1;
    }
    [_classifyTable setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+79, MyWidth, classyHight)];
    [_classifyTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------UITableViewDelegate------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float tableHeight=0.0;
    if (tableView.tag!=501) {
        if(tableView.tag == 402){
            return 135;
        }
        CGSize labSize0=[PublicMethod setNameFontSize:@"宝哥" andFont:FONTTHIRTY_TWO andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize labSize1=[PublicMethod setNameFontSize:@"推荐数" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize labSize2=[PublicMethod setNameFontSize:@"单选推荐数" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        tableHeight=labSize0.height+labSize1.height+labSize2.height+46;
    }else if(tableView.tag==501){
        tableHeight=40.0;
    }
    return tableHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(tableView.tag==501){
        if(_selectCell){
            _selectCell.txtLabel.textColor=BLACK_EIGHTYSEVER;
            _selectCell.selectImgV.hidden=YES;
        }
        ClassifyCell *cell=(ClassifyCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.txtLabel.textColor=[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1.0];
        cell.selectImgV.hidden=NO;
        _selectCell=cell;
        if (selectClassifyTag==100||selectClassifyTag==103) {
            rankLisTag=indexPath.row+301;
            for(UIView *view in [_rankScroll subviews]){
                if([view isKindOfClass:[UIButton class]]){
                    UIButton *currentBtn=(UIButton *)view;
                    if ([_expertsType isEqualToString:@"-201"]) {
                        if (currentBtn.tag==101||currentBtn.tag==102) {
                            currentBtn.selected=NO;
                            if(currentBtn.tag==101){
                                [currentBtn setTitle:@"近7天" forState:UIControlStateNormal];
                                [currentBtn setTitle:@"近7天" forState:UIControlStateSelected];
                                _weekListType=@"1";
                            }else if(currentBtn.tag==102){
                                [currentBtn setTitle:@"全部" forState:UIControlStateNormal];
                                [currentBtn setTitle:@"全部" forState:UIControlStateSelected];
                                _choiceType=@"1";
                            }
                        }
                    }else if ([_expertsType isEqualToString:@"201"]){
                        if (currentBtn.tag==104) {
                            currentBtn.selected=NO;
                            [currentBtn setTitle:@"近7天" forState:UIControlStateNormal];
                            [currentBtn setTitle:@"近7天" forState:UIControlStateSelected];
                            _weekListType=@"1";
                            _choiceType=@"1";
                            
                            CGSize btnsize=[PublicMethod setNameFontSize:currentBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                            [currentBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, currentBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, currentBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
                            
                            for (UIView *view in [currentBtn subviews]) {
                                if ([view isKindOfClass:[UIImageView class]]) {
                                    UIImageView *pointImgV=(UIImageView *)view;
                                    if (pointImgV.tag==201) {
                                        [pointImgV setFrame:CGRectMake(currentBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (indexPath.row!=1&&[_expertsType isEqualToString:@"-201"]) {
                CGRect rect=_secondBtn.frame;
                rect.size.width=MyWidth/3;
                [_secondBtn setFrame:rect];
                
                CGSize btnsize=[PublicMethod setNameFontSize:_secondBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, _secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, _secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
                
                for (UIView *view in [_secondBtn subviews]) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        UIImageView *pointImgV=(UIImageView *)view;
                        if (pointImgV.tag==201) {
                            [pointImgV setFrame:CGRectMake(_secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
                        }
                    }
                }
                [_secondLine setFrame:CGRectMake(_secondBtn.frame.size.width-0.5, 6.5, 0.5, 22)];
                
                rect=_thirdBtn.frame;
                rect.origin.x=MyWidth*2/3;
                rect.size.width=MyWidth/3;
                [_thirdBtn setFrame:rect];
                
                btnsize=[PublicMethod setNameFontSize:_thirdBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                [_thirdBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, _thirdBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, _thirdBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
                
                for (UIView *view in [_thirdBtn subviews]) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        UIImageView *pointImgV=(UIImageView *)view;
                        if (pointImgV.tag==202) {
                            [pointImgV setFrame:CGRectMake(_thirdBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
                        }
                    }
                }
            }else if([_expertsType isEqualToString:@"-201"]){
                CGRect rect=_secondBtn.frame;
                rect.size.width=MyWidth*2/3;
                [_secondBtn setFrame:rect];
                
                CGSize btnsize=[PublicMethod setNameFontSize:_secondBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, _secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, _secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
                
                for (UIView *view in [_secondBtn subviews]) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        UIImageView *pointImgV=(UIImageView *)view;
                        if (pointImgV.tag==201) {
                            [pointImgV setFrame:CGRectMake(_secondBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
                        }
                    }
                }
                
                [_secondLine setFrame:CGRectMake(_secondBtn.frame.size.width, 6.5, 0, 22)];
                
                rect=_thirdBtn.frame;
                rect.origin.x=MyWidth;
                rect.size.width=0;
                [_thirdBtn setFrame:rect];
                
                for (UIView *view in [_thirdBtn subviews]) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        UIImageView *pointImgV=(UIImageView *)view;
                        if (pointImgV.tag==202) {
                            [pointImgV setFrame:CGRectMake(_thirdBtn.frame.origin.x, 15, 0, 0)];
                        }
                    }
                }
            }
        }else if (selectClassifyTag==101||selectClassifyTag==104) {
            if (indexPath.row==0) {
                _weekListType=@"1";
            }else if(indexPath.row==1){
                _weekListType=@"2";
            }else if(indexPath.row==2){
                _weekListType=@"3";
            }
        }else if(selectClassifyTag==102){
            if (indexPath.row==0) {
                _choiceType=@"1";
            }else if(indexPath.row==1){
                _choiceType=@"2";
            }
        }
        NSString *str=[_classyArr objectAtIndex:indexPath.row];
        [_selectBtn setTitle:str forState:UIControlStateNormal];
        [_selectBtn setTitle:str forState:UIControlStateSelected];
        CGSize btnsize=[PublicMethod setNameFontSize:str andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [_selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, _selectBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2, 12, _selectBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
        for (UIView *view in [_selectBtn subviews]) {
            if ([view isKindOfClass:[UIImageView class]]) {
                UIImageView *pointImgV=(UIImageView *)view;
                if (pointImgV.tag==200) {
                    [pointImgV setFrame:CGRectMake(_selectBtn.frame.size.width/2-(btnsize.width+6*MyWidth/320+10)/2+btnsize.width+6*MyWidth/320, 15, 10, 5)];
                }
            }
        }
        [self clearShadow];
        if ([_expertsType isEqualToString:@"-201"]) {
            jCutPage=1;
        }else if ([_expertsType isEqualToString:@"201"]) {
            yCutPage=1;
        }
        [self requestRankList:1];
    }else if(tableView.tag!=501){
        Info *info = [Info getInstance];
        NSString *nameSty=@"";
        if ([info.userId intValue]) {
            nameSty=[[Info getInstance] userName];
        }
        
        NSString *expertName = @"";
        if (tableView.tag==401) {
            RankListM *rankListModel=[_jcRkArr objectAtIndex:indexPath.row];
            expertName = rankListModel.expertsName;
        }else if (tableView.tag==402){
            ExpertMainListModel *rankListModel=[_ypRkArr objectAtIndex:indexPath.row];
            expertName = rankListModel.EXPERTS_NAME;
        }
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"expertsName":expertName,@"expertsClassCode":@"001",@"loginUserName":nameSty,@"erAgintOrderId":@"",@"type":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":_expertsType} forKey:@"parameters"];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
            
            NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
            ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
            vc.exBaseInfo=exBase;
            
            NSArray *arr=responseJSON[@"result"][@"historyPlanList"];
            NSMutableArray *historyArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary *dicHistoryPlan in arr) {
                HistoryPlanList *hisPlanList=[HistoryPlanList historyPlanListWithDic:dicHistoryPlan];
                [historyArr addObject:hisPlanList];
            }
            vc.historyPlanArr=historyArr;
            
            dic=responseJSON[@"result"][@"leastTenInfo"];
            LeastTenInfo *leastTenInfo=[LeastTenInfo leastTenInfoWithDic:dic];
            vc.leastTenInfo=leastTenInfo;
            
            arr=responseJSON[@"result"][@"newPlanList"];
            NSMutableArray *newPlanArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary *dicNewPlan in arr) {
                NewPlanList *newPlanList=[NewPlanList newPlanListWithDic:dicNewPlan];
                if ([newPlanList.closeStatus isEqualToString:@"1"]) {
                    [newPlanArr addObject:newPlanList];
                }
            }
            vc.npList=newPlanArr;
            vc.hidesBottomBarWhenPushed=YES;
            vc.segmentOnClickIndexFlags=YES;
            vc.planIDStr=@"";
            vc.jcyplryType=_expertsType;
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError * error) {
            
        }];
        
    }
}
#pragma mark -----------UITableViewDataSource-----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==501) {
        return [_classyArr count];
    }else if(tableView.tag==401&&_jcRkArr){
        return [_jcRkArr count];
    }else if(tableView.tag==402&&_ypRkArr){
        return [_ypRkArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag!=501) {
        if (tableView.tag==402){
            
            static NSString * cellID = @"ExpertRankListTableViewCell";
            ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            ExpertMainListModel *model = [_ypRkArr objectAtIndex:indexPath.row];
            
            cell.buttonAction = ^(UIButton *button) {
                
//                [newSelf getIsBuyInfoWithOrderID:model];
            };
            cell.isZhuanjia = NO;
            [cell loadYuecaiRankListInfo:model];
            
            return cell;
        }else{
            RankListCell *cell=[RankListCell rankListCellWithTableView:tableView indexPath:indexPath];
            RankListM *rankListModel;
            if (tableView.tag==401) {
                rankListModel=[_jcRkArr objectAtIndex:indexPath.row];
            }else if (tableView.tag==402){
                rankListModel=[_ypRkArr objectAtIndex:indexPath.row];
            }
            
            NSString *firstSty=@"";
            NSString *secSty=@"";
            NSString *thirdSty=@"";
            NSString *fourSty=@"";
            if(rankLisTag==HITAG){
                firstSty=[NSString stringWithFormat:@"%ld",(long)rankListModel.totalRecommend];
                secSty=[NSString stringWithFormat:@"%ld%%",(long)rankListModel.totalHitRate];
                thirdSty=[NSString stringWithFormat:@"%ld",(long)rankListModel.radioRecommend];
                fourSty=[NSString stringWithFormat:@"%ld%%",(long)rankListModel.radioRecommendHitRate];
            }else if(rankLisTag==HEATAG){
                firstSty=[NSString stringWithFormat:@"%ld",(long)rankListModel.totalRecommend];
                secSty=@"";
                thirdSty=[NSString stringWithFormat:@"%ld",(long)rankListModel.heat];
                fourSty=@"";
            }else if(rankLisTag==RETURNTAG){
                firstSty=[NSString stringWithFormat:@"%ld",(long)rankListModel.totalRecommend];
                secSty=@"";
                thirdSty=[NSString stringWithFormat:@"%ld%%",(long)rankListModel.rewardRate];
                fourSty=[NSString stringWithFormat:@"%ld",(long)rankListModel.continuousHit];
            }
            [cell potrait:rankListModel.headPortait name:rankListModel.expertsNickName rank:rankListModel.star recomNo:firstSty  hitPbablity:secSty singleRecNo:thirdSty singleHitRate:fourSty order:indexPath.row+1 tableTag:rankLisTag lotryType:_expertsType];
            //if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            //    cell.separatorInset=UIEdgeInsetsMake(0,-15,0,0);
            //}
            return cell;
        }
    }else if(tableView.tag==501){
        CGSize labSize=[PublicMethod setNameFontSize:[_classyArr objectAtIndex:indexPath.row] andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        ClassifyCell *cell=[ClassifyCell classifyCellWithTView:tableView indexPath:indexPath];
        [cell.txtLabel setFrame:CGRectMake(36*MyWidth/320, 0, labSize.width, 40)];
        cell.txtLabel.text=[_classyArr objectAtIndex:indexPath.row];
        if([[_classyArr objectAtIndex:indexPath.row] isEqualToString:_selectedBtnStr]){
            cell.selectImgV.hidden=NO;
            cell.txtLabel.textColor=[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1.0];
        }
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark ------------请求接口数据-----------
- (void)requestRankList:(NSInteger)page{
    NSString *rankType=@"";
    if(rankLisTag==HITAG){
        rankType=@"1";
    }else if(rankLisTag==HEATAG){
        rankType=@"2";
    }else if(rankLisTag==RETURNTAG){
        rankType=@"3";
    }
    if(_noRankView){
        [_noRankView removeFromSuperview];
        _noRankView=nil;
    }
    
    if([_expertsType isEqualToString:@"201"]){
        [self getRankExpertRequestWithPage:[NSString stringWithFormat:@"%ld",(long)page]];
        return;
    }
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getExpertsRankList",@"parameters":@{@"lotteyClassCode":_expertsType,@"rankType":rankType,@"timeSpan":_weekListType,@"expertType":@"3",@"chooseType":_choiceType,@"curPage":[NSString stringWithFormat:@"%ld",(long)page],@"pageSize":@"20",@"levelType":@"1"}}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSDictionary *dic=responseJSON;
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *arr_plan=dic[@"result"][@"data"];
            if ([arr_plan count]!=0) {
                NSMutableArray *arr=[NSMutableArray arrayWithCapacity:[arr_plan count]];
                for (NSDictionary *dic in arr_plan) {
                    [arr addObject:[RankListM RankListMWithDic:dic]];
                }
                if([_expertsType isEqualToString:@"-201"]){
                    if (page==1) {
                        [_jcRkArr removeAllObjects];
                        _jcRkArr=arr;
                    }else{
                        [_jcRkArr addObjectsFromArray:arr];
                        jCutPage++;
                    }
                    [_jcRkTable reloadData];
                }else if ([_expertsType isEqualToString:@"201"]){
                    if (page==1) {
                        [_ypRkArr removeAllObjects];
                        _ypRkArr=arr;
                    }else{
                        [_ypRkArr addObjectsFromArray:arr];
                        yCutPage++;
                    }
                    [_ypRkTable reloadData];
                }
            }else{
                if (page==1) {
                    if([_expertsType isEqualToString:@"-201"]){
                        [_jcRkArr removeAllObjects];
                        [_jcRkTable reloadData];
                    }else if ([_expertsType isEqualToString:@"201"]){
                        [_ypRkArr removeAllObjects];
                        [_ypRkTable reloadData];
                    }
                    _noRankView=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44-49)];
                    _noRankView.backgroundColor=[UIColor clearColor];
                    if([_expertsType isEqualToString:@"-201"]){
                        [_noRankView setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44-49)];
                    }else if ([_expertsType isEqualToString:@"201"]){
                        [_noRankView setFrame:CGRectMake(320, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44-49)];
                    }
                    [_rankScroll addSubview:_noRankView];
                    
                    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(125, (_noRankView.frame.size.height-92.5)/2-80, 70, 92.5)];
                    imgV.image=[UIImage imageNamed:@"norecon"];
                    [_noRankView addSubview:imgV];
                    
                    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(60, ORIGIN_Y(imgV)+10, 200, 40)];
                    lab.backgroundColor=[UIColor clearColor];
                    lab.text=@"暂时没有专家上榜";
                    lab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                    lab.textAlignment=NSTextAlignmentCenter;
                    lab.font=FONTTHIRTY_TWO;
                    [_noRankView addSubview:lab];
                }
               // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                //[alert show];
                //[self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcRkTable.header endRefreshing];
            [_jcRkTable.footer endRefreshing];
            [_ypRkTable.header endRefreshing];
            [_ypRkTable.footer endRefreshing];
        });
    } failure:^(NSError * error) {
        NSLog(@"error=%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcRkTable.header endRefreshing];
            [_jcRkTable.footer endRefreshing];
            [_ypRkTable.header endRefreshing];
            [_ypRkTable.footer endRefreshing];
        });
    }];
}

-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

#pragma mark 刷新
- (void)setupRefresh
{
    _jcRkTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_jcRkTable.header];
    
    _jcRkTable.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_jcRkTable.footer];
    
    _ypRkTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_ypRkTable.header];
    
    _ypRkTable.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_ypRkTable.footer];
}

#pragma mark ------开始进入刷新状态-------
- (void)NearheaderRereshing
{
    if ([_expertsType isEqualToString:@"-201"]) {
        jCutPage=1;
        [self requestRankList:jCutPage];
    }else if ([_expertsType isEqualToString:@"201"]) {
        yCutPage=1;
        [self requestRankList:yCutPage];
    }
}

#pragma mark -------加载-------
- (void)NearfooterRereshing
{
    NSInteger page;
    if ([_expertsType isEqualToString:@"-201"]) {
        page=jCutPage;
    }else if ([_expertsType isEqualToString:@"201"]) {
        page=yCutPage;
    }
    page++;
    [self requestRankList:page];
}

#define mark -----------UIScrollViewDelegate------------------
- (void)setScrollContent{
    CGPoint offset=_rankScroll.contentOffset;
    if (offset.x<MyWidth/2) {
        [_rankScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        [_rankScroll setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(_noRankView){
        [_noRankView removeFromSuperview];
        _noRankView=nil;
    }
    [self setScrollContent];
    CGPoint offset=_rankScroll.contentOffset;
    if (offset.x<MyWidth/2) {
        _expertsType=@"-201";
        _yapanPaiHBBtn.selected=NO;
        _jingPaiHBBtn.selected=YES;
        if (!_jcRkArr) {
            jCutPage=1;
            [self requestRankList:1];
        }
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        _expertsType=@"201";
        _yapanPaiHBBtn.selected=YES;
        _jingPaiHBBtn.selected=NO;
        if (!_ypRkArr) {
            yCutPage=1;
            [self requestRankList:1];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setScrollContent];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self setScrollContent];
}
-(void)getRankExpertRequestWithPage:(NSString *)page{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"userName":[[Info getInstance] userName],
                                                                                       @"expertClassCode":@"001",//竞彩001  写死
                                                                                       @"lotteryClassCode":@"201",
                                                                                       @"orderFlag":@"0",
                                                                                       @"curPage":page,
                                                                                       @"pageSize":@"20"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportExpertsRankPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary * bodyData=[responseJSON valueForKey:@"result"];
            NSArray * dataArr = [bodyData objectForKey:@"data"];
            
            if ([dataArr count]!=0) {
                
                NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
                
                for (NSDictionary * dic in dataArr) {
                    [arr addObject:[ExpertMainListModel expertListWithDic:dic]];
                }
                
                if ([page isEqualToString:@"1"]) {
                    [_ypRkArr removeAllObjects];
                    _ypRkArr=arr;
                }else{
                    [_ypRkArr addObjectsFromArray:arr];
                    yCutPage++;
                }
                [_ypRkTable reloadData];
            }else{
                if ([page isEqualToString:@"1"]) {
                    if([_expertsType isEqualToString:@"-201"]){
                        [_jcRkArr removeAllObjects];
                        [_jcRkTable reloadData];
                    }else if ([_expertsType isEqualToString:@"201"]){
                        [_ypRkArr removeAllObjects];
                        [_ypRkTable reloadData];
                    }
                    _noRankView=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44-49)];
                    _noRankView.backgroundColor=[UIColor clearColor];
                    if([_expertsType isEqualToString:@"-201"]){
                        [_noRankView setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44-49)];
                    }else if ([_expertsType isEqualToString:@"201"]){
                        [_noRankView setFrame:CGRectMake(320, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44-49)];
                    }
                    [_rankScroll addSubview:_noRankView];
                    
                    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(125, (_noRankView.frame.size.height-92.5)/2-80, 70, 92.5)];
                    imgV.image=[UIImage imageNamed:@"norecon"];
                    [_noRankView addSubview:imgV];
                    
                    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(60, ORIGIN_Y(imgV)+10, 200, 40)];
                    lab.backgroundColor=[UIColor clearColor];
                    lab.text=@"暂时没有专家上榜";
                    lab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                    lab.textAlignment=NSTextAlignmentCenter;
                    lab.font=FONTTHIRTY_TWO;
                    [_noRankView addSubview:lab];
                }
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcRkTable.header endRefreshing];
            [_jcRkTable.footer endRefreshing];
            [_ypRkTable.header endRefreshing];
            [_ypRkTable.footer endRefreshing];
        });
    } failure:^(NSError * error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcRkTable.header endRefreshing];
            [_jcRkTable.footer endRefreshing];
            [_ypRkTable.header endRefreshing];
            [_ypRkTable.footer endRefreshing];
        });
    }];
}
-(NSMutableArray *)reloadArrayWithAry:(NSArray *)ary{
    
    NSMutableArray *arym = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary * dic in ary) {
        RankListM *model = [[RankListM alloc]init];
        
        model.expertsNickName = [dic valueForKey:@"EXPERTS_NICK_NAME"];
        model.expertsIntroduction = @"";
        model.totalRecommend = 0;
        model.totalHitRate = [[dic valueForKey:@"RANKRATE"] integerValue];
        model.radioRecommend = 0;
        model.radioRecommendHitRate = 0;
        model.star = [[dic valueForKey:@"STAR"] integerValue];
        model.headPortait = [dic valueForKey:@"HEAD_PORTRAIT"];
        model.source = [[dic valueForKey:@"SOURCE"] integerValue];
        model.heat = 0;
        model.rewardRate = 0;
        model.continuousHit = 0;
        model.currentRank = 0;
        model.lastRank = 0;
        model.expertsName = [dic valueForKey:@"EXPERTS_NAME"];
        model.expertsClassCode = [dic valueForKey:@"EXPERTS_CLASS_CODE"];
        model.lotteyClassCode = [dic valueForKey:@"LOTTEY_CLASS_CODE"];
        
        [arym addObject:model];
        //        [arym addObject:[ExpertMainListModel expertListWithDic:dic]];
    }
    
    return arym;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    