//
//  MyPictureListModel.h
//  GouGou-Live
//
//  Created by ma c on 16/11/30.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface MyPictureListModel : BaseModel

@property(nonatomic, strong) NSString *pathBig; /**< 相片url */
@property(nonatomic, strong) NSString *ID; /**< 相片id */

@end
