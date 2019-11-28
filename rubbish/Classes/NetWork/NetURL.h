//
//  HttpService.h
//  caibo
//
//  Created by jacob on 11-5-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "caiboAppDelegate.h"


#define TEST_URL  @"http://tapi.diyicai.com:7073/api/mobileClientApi.action?"
//#define HOST_URL @"http://122.11.50.164:7070/api/mobileClientApi.action?"

//#define BangdingURL @"http://122.11.50.164:7070/api/unionLogin/postLogin.action?"


//可变测试环境
//#define BangdingURL [[Info getInstance] testBangdingurl]
//#define IP_URL [[Info getInstance] testipURL]
//#define HOST_URL  [[Info getInstance] testhost2]
//#define pkweb_URL [[Info getInstance] testpkweburl]
//#define checkNew_URL [[Info getInstance] testcheckNew]
//#define  buyLotteryHall [[Info getInstance] testbuylotter]
//#define verifyCode [[Info getInstance] testverify]
//#define licai365H5URL [[Info getInstance] testlicai]
//#define happyH5_URL [[Info getInstance] testHappy]




//正式测试1
//#define BangdingURL @"http://cpapi.dingdingcai.com/api/unionLogin/postLogin.action?"
//#define IP_URL @"http://cpapi.dingdingcai.com"
//#define HOST_URL  @"http://211.151.37.58:8080/api/mobileClientApi.action?"//正式
//#define pkweb_URL @"http://m.dingdingcai.com/wap//csj/openapi/PKcheck.jsp?"//pk赛跳网页
//#define checkNew_URL @"http://211.151.37.58:8080/api/mobileClientApi.action?"//checkNew新地址
//#define  buyLotteryHall @"http://download.caipiao365.com/cp365/config/buylotteryhall.txt"
//#define verifyCode @"http://211.151.37.58/api/servlet/verifyCode?type=reg"
//#define licai365H5URL @"http://t.caipiao365.com/"
//#define happyH5_URL @"http://t.caipiao365.com/"




// 正式

#define BangdingURL @"http://cpapi.dingdingcai.com/api/unionLogin/postLogin.action?"
#define IP_URL @"http://cpapi.dingdingcai.com"
#define HOST_URL  @"http://cpapi.dingdingcai.com/api/mobileClientApi.action?"//正式
#define pkweb_URL @"http://m.dingdingcai.com/wap//csj/openapi/PKcheck.jsp?"//pk赛跳网页
#define checkNew_URL @"http://cpapinc.diyicai.com/api/mobileClientApi.action?"//checkNew新地址
#define  buyLotteryHall @"http://download.caipiao365.com/cp365/config/tc_lotteryhall.txt"
#define BaseAPI  @"http://cpapi.dingdingcai.com/api/zjtj.action"// @"http://cpapi.dingdingcai.com/api/zjtj.action"//正式
#define verifyCode @"http://cpapi.dingdingcai.com/api/servlet/verifyCode?type=reg"
#define licai365H5URL @"http://t.caipiao365.com/"
#define happyH5_URL @"http://t.caipiao365.com/"
#define UPLOADHOST @"http://upload.dingdingcai.com"
#define PUBLICURL @"http://public.dingdingcai.com"




// 测试

//#define BangdingURL @"http://tcpapi.cmwb.com/api/unionLogin/postLogin.action?"//122.11.50.208:8088
//#define IP_URL @"http://tcpapi.cmwb.com"
//#define HOST_URL @"http://cpapi.zcw.com/api/mobileClientApi.action?"//测试cpapi.betrich.com// //@"http://tcpapi.cmwb.com/api/mobileClientApi.action?"
////#define HOST_URL @"http://tcpapi.cmwb.com/api/mobileClientApi.action?"
//#define pkweb_URL @"http://tm.cmwb.com/wap//csj/openapi/PKcheck.jsp?"//pk赛跳网页
//#define checkNew_URL @"http://test2.cmwb.com/api/mobileClientApi.action?"//checkNew新地址
//#define  buyLotteryHall @"http://tmoapi.cmwb.com/buylotteryhall.txt"
//#define verifyCode @"http://tcpapi.cmwb.com/api/servlet/verifyCode?type=reg"
//#define licai365H5URL @"http://th6.cmwb.com/"
//#define happyH5_URL @"http://h5123.cmwb.com/"



// 公网 56
//#define BangdingURL @"http://cpapi.dingdingcai.com/api/unionLogin/postLogin.action?"//122.11.50.208:8088
//#define IP_URL @"http://cpapi.dingdingcai.com"
//#define HOST_URL  @"http://tcpapi.cmwb.com/api/mobileClientApi.action?"//测试cpapi.betrich.com//http://192.168.5.26:8082/api/mobileClientApi.action?
//#define pkweb_URL @"http://tm.cmwb.com/wap//csj/openapi/PKcheck.jsp?"//pk赛跳网页
//#define checkNew_URL @"http://tcpapi.cmwb.com/api/mobileClientApi.action?"//checkNew新地址
//#define  buyLotteryHall @"http://tmoapi.cmwb.com/buylotteryhall.txt"
//#define verifyCode @"http://tcpapi.cmwb.com/api/servlet/verifyCode?type=reg"
//#define licai365H5URL @"http://h5123.cmwb.com/"
//#define happyH5_URL @"http://h5123.cmwb.com/"




#define Image_URL @"http://t.diyicai.com"
#define clientSecretKey @"eTeasHujm2lrrfas"//secret加密
#define clientParaKey @"sfsaNn_A2bytbd10"//单个加密kGetUnreadPushNum
#define AllparaSecretKey @"XZYE8HiXABKrBfXT"// 整体加密

//#ifdef isCaiPiaoForIPad
//#define kSouse  @"15"
//#else
//    #ifdef is365CaiPiao
//        #define kSouse  @"17"
//    #else
//        #ifdef isJinShanIphone
//            #ifdef isJinShanIphoneNew
//            #define kSouse  @"19"
//            #else
//            #define kSouse  @"14"
//            #endif
//
//        #else
//            #ifdef isCaiPiao365ForIphone5
//                #define kSouse  @"13"
//            #else
//                #define kSouse  @"8"
//            #endif
//        #endif
//    #endif
//#endif

#define klogin    @"newLoginest"//newLogin //2.22 登录
#define kregister @"newregister"// 2.24 注册

