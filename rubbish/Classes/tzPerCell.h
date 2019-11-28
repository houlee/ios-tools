//
//  tzPerCell.h
//  caibo
//
//  Created by yao on 12-5-5.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	tzPerCellTypeJC,//竞彩
	tzPerCellTypeBD,//北单
	tzPerCellTypeZC//足彩
	
}tzPerCellType;

@interface tzPerCell : UITableViewCell {
	UILabel *name1Label;
	UILabel *name2Label;
	UILabel *name3Label;
	UILabel *name4Label;
	UILabel *name5Label;
	
	UIImageView *imageV;
}

- (void)LoadDataName1:(NSString *)name1
				Name2:(NSString *)name2
				Name3:(NSString *)name3
				Name4:(NSString *)name4
				Name5:(NSString *)name5
			  isTitle:(BOOL)isTitle;

- (void)LoadDataDic1:(NSDictionary *)dic1
				Dic2:(NSDictionary *)dic2
				Dic3:(NSDictionary *)dic3
				Dic4:(NSDictionary *)dic4
				Dic5:(NSDictionary *)dic5
			  isTitle:(BOOL)isTitle;

@end
