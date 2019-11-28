//
//  RankListCell.m
//  caibo
//
//  Created by zhoujunwang on 16/1/6.
//
//

#import "RankListCell.h"

@interface RankListCell()

@property(nonatomic,strong) UIImageView *rankImgV;//序号
@property(nonatomic,strong) UILabel *rankLab;
@property(nonatomic,strong) UIImageView *djImgV;
@property(nonatomic,strong) UILabel *djLab;
@property(nonatomic,strong) UIImageView *portImgV;//头像
@property(nonatomic,strong) UILabel *nameLab;//名称
@property(nonatomic,strong) UILabel *recMarkLab;//推荐数标签
@property(nonatomic,strong) UILabel *recLab;//推荐数
@property(nonatomic,strong) UILabel *hitMarkLab;//命中率标签
@property(nonatomic,strong) UILabel *hitLab;//命中率
@property(nonatomic,strong) UILabel *siglRecMarkLab;//单选推荐数标签
@property(nonatomic,strong) UILabel *siglRecLab;//单选推荐数
@property(nonatomic,strong) UILabel *siglHitMarkLab;//单选命中率标签
@property(nonatomic,strong) UILabel *siglHitLab;//连中场数

@end

@implementation RankListCell

+(id)rankListCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * SMGDetailCellId=@"perHonorCell";
    RankListCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[RankListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SMGDetailCellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _rankImgV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 23)];
        _rankImgV.image=[UIImage imageNamed:@"普通排名"];
        _rankImgV.backgroundColor=[UIColor clearColor];
        [self addSubview:_rankImgV];
        
        _rankLab=[[UILabel alloc] init];
        _rankLab.font=FONTEIGHTEEN;
        _rankLab.backgroundColor=[UIColor clearColor];
        _rankLab.textAlignment=NSTextAlignmentCenter;
        _rankLab.textColor=[UIColor whiteColor];
        [_rankImgV addSubview:_rankLab];
        
        _portImgV=[[UIImageView alloc] initWithFrame:CGRectMake(28*MyWidth/320, 21, 45, 45)];
        _portImgV.image=[UIImage imageNamed:@"默认头像"];
        _portImgV.layer.masksToBounds=YES;
        _portImgV.layer.cornerRadius=22.5;
        _portImgV.backgroundColor=[UIColor clearColor];
        [self addSubview:_portImgV];
        
        _nameLab=[[UILabel alloc] init];
        _nameLab.font=FONTTHIRTY_TWO;
        _nameLab.textColor=[UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:1.0];
        _nameLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_nameLab];

        UIImageView *djImgView=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(_nameLab)+10, _nameLab.frame.size.height/2-7, 39, 14)];
        djImgView.backgroundColor=[UIColor clearColor];
        [self addSubview:djImgView];
        _djImgV=djImgView;
        
        UILabel *djLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 22, 14)];
        djLabel.backgroundColor=[UIColor clearColor];
        djLabel.font=[UIFont systemFontOfSize:8.0];
        djLabel.textColor=RGBColor(255.0, 96.0, 0.0);
        djLabel.textAlignment=NSTextAlignmentLeft;
        [_djImgV addSubview:djLabel];
        _djLab=djLabel;
        
        _recMarkLab=[[UILabel alloc] init];
        _recMarkLab.textColor=BLACK_SEVENTY;
        _recMarkLab.font=FONTTWENTY_FOUR;
        _recMarkLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_recMarkLab];
        
        _recLab=[[UILabel alloc] init];
        _recLab.textColor=BLACK_EIGHTYSEVER;
        _recLab.font=FONTTWENTY_FOUR;
        _recLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_recLab];
        
        _hitMarkLab=[[UILabel alloc] init];
        _hitMarkLab.textColor=BLACK_SEVENTY;
        _hitMarkLab.font=FONTTWENTY_FOUR;
        _hitMarkLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_hitMarkLab];
        
        _hitLab=[[UILabel alloc] init];
        _hitLab.textColor=BLACK_EIGHTYSEVER;
        _hitLab.font=FONTTWENTY_FOUR;
        _hitLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_hitLab];
        
        _siglRecMarkLab=[[UILabel alloc] init];
        _siglRecMarkLab.textColor=BLACK_SEVENTY;
        _siglRecMarkLab.font=FONTTWENTY_FOUR;
        _siglRecMarkLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_siglRecMarkLab];
        
        _siglRecLab=[[UILabel alloc] init];
        _siglRecLab.textColor=BLACK_EIGHTYSEVER;
        _siglRecLab.font=FONTTWENTY_FOUR;
        _siglRecLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_siglRecLab];
        
        _siglHitMarkLab=[[UILabel alloc] init];
        _siglHitMarkLab.textColor=BLACK_SEVENTY;
        _siglHitMarkLab.font=FONTTWENTY_FOUR;
        _siglHitMarkLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_siglHitMarkLab];
        
        _siglHitLab=[[UILabel alloc] init];
        _siglHitLab.textColor=BLACK_EIGHTYSEVER;
        _siglHitLab.font=FONTTWENTY_FOUR;
        _siglHitLab.backgroundColor=[UIColor clearColor];
        [self addSubview:_siglHitLab];
        
        CGSize labSize0=[PublicMethod setNameFontSize:@"宝哥" andFont:FONTTHIRTY_TWO andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize labSize1=[PublicMethod setNameFontSize:@"推荐数" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize labSize2=[PublicMethod setNameFontSize:@"单选推荐数" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        float  tableHeight=labSize0.height+labSize1.height+labSize2.height+46;
        
        UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,tableHeight-0.5, MyWidth, 0.5)];
        Line.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
        [self addSubview:Line];
    }
    return self;
}

