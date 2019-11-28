//
//  MySaleTableCell.h
//  Experts
//
//  Created by V1pin on 15/11/3.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySaleTableCell : UITableViewCell{
    UILabel *_group;//队伍
    UIImageView *_ypImgView;//亚盘图标
    UIImageView *_sdImgView;//神单方案图标
    UILabel *_prices;//定价跟销量
    UILabel *_sales;
    
    UILabel *_group2;//队伍
    UIButton *erchuanyiBtn;
    UIButton *jingcaiBtn;
    UIImageView *lineIma;
}

-(void)group:(NSString *)group price:(NSString *)price sales:(NSString *)sales lotryTpye:(NSString *)lotryTpye sdType:(NSString *)sdType;

-(void)loadAppointInfo:(NSDictionary *)dict;
-(void)loadErchuanyiAppointInfo:(NSDictionary *)dict;

@end
