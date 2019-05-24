//
//  LECSubBreedListTableViewController.h
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/23/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LECBreed.h"

NS_ASSUME_NONNULL_BEGIN

@interface LECSubBreedListTableViewController : UITableViewController

@property(nonatomic, strong) LECBreed *breed;

@end

NS_ASSUME_NONNULL_END
