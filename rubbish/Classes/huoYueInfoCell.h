//
//  huoYueInfoCell.h
//  caibo
//
//  Created by houchenguang on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "houYueInfoData.h"

@interface huoYueInfoCell : UITableViewCell{
    UILabel * gangla;
    UILabel * datela;
    UILabel * timela;
    UILabel * userla;
    UILabel * operatela;
    UILabel * moneyla;
    houYueInfoDataResult * infodata;
}

@property (nonatomic, retain)houYueInfoDataResult * infodata;

@end
