//
//  LECDoggoApp.m
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/22/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import "LECBreed.h"

@implementation LECBreed

-(instancetype)initWithName:(NSString *)name subBreeds:(NSArray *)subBreeds imageUrls:(NSArray *)imageUrls
{
    self = [super init];
    if (self){
        _name = name;
        _subBreeds = subBreeds;
        _imageUrls = imageUrls;
    }
    return self;
}

@end