#define kForgetPassStep1 @"forgetPassStep1" // 2.22 找回密码第一步：获取验证码
#define kResetPassword @"resetPasswd" // 2.23 找回密码第二步：重置密码
#define ksaveYtTopic @"saveYtTopic" //2.3发帖转帖
#define ksaveYtComment @"saveYtComment" //2.4 评论
#define klistAttentionYtTopic @"listAttentionYtTopic" //2.5关注人 发帖列表 （首页 列表）
#define klistYtTopicByUserId @"listYtTopicByUserId"//2.7 用户发帖列表
#define kgetCommentList @"getCommentList"//2.8 获取评论
#define kgetYtTopicCommentList @"getYtTopicCommentList"// 2.9获取帖子评论
#define kgetMyFansList @"getMyFansList"// 2.18 粉丝列表
#define kgetMyAttenList @"getMyAttenList"//2.19 关注列表
#define kgetUserIdByName @"getUserIdByName" //2.17获取用户ID
#define kgetUserInfo @"getUserInfo" //2.6获取用户信息
#define kgetRelationByUserId @"getRelationbyuserid" // 2.20 获取和指定用户的关系
#define ksaveAttention @"saveAttention"// 2.10 添加关注
#define kcancelAttention @"cancelAttention"// 2.13 取消关注
#define ksaveFavorite @"saveFavorite"// 2.26 收藏
#define klistFavoYtTopicByUserId @"listFavoYtTopicByUserId"// 2.28 用户收藏帖子列表
#define klistYtTheme @"listYtTheme"// 2.30获取话题列表
#define kgetThemetYtTipic @"getThemetYtTipic"// 2.31 获取话题列表
#define klistHotYtTopic @"listHotYtTopic"// 2.34 获取热门转发
#define klistHotYtComent @"listHotYtComment"// 2.35 获取热门评论
#define kgetBlackUserList @"getBlackUserList"// 2.36 我的黑名单
#define ksaveBlackUser @"saveBlackUser"// 2.37 添加黑名单
#define kdeleteBlackUser @"deleteBlackUser"//2.38 解除黑名单
#define ksendMail @"sendMail"// 2.39 发私信
#define knewMailList @"newMailList"// 2.67 新私信列表
#define kgetAtmeTopicList @"getAtmeTopicList"//2.42获取@博主帖子列表
#define ksearchTopicList @"searchTopicList"//2.43搜索帖子列表
#define ksearchUserList @"searchUserList"//2.44 搜索人列表
#define kgetOrganizationYtTopicList @"getOrganizationYtTopicList"// 2.45官方微博 发帖 列表
#define kshareYtTopic @"shareYtTopic"//2.46 分享帖子
#define katmeUser @"atmeUser" //2.47 @博主
#define kcheckUpdate @"checkUpdate"//2.48 检查更新
#define knewUpdateTime @"newUpdateTime"//2.49 新评论、新私信和新粉丝提醒
#define kqA @"qA1"// 2.77 新问题反馈
#define ksendComment @"sendComment"// 2.51 评c论回复
#define kgetBlackRelation @"checkBlackUser" // 2.52 获取我和某人的黑名单关系
#define kgetUserGroupList @"getUserGroupList"// 2.54 查看分组
#define kEditPerInfo @"updateUser" // 2.56 编辑个人资料
#define kGetUnreadPushNum @"checkNewMsg_new" // // 2.57 未读的推送消息数（广场）
#define kGetPassword @"retrievePwd" // 2.59 新密码找回
#define kGetBindState @"selectKeepUserStatus" // 2.60 新查询用户绑定状态接口
#define kbindMail @"keepMailUser" // 2.61 邮箱绑定
#define kgetPassCode @"keepMobileUser" // 2.62 获取手机验证码
#define kbindPhone @"keepMobileUser2" // 2.63 发送验证码
#define klistYtThemeGz @"listYtThemeGz"// 2.65 获取关注话题
#define kgetTopicListById @"getTopicListById"//2.64 获取帖子详情
#define klistYtTopicByZhuanjia @"listYtTopicByZhuanjia"// 2.29 专家说
#define klistYtTopicByOther @"listYtTopicByOther"// 2.58 其他消息列表（最新开奖，最新动态，官方组织等）

#define klistYtTopic @"listYtTopic"// 2.1 广场首页－帖子列表
#define klistytTopicac @"listYtTopic_ac"//listYtTopic65. 广场添加活动推送 取代listYtTopic
#define klistYtTopicNew @"listYtTopicNew"//2.1new；

#define klistytTopicType @"getYtTopicTypelist"//118.微博类型列表


#define kgetTopicListByGroupId @"getTopicListByGroupId"// 2.66 分组帖子列表
#define kdeleteCommentById @"deleteCommentById"// 2.70 删除自己评论
#define kdeleteUserTopicById @"deleteUserTopicById"// 2.71取消收藏
#define kusersMailList @"usersMailList"//2.68 一对一私信usersMailList
#define kefuMailList @"usersMailList_add_pic" //客服私信
#define kdelUsersMailList @"delUsersMailList"//2.72删除私信
#define kgetMailList1 @"getMailList1" // 2.74获取相互关注私信列表人
#define kpushMessageList @"pushMessageList"// 2.69 推送消息接口（关注人列表修改）
#define kreport @"report1"// 2.78 新举报
#define kdelTopic @"delTopic"// 2.75删除微博
#define kdelUsersMailById @"delUsersMailById"// 2.76 删除 单条通知
#define kcollectTheme @"collectionTheme" // 2.79 话题收藏 
#define kdelCollectionTheme @"delCollectionTheme" // 2.80 取消话题收藏
#define kgetThemeStatus @"collectionThemeStatus" // 2.81 话题收藏状态

/*****比分直播*****/
#define kgetAttentionMatchList @"getAttentionMatchList" // 2.82 比分关注和结束比赛
#define kgetMatchInfo @"getMatchinfo" // 2.83 获取比赛信息
#define kattentionMatch @"attentionMatch" // 2.84 关注比赛
#define kcancelAttentionMatch @"cancelAttentionMatch" // 2.85 取消关注比赛
#define kgetLeagueList @"getLeagueList" // 2.86 获取比赛的赛事列表
#define kgetLotteryTypeList @"getLotteryTypeList" // 2.87 获取比赛的彩种列表
#define kgetMatchListByLotteryType @"getMatchListByLotteryType" // 2.88 根据彩种获取比赛列表
#define kLanqiuLiveMatchList @"LanqiuLiveMatchList" //了获取篮球比赛列表
#define ksynLanqiuLiveMatchList @"synLanqiuLiveMatchList"  //篮球刷新
#define kLanqiuLiveMatchDetail  @"LanqiuLiveMatchDetail"  //83获取篮球赛事详情
#define ksynLanqiuLiveMatchDetai @"synLanqiuLiveMatchDetail" //84篮球详情刷新

