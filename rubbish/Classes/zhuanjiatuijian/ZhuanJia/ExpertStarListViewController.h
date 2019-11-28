//
//  ExpertStarListViewController.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/26.
//
//

#import "CPViewController.h"
#import "UpLoadView.h"
#import "caiboAppDelegate.h"

typedef enum {
    
    expertStarType,
    expertSquareType,
    expertRedType,
    
}ExpertType;

@interface ExpertStarListViewController : CPViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *myCollection;
    NSMutableArray *starArym;
    NSMutableArray *squareArym;
    NSMutableArray *redArym;
    
    NSInteger segmentTag;
    NSMutableArray *cellPageArym;
    UIImageView *segmentIma;
    
    UIView *headerView;
    UpLoadView * _loadView;
    NSString *erAgintOrderId;
    CGFloat disPrice;
}
@property (nonatomic, assign) ExpertType expertType;
@end
