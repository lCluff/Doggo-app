//
//  LECSubBreedListTableViewController.m
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/23/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//
#import "LECSubBreedListTableViewController.h"
#import "LECBreed.h"
#import "LECBreedNetworking.h"
#import "LECImagesCollectionViewController.h"

@interface LECSubBreedListTableViewController ()

@end

@implementation LECSubBreedListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.breed.name capitalizedString];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.breed.subBreeds count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subBreedCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.breed.subBreeds[indexPath.row] name] capitalizedString];
    return cell;
}

//Landing pad setValue
//run this when the breed property is set
- (void)setBreed:(LECBreed *)breed
{
    if(breed != _breed){
        _breed = breed;
        [self.tableView reloadData];
    }
}

//when a row is selected, the view will perform a the specified segue
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"fromSubBreedsToImages" sender:self];
}

//when a segue is about to happen this code will run
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LECSubBreed * subBreed = self.breed.subBreeds[[[[self tableView] indexPathForSelectedRow] row]];
    if([segue.identifier  isEqualToString: @"fromSubBreedsToImages"])
    {
        //send breed and subBreed to landing pads on collection view
        LECImagesCollectionViewController *destinationVC = segue.destinationViewController;
        destinationVC.subBreed = subBreed;
        destinationVC.breed = self.breed;
        
    }
}
@end
