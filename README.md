# Braille Pattern Recognition 

Braille Pattern Recognition using using Digital Image Processing Techniques is implemented in MATLAB

## The Braille Language

Braille is a system of touch reading and writing for blind persons in which raised dots represent the letters of the alphabet. It also contains equivalents for punctuation marks and provides symbols to show letter groupings

## About

The project uses image processing tools and techniques for converting an imprinted __GRADE 1__ Braille pattern into natural language character

The processing takes place through a series of steps implemented through MATLAB. 

## Prerequisites
* MATLAB
* MATLAB Add ON: Image Processing Toolbox

## Usage

Input Image is taken through _**imread**_ command in MATLAB, where Image File name is to be given as Input.

```bash
img = imread("filename.extension");

eg. img = imread("img1.jpg");
```

## Limitations

* Currently supports only **Grade 1 Braille**.
* Accepts **only RGB Images** as Input
* Input Image must be **properly aligned**.

## Contributing
Pull requests are welcome. For changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.




