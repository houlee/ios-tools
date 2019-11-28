//
//  ExpertInputInfoTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import "ExpertInputInfoTableViewCell.h"

@implementation ExpertInputInfoTableViewCell

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
        
        _mesText = [[UITextField alloc]init];
        _mesText.frame = CGRectMake(0, 0, 10, 35);
        _mesText.backgroundColor = [UIColor clearColor];
        _mesText.font = [UIFont systemFontOfSize:12];
        _mesText.delegate = self;
        _mesText.textColor = BLACK_EIGHTYSEVER;
        [self.contentView addSubview:_mesText];
        
        _lineIma = [[UIImageView alloc]init];
        _lineIma.frame = CGRectMake(0, 34.5, size.width, 0.5);
        _lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:_lineIma];
    }
    return self;
}
-(void)loadAppointInfo:(NSDictionary *)dict{
    _leftLab.text = [dict valueForKey:@"left"];
    CGSize reSize=[PublicMethod setNameFontSize:_leftLab.text andFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _leftLab.frame = CGRectMake(15, 0, reSize.width+5, 35);
    _mesText.frame = CGRectMake(ORIGIN_X(_leftLab), 5, size.width-ORIGIN_X(_leftLab)-20, 25);
    _mesText.text = [dict valueForKey:@"right"];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(self.textDidEndEditing){
        
        self.textDidEndEditing(textField.text);
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