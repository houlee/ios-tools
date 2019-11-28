//
//  datafile.h
//  caibo
//
//  Created by user on 11-7-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



//关闭面 开关标记(公用)
#define OTHER_SWITCH_OFF @"other_switch_off"


//设置界面 图片质量标记
#define KEY_PICTURE_QUALITY @"picture_quality"
#define QUALITH_HIGH @"quality_high"
#define QUALITH_MIDDLE @"quality_middle"
#define QUALITH_LOW @"quality_low"

//设置界面 提示音 关联的开关标记(打开面)
#define KEY_SWITCH_TONE @"switch_tone"  //提示音开关 键值
#define SWITCH_TONE_ON @"switch_tone_on"

//推送通知界面 关联的开关标记
#define KEY_ZHONGJIANG @"zhongjiang"  //中奖推送提示开关
#define ZHONGJIANG_SWITCH_ON @"zhongjiang_switch_on"


#define KEY_KAIJIANG @"kaijiang"  //开奖推送提示开关
#define KAIJIANG_SWITCH_ON @"kaijiang_switch_on"





#define KEY_COMMENT @"comment"  //评论开关 键值
#define COMMENT_SWITCH_ON @"comment_switch_on"

#define KEY_MENTION @"mention"  //提到我的开关 键值
#define MENTION_SWITCH_ON @"mention_switch_on"

#define KEY_PRIVATE_LETTER @"private_letter"  //私信开关 键值
#define PRIVATE_LETTER_SWITCH_ON @"private_letter_switch_on"

#define KEY_NEW_FANS @"new_fans"  //新粉丝开关 键值
#define NEW_FANS_SWITCH_ON @"new_fans_switch_on"


//消息提醒界面 关联的标记字符串
#define KEY_MESSAGE_ALERTS @"message_alerts"  //消息提醒 键值
#define CLOSE_NOTICE @"close_notice"      //关闭通知
#define HALF_A_MINUTE @"half_a_minute"    //半分钟
#define TWO_MINTERS @"two_minters"        //2分钟
#define FIVE_MINTERS @"five_minters"      //5分钟


//通知接收时段
#define KEY_BEGIN_TIME @"key_begin_time"  //开始时间
#define BEGIN_TIME @"begin_time"
#define KEY_END_TIME @"key_end_time"      //结束时间
//#define END_TIME @"end_time"



//阅读模式
#define KEY_READING_MODEL  @"key_reading_model"   //键值
#define PREVIEW_MODEL      @"preview_model"       //预览图模式
#define REMARKABLE_MODEL   @"remarkable_model"    //经典模式
#define WORD_MODEL         @"word_model"          //文字模式
#define BBS_MODEL          @"bbs_model"           //论坛模式



//显示缩略模式 开关键
#define KEY_SWITCH_CONTRACTION_MODEL   @"key_contraction_model"
#define SWITCH_CONTRACTION_MODEL_ON    @"switch_contraction_model_on"


//主题
#define KEY_THEME      @"key_theme"
#define LIST_THEME     @"list_theme"      //列表主题
#define BUBBLE_THEME   @"bubble_theme"    //气泡主题

#define SWITCH1NUM  10000             //开奖tag表示符
#define SWITCH2NUM  20000             //中奖开关表示符


@interface datafile : NSObject {

}


//获取数据
+ (NSString *)getDataByKey: (NSString *)key;

//写入数据
+ (void)setdata: (NSString *)string forkey: (NSString *)key;

@end










