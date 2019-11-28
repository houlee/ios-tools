//
//  OddInfoTableViewCell.h
//  caibo
//
//  Created by houchenguang on 14-5-23.
//
//

#import <UIKit/UIKit.h>

@interface OddInfoTableViewCell : UITableViewCell{
    
    NSDictionary * oddsDictionary;
    NSIndexPath * oddIndexPath;
    UILabel * chupanLabel;
    UILabel * oneShengLable;
    UILabel * onePingLable;
    UILabel * oneFuLable;
    NSInteger oddsInteger;
    
}

@property (nonatomic, retain)NSDictionary * oddsDictionary;
@property (nonatomic, retain) NSIndexPath * oddIndexPath;
@property (nonatomic, assign)NSInteger oddsInteger;

@end
