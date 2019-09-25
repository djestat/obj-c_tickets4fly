//
//  CollectionViewController.m
//  ticket4fly
//
//  Created by Igor on 24/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"


@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray* imageCollection;
@property (strong, nonatomic) UICollectionView *collectionView;


@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Collection";

//    UICollectionReusableView *searchView = [UICollectionReusableView new];
//    [_collectionView addSubview: searchView];
    _searchController = [[UISearchController alloc] initWithSearchResultsController: self];
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;
//    _searchController.searchBar setish
//    self.collectionView.uicollectioreu = _searchController.searchBar;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(10.0, 0, 0, 0);
    layout.itemSize = CGSizeMake((self.view.bounds.size.width - 20.0) / 3, (self.view.bounds.size.width - 20.0) / 3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"ReuseIdentifier"];


    [self.view addSubview: _collectionView];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ReuseIdentifier" forIndexPath:indexPath];
    // Configure the cell
    cell.backgroundColor = [UIColor blackColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
    UICollectionReusableView *reusableview = nil;
    
       if (kind == UICollectionElementKindSectionFooter) {
           UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
           reusableview = footerview;
       }
           
       return reusableview;
}

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSLog(@"type...");

    }
}


@end
