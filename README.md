# README #

This is a simple way of generating the members letter for Spektrum rf.


## Usage ##

To use this custom class you'll have to either add the spektraklet.cls to your latex installation or adding it to the project you are using.


## Commands ##

There are both optional and mandatory commands here's a list of all commands (with alternative arguments listed as different entries):


```
#!latex

% The front page, showing the name and the yearly number of the letter.
% A cover image should also be included. This cover page is possible to move
% around with offsets in both directions for more control.

\titlepage{arg1}{arg2}{arg3}
\titlepage{arg1}{arg2}{arg3}[arg4_opt]

% arg1       =   Current letter number, shown on the front page
% arg2       =   Width of the cover image
% arg3       =   path to the cover image
% arg4_opt   =   dx, dy     offset of the cover image

% example:
\titlepage{1}{\paperwidth}{images/cover.jpg}[1cm, 2cm]
```
```
#!latex
\contentpage
```
```
#!latex
\lastpage{arg1}{arg2}{arg3}
\lastpage{arg1}{arg2}{arg3}[arg4_opt]
```