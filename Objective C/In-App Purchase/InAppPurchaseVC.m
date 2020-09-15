//
//  InAppPurchaseVC.m
//  Qer3ah
//
//  Created by EbitNHP-i1 on 16/04/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

@import StoreKit;

#import "InAppPurchaseVC.h"

#define kRemoveAdsProductIdentifier @"Proudct_ID"

@interface InAppPurchaseVC () <SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    Utils *utils;
}

@end

@implementation InAppPurchaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialize
    utils = [Utils new];
}

//MARK:- IBActions

- (IBAction)btnPurchaseTap:(UIButton *)sender {
    NSLog(@"User requests to remove ads");
    
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"User can make payments");
        
        //Request product with product identifier
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kRemoveAdsProductIdentifier]];
        
        //Set Delegate
        productsRequest.delegate = self;
        
        //Send request to App Store
        [productsRequest start];
        
    } else {
        NSLog(@"User cannot make payments due to parental controls");
    }
}

- (IBAction)brnRestorePurchaseTap:(UIButton *)sender {
    //This is called when the user restores purchases
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (IBAction)btnBackTap:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK:- SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    SKProduct *validProduct = nil;
    
    if (response.products.count > 0) {
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    } else if (!validProduct) {
        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Failed to load list of products.");
    NSLog(@"Error: %@",error.localizedDescription);
}

//MARK:- SKPaymentTransactionObserver

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    NSLog(@"Received restored transactions: %lu", (unsigned long)queue.transactions.count);
    
    for (SKPaymentTransaction *transaction in queue.transactions) {
        if (transaction.transactionState == SKPaymentTransactionStateRestored) {
            //Called when the user successfully restores a purchase
            NSLog(@"Transaction state -> Restored");

            NSString *productID = transaction.payment.productIdentifier;
            if ([productID isEqual:kRemoveAdsProductIdentifier]) {
                [self doRemoveAds];
            }
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                //User Purchasing Product
                NSLog(@"Transaction state -> Purchasing");
                break;
                
            case SKPaymentTransactionStatePurchased:
                //Usr Purchased Product
                [self doRemoveAds];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased");
                break;
                
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                //User Purchase Restored
                [self doRemoveAds];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                //User Purchase Failed
                if (transaction.error.code == SKErrorPaymentCancelled) {
                    NSLog(@"Transaction state -> User Cancelled");
                } else if (transaction.error.code == SKErrorPaymentInvalid) {
                    NSLog(@"Transaction state -> Payment Invalid");
                } else if (transaction.error.code == SKErrorPaymentNotAllowed) {
                    NSLog(@"Transaction state -> Payment NotAllowed");
                }
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction] ;
                break;
                
            case SKPaymentTransactionStateDeferred:
                NSLog(@"Transaction state -> Deferred");
                break;
        }
    }
}

//MARK:- Custom Method

- (void)purchase:(SKProduct *)product {
    //Get Product Price
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    //Add Observer In Payment Queue
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    //Add payment request in Queue
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)doRemoveAds {
    [utils setIsRemoveAd:@"Yes"];
}

@end
