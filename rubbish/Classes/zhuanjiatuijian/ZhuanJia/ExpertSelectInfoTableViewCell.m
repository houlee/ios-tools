//
//  ExpertSelectInfoTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import "ExpertSelectInfoTableViewCell.h"

@implementation ExpertSelectInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        
        _leftLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 35)];
        _leftLab.backgroundColor = [UIColor clearColor];
        _leftLab.font = [UIFont systemFontOfSize:12];
        _leftLab.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_leftLab];
        
        _rightLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, self.frame.size.width - 130, 35)];
        _rightLab.backgroundColor = [UIColor clearColor];
        _rightLab.font = [UIFont systemFontOfSize:12];
        _rightLab.textAlignment = NSTextAlignmentRight;
        _rightLab.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_rightLab];
        
        _arrowIma = [[UIImageView alloc]init];
        _arrowIma.frame = CGRectMake(self.frame.size.width - 21, 12.5, 6, 10);
        _arrowIma.backgroundColor = [UIColor clearColor];
        _arrowIma.image = [UIImage imageNamed:@"CS_PC_Arrow.png"];
        [self.contentView addSubview:_arrowIma];
        
        UIImageView *lineIma = [[UIImageView alloc]init];
        lineIma.frame = CGRectMake(0, 34.5, size.width, 0.5);
        lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:lineIma];
    }
    return self;
}
-(void)loadAppointInfo:(NSDictionary *)dict{
    _leftLab.text = [dict valueForKey:@"left"];
    _rightLab.text = [dict valueForKey:@"right"];
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