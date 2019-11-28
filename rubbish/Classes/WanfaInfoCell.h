//
//  WanfaInfoCell.h
//  TableTest
//
//  Created by cp365dev on 14-5-6.
//  Copyright (c) 2014年 cp365dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WanfaInfoCell : UITableViewCell

{
    int lieshu;    //列数
    int hangofCell;//行数
    
    NSArray *jiangjiArray;//奖级数组
    NSArray *zjtiaojianArray;//中奖条件数组
    NSArray *zjshuomingArray;//中奖说明数组
    NSArray *jiangjinArray;//奖金数组
    
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    BOOL isQiLeCai;
    


}
@property (nonatomic) int lieshu;
@property (nonatomic) int hangofCell;
@property (nonatomic, retain) NSArray *jiangjiArray;
@property (nonatomic, retain) NSArray *zjtiaojianArray;
@property (nonatomic, retain) NSArray *zjshuomingArray;

@property (nonatomic, retain) NSArray *jiangjinArray;

@property (nonatomic, assign) BOOL isQiLeCai;




//第一列
-(void)addCell1:(NSString *)jiangji andCellNUm:(int)num andWedith:(int)wed;
-(void)addCell1:(NSString *)jiangji andCellNUm:(int)num andWedith:(int)wed lineHeight:(float)height;
//第二列（文字）
-(void)addCell2:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed;
-(void)addCell2:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed textAlignment:(NSTextAlignment)textAlignment;



//第二列（球）
-(void)addCell2WithRedBordNum:(int)redNum andBlueBordNum:(int)blueNum andCellNum:(int)num andWedith:(int)wed ;


//第三列
-(void)addCell3:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed;
//第三列(带球滴)
-(void)addCell3WithBord:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed;

//第四列
-(void)addCell4:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed;


//一列对多行
-(void)addCell2Another:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed andX:(int)y;
-(void)addCell3Another:(NSString *)jiangji andCellNum:(int)num andWedith:(int)wed andX:(int)y;

@end

