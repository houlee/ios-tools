//
//  GouCaiChaiCell.h
//  caibo
//
//  Created by yaofuyu on 13-8-15.
//
//

#import <UIKit/UIKit.h>
#import "ColorView.h"

@interface GouCaiChaiCell : UITableViewCell {
    UIImageView *backImageView;
    UILabel *infoLabel;
    UIImageView *lineImageV;
    UIImageView *backUpImageView;
    UIImageView *upImageV;
    
    UILabel *numLabel;
    ColorView *jiangJiLable;
    UIImageView *line2;
    UILabel *Zhulabel;
    UILabel *moneyLabel;
    
}

- (void)setMyinfo:(NSString *)_info;

@property (nonatomic)NSInteger Index;

@property (nonatomic,assign)id jJYHChaiCellDelegate;

@end