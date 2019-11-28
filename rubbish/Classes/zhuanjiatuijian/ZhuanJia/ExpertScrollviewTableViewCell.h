//
//  ExpertScrollviewTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/22.
//
//

#import <UIKit/UIKit.h>

typedef void(^CollectionScrollEnd)(CGFloat  offsetX);
typedef void(^DidSelectTableViewAndCollectionView)(UITableView * tableView, NSIndexPath * tableViewIndexPath, NSIndexPath * collectionViewIndexPath);

@interface ExpertScrollviewTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGSize size;
    NSMutableArray *dataArym;
}
@property (nonatomic, strong) UICollectionView *listCollection;//专家
@property (nonatomic, copy) CollectionScrollEnd collectionScrollEnd;
@property (nonatomic, copy) DidSelectTableViewAndCollectionView didSelectRow;
@property (nonatomic, assign) BOOL isZhuanjia;//yes专家    no榜单
-(void)loadAppointInfo:(NSArray *)ary;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withHeight:(CGFloat)height;
@end
