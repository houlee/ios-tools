//
//  NewsData.h
//  caibo
//
//  Created by  on 12-7-3.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsData : NSObject{
    NSString * newstitle;
    NSString * newstime;
    NSString * laizi;
    NSString * newsid;
    NSString * type;
    NSString * content;
    NSString * timeformate;
    NSString * attach_small;
    NSString * count_zf;
    NSString * count_pl;
    NSString * image_b;
    NSString * issue;//天天竞彩期数
    NSString * type_news1;//类型 1是普通新闻，2是公告，3是双色球预测，4是大乐透预测，5.是3D预测, 10 天天竞猜
    NSString * intro;//预测内容
    
    NSString *type_id;//banner类型 1、微博  2、方案 3、url 4、客户端购彩页 5、H5购彩投注
    NSString *flag;   //内容  微博id或url
    
    NSString *lottery_id;//彩种ID
    NSString *play_id;//玩法ID
    NSString *bet_id;//投注方式ID
    NSString *h5_url;//h5地址
    NSString *staySecond;//每张广告停留时间
    
    
}
@property (nonatomic, retain)NSString * newstitle, * newstime, * laizi, * newsid, * type ,* issue,* type_news1,* intro;
@property (nonatomic, retain)NSString * content, * timeformate, *attach_small, *count_zf, *count_pl, *image_b;

@property (nonatomic, copy) NSString *type_id,*flag,*lottery_id,*play_id,*bet_id,*staySecond;
@end