#define kgetIssueList @"getIssueList"  // 2.89 根据彩种获取彩期列表
#define kaddGoalNotice @"addGoalNotice" // 2.91 增加进球通知
#define kcancelGoalNotice @"cancelGoalNotice"  // 2.92 取消进球通知
#define kautoRefreshMyAtt @"synAttentionMatchList" // 2.93 关注列表数据更新接口
#define kautoRefreshLottery @"synMatchListByType" // 2.94 彩种列表数据更新接口
#define kwelcomePageUpdate @"getLoginPic" //2.95 欢迎图片检查更新
#define kadvertisementPic   @"getAdvPic" //2.96 广告位图片检查更新
#define ksynLotteryHall @"synLotteryHallNewest" // 2.97 开奖大厅
#define ksynLotteryDetails @"synLotteryDetails" // 2.98 开奖详情
#define ksynLotteryList @"synLotteryList" // 2.99 开奖列表
#define kgetSpUsersList @"getSpUsersList" // 3.3特殊用户数据列表
#define ksaveMoreAttentions @"saveMoreAttentions"//3.4关注多人；

#define kiosIdetity  @"03" //iphone 客户端标志号

#define kgetPushStatus @"getPushStatus" // 3.5获取推送设置数据
#define ksetPushStatus @"setPushStatus" // 3.6设置推送设置数据
#define kgetLotteryStaion @"kgetLotteryStaion" //station column

#define kSetLikeLotteryByUserId @"setLikeLotteryByUserId"//彩票喜好设置
#define kgetLikeLotteryByUserId @"getLikeLotteryByUserId"//获取偏好设置

#define ksetNickNameForUnionUser @"setNickNameForUnionUser"//4.7合作用户补充昵称接口
#define kaddPPTVuserInfo  @"addPPTVuserInfo"//pptv完善昵称
#define ksetSysBlogForUnionUser @"setSysBlogForUnionUser"//4.8合作用户设置同步接口
#define kgetSysBlogForUnionUser	@"getSysBlogForUnionUser"//4.9获取合作用户同步设置接口
#define kdelAppMsg			@"delAppMsg"//5.0 清除app应用消息 
#define kauthentication			@"SendMontoAddUserInfo_est"//5.1 设定用户实名信息


/*********pk赛***********/
#define pkgRade @"awardRank"//pk赛排行等级
#define pkIssue @"pkIssueList"//查询在售/往期期次列表
#define pkRecord @"pkBetRecord" //查询pk赛的投注记录
#define myRecord @"myPkBetRecord"//我的pk赛的投注记录
#define pkStatistics @"pkGuoguan"//过关统计
#define pkDetails @"orderDetail"//pk赛方案详情
#define pkSearch @"pkSearch"//pk赛搜索
#define pkInfo @"pkMatchInfo"//pk赛对阵信息
#define pkBet @"pkBuyLottery"//pk投注

/*********365***********/
#define cpsanliuwu @"getHotThemet"//话题里的label
#define cplottery @"issueInfo"//彩种最新期次
#define cpred @"getHotStar"//红人榜
#define cpthreesearch @"userSearch"//投注站搜索
#define ktopicBetInfo @"topicBetInfo"//帖子投注详情
#define kgetBFYC   @"getBFYC"//365八方预测
#define krefreshEURO @"refreshEURO"//刷新哦呸
#define krefreshASIA @"refreshASIA"//刷新亚赔
#define KrefreshBall @"refreshBall"//刷新大小分
#define kgetLanqiuBFYC @"getLanqiuBFYC"//篮球八方预测
#define kgetLanqiuBFYCPHB @"getLanqiuBFYCPHB"//篮球八方预测排名

#define kgetYL @"getYL"//遗漏图
#define kgetYL_K3 @"getYL_K3"//快3遗漏图
#define cpthreeAuthentication @"getAuthentication"//获取用户信息 投注站
#define userAuthentication @"authentication"//只完善用户信息
#define cpthreeqa @"qA2"//新问题反馈
#define cpthreesend @"sendPreditTopic"//我来预测发送

#define cpthreehuati @"getLotteryDetails_new"//开奖话题
#define kgetSessionIdbyUL @"getSessionIdbyUL"//第三方获取token

#ifdef  isCaiPiao365AndPPTV
#define bafangshipin @"queryViewInfor_new"//新八方视频
#else
#define bafangshipin @"queryViewInfor"//八方视频
#endif

#define ksendTopicMessageToMq @"sendTopicMessageToMq"//第三方分享；
#define hemaihongrenbang @"getHotStarbylotteryID"//合买红人榜
#define cpthreeNews @"getNewsList"//新闻列表
#define cphreeuserid @"GetUserIdbyUserName"//通过username来获取userid

#define cploginsave @"loginSave"//保存登录信息登录


#define kInviteFriend @"InviteFriend"//邀请好友

#define kqueryActivtyList @"queryActivtyList^s_act"//奖励活动列表

#define kefusixin @"checkkfsx^s_newse"//客服私信 服务端返回多长时间刷新一次的时间

#define kgetAppInfoList @"getAppInfoList"//获取app应用列表
#define cpqueryVoice @"queryVoice"//好声音

#define n11xuan5 @"getElevenSelectedFive"//11选5遗漏图
#define kl10fen @"getKLSF"//快乐十分

#define FindPasswordgetUserInfo @"getbackPassfindUser"//找回密码之查询用户信息
#define FindPasswordgetJiaoyanma @"getbackPassgetValidate"//找回密码之获取校验码
#define FindPasswordInputJiaoyanma @"getbackPassSetValidate"//找回密码之输入校验码
#define FindPasswordChangePassword @"getbackPassSetPwd"//找回密码之修改密码

#define KqueryUnionshareBlogStatus @"queryUnionshareBlogStatus"//检测微博

#define footballLotteryDatail @"Kaijiang_datail"//官方开奖 足彩北单篮彩

#define getMacthTypeNew @"getMatchListByLotteryTypeNew"//63 获取比分直播列表（足彩竟彩北单）

#define myAttentionNew @"getAttentionMatchListNew"//64. 我的关注的比赛

#define kunLogin @"UnLogin" //66. 未登录推送接口
#define kgetMatchInfoNew @"getMatchinfo_new"
#define kLiveMatchListByID @"LiveMatchListByID"//70. 投注详情具体比赛时时比分
#define kdeleteUserByMan @"deleteUserByMan" //51 管理员删除用户
#define kdeleteTopicByMan @"deleteTopicByMan"//52 管理员删除帖子
#define kdeleteCommonByMan @"deleteCommonByMan"//53 管理员删除评论
#define kgetUserInfoByMan @"getUserInfoByMan" //56管理员获取用户信息

