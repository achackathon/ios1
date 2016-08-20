//
//  NewProductViewController.m
//  Troca Legal
//
//  Created by Matheus C. Candido on 8/20/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "NewProductViewController.h"
#import "PFFile.h"
#import "PFQuery.h"

@interface NewProductViewController() {
    UIImageView *imageViewToSet;
    UIImageView *buttonToHide;
    
    
    NSArray *categories;
    NSArray *periods;
    PFObject *category;
}

@property (weak, nonatomic) IBOutlet UITextView *productDescription;
@property (weak, nonatomic) IBOutlet UITextField *productName;
@property (weak, nonatomic) IBOutlet UITextField *productCategory;
@property (weak, nonatomic) IBOutlet UISwitch *isForSell;
@property (weak, nonatomic) IBOutlet UISwitch *isForRent;
@property (weak, nonatomic) IBOutlet TRCurrencyTextField *productPrice;
@property (weak, nonatomic) IBOutlet UITextField *rentFrequency;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;


@property (weak, nonatomic) IBOutlet UIImageView *ico1;
@property (weak, nonatomic) IBOutlet UIImageView *ico2;
@property (weak, nonatomic) IBOutlet UIImageView *ico3;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

@end

@implementation NewProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *borderColor = [UIColor colorWithRed:189.0 / 255.0 green:193.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
    
    _productDescription.layer.borderWidth = 0.5f;
    _productDescription.layer.borderColor = borderColor.CGColor;
    
    _productName.layer.borderWidth = 0.5f;
    _productName.layer.borderColor = borderColor.CGColor;
    _productName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _productName.leftViewMode = UITextFieldViewModeAlways;
    
    _productCategory.layer.borderWidth = 0.5f;
    _productCategory.layer.borderColor = borderColor.CGColor;
    _productCategory.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _productCategory.leftViewMode = UITextFieldViewModeAlways;
    
    _productPrice.layer.borderWidth = 0.5f;
    _productPrice.layer.borderColor = borderColor.CGColor;
    _productPrice.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _productPrice.leftViewMode = UITextFieldViewModeAlways;
    
    _rentFrequency.layer.borderWidth = 0.5f;
    _rentFrequency.layer.borderColor = borderColor.CGColor;
    _rentFrequency.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _rentFrequency.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIPickerView *categoriesPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [categoriesPicker setDataSource: self];
    [categoriesPicker setDelegate: self];
    categoriesPicker.tag = 111;
    categoriesPicker.showsSelectionIndicator = YES;
    _productCategory.inputView = categoriesPicker;
    
    UIPickerView *periodsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [periodsPicker setDataSource: self];
    [periodsPicker setDelegate: self];
    periodsPicker.tag = 122;
    periodsPicker.showsSelectionIndicator = YES;
    _rentFrequency .inputView = periodsPicker;
    
    periods = @[@"dia", @"semana", @"mes"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Category"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        categories = objects;
    }];
    
    
    
}
- (IBAction)saveProduct:(id)sender {
    
    NSMutableArray *saveArray = [NSMutableArray array];
    
    PFObject *product = [PFObject objectWithClassName:@"Product"];
    product[@"productDescription"] = _productDescription.text;
    product[@"model"] = _productName.text;
    
    NSNumber *available = [NSNumber numberWithBool: true];
    product[@"available"] = available;
    
    
    NSNumber *isForRent = [NSNumber numberWithBool: _isForRent.isOn];
    NSNumber *isForSell = [NSNumber numberWithBool: _isForSell.isOn];
    
    product[@"isForRent"] = isForRent;
    product[@"isForSell"] = isForSell;
    
    product[@"price"] = _productPrice.value;
    
    product[@"seller"] = [PFUser currentUser];
    
    product[@"category"] = category;
    
    
    [saveArray addObject:product];
    
    
    if (!_image1.hidden && _image1.image != nil) {
        
        
        NSData* data = UIImageJPEGRepresentation(_image1.image, 0.5f);
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
        
        PFObject *image = [PFObject objectWithClassName:@"Images"];
        [image setObject:imageFile forKey:@"image"];
        [image setObject:product forKey:@"product"];
        
        product[@"featuredImage"] = image;
        
//        [saveArray addObject:image];

    }
    
    if (!_image2.hidden && _image2.image != nil) {
        
        NSData* data = UIImageJPEGRepresentation(_image2.image, 0.5f);
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
        
        PFObject *image = [PFObject objectWithClassName:@"Images"];
        [image setObject:imageFile forKey:@"image"];
        [image setObject:product forKey:@"product"];
        
        product[@"featuredImage"] = image;
        
//        [saveArray addObject:image];
    }
    
    if (!_image3.hidden && _image3.image != nil) {
    
        NSData* data = UIImageJPEGRepresentation(_image3.image, 0.5f);
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
        
        PFObject *image = [PFObject objectWithClassName:@"Images"];
        [image setObject:imageFile forKey:@"image"];
        [image setObject:product forKey:@"product"];
        
        product[@"featuredImage"] = image;
        
//        [saveArray addObject:image];
    }
    
    [PFObject saveAllInBackground:saveArray block:^(BOOL succeeded, NSError * _Nullable error) {
       
        if (succeeded) {
            
        }
        
        else {
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }];
    
}


#pragma mark - UIImagePicker actions and callbacks


- (IBAction)selectImage1:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        return;
        
    }
    
    imageViewToSet = _image1;
    buttonToHide = _ico1;
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectImage2:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        return;
        
    }
    
    imageViewToSet = _image2;
    buttonToHide = _ico2;
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectImage3:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        return;
        
    }
    
    imageViewToSet = _image3;
    buttonToHide = _ico3;
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    imageViewToSet.hidden = false;
    imageViewToSet.image = chosenImage;
    buttonToHide.hidden = true;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView.tag == 111) {
        return [categories count];
    }
    
    return [periods count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView.tag == 111) {
        return (NSString *) [[categories objectAtIndex:row] objectForKey:@"name"];
    }
    
    return (NSString *) [periods objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView.tag == 111) {
        
        category = [categories objectAtIndex:row];
        _productCategory.text = [category objectForKey:@"name"];
        
    }
    
    else {
        _rentFrequency.text = (NSString *) [periods objectAtIndex:row];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
