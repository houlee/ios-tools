//
//  LastLotteryCell.h
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LotteryButton.h"
#import "ImageStoreReceiver.h"
#import "KJButtdata.h"
#import "kjButtCellTuiSong.h"

@protocol LastLotteryCellDelegate <NSObject>

- (void)returncellrownum:(NSInteger)num quedingbool:(BOOL)quebool;
@end

@interface LastLotteryCell : UITableViewCell {
	IBOutlet LotteryButton *headImageBtn;
	IBOutlet UILabel *name;
	IBOutlet UILabel *issue;
	IBOutlet UIView *ballsView;
	IBOutlet UIImageView * caiimage;
	NSString *imageUrl;
	ImageStoreReceiver *receiver;
    
   IBOutlet UIImageView * labaimage;
     UIButton * xuanzhebut;
    BOOL songbool;
    KJButtdata * buttdata;
     UIButton * buttxuan;
    int row;
    id<LastLotteryCellDelegate>delegate;
   // UIButton * xuanbutton;
    kjButtCellTuiSong * tuisongtongzhi;
    BOOL dangqianzhuangtai;
    
    BOOL queding;
    
   IBOutlet UIImageView * bgmonery;
   IBOutlet UILabel * dilabel;
   IBOutlet UILabel * qilabel;
    IBOutlet UIImageView * cellbgimage;
    
}
@property (nonatomic, retain)IBOutlet UIImageView * caiimage;
@property (nonatomic, retain)IBOutlet UIImageView * cellbgimage;
@property (nonatomic, retain)IBOutlet UIImageView * bgmonery;
@property (nonatomic, retain)IBOutlet UILabel * dilabel;
@property (nonatomic, retain)IBOutlet UILabel * qilabel;
@property (nonatomic, assign)kjButtCellTuiSong * tuisongtongzhi;
@property (nonatomic, assign)id<LastLotteryCellDelegate>delegate;
@property (nonatomic, assign)int row;
@property (nonatomic, retain) UIButton * buttxuan;
@property (nonatomic, retain)KJButtdata * buttdata;
@property (nonatomic, retain)IBOutlet UIButton * xuanzhebut;
@property (nonatomic, retain)IBOutlet UIImageView * labaimage;
@property(nonatomic, retain)LotteryButton *headImageBtn;
@property(nonatomic, retain)IBOutlet UILabel *name;
@property(nonatomic, retain)IBOutlet UILabel *issue;
@property(nonatomic, retain)IBOutlet UIView *ballsView;
@property(nonatomic, retain)ImageStoreReceiver *receiver;
@property (nonatomic)BOOL songbool;

@property (nonatomic, retain) UILabel *difangLab;
@property (nonatomic, retain) UIImageView *guanfangIma;
@property (nonatomic, retain) UILabel *tryLab;

-(void)setImageUrl:(NSString*)url;
- (void)returncellrownum:(NSInteger)num quedingbool:(BOOL)quebool;
- (IBAction)pressbuttonxuan:(UIButton *)sender;
@end






