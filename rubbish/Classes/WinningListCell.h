//
//  WinningListCell.h
//  caibo
//
//  Created by cp365dev on 14-5-13.
//
//

#import <UIKit/UIKit.h>

@interface WinningListCell : UITableViewCell

@property (nonatomic, retain) NSString *mYear;
@property (nonatomic, retain) NSString *mMouth;
@property (nonatomic, retain) NSString *mDay;
-(void)addCellWithTime:(NSString *)time andName:(NSString *)name andPrize:(NSString *)prize andType:(NSString *)type;

@end
