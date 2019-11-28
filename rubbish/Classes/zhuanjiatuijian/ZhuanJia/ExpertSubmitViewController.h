//
//  ExpertSubmitViewController.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import "CPViewController.h"
#import "MatchVCModel.h"
#import "V1PickerView.h"

@interface ExpertSubmitViewController : CPViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,V1PickerViewDelegate,UITextViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataArym;//cell数组
    UIView *footerView;
    NSMutableArray *pickerViewDataArym;//pick展示数组
    V1PickerView *picker;
    
    NSMutableDictionary *leagueTypeDict;//赛事接口整理好的字典
    NSMutableArray *leagueTimeArym;//赛事接口整理好的日期数组
    
    NSMutableArray *leagueTypeArym;//存储  选择好日期后所对应所有赛事的数组
    
    NSMutableArray *allMatchArym1;//根据日期和赛事ID获取的所有赛程数组
    NSMutableArray *allMatchArym2;//根据日期和赛事ID获取的所有赛程数组
    NSMutableArray *matchArym1;//所选的第一场比赛
    NSMutableArray *matchArym2;//所选的第一场比赛
    
    NSMutableArray *priceArym;//价格数组
    NSMutableArray *discountPriceArym;//折扣价格数组
    
    NSMutableArray *shengpingfuArym;
    
    CGSize liyouSize;
    
    UITextView *mesTextView;
    
    CGFloat textContentSize;
    UILabel *placeholderLab;
    
    BOOL mayJingcai;//是否可以发竞彩
    BOOL mayErchuanyi;//是否可以发二串一
    BOOL mayLancai;//是否可以发篮彩
    
//    BOOL isStar;//是否是明星
    BOOL isSubmit;//是不是去发布
    BOOL isSubmitFinish;//是不是发布完成
    BOOL isFirst;// 首次；
}
//@property (nonatomic,assign) BOOL isErchuanyi;
@property (nonatomic,copy) NSString *type;//
@property(nonatomic,strong)MatchDetailVCMdl *matchdetailMdl;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *discountPrice;
@property(nonatomic,copy) NSString *tuidan;
@property (nonatomic,assign) BOOL lcLeftBtn;//篮彩赛果左边按钮    客队、大球
@property (nonatomic,assign) BOOL lcRightBtn;//篮彩赛果右边按钮    主队、小球
//@property(nonatomic,copy) NSString *jingcaiNumber;//竞彩发布次数
//@property(nonatomic,copy) NSString *erchuanyiNumber;//二串一发布次数
//@property (nonatomic,assign) BOOL mayJingcai;
//@property (nonatomic,assign) BOOL mayErchuanyi;

@property(nonatomic,copy) NSString *multipleChoiceOdds;//单选赔率限制
@property(nonatomic,copy) NSString *doubleSelectionOdds;//双选赔率限制
@end
