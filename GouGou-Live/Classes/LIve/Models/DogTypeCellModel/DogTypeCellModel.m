//
//  DogTypeCellModel.m
//  GouGou-Live
//
//  Created by ma c on 16/10/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogTypeCellModel.h"

@implementation DogTypeCellModel

- (instancetype)initWithDogIcon:(NSString *)dogIcon focusCount:(NSString *)focusCount dogDesc:(NSString *)dogDesc anchorName:(NSString *)anchorName showCount:(NSString *)showCount onSailCount:(NSString *)onSailCount {
    
        DogTypeCellModel *dogCard = [[DogTypeCellModel alloc] init];
        
        dogCard.dogIcon = dogIcon;
        dogCard.focusCount = focusCount;
        dogCard.dogDesc = dogDesc;
        dogCard.anchorName = anchorName;
        dogCard.showCount = showCount;
        dogCard.onSailCount = onSailCount;

    return dogCard;
}
@end
