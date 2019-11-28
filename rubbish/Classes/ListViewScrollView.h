//
//  ListViewScrollView.h
//  caibo
//
//  Created by houchenguang on 14-5-22.
//
//

#import <UIKit/UIKit.h>
#import "FootListTableViewCell.h"
typedef enum{

    homeTeamListViewType,
    guestTeamListViewType,
    historyListViewType,

} ListViewType;

@interface ListViewScrollView : UIScrollView<UITableViewDataSource, UITableViewDelegate, FootListDelegate>{

    ListViewType listType;
    UILabel * titleLabel;
    UILabel * teamLable;
    UIImageView * lineImageView;
    NSString * keyString;
//    UITableView * plTableView;
    UITableView * teamTableView;
    UIImageView * leftLineImage;
    id delegateList;
    UIImageView * titleImageView;
    NSMutableDictionary * analyzeDictionary;//分析中心数据
    UIImageView * zwImageView;
}

@property (nonatomic, assign)ListViewType listType;
@property (nonatomic, assign)id delegateList;
@property (nonatomic, retain)UIImageView * titleImageView;
@property (nonatomic, retain) NSMutableDictionary * analyzeDictionary;
@property (nonatomic, retain)NSString * keyString;

@end

@protocol ListViewDelegate <NSObject>
@optional
- (void)listViewScrollView:(ListViewScrollView *)listView macthTouch:(BOOL)macthBool teamButtonTouch:(BOOL)teamBool name:(NSString *)name dict:(NSDictionary *)dictData;//macthBool为YES 触发赛事对阵  teamBool为YES  触发对阵弹框

- (void)listViewScrollView:(ListViewScrollView *)listView selectIndexPatch:(NSIndexPath *)indexPath viewType:(ListViewType)listType withNum:(NSString *)num;
@end