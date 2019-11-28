//
//  NewAlgorithm.m
//  Lottery
//
//  Created by j on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_NewAlgorithm.h"
#import "GC_LotteryUtil.h"

@implementation GC_NewAlgorithm
@synthesize totalNum;
//@synthesize m_arr;

/*************************************
 *设胆时的算法
 @algArray 每一场的结果数
 @chuanGuan 串关方式
 @changCi 场次
 @sArray 每一场的设胆情况
**************************************/
- (void)countAlgorithmWithArray:(NSMutableArray *)algArray chuanGuan:(NSString *)chuanGuan changCi:(NSInteger)changCi sheDan:(NSArray *)sArray {
    
    if ([algArray count] > 0) {
        //NSMutableArray *mArr = [[NSMutableArray alloc] init];
        
        m_arr = [[NSMutableArray alloc] init];
       

        bValue = 1;
        NSInteger shedanNum = 0;
        
        for (int i = 0; i < [sArray count]; i++) {
            NSInteger sdValue = [[sArray objectAtIndex:i] integerValue];
            if (sdValue) {
                NSInteger beiValue = [[algArray objectAtIndex:i] integerValue];
                bValue *= beiValue;
                shedanNum += 1;
            }
            else {
                [m_arr addObject:[algArray objectAtIndex:i]];
            }
        }
      
        NSLog(@"m_arr = %@", m_arr);
        
        //NSInteger yuChang = changCi - shedanNum;//NSLog(@"yuChang = %d", yuChang);//余下来的场数
         NSString *selChangShu = @"";
        NSRange chuanfa = [chuanGuan rangeOfString:@"串"];
        if (chuanfa.location != NSNotFound) {
            NSArray * arr = [chuanGuan componentsSeparatedByString:@"串"];
            selChangShu = [arr objectAtIndex:0];//NSLog(@"需要选择的场数 = %@", selChangShu);
        }
       
        
        NSInteger haiXu = [selChangShu integerValue]-shedanNum;//NSLog(@"还需要选择的场数 = %d", haiXu);
        
        //NSInteger comb = [LotteryUtil combination:yuChang :haiXu];
        //NSLog(@"组合数 = %d", comb);//组合数  多少＋
        [self totalNumByYuSelChangCi:haiXu yuArr:m_arr];
    }
}

/*****************************
 *计算设胆后的场次的注数
 @selChang 还需要选择的场次 作循环数
 @beiyuArr 除设胆  余下每场的结果数
 ****************************/
