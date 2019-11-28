//
//  ExpertButtonInfoTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import "ExpertButtonInfoTableViewCell.h"
#import "SharedMethod.h"

@implementation ExpertButtonInfoTableViewCell

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
        
        _btnBGIma = [[UIImageView alloc]initWithFrame:CGRectMake(90, 7, 180, 20)];
        _btnBGIma.backgroundColor = [UIColor clearColor];
        _btnBGIma.layer.borderColor = [[SharedMethod getColorByHexString:@"1da3ff"] CGColor];
        _btnBGIma.layer.borderWidth = 0.5f;
        _btnBGIma.userInteractionEnabled = YES;
        _btnBGIma.hidden = YES;
        [self.contentView addSubview:_btnBGIma];
        UIImageView *lineIma1 = [[UIImageView alloc]initWithFrame:CGRectMake(60, 0, 0.5, 20)];
        lineIma1.backgroundColor = [SharedMethod getColorByHexString:@"1da3ff"];
        [_btnBGIma addSubview:lineIma1];
        UIImageView *lineIma2 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 0, 0.5, 20)];
        lineIma2.backgroundColor = [SharedMethod getColorByHexString:@"1da3ff"];
        [_btnBGIma addSubview:lineIma2];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, 60, 20);
        _leftBtn.backgroundColor = [UIColor clearColor];
        [_leftBtn setTitle:@"胜" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _leftBtn.tag = 10;
        [_leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_leftBtn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtnblue_image.png"] forState:UIControlStateSelected];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_btnBGIma addSubview:_leftBtn];
        
        _middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _middleBtn.frame = CGRectMake(60, 0, 60, 20);
        _middleBtn.backgroundColor = [UIColor clearColor];
        [_middleBtn setTitle:@"平" forState:UIControlStateNormal];
        _middleBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _middleBtn.tag = 11;
        [_middleBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_middleBtn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
        [_middleBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtnblue_image.png"] forState:UIControlStateSelected];
        [_middleBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_btnBGIma addSubview:_middleBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(120, 0, 60, 20);
        _rightBtn.backgroundColor = [UIColor clearColor];
        [_rightBtn setTitle:@"负" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _rightBtn.tag = 12;
        [_rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_rightBtn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtnblue_image.png"] forState:UIControlStateSelected];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_btnBGIma addSubview:_rightBtn];
        
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchBtn.frame = CGRectMake(size.width-53, 8, 38, 18);
        _switchBtn.backgroundColor = [UIColor clearColor];
        _switchBtn.tag = 20;
        _switchBtn.hidden = YES;
        [_switchBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"expert_switchblue_on.png"] forState:UIControlStateSelected];
        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"expert_switch_off.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_switchBtn];
        
        UIImageView *lineIma = [[UIImageView alloc]init];
        lineIma.frame = CGRectMake(0, 34.5, size.width, 0.5);
        lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:lineIma];
        
#if defined CRAZYSPORTS
        _btnBGIma.layer.borderColor = [[SharedMethod getColorByHexString:@"6e29bd"] CGColor];
        lineIma1.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
        lineIma2.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"expert_switch_on.png"] forState:UIControlStateSelected];
        
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtn_image.png"] forState:UIControlStateSelected];
        [_middleBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtn_image.png"] forState:UIControlStateSelected];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtn_image.png"] forState:UIControlStateSelected];
#endif
    }
    return self;
}
-(void)loadAppointInfo:(NSDictionary *)dict WithSeletArray:(NSArray *)seletArray{
    
    _leftBtn.selected = NO;
    _middleBtn.selected = NO;
    _rightBtn.selected = NO;
    if ([seletArray count] >= 1) {
        _leftBtn.selected = [[seletArray objectAtIndex:0] boolValue];
    }
    if ([seletArray count] >= 2) {
        _middleBtn.selected = [[seletArray objectAtIndex:1] boolValue];
    }
    if ([seletArray count] >= 3) {
        _rightBtn.selected = [[seletArray objectAtIndex:2] boolValue];
    }
    _leftLab.text = [dict valueForKey:@"left"];
    NSString *peilv = [dict valueForKey:@"right"];
    if(peilv.length > 0){
        NSArray *ary = [peilv componentsSeparatedByString:@" "];
        if(ary.count == 3){
            [_leftBtn setTitle:[NSString stringWithFormat:@"胜%@",[ary objectAtIndex:0]] forState:UIControlStateNormal];
            [_middleBtn setTitle:[NSString stringWithFormat:@"平%@",[ary objectAtIndex:1]] forState:UIControlStateNormal];
            [_rightBtn setTitle:[NSString stringWithFormat:@"负%@",[ary objectAtIndex:2]]forState:UIControlStateNormal];
        }else{
            [_leftBtn setTitle:@"胜" forState:UIControlStateNormal];
            [_middleBtn setTitle:@"平" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"负" forState:UIControlStateNormal];
        }
    }else{
        [_leftBtn setTitle:@"胜" forState:UIControlStateNormal];
        [_middleBtn setTitle:@"平" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"负" forState:UIControlStateNormal];
    }
}
-(void)btnAction:(UIButton *)button{
    
    if(button.tag != 20){
        
        NSInteger num = _leftBtn.selected + _middleBtn.selected + _rightBtn.selected;
        if(num >= 2 && !button.selected){
            return;
        }
    }
    
    button.selected = !button.selected;
    
    if(self.buttonBlcok){
        self.buttonBlcok(button);
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