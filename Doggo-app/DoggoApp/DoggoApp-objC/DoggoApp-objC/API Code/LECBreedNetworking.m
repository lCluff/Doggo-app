//
//  LECBreedNetworking.m
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/22/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import "LECBreedNetworking.h"
#import "LECBreed.h"
#import "LECSubBreed.h"

static NSString * const baseUrlString = @"https://dog.ceo/api";

@implementation LECBreedNetworking

+(LECBreedNetworking *)sharedController
{
    static LECBreedNetworking *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [LECBreedNetworking new];
    });
    return sharedController;
}

-(void)fetchAllBreeds:(void (^)(NSArray * _Nonnull))completion
{
    NSURL *baseUrl = [NSURL URLWithString:baseUrlString];
    NSURL *breedUrl = [[[baseUrl URLByAppendingPathComponent:@"breeds"]
        URLByAppendingPathComponent:@"list"]
        URLByAppendingPathComponent:@"all"];
    
   [[NSURLSession sharedSession]dataTaskWithURL:breedUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Oh H*CK, there's been an error fetching breeds data! %@", error);
            completion(nil);
            return;
        }
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]){
            NSLog(@"There's been an error looking pup the json dictionary %@", error);
            completion(nil);
            return;
        }
        NSDictionary *messageDictionary = jsonDictionary[@"message"];
        NSMutableArray *breeds = [[NSMutableArray alloc] init];
        for (id key in messageDictionary)
        {
            NSMutableArray *subBreeds = [[NSMutableArray alloc] init];
            for (NSString * name in messageDictionary[key])
            {
                LECSubBreed *subBreed = [[LECSubBreed alloc] initWithName:name imageUrls:[[NSMutableArray alloc] init]];
                [subBreeds addObject:subBreed];
            }
            
        }
    }
    
}
@end
