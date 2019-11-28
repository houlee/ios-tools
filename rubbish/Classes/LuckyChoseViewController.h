//
//  LuckyChoseViewController.h
//  caibo
//
//  Created by yaofuyu on 12-11-5.
//  幸运选号
//

#import <UIKit/UIKit.h>
#import "GC_LotteryType.h"
#import "CPViewController.h"
#import "MyPickerView.h"
#import <AVFoundation/AVFoundation.h>

@interface LuckyChoseViewController : CPViewController <MyPickerViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,AVAudioPlayerDelegate>{
    
    UILabel *caizhongLable;
    UILabel *zhushuLable;
    
    NSInteger zhushu;
    
    NSArray *caiZhongArray;
        
    NSMutableArray *dataArray;//投注内容
    LotteryTYPE lotterytype;
    
    UIView *databackVie;
    UIImageView *databackImageV;
    UITextView *dateText;
    UIButton *senBtn;
    UIImageView *shandianImage;
    UIImageView *xingmangImage;
    UIImageView *mofaQiu;
    UIImageView *backimage;
    UIImageView *wenzi;
    int donghuaShua;
    AVAudioPlayer *infoPlayer;
    
    BOOL isOnSound;// 是否开启了声音
    
}

@property(nonatomic)NSInteger caiZhong;
@property (nonatomic,retain)NSMutableArray *dataArray;

@end
