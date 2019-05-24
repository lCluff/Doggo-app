//
//  LECImageCollectionViewCell.m
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/23/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import "LECImageCollectionViewCell.h"
#import "LECBreedNetworking.h"

@implementation LECImageCollectionViewCell

- (void)prepareForReuse

{
    
    [super prepareForReuse];
    self.imageView.image = [UIImage imageNamed:@"dog"];
}


- (void)setImageURL:(NSURL *)imageURL
{
    
    [LECBreedNetworking.sharedController fetchImageData:imageURL completion:^(NSData *imageData, NSError *error) {
        if (error || !imageData) {
            NSLog(@"Couldn't fetch the cute pups%@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageView.image = [UIImage imageWithData:imageData];
        });
    }];
}

@end
