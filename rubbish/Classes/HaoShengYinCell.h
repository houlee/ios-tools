//
//  HaoShengYinCell.h
//  caibo
//
//  Created by houchenguang on 13-1-17.
//
//

#import <UIKit/UIKit.h>
#import "HaoShengYinData.h"
#import "ImageStoreReceiver.h"
#import "DownLoadImageView.h"

@protocol haoShengYinDelegate <NSObject>

- (void)returnDidSetSelecteInTheRow:(NSInteger)selecteRow;

@end

@interface HaoShengYinCell : UITableViewCell{

    DownLoadImageView * headImge;
    
    UILabel * nameLabel;
    UIImageView * xinImge;
    UILabel * dengjiLabel;
    UIImageView * dengjiiamge1;
    
    UILabel * moneyLabel;
    HaoShengYinData * haoData;
    ImageStoreReceiver *receiver;
//    UILabel * timeLabel;
    NSInteger row;
    id<haoShengYinDelegate>delegate;
}

@property (nonatomic, assign)id<haoShengYinDelegate>delegate;
@property (nonatomic, retain)HaoShengYinData * haoData;
@property (nonatomic, assign)NSInteger row;

- (void)returnDidSetSelecteInTheRow:(NSInteger)selecteRow;

@end
