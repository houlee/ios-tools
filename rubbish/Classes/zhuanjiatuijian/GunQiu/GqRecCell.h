//
//  GqRecCell.h
//  caibo
//
//  Created by zhoujunwang on 16/5/26.
//
//

#import <UIKit/UIKit.h>

@interface GqRecCell : UITableViewCell

- (void)setHostName:(NSString *)hostName score:(NSString *)score guestName:(NSString *)guestName gameTime:(NSString *)gameTime leagueTime:(NSString *)leagueTime recNo:(NSString *)recNo;

@end


@protocol GqZJCellCXXQDelegate <NSObject>

@optional
-(void)gqckxqClick:(UIButton *)btn;

@end


@interface GqZJCell : UITableViewCell<GqZJCellCXXQDelegate>

@property(nonatomic,strong)UIButton *ckxqBtn;

@property(nonatomic,weak)id<GqZJCellCXXQDelegate> delegate;

- (void)setPortrait:(NSString *)Portrait gqNikNm:(NSString *)gqNikNm gqRk:(NSInteger)gqRk gqGameSides:(NSString *)gqGameSides gqsqSpl:(NSString *)gqsqSpl gqsqRq:(NSString *)gqsqRq gqsqFpl:(NSString *)gqsqfpl gqzxSpl:(NSString *)gqzxSpl gqzxRq:(NSString *)gqzxRq gqzxfpl:(NSString *)gqzxfpl releasaTime:(NSString *)releseTime gpPrice:(NSString *)gqPrice startOrNo:(NSInteger)startOrNo isRec:(NSInteger)isRec;

@end