- (void)potrait:(NSString *)potrait name:(NSString *)name rank:(NSInteger)rank recomNo:(NSString *)recomNo hitPbablity:(NSString *)hitPbablity singleRecNo:(NSString *)singleRecNo singleHitRate:(NSString *)singleHitRate order:(NSInteger)order tableTag:(NSInteger)tableTag lotryType:(NSString *)lotryType{
    NSURL *url=[NSURL URLWithString:potrait];
    [_portImgV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    
    _rankLab.text=[NSString stringWithFormat:@"%ld",(long)order];
    CGSize labSize=[PublicMethod setNameFontSize:_rankLab.text andFont:FONTEIGHTEEN andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_rankLab setFrame:CGRectMake(5, 3, labSize.width, labSize.height)];
    if(order>9){
        [_rankLab setFrame:CGRectMake(2, 3, labSize.width, labSize.height)];
    }
    
    NSString *str=@"普通排名";
    if (order==1) {
        str=@"第一排名";
    }else if(order==2){
        str=@"第二排名";
    }else if(order==3){
        str=@"第三排名";
    }
    _rankImgV.image=[UIImage imageNamed:str];
    
    labSize=[PublicMethod setNameFontSize:name andFont:FONTTHIRTY_TWO andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLab.text=name;
    [_nameLab setFrame:CGRectMake(CGRectGetMaxX(_portImgV.frame)+15*MyWidth/320, 15, labSize.width, labSize.height)];

    [_djImgV setFrame:CGRectMake(ORIGIN_X(_nameLab)+10, _nameLab.frame.origin.y+(_nameLab.frame.size.height-14)/2, 39, 14)];
    NSString *rankImg=@"";
    if (rank<=5) {
        rankImg=@"ranklv1-5";
        _djLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (rank>5&&rank<=10){
        rankImg=@"ranklv6-10";
        _djLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (rank>10&&rank<=15){
        rankImg=@"ranklv11-15";
        _djLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (rank>15&&rank<=20){
        rankImg=@"ranklv16-20";
        _djLab.textColor=[UIColor whiteColor];
    }else if (rank>20&&rank<=25){
        rankImg=@"ranklv21-25";
        _djLab.textColor=[UIColor whiteColor];
    }
    _djImgV.image=[UIImage imageNamed:rankImg];
    _djLab.text=[NSString stringWithFormat:@"LV%ld",(long)rank];
    CGSize reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)rank] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_djLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    if(tableTag==HITAG){
        _recMarkLab.text=@"推荐数";
        _hitMarkLab.text=@"命中率";
        _hitMarkLab.hidden=NO;
        _hitLab.hidden=NO;
        _siglRecMarkLab.text=@"单选推荐数";
        _siglHitMarkLab.text=@"单选命中率";
        _siglHitMarkLab.hidden=NO;
        _siglHitLab.hidden=NO;
    }else if(tableTag==HEATAG){
        _recMarkLab.text=@"推荐数";
        _hitMarkLab.hidden=YES;
        _hitLab.hidden=YES;
        _siglRecMarkLab.text=@"人气度";
        _siglHitMarkLab.hidden=YES;
        _siglHitLab.hidden=YES;
    }else if(tableTag==RETURNTAG){
        _recMarkLab.text=@"推荐数";
        _hitMarkLab.hidden=YES;
        _hitLab.hidden=YES;
        _siglRecMarkLab.text=@"回报率";
        _siglHitMarkLab.text=@"连中";
        _siglHitMarkLab.hidden=NO;
        _siglHitLab.hidden=NO;
    }
    
    labSize=[PublicMethod setNameFontSize:_recMarkLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_recMarkLab setFrame:CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_nameLab.frame)+10, labSize.width, labSize.height)];
    
    _recLab.text=recomNo;
    labSize=[PublicMethod setNameFontSize:recomNo andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_recLab setFrame:CGRectMake(CGRectGetMaxX(_recMarkLab.frame)+8*MyWidth/320, CGRectGetMinY(_recMarkLab.frame), labSize.width, labSize.height)];
    
    labSize=[PublicMethod setNameFontSize:_hitMarkLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_hitMarkLab setFrame:CGRectMake(188*MyWidth/320, CGRectGetMinY(_recMarkLab.frame), labSize.width, labSize.height)];
    
    _hitLab.text=hitPbablity;
    labSize=[PublicMethod setNameFontSize:hitPbablity andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_hitLab setFrame:CGRectMake(CGRectGetMaxX(_hitMarkLab.frame)+8*MyWidth/320, CGRectGetMinY(_hitMarkLab.frame), labSize.width, labSize.height)];
    
    labSize=[PublicMethod setNameFontSize:_siglRecMarkLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_siglRecMarkLab setFrame:CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_recMarkLab.frame)+6, labSize.width, labSize.height)];

    _siglRecLab.text=singleRecNo;
    labSize=[PublicMethod setNameFontSize:singleRecNo andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_siglRecLab setFrame:CGRectMake(CGRectGetMaxX(_siglRecMarkLab.frame)+8*MyWidth/320, CGRectGetMinY(_siglRecMarkLab.frame), labSize.width, labSize.height)];
    
    labSize=[PublicMethod setNameFontSize:_siglHitMarkLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_siglHitMarkLab setFrame:CGRectMake(188*MyWidth/320, CGRectGetMinY(_siglRecMarkLab.frame), labSize.width, labSize.height)];
    
    _siglHitLab.text=singleHitRate;
    labSize=[PublicMethod setNameFontSize:singleHitRate andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_siglHitLab setFrame:CGRectMake(CGRectGetMaxX(_siglHitMarkLab.frame)+8*MyWidth/320, CGRectGetMinY(_siglHitMarkLab.frame), labSize.width, labSize.height)];
    
    
    if(tableTag==HITAG){
//        if ([lotryType isEqualToString:@"202"]) {
        if ([lotryType isEqualToString:@"201"]) {
            _siglRecMarkLab.hidden=YES;
            _siglRecLab.hidden=YES;
            _siglHitMarkLab.hidden=YES;
            _siglHitLab.hidden=YES;
            
            _recLab.hidden = YES;
            _recMarkLab.hidden = YES;
            
            CGRect rect=_siglRecMarkLab.frame;
            rect.size.width=_hitMarkLab.frame.size.width;
            [_hitMarkLab setFrame:rect];
            
            rect=_siglRecLab.frame;
            rect.origin.x=CGRectGetMaxX(_hitMarkLab.frame)+8*MyWidth/320;
            rect.size.width=_hitLab.frame.size.width;
            [_hitLab setFrame:rect];
            
            _hitMarkLab.text = @"准确率";
            _hitMarkLab.frame = CGRectMake(_hitMarkLab.frame.origin.x, _hitMarkLab.frame.origin.y-15, _hitMarkLab.frame.size.width, _hitMarkLab.frame.size.height);
            _hitLab.frame = CGRectMake(_hitLab.frame.origin.x, _hitLab.frame.origin.y-15, _hitLab.frame.size.width, _hitLab.frame.size.height);
        }
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    