//
//  DogPictureCollectionViewCell.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HostLiveModel;

@interface DogPictureCollectionViewCell : UICollectionViewCell

/** cell模型 */
@property (strong,nonatomic) HostLiveModel *model;

@end
