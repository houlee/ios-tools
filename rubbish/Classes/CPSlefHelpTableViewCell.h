//
//  ;
//  caibo
//
//  Created by houchenguang on 14-5-6.
//
//

#import <UIKit/UIKit.h>
#import "CPSlefHelpData.h"

@interface CPSlefHelpTableViewCell : UITableViewCell{

    CPSlefHelpData * selfHelpData;
    UIImageView * bgImageView;
    UIImageView * headImageView;
    UIButton *headImageButton;
    UILabel * nameLabel;
    UIImageView * kfmarkImageView;
    UIImageView* selfHelpImageView;
    NSIndexPath * cellIndexPath;
    UIImageView * lineImage;
}

@property (nonatomic, retain) UIImageView *lineImage;
@property (nonatomic, retain) CPSlefHelpData * selfHelpData;
@property (nonatomic, retain)NSIndexPath * cellIndexPath;
@property (nonatomic, retain) UILabel *nameLabel;

@end