#define kCheckAchieveActivMon @"CheckSendLotteryMoney" //77检测能否参加“7天免费领彩票”活动
#define kachieveActivMon @"SendLotteryMoney" //76关于用户“7天免费领彩票”活动
#define SHAREBLOG @"shareBlogActivity"//91.微信分享送彩金活动
#define activityInfo @"queryTopPicListBytype"//活动详情

#define forecastContent @"queryyucelist"//获取预测列表

#define everydayContent @"queryTTJC"//天天竞彩内容
#define everydayIssue @"queryTTJCissue"//天天竞彩期次

#define queryGonggao @"queryGonggao"//获取公告列表

#define kUnionLogin1 @"UnionLogin1"// sso授权登录接口

#define kJisuanjiangjin @"preCountAwards"//计算奖金
#define kpreAlipayLogin @"preAlipayLogin" //支付宝登录参数请求
#define RankingListCount @"getHotStar_all"//103红人榜总榜
#define RankingListDate @"getHotStar_recentdaily"//104红人榜日榜（按天）
#define SSQAndDLT @"getYL_new"//105新的走势图（包含双色球，大乐透）

#define getUnionName @"getUnionNickName"//84 获取用户在第三方的昵称
#define deleteUnion @"deleteUnionUserShare"//85 删除用户向第三方分享

#define SignUpFlagActive @"SignUpFlagActive"//6.0 世界杯活动报名
#define GetFlagItem @"getFlagItem"//6.1获得的国旗列表
#define GetBonusbyFlag @"getBonusbyFlag"//6.2 抢彩金接口
#define getFlagPrize_Winner @"getPrize_Winner"  //6.3国旗活动获奖列表
#define GetSignUpStatus @"getSignUpStatus"//6.4刷新报名状态
#define GetWorldCupDate @"getWorldCupDate"//112世界杯期间购彩按钮的状态

#define GetBFYCAnalyze @"getBFYCMain"//108 新版足球八方预测主接口-分析中心
#define GetBFYCOddsCenter @"getOddsCenter"//110 赔率中心
#define GetBFYCZhanji @"getZhanji"//109 获取战绩
#define GetBFYCJiFenBang @"getJiFenBang"//113足球八方预测-联赛积分榜
#define getBFYCLc @"getLc"//114足球八方预测-联赛/杯赛的所有轮次的对阵

#define getAutoResponseList @"AutoResponseList" //自动回复经典问题和近期问题

#define getAppActiveWindow @"getActiveWindow"  //应用内弹窗

#define GetDescription @"getDescription"  // 115 足彩八方预测-赛前简报
#define SetSmState @"setSmsState"//117推广短信
#define newBFYCjb @"getDescription"//115足彩八方预测-赛前简报

#define WeiBoLike @"getYtTopicPraise"

#define KsidSendMonto @"sidSendMonto"  //不同渠道号送彩金
#define StartPicInfo @"getStartPicInfo"//123客户端加载启动图接口

#define MycaipiaoImg @"getMycaipiaoImg"  //124 我的彩票图片

#define getRefillRemind @"refillRemind"//129充值列表提醒

#define keyrepairPatch   @"repairPatch"//48、 客户端打补丁接口

#define ExpertApply @"sqzjtj"//专家申请
#define ExpertCommonProblem @"zjtjhelp"//专家常见问题

@interface NetURL : NSObject
{

}
+ (NSMutableString *)returnPublicUse:(NSMutableString *)requestUrl;//每个接口必须传的4个参数
+(NSURL*)CBlistYtTopic:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid;
+(NSURL*)CBlistYtTopic:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid istoppic:(NSString *)istop;
+(NSURL*)CBlistYtTopic:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid topickID:(NSString *)topickID;

+(NSURL*)initMacCode:(NSString *)macCode Sid:(NSString *)sid Time:(NSString *)time;
+(NSURL*)CBregister:(NSString*)nickname passWord:(NSString*)password;

// 2.25 登录
+ (NSURL*)CBlogin:(NSString*)username passWord:(NSString*)password;
+ (NSURL*)CBgetSessionIdbyUL:unionId UserName:(NSString *)userName Partnerid:(NSString *)partnerid;

// 2.22 找回密码第一步：获取验证码
+ (NSURL*)CBforgetPassFristStep:(NSString*)phone;
// 2.23 找回密码第二步：重置密码
+ (NSURL*)CBResetPassword:(NSString *)phone PassCode:(NSString*)passcode PassWord:(NSString*)password RePassWord:(NSString*)repassword;

+(NSURL*)CBlistAttentionYtTopic:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBlistYtTopicByUserId:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

//2.6 获取用户信息（userId）
+ (NSURL*)CBgetUserInfoWithUserId:(NSString*)userId;
//2.6 获取用户信息（userId）世界杯
//+ (NSURL*)CBWCgetUserInfoWithUserId:(NSString*)userId;
//2.6 获取用户信息（nickName）
+ (NSURL*)CBgetUserInfoWithNickName:(NSString*)nickName;
//2.6 获取用户信息（nickName）世界杯
//+ (NSURL*)CBWCgetUserInfoWithNickName:(NSString*)nickName;

//2.20 获取和指定用户的关系
+(NSURL*)CBgetRelationByUserId:(NSString *)userId himId:(NSString*)himId;

+(NSURL*)CBSaveYtTopic : (NSString *) fwTopicId 
			   content : (NSString *) content 
			attachType : (NSString *) attachType 
				attach : (NSString*) attach 
				  type : (NSString*) type 
				userId : (NSString *) userId 
				source : (NSString*) source 
			 orignalId :(NSString *) orignalId 
			is_comment : (NSString *) is_comment
				  share:(NSString *)share
           shareorderId:(NSString *)shareorderId;

+ (NSURL*)CBSaveYtTopic:(NSString *)fwTopicId 
				content:(NSString *)content 
			 attachType:(NSString *)attachType 
				 attach:(NSString *)attach 
				  type : (NSString*) type 
				 userId:(NSString *)userId 
				 source:(NSString *)source 
			  orignalId:(NSString *)orignalId 
			 is_comment:(NSString *)is_comment 
				  share:(NSString *)share
                orderId:(NSString *)orderId
             lottery_id:(NSString *)lottery_id
                   play:(NSString *)play 
           ;

