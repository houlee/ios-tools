//
//  calculateCell.h
//  caibo
//
//  Created by houchenguang on 12-11-5.
//
//

#import <UIKit/UIKit.h>
#import "CP_LieBiaoView.h"
@class calculateCell;
@protocol calculateCellDelegate <NSObject>
@optional
- (void)returnjianpan:(BOOL)yesorno;
- (void)returnRow:(NSInteger)rerow beishu:(NSString *)beishus qihao:(NSString *)issue;
- (void)returnTextField:(NSString *)fieldText row:(NSInteger)rowte;
- (void)returnjianpanjiaodian:(BOOL)yesorno;
- (void)openCellKeyboard:(calculateCell *)cellKeyboard;

- (void)returnButtonSelectBool:(BOOL)yesORno row:(NSInteger)row;
@end

@interface calculateCell : UITableViewCell<UITextFieldDelegate, UIActionSheetDelegate, CP_lieBiaoDelegate>{
    
    UITextField * textqihao;
    id<calculateCellDelegate>delegate;
    UILabel * labelqihao;
    NSInteger row;
    NSString * issuestr;
    NSString * beishustr;
    UILabel * haolabel;
    UILabel * yuanlabel;
    NSMutableArray * issuearr;
    NSInteger qianshu;
    BOOL zhuijiaBOOL;
    UIImageView * imageViewkey;//弹出键盘
//    BOOL changeBeiShu;
    NSString *lastBeiShu;
    NSString * markString;
    BOOL buttonBool;
}

@property (nonatomic, retain)UIImageView * imageViewkey;
@property (nonatomic, assign)id<calculateCellDelegate>delegate;
@property (nonatomic, retain)UITextField * textqihao;
@property (nonatomic, retain)NSString * issuestr, * beishustr;
@property (nonatomic, assign)NSInteger row, qianshu;
@property (nonatomic, retain) UILabel * yuanlabel,  * haolabel, * labelqihao;
@property (nonatomic, retain)NSMutableArray * issuearr;
@property (nonatomic, assign)BOOL zhuijiaBOOL,buttonBool;
- (void)returnjianpan:(BOOL)yesorno;
- (void)returnRow:(NSInteger)rerow beishu:(NSString *)beishus qihao:(NSString *)issue;
- (void)returnTextField:(NSString *)fieldText row:(NSInteger)rowte;
- (void)returnjianpanjiaodian:(BOOL)yesorno;

@end
