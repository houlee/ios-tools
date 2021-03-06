//
//  CP_UISegement.m
//  caibo
//
//  Created by yaofuyu on 13-1-20.
//
//

#import "CP_UISegement.h"

@implementation CP_UISegement
@synthesize backgroudImageView = _backgroudImageView;
@synthesize titleColor         = _titleColor;
@synthesize titleArray         = _titleArray;
@synthesize selectIndex        = _selectIndex;
@synthesize selectBtn          = _selectBtn;
@synthesize delegate;

#define LONG_WIDTH 85
#define SHORT_WIDTH 54
#define MIDLE_WIDTH 70

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        
        _titleArray = [[NSMutableArray arrayWithArray:items] retain];
        for (int i = 0; i < [items count]; i ++) {
            UILabel *lable = [[UILabel alloc] init];
            lable.backgroundColor = [UIColor clearColor];
            [self addSubview:lable];
            lable.font = [UIFont systemFontOfSize:15];
            lable.text = [_titleArray objectAtIndex:i];
            lable.tag = 100 +i;
            lable.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
            lable.textAlignment = NSTextAlignmentCenter;
            [lable release];

            if (i != 0) {
                UIView *v = [[UIView alloc] init];
                v.backgroundColor = [UIColor colorWithRed:17/255.0 green:163/255.0 blue:255/255.0 alpha:1];
                [lable addSubview:v];
                v.tag = 300;
                [v release];
            }
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [lable addSubview:btn];
            lable.userInteractionEnabled = YES;
            [btn addTarget:self action:@selector(selectBtnClicke:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 400 +i;

        }
    }
    return  self;
}

- (void)selectBtnClicke:(UIButton *)sender {
    [self setSelectIndex:sender.tag - 400];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    if (selectIndex >= [_titleArray count] && ![_titleArray count]) {
        return;
    }
    _selectIndex = selectIndex;
    if (_selectIndex >= [_titleArray count]) {
        _selectIndex = [_titleArray count] - 2;
    }
    if (!_selectBtn) {
        self.selectBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.selectBtn];
        self.selectBtn.userInteractionEnabled = NO;
   
        
//------------------------------------------bianpinghua by sichuanlin
//        [self.selectBtn loadButonImage:@"TYD960.png" LabelName:[_titleArray objectAtIndex:selectIndex]];
        [self.selectBtn loadButonImage:@"dikuang7.png" LabelName:[_titleArray objectAtIndex:selectIndex]];
        
        self.selectBtn.buttonName.font = [UIFont systemFontOfSize:15];
        self.selectBtn.buttonName.shadowColor = [UIColor clearColor];
        
        float selectBtnWidth = SHORT_WIDTH;
        if ([self.selectBtn.buttonName.text length] > 2) {
            if ([self.selectBtn.buttonName.text length] == 4) {
                selectBtnWidth = MIDLE_WIDTH;
            }else{
                selectBtnWidth = LONG_WIDTH;
            }
        }
        float selectBtnX = 0;
        for (int i = 0; i < selectIndex; i++) {
            if ([[_titleArray objectAtIndex:i] length] > 2) {
                if ([[_titleArray objectAtIndex:i] length] == 4) {
                    selectBtnX += MIDLE_WIDTH;
                }else{
                    selectBtnX += LONG_WIDTH;
                }
            }else{
                selectBtnX += SHORT_WIDTH;
            }
        }
        self.selectBtn.frame = CGRectMake(selectBtnX, 0, selectBtnWidth, self.bounds.size.height);
    }
    else {
        self.selectBtn.buttonName.text = [_titleArray objectAtIndex:_selectIndex];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.1];

        float selectBtnWidth = SHORT_WIDTH;
        if ([self.selectBtn.buttonName.text length] > 2) {
            if ([self.selectBtn.buttonName.text length] == 4) {
                selectBtnWidth = MIDLE_WIDTH;
            }else{
                selectBtnWidth = LONG_WIDTH;
            }
        }
        float selectBtnX = 0;
        for (int i = 0; i < selectIndex; i++) {
            if ([[_titleArray objectAtIndex:i] length] > 2) {
                if ([[_titleArray objectAtIndex:i] length] == 4) {
                    selectBtnX += MIDLE_WIDTH;
                }else{
                    selectBtnX += LONG_WIDTH;
                }
            }else{
                selectBtnX += SHORT_WIDTH;
            }
        }
        self.selectBtn.frame = CGRectMake(selectBtnX, 0, selectBtnWidth, self.bounds.size.height);

        [UIView commitAnimations];
        
    }
    if (delegate && [delegate respondsToSelector:@selector(selectIndexChangde:)]) {
        [delegate selectIndexChangde:self];
    }
}

-(void)setTitleColor:(UIColor *)titleColor {
    [_titleColor release];
    if (!titleColor) {
        _titleColor = nil;
        return;
    }
    _titleColor = [titleColor retain];
    for (int i = 0;i < [self.titleArray count]; i ++) {
        UILabel *label = (UILabel *)[self viewWithTag:100+i];
        label.textColor = titleColor;
    }
}

- (void)setBackgroudImage:(UIImage *)image {
    if (!_backgroudImageView) {
        _backgroudImageView = [[UIImageView alloc] init];
        [self insertSubview:_backgroudImageView atIndex:0];
        _backgroudImageView.frame = self.bounds;
    
    }
    _backgroudImageView.image = image;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _backgroudImageView.frame = self.bounds;
    
    float labelX = 0;
    
    for (int i = 0;i < [self.titleArray count]; i ++) {
        UILabel *label = (UILabel *)[self viewWithTag:100+i];
//        label.frame = CGRectMake(i *frame.size.width/[_titleArray count], 0 , frame.size.width/[_titleArray count], frame.size.height);
        float labelWidth = SHORT_WIDTH;
        if ([label.text length] > 2) {
            if ([label.text length] == 4) {
                labelWidth = MIDLE_WIDTH;
            }else{
                labelWidth = LONG_WIDTH;
            }
        }
        
        label.frame = CGRectMake(labelX, 0 , labelWidth, frame.size.height);
        
        UIView *v = [label viewWithTag:300];
        v.frame = CGRectMake(0, 0, 0.5, frame.size.height);
        
        UIView *v2 = [label viewWithTag:400 +i];
        v2.frame = label.bounds;
        
        labelX += labelWidth;
    }
    
    if (self.selectBtn) {
        self.selectBtn.frame = CGRectMake(-1 + _selectIndex * self.frame.size.width/[_titleArray count], 0, self.frame.size.width/[_titleArray count] +2, self.bounds.size.height);
        self.selectBtn.buttonName.text = [_titleArray objectAtIndex:_selectIndex];
    }
}

- (void)dealloc {
    self.backgroudImageView = nil;
    [_titleColor release];
    [_titleArray release];
    self.selectBtn = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    