//
//  ResultButtonTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/12/26.
//
//

#import "ResultButtonTableViewCell.h"
#import "SharedMethod.h"

@implementation ResultButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        
        _resultLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 35)];
        _resultLab.backgroundColor = [UIColor clearColor];
        _resultLab.font = [UIFont systemFontOfSize:12];
        _resultLab.textColor = BLACK_EIGHTYSEVER;
        _resultLab.text = @"推荐赛果";
        [self.contentView addSubview:_resultLab];
        
        _lineIma = [[UIImageView alloc]init];
        _lineIma.frame = CGRectMake(0, 35, size.width, 0.5);
        _lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:_lineIma];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(60, 45, 60, 30);
        _leftBtn.backgroundColor = [UIColor clearColor];
        [_leftBtn setTitle:@"客胜" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _leftBtn.tag = 10;
        [_leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
#ifdef CRAZYSPORTS
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtn_image.png"] forState:UIControlStateSelected];
#else
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtnblue_image.png"] forState:UIControlStateSelected];
#endif
        
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.contentView addSubview:_leftBtn];
        
#ifdef CRAZYSPORTS
        _leftBtn.layer.borderColor = [[UIColor colorWithRed:143/255.0 green:86/255.0 blue:195/255.0 alpha:1] CGColor];
        [_leftBtn setTitleColor:[UIColor colorWithRed:143/255.0 green:86/255.0 blue:195/255.0 alpha:1] forState:UIControlStateNormal];
#else
        _leftBtn.layer.borderColor = [[SharedMethod getColorByHexString:@"16a5ff"] CGColor];
        [_leftBtn setTitleColor:[SharedMethod getColorByHexString:@"16a5ff"] forState:UIControlStateNormal];
#endif
        _leftBtn.layer.borderWidth = 1.5f;
        _leftBtn.layer.cornerRadius = 4;
        _leftBtn.layer.masksToBounds = YES;
        
        _middleLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 45, size.width-240, 30)];
        _middleLab.backgroundColor = [UIColor clearColor];
        _middleLab.font = [UIFont systemFontOfSize:12];
        _middleLab.text = @"VS";
        _middleLab.textAlignment = NSTextAlignmentCenter;
        _middleLab.textColor = BLACK_SEVENTY;
        [self.contentView addSubview:_middleLab];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(size.width-120, 45, 60, 30);
        _rightBtn.backgroundColor = [UIColor clearColor];
        [_rightBtn setTitle:@"主胜" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightBtn.tag = 11;
        [_rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
#ifdef CRAZYSPORTS
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtn_image.png"] forState:UIControlStateSelected];
#else
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"expert_spfbtnblue_image.png"] forState:UIControlStateSelected];
#endif
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.contentView addSubview:_rightBtn];
        
#ifdef CRAZYSPORTS
        _rightBtn.layer.borderColor = [[UIColor colorWithRed:143/255.0 green:86/255.0 blue:195/255.0 alpha:1] CGColor];
        [_rightBtn setTitleColor:[UIColor colorWithRed:143/255.0 green:86/255.0 blue:195/255.0 alpha:1] forState:UIControlStateNormal];
#else
        _rightBtn.layer.borderColor = [[SharedMethod getColorByHexString:@"16a5ff"] CGColor];
        [_rightBtn setTitleColor:[SharedMethod getColorByHexString:@"16a5ff"] forState:UIControlStateNormal];
#endif
        _rightBtn.layer.borderWidth = 1.5f;
        _rightBtn.layer.cornerRadius = 4;
        _rightBtn.layer.masksToBounds = YES;
        
        UIImageView *lineIma = [[UIImageView alloc]init];
        lineIma.frame = CGRectMake(0, 84.5, size.width, 0.5);
        lineIma.backgroundColor = SEPARATORCOLOR;
        [self.contentView addSubview:lineIma];
    }
    return self;
}
-(void)loadAppointInfo:(NSDictionary *)dict{
    
    _leftBtn.selected = NO;
    _rightBtn.selected = NO;
    
    NSString *peilv = [dict valueForKey:@"right"];
    if(peilv.length){
        NSArray *ary = [peilv componentsSeparatedByString:@" "];
        if(ary.count == 4){
            if([[ary objectAtIndex:3] isEqualToString:@"daxiaoqiu"]){
                [_leftBtn setTitle:[NSString stringWithFormat:@"大(%@)",[ary objectAtIndex:0]] forState:UIControlStateNormal];
                [_rightBtn setTitle:[NSString stringWithFormat:@"小(%@)",[ary objectAtIndex:1]] forState:UIControlStateNormal];
                _middleLab.text = [NSString stringWithFormat:@"%@",[ary objectAtIndex:2]];
            }else{
                [_leftBtn setTitle:[NSString stringWithFormat:@"客(%@)",[ary objectAtIndex:0]] forState:UIControlStateNormal];
                [_rightBtn setTitle:[NSString stringWithFormat:@"主(%@)",[ary objectAtIndex:1]] forState:UIControlStateNormal];
                _middleLab.text = [NSString stringWithFormat:@"主%@",[ary objectAtIndex:2]];
            }
        }else if(ary.count == 1){
            if([[ary objectAtIndex:0] isEqualToString:@"daxiaoqiu"]){
                [_leftBtn setTitle:@"大" forState:UIControlStateNormal];
                [_rightBtn setTitle:@"小" forState:UIControlStateNormal];
                _middleLab.text = @"VS";
            }else{
                [_leftBtn setTitle:@"客胜" forState:UIControlStateNormal];
                [_rightBtn setTitle:@"主胜" forState:UIControlStateNormal];
                _middleLab.text = @"VS";
            }
        }
    }else{
        [_leftBtn setTitle:@"客胜" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"主胜" forState:UIControlStateNormal];
        _middleLab.text = @"VS";
    }
}
-(void)btnAction:(UIButton *)button{
    
    if((_leftBtn.selected || _rightBtn.selected) && button.selected == NO){
        return;
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