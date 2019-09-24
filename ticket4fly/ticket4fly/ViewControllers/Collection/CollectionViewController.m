//
//  CollectionViewController.m
//  ticket4fly
//
//  Created by Igor on 24/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"


@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray* imageCollection;
@property (strong, nonatomic) UICollectionView *collectionView;


@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(10.0, 0, 0, 0);
    layout.itemSize = CGSizeMake(self.view.bounds.size.width / 3.2, self.view.bounds.size.width / 3.2);
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



@end
