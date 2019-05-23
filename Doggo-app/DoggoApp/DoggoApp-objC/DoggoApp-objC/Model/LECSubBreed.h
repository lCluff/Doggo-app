//
//  LECDoggoAppController.h
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/22/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LECSubBreed : NSObject

@property(nonatomic,copy,readonly) NSString *name;
@property(nonatomic,copy,readonly) NSArray *imageUrls;

-(instancetype) initWithName:(NSString *)name imageUrls:(NSArray *)imageUrls;

@end

NS_ASSUME_NONNULL_END
