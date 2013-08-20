AFCoreImageSerializer
=====================

`AFCoreImageSerializer` automatically applies a series of [Core Image](https://developer.apple.com/library/Mac/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html) filters to response images.

## Usage

```objective-c
#import <CoreImage/CoreImage.h>

#import "UIImageView+AFNetworking"

CIFilter *blackAndWhiteFilter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:@"inputBrightness", @(0.0), @"inputContrast", @(1.1), @"inputSaturation", @(0.0), nil];
self.imageView.imageResponseSerializer = [AFCoreImageSerializer serializerWithFilters:@[blackAndWhiteFilter]];
[self.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.png"]];
```

---

## Contact

Mattt Thompson

- http://github.com/mattt
- http://twitter.com/mattt
- m@mattt.me

## License

AFCoreImageSerializer is available under the MIT license. See the LICENSE file for more info.
