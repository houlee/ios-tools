//
//  YtTopic.h
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// 帖子 列表接口，所有 “返回 值参考 2.1” 的解析类 

#import <Foundation/Foundation.h>
#import "ColorLabel.h"

typedef enum {
    CAIBO_TYPE_HOME,// 首页
    CAIBO_TYPE_COMMENT,// 评论
} CaiboType;

@interface YtTopic : NSObject <ColorLabelDelegate>{
	NSMutableArray *arrayList;
	NSString *region;
	NSString *site;
	NSString *attach_small;// 附件 小图
	NSString *topicid;
	NSString *lottery_id;
	NSString *lottery_id_ref;//
	NSString *count_zf;
	NSString *userid;
	NSString *mid_image;
	NSString *image;
	NSString *count_sc;
	NSString *date_created;
	NSString *count_pl;
	NSString *city;
	NSString *nick_name;
	NSString *vip;
	NSString *content;
	NSString *timeformate;
	NSString *attach;
	NSString *orignal_id;
	NSString *project_id;
	NSString *province;
	NSString *sma_image;
	NSString *is_attention;
	NSString *attach_type;
	NSString *source;
    NSString *count_zf_ref;
    NSString *count_pl_ref;
	NSString *type;//新闻推送
	NSString *oriDelFlag;//原帖是否呗删除
    
    
	//以下参数,有原帖时存在
	NSString *content_ref;
	NSString *nick_name_ref;
	// 将原帖用户名和原帖内容拼接
	NSString *orignalText;
	// 首页经过处理的内容和数据
	NSString *mcontent;
	NSString *mcontent_ref;
    NSString *colorcontentl;
    NSString *colorcontent_ref;
    
    NSString *isCc;
    
    NSString *attach_type_ref;
    NSString *attach_small_ref;
    NSString *attach_ref;// 原帖大图
    
    CGFloat cellHeight;
    CGRect  textBounds;
    CGRect  orignalTextBounds;
    BOOL    isBubbleTheme;
    BOOL    hasImage;
	BOOL    isNewComond;
    NSString * newstitle;
    CaiboType caiboType;
    
    BOOL isAuto;
    
    NSString * blogtype;//微博广场头几行的类型 活动/加奖/竞猜等
    NSString * blogCount;//微博广场头几行的条数 一条直接跳 多条跳列表
    
    BOOL reRequest;
    
    NSIndexPath * indexPath;
    
    float mcontentHeight;
    float mcontentRefHeight;
    UITableView * tableView;
    
    NSString * count_dz;//点赞个数
    NSString * praisestate;//点赞状态  1 已赞  0 未赞
}

@property (nonatomic,retain) NSMutableArray *arrayList;
@property (nonatomic,copy) NSString *region,*site,*attach_small,*topicid,*lottery_id,*count_zf,
*mid_image,*image,*count_sc,*date_created,*count_pl,*city,*nick_name,*vip,*oriDelFlag,
*content,*timeformate,*attach,*orignal_id,*project_id,*province,*sma_image,*is_attention,*lottery_id_ref,
*attach_type,*source, *nick_name_ref, *content_ref,*count_zf_ref,*count_pl_ref,*isCc, *userid, *orignalText, *mcontent, *mcontent_ref,*colorcontentl,*colorcontent_ref, *type, *attach_type_ref, *attach_small_ref, *attach_ref, * newstitle, * blogtype, * blogCount, * count_dz, * praisestate;
@property (nonatomic, assign) CGFloat cellHeight;// tableViewCell的高度
@property (nonatomic, assign) CGRect  textBounds;// 微博内容矩形区域
@property (nonatomic, assign) CGRect  orignalTextBounds;// 原帖内容矩形区域
@property (nonatomic, readwrite) BOOL isBubbleTheme, hasImage;
@property (nonatomic,assign) BOOL    isNewComond;
@property (nonatomic, assign) CaiboType caiboType;

@property (nonatomic, assign) BOOL isAuto;

@property (nonatomic, assign) BOOL reRequest;

@property (nonatomic, retain)NSIndexPath * indexPath;
@property (nonatomic,assign)float mcontentHeight;
@property (nonatomic,assign)float mcontentRefHeight;
@property (nonatomic, assign)UITableView *tableView;

-(id) initWithParse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;
- (int) calcTextBounds : (YtTopic*) status;
- (BOOL) isFangan:(NSString *)_attach_type;
- (BOOL)isZhiChiBiSai:(NSString *)_lottryid;
-(id)initWithHomeParse:(NSString*)responseString homeBool:(BOOL)yesOrNo;
//- (void)loadFinished:(ColorLabel *)label;

- (int)calcTextBounds;
@end
