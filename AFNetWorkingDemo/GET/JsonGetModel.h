//
//  JsonGetModel.h
//  AFNetWorkingDemo
//
//  Created by uen on 16/12/1.
//  Copyright © 2016年 UEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonGetModel : NSObject

//如果服务端传过来的是数字，用NSNumber去接，不用NSInterger，因为OC的字典和数组只能装OC对象
@property (nonatomic,copy)NSString *description1;
@property (nonatomic,copy)NSString *iconUrl;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *updateDate;

@end
