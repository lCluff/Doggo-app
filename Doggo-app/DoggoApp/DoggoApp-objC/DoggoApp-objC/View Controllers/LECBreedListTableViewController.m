//
//  LECBreedListTableViewController.m
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/23/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import "LECBreedListTableViewController.h"
#import "LECImagesCollectionViewController.m"
#import "LECBreed.h"
#import "LECBreedNetworking.h"
#import "LECSubBreedListTableViewController.h"

@interface LECBreedListTableViewController ()

@property (nonatomic, copy) NSArray *breeds;

@end

@implementation LECBreedListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LECBreedNetworking sharedController]
     fetchAllBreeds:^(NSArray * breeds) {
         self.breeds = breed;
         dispatch_async(dispatch_get_main_queue(), ^{
         [[self tableView] reloadData];
    });
}];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.breeds.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"breedCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.breeds[indexPath.row] name]
                           capitalizedString];;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
LECBreed * breed = [[[[self.breeds[self tableView] indexPathForSelectedRow] row]];
if ([breed.subBreeds  count] > 0){
    [self performSegueWithIdentifier:@"toSubBreedVC" sender:self];
        } else {
[self performSegueWithIdentifier:@"toCollectionVC" sender:self];
        }
}


     #pragma mark - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
   LECBreed * breed = [[[self.breeds[self tableView]indexPathForSelectedRow] row]];
             if([segue.identifier isEqualToString:@"toSubBreedVC" ])
{

LECSubBreedListTableViewController *destinationVC = segue.destinationViewController;
    destinationVC.breed = breed;
                     
}else if([segue.identifier  isEqualToString: @"toCollectionVC"]){
    
LECImagesCollectionViewController *destinationVC = segue.destinationViewController;
destinationVC.breed = breed;
    }
}

@end
             
