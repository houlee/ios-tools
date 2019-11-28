//
//  LanQiuRankCell.h
//  caibo
//
//  Created by yaofuyu on 13-12-13.
//
//

#import <UIKit/UIKit.h>

@interface LanQiuRankCell : UITableViewCell {
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    UILabel *lab6;
    UIImageView *imageV;
    UIImageView *backImageV;
    NSString *hostID;
    NSString *guestID;
}
@property (nonatomic,copy)NSString *hostID,*guestID;

- (void)LoadData:(NSDictionary *)dic;

@end
