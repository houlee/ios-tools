//
//  YCMatchTableViewCell.h
//  caibo
//
//  Created by houchenguang on 14-5-24.
//
//

#import <UIKit/UIKit.h>

@interface YCMatchTableViewCell : UITableViewCell{

    NSDictionary * dataDictionary;
    UILabel * monthLabel;
    UILabel * dateLabel;
    UILabel * homeLabel;
    UILabel * scoreLabel;
    UIImageView * vsImageView;
    UILabel * guestLabel;
    UIImageView * shoucimoImage;
//    UILabel * opeiLabel;
    UILabel * oneOPeiLabel;
    UILabel * twoOPeiLabel;
    UILabel * threeOPeiLabel;
}

@property (nonatomic, retain)NSDictionary * dataDictionary;

@end
