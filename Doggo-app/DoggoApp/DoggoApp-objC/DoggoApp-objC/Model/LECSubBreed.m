//
//  LECDoggoAppController.m
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/22/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import "LECSubBreed.h"

@implementation LECSubBreed

-(instancetype)initWithName:(NSString *)name imageUrls:(NSArray *)imageUrls;
{
    self = [super init];
    if (self) {
        _name = name;
        _imageUrls = imageUrls;
       
    }
    return self;
}
@end
