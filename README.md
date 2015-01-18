# README #

This is a simple way of generating the members letter for Spektrum rf.


## Usage ##

To use this custom class you'll have to either add the spektraklet.cls to your latex installation or adding it to the project you are using.


## Commands ##

There are both optional and mandatory commands here's a list of all commands (with alternative arguments listed as different entries). The mandatory arguments are surrounded by { } parenthesis and the optional are surrounded by [ ] parenthesis.


### Title Page ###

This is the cover page of the letter. It contains the title and number of the current paper and a cover picture.

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


### Content Page ###

This is page shows the table of content and the names of the persons who contributed or works in the editorial.

This command doesn't have any parameters, but there are a number of variables that have to be set in order to complete adding this page.

```
#!latex
\contentpage
```


### Last Page ###
```
#!latex
\lastpage{arg1}{arg2}{arg3}
\lastpage{arg1}{arg2}{arg3}[arg4_opt]
```