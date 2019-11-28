//
//  ExpertHornTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/30.
//
//

#import "ExpertHornTableViewCell.h"

@implementation ExpertHornTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        
        UIView *bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, 0, size.width, 35);
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        bgView.layer.masksToBounds = YES;
        
        _hornIma = [[UIImageView alloc] initWithFrame:CGRectMake(15, (bgView.frame.size.height - 12.5)/2.0, 16.5, 12.5)];
        _hornIma.image = [UIImage imageNamed:@"CS_GuessHorn.png"];
        [bgView addSubview:_hornIma];
        
        _hornLab1 = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(_hornIma) + 5, 0, MyWidth - (ORIGIN_X(_hornIma) + 5), 35)];
        _hornLab1.textColor = DEFAULT_TEXTGRAYCOLOR;
        _hornLab1.font = [UIFont systemFontOfSize:11];
        [bgView addSubview:_hornLab1];
        
        _hornLab2 = [[UILabel alloc] initWithFrame:CGRectMake(_hornLab1.frame.origin.x, bgView.frame.size.height, _hornLab1.frame.size.width, bgView.frame.size.height)];
        _hornLab2.textColor = _hornLab2.textColor;
        _hornLab2.font = _hornLab2.font;
        [bgView addSubview:_hornLab2];
    }
    return self;
}
-(void)loadAppointInfo:(NSString *)dict{
    
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