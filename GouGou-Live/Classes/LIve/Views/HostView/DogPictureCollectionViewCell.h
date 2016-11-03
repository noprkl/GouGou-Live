//
//  DogPictureCollectionViewCell.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DogTypeCellModel;

@interface DogPictureCollectionViewCell : UICollectionViewCell

/** cell模型 */
@property (strong,nonatomic) DogTypeCellModel *typeModel;

@end