- (void)totalNumByYuSelChangCi:(NSInteger)selChang yuArr:(NSMutableArray *)yuArr {
    
    if (yuArr) {
        

        if (selChang == [yuArr count]) {
            totalNum = 1;
            for (int u = 0; u < [yuArr count]; u++) {
                NSInteger value = [[yuArr objectAtIndex:u] integerValue];
                totalNum *= value;
            }
        }
        else {
            switch (selChang) {
                case 1:
                {
                    for (int u = 0; u < [yuArr count]; u++) {
                        NSInteger value = [[yuArr objectAtIndex:u] integerValue];
                        totalNum += value;
                    }
                }
                    break;
                case 2:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr = [self subArrayFromIndex:++baseIndex aboutArray:m_arr];
                        totalNum += [self reLoopValue:yArr baseValue:value];
                    }
                }
                    break;
                case 3:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index = 0;
                        while (index < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index aboutArray:yArr1];
                            totalNum += [self reLoopValue:yArr2 baseValue:value2]*value1;
                        }
                    }
                }
                    break;
                case 4:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                totalNum += [self reLoopValue:yArr3 baseValue:value3]*value2*value1;
                            }
                        }
                    }
                }
                    break;
                case 5:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    totalNum += [self reLoopValue:yArr4 baseValue:value4]*value3*value2*value1;
                                }
                            }
                        }
                    }
                }
                    break;
                case 6:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    
                                    NSInteger index5 = 0;
                                    while (index5 < [yArr4 count]-1) {
                                        NSInteger value5 = [[yArr4 objectAtIndex:index5] integerValue];
                                        NSMutableArray *yArr5 = [self subArrayFromIndex:++index5 aboutArray:yArr4];
                                        totalNum += [self reLoopValue:yArr5 baseValue:value5]*value4*value3*value2*value1;
                                    }
                                }
                            }
                        }
                    }
                }
                    break;
                case 7:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    
                                    NSInteger index5 = 0;
                                    while (index5 < [yArr4 count]-1) {
                                        NSInteger value5 = [[yArr4 objectAtIndex:index5] integerValue];
                                        NSMutableArray *yArr5 = [self subArrayFromIndex:++index5 aboutArray:yArr4];
                                        
                                        NSInteger index6 = 0;
                                        while (index6 < [yArr5 count]-1) {
                                            NSInteger value6 = [[yArr5 objectAtIndex:index6] integerValue];
                                            NSMutableArray *yArr6 = [self subArrayFromIndex:++index6 aboutArray:yArr5];
                                            totalNum += [self reLoopValue:yArr6 baseValue:value6]*value5*value4*value3*value2*value1;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                    break;
                case 8:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    
                                    NSInteger index5 = 0;
                                    while (index5 < [yArr4 count]-1) {
                                        NSInteger value5 = [[yArr4 objectAtIndex:index5] integerValue];
                                        NSMutableArray *yArr5 = [self subArrayFromIndex:++index5 aboutArray:yArr4];
                                        
                                        NSInteger index6 = 0;
                                        while (index6 < [yArr5 count]-1) {
                                            NSInteger value6 = [[yArr5 objectAtIndex:index6] integerValue];
                                            NSMutableArray *yArr6 = [self subArrayFromIndex:++index6 aboutArray:yArr5];
                                            
                                            NSInteger index7 = 0;
                                            while (index7 < [yArr6 count]-1) {
                                                NSInteger value7 = [[yArr6 objectAtIndex:index7] integerValue];
                                                NSMutableArray *yArr7 = [self subArrayFromIndex:++index7 aboutArray:yArr6];
                                                totalNum += [self reLoopValue:yArr7 baseValue:value7]*value6*value5*value4*value3*value2*value1;
                                            }

                                        }
                                    }
                                }
                            }
                        }
                    }

                }
                    break;
                case 9:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    
                                    NSInteger index5 = 0;
                                    while (index5 < [yArr4 count]-1) {
                                        NSInteger value5 = [[yArr4 objectAtIndex:index5] integerValue];
                                        NSMutableArray *yArr5 = [self subArrayFromIndex:++index5 aboutArray:yArr4];
                                        
                                        NSInteger index6 = 0;
                                        while (index6 < [yArr5 count]-1) {
                                            NSInteger value6 = [[yArr5 objectAtIndex:index6] integerValue];
                                            NSMutableArray *yArr6 = [self subArrayFromIndex:++index6 aboutArray:yArr5];
                                            
                                            NSInteger index7 = 0;
                                            while (index7 < [yArr6 count]-1) {
                                                NSInteger value7 = [[yArr6 objectAtIndex:index7] integerValue];
                                                NSMutableArray *yArr7 = [self subArrayFromIndex:++index7 aboutArray:yArr6];
                                                
                                                NSInteger index8 = 0;
                                                while (index8 < [yArr7 count]-1) {
                                                    NSInteger value8 = [[yArr7 objectAtIndex:index8] integerValue];
                                                    NSMutableArray *yArr8 = [self subArrayFromIndex:++index8 aboutArray:yArr7];
                                                    totalNum += [self reLoopValue:yArr8 baseValue:value8]*value7*value6*value5*value4*value3*value2*value1;
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
                    break;
                case 10:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    
                                    NSInteger index5 = 0;
                                    while (index5 < [yArr4 count]-1) {
                                        NSInteger value5 = [[yArr4 objectAtIndex:index5] integerValue];
                                        NSMutableArray *yArr5 = [self subArrayFromIndex:++index5 aboutArray:yArr4];
                                        
                                        NSInteger index6 = 0;
                                        while (index6 < [yArr5 count]-1) {
                                            NSInteger value6 = [[yArr5 objectAtIndex:index6] integerValue];
                                            NSMutableArray *yArr6 = [self subArrayFromIndex:++index6 aboutArray:yArr5];
                                            
                                            NSInteger index7 = 0;
                                            while (index7 < [yArr6 count]-1) {
                                                NSInteger value7 = [[yArr6 objectAtIndex:index7] integerValue];
                                                NSMutableArray *yArr7 = [self subArrayFromIndex:++index7 aboutArray:yArr6];
                                                
                                                NSInteger index8 = 0;
                                                while (index8 < [yArr7 count]-1) {
                                                    NSInteger value8 = [[yArr7 objectAtIndex:index8] integerValue];
                                                    NSMutableArray *yArr8 = [self subArrayFromIndex:++index8 aboutArray:yArr7];
                                                   
                                                    
                                                    NSInteger index9 = 0;
                                                    while (index9 < [yArr8 count]-1) {
                                                        NSInteger value9 = [[yArr8 objectAtIndex:index9] integerValue];
                                                        NSMutableArray *yArr9 = [self subArrayFromIndex:++index9 aboutArray:yArr8];
                                                        totalNum += [self reLoopValue:yArr9 baseValue:value9]*value8*value7*value6*value5*value4*value3*value2*value1;
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
                    break;
                case 11:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    
                                    NSInteger index5 = 0;
                                    while (index5 < [yArr4 count]-1) {
                                        NSInteger value5 = [[yArr4 objectAtIndex:index5] integerValue];
                                        NSMutableArray *yArr5 = [self subArrayFromIndex:++index5 aboutArray:yArr4];
                                        
                                        NSInteger index6 = 0;
                                        while (index6 < [yArr5 count]-1) {
                                            NSInteger value6 = [[yArr5 objectAtIndex:index6] integerValue];
                                            NSMutableArray *yArr6 = [self subArrayFromIndex:++index6 aboutArray:yArr5];
                                            
                                            NSInteger index7 = 0;
                                            while (index7 < [yArr6 count]-1) {
                                                NSInteger value7 = [[yArr6 objectAtIndex:index7] integerValue];
                                                NSMutableArray *yArr7 = [self subArrayFromIndex:++index7 aboutArray:yArr6];
                                                
                                                NSInteger index8 = 0;
                                                while (index8 < [yArr7 count]-1) {
                                                    NSInteger value8 = [[yArr7 objectAtIndex:index8] integerValue];
                                                    NSMutableArray *yArr8 = [self subArrayFromIndex:++index8 aboutArray:yArr7];
                                                    
                                                    
                                                    NSInteger index9 = 0;
                                                    while (index9 < [yArr8 count]-1) {
                                                        NSInteger value9 = [[yArr8 objectAtIndex:index9] integerValue];
                                                        NSMutableArray *yArr9 = [self subArrayFromIndex:++index9 aboutArray:yArr8];
                                                        
                                                        NSInteger index10 = 0;
                                                        while (index10 < [yArr9 count]-1) {
                                                            NSInteger value10 = [[yArr9 objectAtIndex:index10] integerValue];
                                                            NSMutableArray *yArr10 = [self subArrayFromIndex:++index10 aboutArray:yArr9];
                                                            totalNum += [self reLoopValue:yArr10 baseValue:value10]*value9*value8*value7*value6*value5*value4*value3*value2*value1;
                                                        }
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    break;
                case 12:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    
                                    NSInteger index5 = 0;
                                    while (index5 < [yArr4 count]-1) {
                                        NSInteger value5 = [[yArr4 objectAtIndex:index5] integerValue];
                                        NSMutableArray *yArr5 = [self subArrayFromIndex:++index5 aboutArray:yArr4];
                                        
                                        NSInteger index6 = 0;
                                        while (index6 < [yArr5 count]-1) {
                                            NSInteger value6 = [[yArr5 objectAtIndex:index6] integerValue];
                                            NSMutableArray *yArr6 = [self subArrayFromIndex:++index6 aboutArray:yArr5];
                                            
                                            NSInteger index7 = 0;
                                            while (index7 < [yArr6 count]-1) {
                                                NSInteger value7 = [[yArr6 objectAtIndex:index7] integerValue];
                                                NSMutableArray *yArr7 = [self subArrayFromIndex:++index7 aboutArray:yArr6];
                                                
                                                NSInteger index8 = 0;
                                                while (index8 < [yArr7 count]-1) {
                                                    NSInteger value8 = [[yArr7 objectAtIndex:index8] integerValue];
                                                    NSMutableArray *yArr8 = [self subArrayFromIndex:++index8 aboutArray:yArr7];
                                                    
                                                    
                                                    NSInteger index9 = 0;
                                                    while (index9 < [yArr8 count]-1) {
                                                        NSInteger value9 = [[yArr8 objectAtIndex:index9] integerValue];
                                                        NSMutableArray *yArr9 = [self subArrayFromIndex:++index9 aboutArray:yArr8];
                                                        
                                                        NSInteger index10 = 0;
                                                        while (index10 < [yArr9 count]-1) {
                                                            NSInteger value10 = [[yArr9 objectAtIndex:index10] integerValue];
                                                            NSMutableArray *yArr10 = [self subArrayFromIndex:++index10 aboutArray:yArr9];
                                                            
                                                            NSInteger index11 = 0;
                                                            while (index11 < [yArr10 count]-1) {
                                                                NSInteger value11 = [[yArr10 objectAtIndex:index11] integerValue];
                                                                NSMutableArray *yArr11 = [self subArrayFromIndex:++index11 aboutArray:yArr10];
                                                                totalNum += [self reLoopValue:yArr11 baseValue:value11]*value10*value9*value8*value7*value6*value5*value4*value3*value2*value1;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
                    break;
                case 13:
                {
                    NSInteger baseIndex = 0;
                    while (baseIndex < [yuArr count]-1) {
                        NSInteger value1 = [[yuArr objectAtIndex:baseIndex] integerValue];
                        NSMutableArray *yArr1 = [self subArrayFromIndex:++baseIndex aboutArray:yuArr];
                        
                        NSInteger index2 = 0;
                        while (index2 < [yArr1 count]-1) {
                            NSInteger value2 = [[yArr1 objectAtIndex:index2] integerValue];
                            NSMutableArray *yArr2 = [self subArrayFromIndex:++index2 aboutArray:yArr1];
                            
                            NSInteger index3 = 0;
                            while (index3 < [yArr2 count]-1) {
                                NSInteger value3 = [[yArr2 objectAtIndex:index3] integerValue];
                                NSMutableArray *yArr3 = [self subArrayFromIndex:++index3 aboutArray:yArr2];
                                
                                NSInteger index4 = 0;
                                while (index4 < [yArr3 count]-1) {
                                    NSInteger value4 = [[yArr3 objectAtIndex:index4] integerValue];
                                    NSMutableArray *yArr4 = [self subArrayFromIndex:++index4 aboutArray:yArr3];
                                    
                                    NSInteger index5 = 0;
                                    while (index5 < [yArr4 count]-1) {
                                        NSInteger value5 = [[yArr4 objectAtIndex:index5] integerValue];
                                        NSMutableArray *yArr5 = [self subArrayFromIndex:++index5 aboutArray:yArr4];
                                        
                                        NSInteger index6 = 0;
                                        while (index6 < [yArr5 count]-1) {
                                            NSInteger value6 = [[yArr5 objectAtIndex:index6] integerValue];
                                            NSMutableArray *yArr6 = [self subArrayFromIndex:++index6 aboutArray:yArr5];
                                            
                                            NSInteger index7 = 0;
                                            while (index7 < [yArr6 count]-1) {
                                                NSInteger value7 = [[yArr6 objectAtIndex:index7] integerValue];
                                                NSMutableArray *yArr7 = [self subArrayFromIndex:++index7 aboutArray:yArr6];
                                                
                                                NSInteger index8 = 0;
                                                while (index8 < [yArr7 count]-1) {
                                                    NSInteger value8 = [[yArr7 objectAtIndex:index8] integerValue];
                                                    NSMutableArray *yArr8 = [self subArrayFromIndex:++index8 aboutArray:yArr7];
                                                    
                                                    
                                                    NSInteger index9 = 0;
                                                    while (index9 < [yArr8 count]-1) {
                                                        NSInteger value9 = [[yArr8 objectAtIndex:index9] integerValue];
                                                        NSMutableArray *yArr9 = [self subArrayFromIndex:++index9 aboutArray:yArr8];
                                                        
                                                        NSInteger index10 = 0;
                                                        while (index10 < [yArr9 count]-1) {
                                                            NSInteger value10 = [[yArr9 objectAtIndex:index10] integerValue];
                                                            NSMutableArray *yArr10 = [self subArrayFromIndex:++index10 aboutArray:yArr9];
                                                            
                                                            NSInteger index11 = 0;
                                                            while (index11 < [yArr10 count]-1) {
                                                                NSInteger value11 = [[yArr10 objectAtIndex:index11] integerValue];
                                                                NSMutableArray *yArr11 = [self subArrayFromIndex:++index11 aboutArray:yArr10];
                                                                
                                                                
                                                                NSInteger index12 = 0;
                                                                while (index12 < [yArr11 count]-1) {
                                                                    NSInteger value12 = [[yArr11 objectAtIndex:index12] integerValue];
                                                                    NSMutableArray *yArr12 = [self subArrayFromIndex:++index12 aboutArray:yArr11];
                                                                    totalNum += [self reLoopValue:yArr12 baseValue:value12]*value11*value10*value9*value8*value7*value6*value5*value4*value3*value2*value1;
                                                                    
                                                                    
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
}
/*
- (NSInteger)selectTwoFieldWithArray:(NSArray *)arr {
    
}*/

//已选定一场的情况下，再选一场
- (NSInteger)reLoopValue:(NSArray *)array baseValue:(NSInteger)baseValue {
    
    NSLog(@"array = %@", array);
    
    NSInteger part = 0;
    int index = 0;
    while (index < [array count]) {
        part += [[array objectAtIndex:index] integerValue]*baseValue;
        index++;
    }
    return part;
}

//余下的数组
- (NSMutableArray *)subArrayFromIndex:(NSInteger)index aboutArray:(NSArray *)arr {
    NSMutableArray *m = [NSMutableArray array];
    for (int u = (int)index; u < [arr count]; u++) {
        [m addObject:[arr objectAtIndex:u]];
    }
    return m;
}

- (long long)reTotalNumber {
    return (long long)(totalNum*bValue);
}

- (void)dealloc {
    [m_arr release];m_arr = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    