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

static NSString * const baseURLString = @"https://dog.ceo/api";

@implementation LECBreedNetworking

//Shared instance
+ (LECBreedNetworking *)sharedController
{
    static LECBreedNetworking *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [LECBreedNetworking new];
    });
    return sharedController;
}

- (void)fetchAllBreeds: (void (^) (NSArray *))completion
{
    //https://dog.ceo/api
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    //https://dog.ceo/api/breeds/list/all
    NSURL *breedURL = [[[baseURL URLByAppendingPathComponent: @"breeds"] URLByAppendingPathComponent:@"list"] URLByAppendingPathComponent:@"all"];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:breedURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle error
        if (error){
            NSLog(@"Error fetching breeds from search term: %@", error);
            completion(nil);
            return;
        }
        //handle missing data
        if(!data){
            NSLog(@"Error fetching breeds DATA from search term: %@", error);
            completion(nil);
            return;
        }
        //serialize to a jsonDictionary
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        //check to see that you got a jsonDictionary back
        if (!jsonDictionary|| ![jsonDictionary isKindOfClass:[NSDictionary class]]){
            NSLog(@"Error fetching json dictionary %@", error);
            completion(nil);
            return;
        }
        //Get the messages Dictionary from the top level dictionary
        NSDictionary *messageDictionary = jsonDictionary[@"message"];
        //make an array to store all breeds into
        NSMutableArray *breeds = [[NSMutableArray alloc] init];
        //loop through dictionary to make keys to breeds and values into subBreeds
        for (id key in messageDictionary)
        {
            //create subBreeds Array
            NSMutableArray *subBreeds = [[NSMutableArray alloc] init];
            //create subbreeds from values
            for (NSString *name in messageDictionary[key] )
            {
                LECSubBreed *subBreed = [[LECSubBreed alloc] initWithName:name imageUrls:[[NSMutableArray alloc] init]];
                [subBreeds addObject:subBreed];
            }
            //create breeds from keys on dictionary
            LECBreed * breed = [[LECBreed alloc] initWithName: key subBreeds: subBreeds imageUrls:[[NSMutableArray alloc] init] ];
            [breeds addObject:breed];
        }
        //complete with an array of breeds
        completion(breeds);
    }]resume];
}

//fetch breed image URLs
- (void)fetchBreedImageURLs:(LECBreed *)breed completion:(void (^) (NSArray *))completion;
{
    //https://dog.ceo/api
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    //https://dog.ceo/api/breed/hound/images
    NSURL *breedURL = [[[baseURL URLByAppendingPathComponent: @"breed"] URLByAppendingPathComponent:breed.name] URLByAppendingPathComponent:@"images"];
    NSLog(@"%@", breedURL);
    [[[NSURLSession sharedSession]dataTaskWithURL:breedURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle error
        if (error){
            NSLog(@"Error fetching breeds from search term: %@", error);
            completion(nil);
            return;
        }
        //handle missing data
        if(!data){
            NSLog(@"Error fetching breeds DATA from search term: %@", error);
            completion(nil);
            return;
        }
        //serialize a jsonDictionary from data
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        //check to see if we got a dictionary back
        if (!jsonDictionary|| ![jsonDictionary isKindOfClass:[NSDictionary class]]){
            NSLog(@"Error fetching json dictionary %@", error);
            completion(nil);
            return;
        }
        //pull the imageURLs out of the messages dictionary
        NSMutableArray *images = jsonDictionary[@"message"];
        //complete with array
        completion(images);
        
    }]resume];
}

//fetch subbreed image URLs
//https://dog.ceo/api/breed/hound/basset/images
- (void)fetchSubBreedImageURLs:(LECSubBreed *)subBreed breed:(LECBreed *)breed completion:(void (^) (NSArray *))completion;
{
    //https://dog.ceo/api
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    //https://dog.ceo/api/breed/hound/images
    NSURL *breedURL = [[[[baseURL URLByAppendingPathComponent: @"breed"] URLByAppendingPathComponent:breed.name] URLByAppendingPathComponent:subBreed.name] URLByAppendingPathComponent:@"images"];
    NSLog(@"%@🤡", breedURL);
    [[[NSURLSession sharedSession]dataTaskWithURL:breedURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle error
        if (error){
            NSLog(@"Error fetching breeds from search term: %@", error);
            completion(nil);
            return;
        }
        //handle missing data
        if(!data){
            NSLog(@"Error fetching breeds DATA from search term: %@", error);
            completion(nil);
            return;
        }
        //serialize into jsonDictionary
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        //verify that we got a jsonDictionary
        if (!jsonDictionary|| ![jsonDictionary isKindOfClass:[NSDictionary class]]){
            NSLog(@"Error fetching json dictionary %@", error);
            completion(nil);
            return;
        }
        //create an array of imageURLs from message dictionary
        NSMutableArray *images = jsonDictionary[@"message"];
        //complete with array
        completion(images);
        
    }]resume];
}

- (void)fetchImageData:(NSURL *)url completion:(void (^)(NSData *imageData, NSError *error))completion
{
    //Fetch image with provided URL
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle error
        if (error){
            NSLog(@"Error fetching breeds from search term: %@", error);
            return completion(nil, error);
        }
        //handle missing data
        if(!data){
            NSLog(@"Error fetching breeds DATA from search term: %@", error);
            return completion(nil, error);
        }
        //complete with data
        completion(data, nil);
    }]resume];
}

@end



