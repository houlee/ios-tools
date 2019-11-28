//
//  PermutationAndCombination.m
//  caibo
//
//  Created by houchenguang on 15/1/12.
//
//

#import "PermutationAndCombination.h"

@implementation PermutationAndCombination

- (id)init{
     self = [super init];
    if (self) {
        pernutationArray = [[NSMutableArray alloc] initWithCapacity:0];
//        allMatchArray = [[NSMutableArray alloc] initWithCoder:0];
        chaifenSaishiArym = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)twoCountSumConbination:(NSMutableArray *)matchArray{
    NSInteger mtchCount = [matchArray count];
    NSMutableArray * conbinationArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < mtchCount; i++) {
        
        for (int m = i; m < mtchCount; m++) {
            NSString * conbinationString = [matchArray objectAtIndex:i];
            NSArray * conarr = [conbinationString componentsSeparatedByString:@"|"];
            //            if ([conarr count] > 1) {
            //                conbinationString = [NSString stringWithFormat:@"%@%@", [conarr objectAtIndex:0], [conarr objectAtIndex:1]];
            //            }
            for (int j = 1; j < 2; j++) {
                
                if (j+m < mtchCount) {
                    if ([conarr count] > 0) {
                        //                        NSString * oneString = [conarr objectAtIndex:0];
                        
                        NSString * matchString = [matchArray objectAtIndex:j+m];
                        NSArray * marr = [matchString componentsSeparatedByString:@"|"];
                        if ([marr count] > 0) {
                            NSString * twoString = [marr objectAtIndex:0];
                            
                            NSArray * combinArray = [conbinationString componentsSeparatedByString:@"x"];
                            BOOL yesOrNo = NO;
                            for (int n = 0; n < [combinArray count];  n++) {
                                NSString * comstr = [combinArray objectAtIndex:n];
                                NSArray * comarr = [comstr componentsSeparatedByString:@"|"];
                                if ([comarr count]>= 1) {
                                    if ([[comarr objectAtIndex:0] isEqualToString:twoString]) {
                                        yesOrNo = YES;
                                    }
                                }
                                
                                
                            }
                            
                            if (yesOrNo == NO) {//如果不是同一场次的 再组合
                                conbinationString = [NSString stringWithFormat:@"%@x%@", conbinationString,[matchArray objectAtIndex:j+m]];
                            }
                        }
                        
                    }
                    
                    
                    
                }else{
                    break;
                }
                
                
            }
            NSArray * comArray = [conbinationString componentsSeparatedByString:@"x"];
            
            if ([comArray count] == 2) {
                
                [conbinationArray addObject:conbinationString];
            }
        }
        
    }
    
    [chaifenSaishiArym removeAllObjects];
    [chaifenSaishiArym addObjectsFromArray:conbinationArray];
    NSLog(@"ddd = %@", conbinationArray);
}



- (void)recursionOne:(NSMutableArray *)matchArray chuan:(int)b current:(int)c{
    for (int i = 0; i < [[matchArray objectAtIndex:0] count]; i++) {
        NSMutableArray * oneArray = [matchArray objectAtIndex:0];
        for (int j = 0; j < [[matchArray objectAtIndex:1] count]; j++) {
            NSMutableArray * twoArray = [matchArray objectAtIndex:1];
            for (int k = 0; k < [[matchArray objectAtIndex:2] count]; k++) {
                NSMutableArray * threeArray = [matchArray objectAtIndex:2];
                NSString * str = [NSString stringWithFormat:@"%@x%@x%@", [oneArray objectAtIndex:i], [twoArray objectAtIndex:j], [threeArray objectAtIndex:k]];
                [pernutationArray addObject:str];
            }
            
        }
        
        
    }

    [chaifenSaishiArym removeAllObjects];
    [chaifenSaishiArym addObjectsFromArray:pernutationArray];
    NSLog(@"pernutationArray = %@", pernutationArray);
//
}

-(NSMutableArray *)chaifenArray
{
    return chaifenSaishiArym;
}

- (void)combinationWhithMatchArray:(NSMutableArray *)matchArray chuanCount:(NSString *)countSum{

//    [allMatchArray addObjectsFromArray:matchArray];
    
    if ([countSum isEqualToString:@"2"]) {
        [self twoCountSumConbination:matchArray];
    }else if ([countSum isEqualToString:@"3"]){
    
//        [self threeCountSumConbination:matchArray];
        [self recursionOne:matchArray chuan:3 current:0];
    }

    
   
    
    
   
    

}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    