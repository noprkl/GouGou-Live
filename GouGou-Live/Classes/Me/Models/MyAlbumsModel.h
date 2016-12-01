//
//  MyAlbumsModel.h
//  GouGou-Live
//
//  Created by ma c on 16/11/30.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface MyAlbumsModel : BaseModel

@property(nonatomic, strong) NSString *albumName; /**< 相册名字 */
@property(nonatomic, strong) NSString *ID; /**< 相册id */
@property(nonatomic, strong) NSString *pNum; /**< 图片个数 */
@property(nonatomic, strong) NSString *pathSmall; /**< 缩略图 */

@end
