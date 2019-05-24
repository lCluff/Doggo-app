//
//  LECBreedNetworking.h
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/22/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LECBreed;
@class LECSubBreed;
@class LECImage;

NS_ASSUME_NONNULL_BEGIN

@interface LECBreedNetworking : NSObject

- (void)fetchAllBreeds: (void (^)(NSArray *))completion;

- (void)fetchBreedImageURLS: (LECBreed *)breed completion:(void(^)(NSArray *))completion;

- (void)fetchSubBreedImageUrls: (LECSubBreed *)subBreed breed:(LECBreed *)breed completion:(void(^)(NSArray *)) completion;

- (void)fetchImageData: (NSURL *)url completion:(void (^)(NSData *imageData, NSError * error))completion;

+ (LECBreedNetworking *)sharedController;

@end

NS_ASSUME_NONNULL_END
