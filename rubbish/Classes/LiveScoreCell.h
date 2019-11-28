//
//  LiveScoreCell.h
//  caibo
//
//  Created by Kiefer on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LiveScoreCell : UITableViewCell 
{  
    UILabel *lbStatus; // 时间
    UILabel *lbHome; // 主队
    UILabel *lbLeagueName; // 联赛名
    UILabel *lbHost; // 比分
    UILabel *lbAway; // 客队
    UILabel *lbCaiguo; // 彩果
    UIButton *btnAtt; // 关注状态
	UIButton *tuisongBnt;      //推送通知btn；
    
    UIImageView *lsImageView;
    UIButton *Btn;
    UIImageView *pptvlogoImage;
    UILabel *changciLable;
}

@property (nonatomic, retain) IBOutlet UILabel *lbStatus;
@property (nonatomic, retain) IBOutlet UILabel *lbHome;
@property (nonatomic, retain) IBOutlet UILabel *lbLeagueName;
@property (nonatomic, retain) IBOutlet UILabel *lbHost;
@property (nonatomic, retain) IBOutlet UILabel *lbAway;
@property (nonatomic, retain) IBOutlet UILabel *lbCaiguo;
@property (nonatomic, retain) IBOutlet UIButton *btnAtt;
@property (nonatomic, retain) IBOutlet UIButton *tuisongBnt;
@property (nonatomic, retain) IBOutlet UIImageView *lsImageView;
@property (nonatomic, retain) IBOutlet UIButton *Btn;
@property (nonatomic, retain) IBOutlet UIImageView *pptvlogoImage;
@property (nonatomic, retain) IBOutlet UILabel *changciLable;


@end
