# PenguinPay-iOS
Technical Test

## Architecture
I went for an MVVM architecture on this test. I also think it serves its purpose for the assignment so that I can show what I can do in terms of code structure and my way of decoupiling things.

## What can be improved

1- β Caching the conversion rate and deal with the timestamp to decide whether or not we can choose to perform request

2- π¨ Design π

3- π‘ Network layer: because we are dealing with just one API call here, a better abstraction can be considered 

4- βοΈ Tests: the ViewModels and all the logic around conversion and decoding could have been unit tested but it requires much more time to achieve it π

5- 0οΈβ£1οΈβ£ Binary conversion of decimal. In the demo, I am not proud to use `ceil` .

6- βοΈ Lack of fluid way of handling reactive programming (form validation). I put Rx first and after that tries other concept to avoid reactive framework dependency.


Thank you in advance for the review βΊοΈππ»π±
