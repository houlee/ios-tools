//
//  MyPickerView.h
//  caibo
//
//  Created by GongHe on 14-7-18.
//
//

#import <UIKit/UIKit.h>

@class MyPickerView;

@protocol MyPickerViewDelegate <NSObject>

@optional
-(void)myPickerView:(MyPickerView *)myPickerView content:(NSString *)content;

-(void)myPickerView:(MyPickerView *)myPickerView cellIndex:(NSInteger)index content:(NSString *)content;


@end

@interface MyPickerView : UIView <UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
{
    UIView * pickerBG;
    UIPickerView * pickerView;
    NSArray * contentArray;
    
    CGRect showFrame;
    CGRect beginFrame;
    
    NSString * contentString;
    NSString * titleString;
    
    id delegate;
}

@property(nonatomic,assign)id <MyPickerViewDelegate> delegate;

- (id)DefaultPickerView;


- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)array;
- (id)initWithContentArray:(NSArray *)array;

-(void)showWithTitle:(NSString *)title;

@end
