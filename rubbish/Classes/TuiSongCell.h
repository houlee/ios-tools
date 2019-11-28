//
//  TuiSongCell.h
//  caibo
//
//  Created by houchenguang on 12-12-12.
//
//

#import <UIKit/UIKit.h>

@interface TuiSongCell : UITableViewCell{

    UIImageView * bgimage;
    UIImageView * line;
    UIView * line2;
    UIImageView * jiantou;
    UILabel * titleText;
}
@property (nonatomic, retain)UIImageView * bgimage, * line;
@property (nonatomic, retain)UIView *line2;
@property (nonatomic, retain)UILabel * titleText;
@property (nonatomic, retain)UIImageView * jiantou;

@end