// 2.4评论
+(NSURL*)CBsaveYtComment:(NSString*)topicId 
				 content:(NSString*)content 
				  userId:(NSString*)userId 
		 is_trans_topic : (NSString *) is_trans_topic 
				 source : (NSString *) source
				   share:(NSString *)share;


+(NSURL*)CBgetCommentList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pageSize;
// 2.9获取帖子评论
+(NSURL*)CBgetYtTopicCommentList:(NSString*)userId topicId : (NSString *) topicId pageNum:(NSString*)pagenum pageSize:(NSString*)pageSize;

+(NSURL*)CBsaveAttention:(NSString*)userId attUserId:(NSString*)attUserId;

+(NSURL*)CBcancelAttention:(NSString*)userId attUserId:(NSString*)attUserId;

//2.17 获取用户ID
+(NSURL*)CBgetUserId:(NSString *)username Password:(NSString*)password;
+(NSString *)EncryptWithMD5:(NSString*)str;

+(NSURL*)CBgetMyFansList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize myUserId:(NSString*)myUserId;
+(NSURL*)CBgetMyAttenList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize myUserId:(NSString*)myUserId;

+(NSURL*)CBsaveFavorite:(NSString*)topicId userId:(NSString*)userId;

+(NSURL*)CBlistFavoYtTopicByUserId:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBlistYtTheme: (NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBgetThemetYtTipic: (NSString*)userID themeName:(NSString*)themeName pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBlistHotYtTopic;
+(NSURL*)CBlistHotYtTopic:(NSString*)userID pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBlistHotYtComment;
+(NSURL*)CBlistHotYtComment:(NSString*)userID pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

// 2.36 我的黑名单列表
+ (NSURL*)CBgetBlackUserList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBsaveBlackUser:(NSString*)userId taUserId:(NSString*)taUserId;

+(NSURL*)CBdeleteBlackUser:(NSString*)userId taUserId:(NSString*)taUserId;

+(NSURL*)CBsendMail:(NSString*)userId taUserId:(NSString*)taUserId content:(NSString*)content imageUrl:(NSString *)imageurl;

+(NSURL*)CBgetMailList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBgetAtmeTopicList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBsearchTopicList:(NSString*)keywords pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBsearchUserList:(NSString*)keywords pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBgetOrganizationYtTopicList:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBshareYtTopic:(NSString*)userId topicId:(NSString*)topicId;

+(NSURL*)CBatmeUser:(NSString*)userId topicId:(NSString*)topicId content:(NSString*)content;

+(NSURL*)CBcheckUpdate:(NSString*)version identity:(NSString*)identity;

+(NSURL*)CBnewUpdateTime:(NSString*)userId ;

// 2.52 获取我和某人的黑名单关系
+ (NSURL*)CBgetBlackRelation:(NSString*)userId himId:(NSString*)himId;

+(NSURL*)CBgetUserGroupList:(NSString*)userId pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

// 2.56 编辑个人资料
+ (NSURL*)CbEditPerInfo:(NSInteger)userId Province:(NSInteger)province City:(NSInteger)city Sex:(NSInteger)sex Signatures:(NSString*)signatures ImageUrl:(NSString*)imageUrl;
// 2.57 未读的推送消息数（广场）
+ (NSURL*)CbGetUnreadPushNum:(NSString*)userId;
// 2.59 新密码找回
+(NSURL*)CBgetPassword:(NSInteger)type NickName:(NSString*)nickName;
// 2.60 新查询用户绑定状态接口
+(NSURL*)CBgetBindState:(NSString*)nickName;
// 2.61 邮箱绑定
+ (NSURL*)CbbindMail:(NSString*)mailNum NickName:(NSString*)nickName;
// 2.62 获取手机验证码
+ (NSURL*)CbgetPassCode:(NSString*)phoneNum NickName:(NSString*)nickName;
// 2.63 发送验证码
+ (NSURL*)CbbindPhone:(NSString*)nickName PassCode:(NSString*)passCode verify:(NSString *)verify;

+(NSURL*)CBlistYtThemeGz:(NSString *)userId;

+(NSURL*)CBgetTopicListById:(NSString*)topicId;

+(NSURL*)CBsendComment:(NSString*)userId content:(NSString*)content topicId:(NSString*)topicId source:(NSString*)source totop:(NSString*)totop;

+(NSURL*)CBlistYtTopicByZhuanjia:(NSString *)pagenum pageSize:(NSString *)pagesize userId:(NSString*)userid;

+(NSURL*)CBlistYtTopicByOther:(NSString *)pagenum pageSize:(NSString *)pagesize para:(NSString*)para userId:(NSString*)userid;
// 2.70 删除自己评论
+(NSURL*)CBdeleteCommentById : (NSString *) userId commentId : (NSString *) commentId;

// 2.71 取消收藏
+(NSURL*)CBdeleteUserTopicById : (NSString *) userId topicId : (NSString *) topicId;

+(NSURL*)CBgetTopicListByGroupId:(NSString *)userId groupId:(NSString*)groupid pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBusersMailList:(NSString*)userId
				 userId2:(NSString*)userid2 
				 pageNum:(NSString*)pagenum 
				pageSize:(NSString*)pagesize 
				mailType:(NSString*)mailtype
					mode:(NSString*)mode;
+(NSURL*)CBusersMailList:(NSString*)userId userId2:(NSString*)userid2 pageNum:(NSString*)pagenum pageSize:(NSString*)pagesize;

+(NSURL*)CBdelUsersMailList:(NSString*)userId1 userId2:(NSString*)userId2;

// 2.74获取相互关注私信列表人
+(NSURL *) CBgetMaillist1 : (NSString*)userId pageNum : (NSString*)pageNum pageSize : (NSString*)pageSize;

// 2.69 推送消息
+(NSURL*)CBpushMessageList:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid;
+(NSURL*)CBpushMessageList:(NSString*)pagenum pageSize:(NSString*)pagesize maxTopicId:(NSString *)maxTopicId userId:(NSString*)userid;
+(NSURL*)CBpushMessageList:(NSString*)pagenum pageSize:(NSString*)pagesize userId:(NSString*)userid mode:(NSString*)mode;

// 2.77 新问题反馈
+(NSURL*)CBqA:(NSString*)userId Content:(NSString*)content AttachType:(unsigned short)attachType Attach:(NSString*)attach;
// 2.78 新举报
+(NSURL*)CBreport:(NSString*)userId content:(NSString*)content topicId:(NSString*)topicid;

+(NSURL*)CBdelTopic : (NSString *) userId topicId : (NSString *) topicId;

+(NSURL*)CBdelUsersMailById:(NSString*)noticeId userId:(NSString*)userId;

// 2.79 话题收藏
+(NSURL*)CBcollectTheme:(NSString*)themeId Theme:(NSString*)theme UserId:(NSString*)userId;

// 2.80 取消话题收藏
+(NSURL*)CBdelCollectionTheme:(NSString*)themeId Theme:(NSString*)theme UserId:(NSString*)userId;

// 2.81 话题收藏状态接口
+(NSURL*)CBgetThemeStatus:(NSString*)themeId Theme:(NSString*)theme UserId:(NSString*)userId;

+ (NSURL *)CBsetPushStatustwo:(NSString *)userId kj:(NSMutableArray *)kj zj:(NSString *)zj ;

/*******************比分直播******************/
// 2.82 比分关注和结束比赛
+ (NSURL *)CBgetAttentionMatchList;
// 2.83 获取比赛信息
+ (NSURL *)CBgetMatchInfo:(NSString*)userId MatchId:(NSString*)matchId LotteryId:(NSString*)lotteryId Issue:(NSString*)issue;
// 2.84 关注比赛
+ (NSURL *)CBattentionMatch:(NSString*)userId MatchId:(NSString*)matchId LotteryId:(NSString*)lotteryId Issue:(NSString*)issue;
// 2.85 取消关注比赛
+ (NSURL *)CBcancelAttentionMatch:(NSString*)userId MatchId:(NSString*)matchId LotteryId:(NSString*)lotteryId Issue:(NSString*)issue;
// 2.86 获取比赛的赛事列表
+ (NSURL *)CBgetLeagueList;
// 2.87 获取比赛的彩种列表
+ (NSURL *)CBgetLotteryTypeList;
// 2.88 根据彩种获取比赛列表
+ (NSURL *)CBgetMatchList:(NSString*)lotteryId Issue:(NSString*)issue UserId:(NSString*)userId PageNum:(NSString*)pageNum PageSize:(NSString*)pageSize;

// 81 篮球比分直播
+ (NSURL *)CBgetLanQiuMatchListWithIssue:(NSString*)issue UserId:(NSString*)userId PageNum:(NSString*)pageNum PageSize:(NSString*)pageSize Type:(NSString *)type;

//82 篮球比分直播刷新
+ (NSURL *)CBrefreshLanQiuMatchListWithIssue:(NSString*)issue PlayId:playid;

//83 篮球比分直播详情
+ (NSURL *)CBlanqiuLiveMatchDetailWithIssue:(NSString*)issue PlayId:playid;

//84 篮球比分直播详情刷新
+ (NSURL *)CBsynlanqiuLiveMatchDetailWithIssue:(NSString*)issue PlayId:playid;

// 2.89 根据彩种彩期列表
+ (NSURL *)CBgetIssueList:(NSString*)lotteryId;
// 2.90 根据赛事获取比赛列表
+ (NSURL *)CBgetMatchList:(NSString*)leagueId;
// 2.91 添加进球通知
+ (NSURL *)CBaddGoalNotice: (NSString *)userId MatchId: (NSString *)matchId lotteryId: (NSString *)lotteryId issue: (NSString *)issue;
// 2.92 取消进球通知
+ (NSURL *)CBcancelGoalNotice:(NSString*)userId MatchId:(NSString*)matchId lotteryId: (NSString *)lotteryId issue: (NSString *)issue;
// 2.93 关注列表数据更新接口
+ (NSMutableString *)getCBAutoRefreshMyAttUrl;
// 2.94 彩种列表数据更新接口
+ (NSMutableString *)CBAutoRefreshLottery:(NSString*)lotteryId Issue:(NSString*)issue;
// 2.95 欢迎图片检查更新
+ (NSURL *)CBUpdateWelcomePage;  
//2.96 广告位图片检查更新
+ (NSURL *)CBADvertisementPic;
// 2.97 开奖大厅
+ (NSURL *)CBsynLotteryHall;
// 2.98 开奖详情
+ (NSURL *)synLotteryDetails:(NSString *)lotteryId issue:(NSString *)issue status:(NSString *)status userId:(NSString *)userId;
// 2.99 开奖列表
+ (NSURL *)CBsynLotteryList:(NSString *)lotteryId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize userId:(NSString *)userId;
// 3.3 特殊用户数据列表接口
+ (NSURL *)CBgetSpUsersList:(NSString *)type pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize userId:(NSString *)userId;
+ (NSURL *)CBsaveMoreAttentions:(NSString *)userIDs userId:(NSString *)userId;
+ (NSURL *)CBgetPushStatus:(NSString *)userId;
+ (NSURL *)CBsetPushStatus:(NSString *)userId kj:(NSMutableArray *)kj zj:(NSString *)zj;

+ (NSURL *)CBgetLotteryStation:(NSMutableDictionary *)parameterDictionary;

//3.8彩票喜好设置 
+ (NSURL *)CBsetLikeLotteryByUserId:(NSString *)userId lotteryTypes:(NSString *)lotteryTypes;

//4.4获取彩票喜欢设置
+ (NSURL *)CBgetLikeLotteryByUserId:(NSString *)userId;

//4.5 合作用户登录连接
+ (NSURL *)CBUnitonLogin:(NSString *)loginSource;//新郎1，腾讯3，腾讯微博2；
+ (NSURL *)CBBangDing:(NSString *)BangdingType;//第三方绑定
+ (NSURL *)CBPPTVLoginWithUserName:(NSString *)username Password:(NSString *)passWord;

//4.7合作用户补充昵称接口 新浪300，腾讯微博301，qq登陆311；
+ (NSURL *)CBsetNickNameForUnionUser:(NSString *)unionId NickName:(NSString *)nickName Status:(NSString *)status Partnerid:(NSString *)partnerid LoginSoure:(NSString *)loginSoure;
//37．PPTV完善用户信息
+ (NSURL *)CBsetNickNameForPPTVUnionUser:(NSString *)unionId NickName:(NSString *)nickName UserName:(NSString *)user_name Partnerid:(NSString *)partnerid Password:(NSString *)password;

//4.8合作用户设置同步接口
+ (NSURL *)CBsetSysBlogForUnionUser:(NSString *)userId LoginSource:(NSString *)loginSource Status:(NSString *)status;

//4.9获取合作用户同步设置接口
+ (NSURL *)CBgetSysBlogForUnionUser:(NSString *)userId LoginSource:(NSString *)loginSource;

//5.0 清除app应用消息 
+ (NSURL *)CBdelAppMsg:(NSString *)token;
//5.1 设定用户实名信息
+ (NSURL *)CBauthentication:(NSString *)id_card UserID:(NSString *)userId True_name:(NSString *)true_name Mobile:(NSString *)mobile;

/********pk赛***********/
//pk赛排行等级
+ (NSURL *)PKMatchGrade:(NSString *)type;

//查询在售/往期期次列表
+ (NSURL *)pkIssueList:(NSString *)issueNumber;

//查询pk赛的投注记录
+ (NSURL *)pkBetRecordIssue:(NSString *)issue pageNum:(NSString *)page;

//我的pk赛的投注记录
+ (NSURL *)myPkBetRecordUseId:(NSString *)useId pageNum:(NSString *)page;

//过关统计
+ (NSURL *)pkguoGuanIssue:(NSString *)issue pageNum:(NSString *)page;

//pk赛方案详情
+ (NSURL *)pkorderDetailOrderId:(NSString *)orderId;

//pk搜索
+ (NSURL *)pkSearchSearchKey:(NSString *)searchKey;

//pk赛对阵信息
+ (NSURL *)pkMatchInfo:(NSString *)issue;

//pk跳转投注
+ (NSURL *)pkBuyLotterybetNumber:(NSString *)betNuber userid:(NSString *)userId betCount:(NSString *)count issue:(NSString *)issue;

//PK直接投注
+ (NSURL *)pkZhiJieBuyLotterybetNumber:(NSString *)betNuber userid:(NSString *)userId betCount:(NSString *)count issue:(NSString *)issue;

//投注站 话题
+ (NSURL *)cpSanLiuWu;

//彩种最新期次
+ (NSURL *)caipiaolottery;

//红人榜
+ (NSURL *)caipiaoRedRequest;

//投注站搜索
+(NSURL *)cpthreeSearchSearchKey:(NSString *)searchKey;

//帖子投注详情
+(NSURL *)CBtopicBetInfo:(NSString *)topicId;

//365八方预测
+(NSURL *)CBgetBFYC:(NSString *)playId;
+(NSURL *)refreshEURO:(NSString *)playId;
+(NSURL *)refreshASIA:(NSString *)playId;
+(NSURL *)refreshBall:(NSString *)playId;
+(NSURL *)CBgetLanQiuBFYC:(NSString *)playId;
+(NSURL *)CBgetLanQiuBFYCHB:(NSString *)playId;


//遗漏图
+(NSURL *)CBgetYL:(NSString *)lottery Item:(NSString *)item;

//获取投注站用户信息
+ (NSURL *)CPThreeGetAuthentication:(NSString *)username userpassword:(NSString *)password type:(NSString *)type;

//新问题反馈

+ (NSURL *)CPThreeQAtwouserid:(NSString *)userid content:(NSString *)content mobile:(NSString *)mobile mail:(NSString *)mail;


//发送我来预测
+(NSURL *)CPThreeSendPreditTopicIssue:(NSString *)issue userid:(NSString *)userid lotteryId:(NSString *)lotteryId lotteryNumber:(NSString *)lotteryNumber content:(NSString *)content endtime:(NSString *)endt;

//开奖话题
+(NSURL *)cpthreeKaiJiangHuaTiLotteryId:(NSString *)lotteryId userid:(NSString *)userId pageSize:(NSString *)pagesize PageNum:(NSString *)pagenum issue:(NSString *)issue themeName:(NSString *)name;


// 八方视频
+ (NSURL *)baFangShiPing;

//第三方分享
+ (NSURL *)sendTopicMessageToMqtopicId:(NSString *)topicId ShareSource:(NSString *)shareSource Content:(NSString *)content orderID:(NSString *)lotteryid;

//合买红人榜
+(NSURL *)hemaihongrenbangLotteryId:(NSString *)lotteryId page:(NSString *)page;

//新闻列表
+ (NSURL *)CPThreeNewsPageSize:(NSString *)pageSize pageNum:(NSString *)pageNum;

//通过username来获取userid
+ (NSURL *)cpThreeUserName:(NSString *)userNameStr;

//保存登录信息登录
+(NSURL *)cpLoginSaveUserName:(NSString *)uname;

//邀请好友
+ (NSURL *)CBInviteFriend:(NSString *)userid type:(NSString *)Type success:(NSString *)yesorno typeId:(NSString *)typeids;


//奖励活动列表
+ (NSURL *)CPQueryActivtyListPageSize:(NSString *)pageSize pageNum:(NSString *)pageNum;

//客服私信
+(NSURL *)keFuSiXinUserID:(NSString *)userstr;


//版本检查更新
+(NSURL *)checkUpDateFunc;


//获取app应用列表
+(NSURL *)CPgetAppInfoList:(NSString *)userid pageNum:(NSString *)pagenum app_type:(NSString *)appType pageSize:(NSString *)pagesize;

//好声音
+(NSURL *)cpQueryVoice;

//11选5遗漏图
+(NSURL *)yiLouTuLottery:(NSString *)lottery item:(NSString *)item category:(NSString *)cate;
//快3遗漏图
+(NSURL *)kuai3YiLouTuo:(NSString *)lottery Item:(NSString *)item;
//快乐十分
+(NSURL *)klsfLouTuLottery:(NSString *)lottery item:(NSString *)item category:(NSString *)cate;

//找回密码之获取用户信息
+(NSURL *)FindpasswordUserInfo:(NSString *)userstr;
//找回密码之获取验证码
+(NSURL *)FindpasswordGetJiaoyanma:(NSString *)nickname mobile:(NSString *)mobil;
//找回密码之输入验证码
+(NSURL *)FindpasswordInputJiaoyanma:(NSString *)nickname Id:(NSString *)idstr Code:(NSString *)codes;
//找回密码之修改密码
+(NSURL *)FindpasswordChangePassword:(NSString *)nickname Uuid:(NSString *)uuidstr Password:(NSString *)pasw;

//检测能否分享
+(NSURL *)queryUnionshareBlogStatus:(NSString *)user_name Type:(NSString *)type;

//官方开奖 足彩北单篮彩
+(NSURL *)footballLotteryDatailType:(NSString *)type iussueString:(NSString *)issue;

//64. 我的关注的比赛
+(NSURL *)scoreLiveMyAttentionNew:(NSString *)lotterId;

//63 获取比分直播列表（足彩竟彩北单）
+(NSURL *)scoreLiveLotteryId:(NSString *)lotteryId issue:(NSString *)issue userId:(NSString *)userId matchestate:(NSString *)matchestate;

//66 未登录的推送
+(NSURL *)unLoginDevicenToken:(NSString *)Token;

+(NSURL*)KFCBusersMailList:(NSString*)userId
				 userId2:(NSString*)userid2
				 pageNum:(NSString*)pagenum
				pageSize:(NSString*)pagesize
				mailType:(NSString*)mailtype
					mode:(NSString*)mode;

//70. 投注详情具体比赛时时比分
+(NSURL *)getLiveMatchListByID:(NSString *)playid Lotteryid:(NSString *)lotteryid Issue:(NSString *)issue;

//51 管理员删除用户
+(NSURL *)deleteUserUserid:(NSString *)deleteid Username:(NSString *)username Password:(NSString *)password;

//52 管理员删除帖子
+(NSURL *)deleteTopic:(NSString *)deleteid Username:(NSString *)username Password:(NSString *)password;

//53 管理员删除评论
+(NSURL *)deleteCommon:(NSString *)deleteid Username:(NSString *)username Password:(NSString *)password;

//56管理员获取用户信息
+(NSURL *)getUserInfo:(NSString *)userId Username:(NSString *)username Password:(NSString *)password;

//之完善用户信息
+(NSURL *)getUserInfoCard:(NSString *)card userId:(NSString *)userId trueName:(NSString *)truename mobile:(NSString *)mobile;

//77检测能否参加“7天免费领彩票”活动
+(NSURL *)CheckAchieveActivMon;

//76关于用户“7天免费领彩票”活动
+(NSURL *)achieveActivMon:(NSString *)type;

//91.微信分享送彩金活动
+ (NSURL *)shareBlogActivityRequest:(NSString *)orderID;
//72．获取推广活动详情
+(NSURL *)activityInfoType:(NSString *)type;

//96获取预测列表
+ (NSURL *)getForecastContentWithPageSize:(NSString *)pageSize pageNum:(NSString *)pageNum;

//93天天竞彩
+ (NSURL *)getEverydayContentWithIssue:(NSString *)issue;

//94天天竞彩期次
+ (NSURL *)getEverydayIssue;

//95获取公告列表queryGonggao
+ (NSURL *)getGonggao;

//97第三方授权后登录cmwb接口

+ (NSURL *)loginUnionWithloginSource:(NSString *)loginSource unionId:(NSString *)unionId token:(NSString *)token tokenSecret:(NSString *)tokenSecret openid:(NSString *)openid userId:(NSString *)userId;

//101预测奖金
+ (NSURL *)JiangJinJiSuanWithlotteryid:(NSString *)lotteryid t_h:(NSString *)t_h t_l:(NSString *)t_l z_h:(NSString *)z_h z_l:(NSString *)z_l playtype:(NSString *)playtype issue:(NSString *)issue;

//102支付宝插件登陆第一步获取参数
+ (NSURL *)alipayCanshu;

//104红人榜日榜（按天）
+(NSURL *)rankingListDateRequest;

//103红人榜总榜
+(NSURL *)rankingListCountRequest;

//105新的走势图（包含双色球，大乐透）
+(NSURL *)ssqAndddtLotteryid:(NSString *)lotterId itemNum:(NSString *)num issue:(NSString *) issue;
+(NSURL *)ssqAndddtLotteryid:(NSString *)lotterId itemNum:(NSString *)num issue:(NSString *) issue cacheable:(BOOL)cach;

//84 获取用户在第三方的昵称
+(NSURL *)getUnionNickNameWithUserId;

//85 删除用户向第三方分享
+(NSURL *)deleteUnionUserShareWithType:(NSString *)type;

//6.0 世界杯活动报名
//+ (NSURL*)worldCupSignUp;

//6.1获得的国旗列表
//+ (NSURL*)worldCupGetFlagItem;
//+ (NSURL*)worldCupGetFlagItemByUserName:(NSString *)userName;

//6.2 抢彩金接口
//+ (NSURL*)worldCupGetBonusWithCupType:(NSString *)cupType;

//6.3 国旗活动获奖列表
//+(NSURL *)getFlagPrize_WinnerListWithCurPage:(int)page andPageSize:(int)pagesize;

//6.4刷新报名状态
//+ (NSURL*)worldCupGetSignUpStatus;

//112世界杯期间购彩按钮的状态
+ (NSURL*)getWorldCupDate;

//108 新版足球八方预测主接口-分析中心
+ (NSURL *)getBFYCAnalyzeWithPlayid:(NSString *)playid ZhanjiSize:(NSInteger)count ZSTlenght:(NSInteger)length;

//110 赔率中心
+ (NSURL *)getBFYCOddsCenterWithPlayid:(NSString *)playid playSize:(NSInteger)count;

//109 获取战绩
+ (NSURL *)getBFYCZhanjiWithPlayid:(NSString *)playid  zhanjiSize:(NSInteger)count teamType:(NSString *)teamType matchType:(NSInteger)matchType;

//114足球八方预测-联赛/杯赛的所有轮次的对阵
+ (NSURL *)getBFYCLCWithleague:(NSString *)league season:(NSString *)season seasonType:(NSString *)type lun:(NSString *)lun;

//113足球八方预测-联赛积分榜
+ (NSURL *)getBFYCJiFenBangWithPlayid:(NSString *)playid;


//107自动回复经典问题和近期问题
+ (NSURL *)getAutoResponseListWithType:(NSString *)type;

//应用内弹窗
+(NSURL *)getAppActiveWindowWithUserid:(NSString *)userid;

// 115 足彩八方预测-赛前简报
+(NSURL*)BFgetDescriptionByPlayID:(NSString*)playID;
//117推广短信
+(NSURL *)setSmsStateWithState:(NSString *)type;

//115足彩八方预测-赛前简报
+(NSURL *)bfycAboutWithPlayid:(NSString *)playid;

//118.微博类型列表
+(NSURL*)getYtTopicTypelistByByBlogtype:(NSString *)blogtype pageNum:(NSString*)pageNum pageSize:(NSString*)pageSize;

//121微博赞
+(NSURL*)weiBoLikeByTopicId:(NSString *)topicId praisestate:(NSString *)praisestate;

//122 不同渠道，送彩金
+(NSURL*) sendCaiJinBySid;

//123客户端加载启动图接口
+ (NSURL *)getStartPicInfoWithVersion:(NSString *)version;

//124 我的彩票图片
+ (NSURL *)getMycaipiaoImage;

+(NSURL *)getRefillRemindRequest;

//48、 客户端打补丁接口
+ (NSURL *)getrepairPatch;

//专家申请
+(NSURL *)expertApplyByPicUrl:(NSString *)picUrl parameterStr:(NSString *)parameterStr;

//专家推荐常见问题
+(NSURL *)expertCommonProblem;

@end
