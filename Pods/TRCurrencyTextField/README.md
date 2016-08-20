# TRCurrencyTextField

[![Build Status](https://travis-ci.org/thiagoross/TRCurrencyTextField.svg?branch=master)](https://travis-ci.org/thiagoross/TRCurrencyTextField)
[![Version](https://img.shields.io/cocoapods/v/TRCurrencyTextField.svg?style=flat)](http://cocoapods.org/pods/TRCurrencyTextField)
[![License](https://img.shields.io/cocoapods/l/TRCurrencyTextField.svg?style=flat)](http://cocoapods.org/pods/TRCurrencyTextField)
[![Platform](https://img.shields.io/cocoapods/p/TRCurrencyTextField.svg?style=flat)](http://cocoapods.org/pods/TRCurrencyTextField)

## What it is?

TRCurrencyTextField is a component to make currency formatted input easy to get. It provides a real-time currency formatted text while the user types on number pad.

![TRCurrencyTextField Example](http://i1310.photobucket.com/albums/s647/rossener/TRCurrencyTextField/trcurrencytextfield-example_zpsc3c4y4rj.gif)

## What it does?

* No value means value 0
* Digits come from right to the left
* No need to type commmas or dots
* Delete shifts digits
* Edit text from the middle
* Paste from anywhere
* Change currency code easily
* Change country code easily
* Change locale easily
* Set maximum of digits
* Whitespace close to symbol configurable
* Get text value (ex: R$ 1.234,00)
* Get number value (ex: 1234.0)

More details [here](http://www.rossener.com/trcurrencytextfield-a-component-with-value/).

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

TRCurrencyTextField is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TRCurrencyTextField"
```

## How to create a TRCurrencyTextField

The component is always created with:

* Currency code: BRL
* Value: 0
* Max digits: 11
* Whitespace close to symbol: true

To create a component, just do what you are used to do:

```objective-c
TRCurrencyTextField *textField = [[TRCurrencyTextField alloc] init];
```

### Change the Value

From R$ 0,00 to R$ 1.234,00, you can do for example:

```objective-c
textField.value = [NSNumber numberWithInt:1234];
```

#### Change the Currency Code

From R$ 1.234,00 to $ 1,234.00

```objective-c
textField.currencyCode = @"USD";
```

#### Change the Country Code

From $ 1,234.00 to 1 234,00 €

```objective-c
[textField setCountryCode:@"FR"];
```

It is possible only with set method, because one country has only one currency, but one currency can be used on many countries. 

So, you can set only one country, but you can get all of countries which use the currency.

#### Change the Locale

From 1 234,00 € to US$ 1,234.00

```objective-c
[textField setLocale:@"en_ZW"];
```

Also, it is possible only with set method.

#### Change max digits

You can set the maximum of number digits on the text, so to change, for example, from US$ 999,999,999.99 to US$ 999,999.99

```objective-c
textField.maxDigits = 8;
```

#### Hide the whitespace close to symbol

Also, you can remove the whitespace close to symbol.

So, from US$ 1,234.00 to US$1,234.00

```objective-c
textField.addWhiteSpaceOnSymbol = NO;
```

## Release Notes

Version 0.1.1
* Fixed crashes caused by editing currency symbol
* Fixed conversion from value to string in TRFormatterHelper
* Added support for Editing Changed event

Version 0.1.0
* Initial release

## Author

[Thiago Rossener](http://www.rossener.com)

## License

TRCurrencyTextField is available under the MIT license. See the LICENSE file for more info.
