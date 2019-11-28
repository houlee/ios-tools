//
//  ZuCaiJinQiuCell.h
//  caibo
//
//  Created by yao on 12-5-9.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZuCaiJinQiuCell : UITableViewCell {
	UILabel *numLabel1;
	UILabel *saishiLabel1;
	UILabel *duizhenLabel1;
	UILabel *jinqiu0Label1;
	UILabel *jinqiu1Label1;
	UILabel *jinqiu2Label1;
	UILabel *jinqiu3Label1;
	
	UILabel *numLabel2;
	UILabel *duizhenLabel2;
	UILabel *jinqiu0Label2;
	UILabel *jinqiu1Label2;
	UILabel *jinqiu2Label2;
	UILabel *jinqiu3Label2;
	
	UIView *shuxianView1;
	UIView *shuxianView2;
	UIView *shuxianView3;
	UIView *shuxianView4;
	UIView *shuxianView5;
	UIView *shuxianView6;
	
	UIView *hengxianView1;
	UIView *hengxianView2;
	UIView *hengxianView3;
}
- (void)LoadData:(NSDictionary *)dic Is4:(BOOL)is4;
- (void)setLabelColor:(UIColor *)_color;

@end
