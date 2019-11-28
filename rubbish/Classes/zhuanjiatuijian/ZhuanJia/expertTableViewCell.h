//
//  expertTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/21.
//
//

#import <UIKit/UIKit.h>
#import "ExpertCollectionViewCell.h"
#import "ExpertJingjiModel.h"

typedef void(^DidSelectRow)(NSIndexPath * indexPath);

@interface expertTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGSize size;
    NSMutableArray *dataArym;
}
@property (nonatomic, strong) UICollectionView *expertCollection;//专家
@property (nonatomic, copy) DidSelectRow didSelectRow;

-(void)loadAppointInfo:(NSArray *)ary;

@end
