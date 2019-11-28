//
//  moneyViewController.h
//  caibo
//
//  Created by cp365dev on 14-3-3.
//
//

#import "CPViewController.h"
#import "ASIHTTPRequest.h"

typedef enum{
    monyTypeShuangSeQiu,
    monyTypeDaletou
    
}MonyType;


@interface moneyViewController : CPViewController<ASIHTTPRequestDelegate>

{
    UIView *viewshuang;
    UIView *viewDaletou;
    UILabel *labelshuang;
    UILabel *labeDa;
    UIImageView *lanxian;
    NSString * issString;

    
    UIImageView *putongImg;
    UIImageView *zhujiaImag;
    NSString *lottoryID;//彩种id
    ASIHTTPRequest *myHttpRequest;
    ASIHTTPRequest *infoHttpRequest;
    ASIHTTPRequest *infoHttpRequest2;
    NSMutableDictionary *dataDic;
    MonyType monytype;
    UIButton *putongButton;
    UIButton *zhujiaButton;
    BOOL isDaleTouKaiChu;       //大乐透是否开出
    BOOL isShuangSeQiuKaichu;   //双色球是否开出
    NSInteger daletouQici;      //大乐透选择的第几个期次
    NSInteger shuangseqiuQici;  //双色球选的第几个期次
}

@property (nonatomic,copy)NSString *lottoryID;
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest,*infoHttpRequest,*infoHttpRequest2;
@property (nonatomic,retain)NSMutableDictionary *dataDic;
@property (nonatomic,assign)BOOL isDaleTouKaiChu,isShuangSeQiuKaichu;
@property (nonatomic,assign)NSInteger daletouQici,shuangseqiuQici;
@end
