# Polar-Check
 
Quick check on whether Gen Z men are super conservative, inspired by [this tweet](https://twitter.com/jburnmurdoch/status/1750849189834022932) and [this article](https://www.ft.com/content/29fd9b5c-2f35-41bf-9d4c-994db4e12998).

My conclusion? Seems driven by a huge outlier in 2022 after the sampling methodology changed.

The [General Social Survey (GSS) website](https://gss.norc.org/) and their detailed [codebook](https://gss.norc.org/Documents/codebook/GSS%202022%20Codebook.pdf) are filled with warnings about it. It could be pure measurement or survey error, but I suspect it's something with the new post-stratification. I leave that rabbit hole to my fellow data-nerd comrades with long plane rides :)

Data source: [GSS Data](https://gss.norc.org/get-the-data/stata).

The code is pretty straightforward. Just load the dataset, take weighted averages by demo x year, and plot.

Only thing I had to figure out was what's the correct weight variable. The Codebook says to use `wtsscomp`, which is also what's used on the site here: [GSS Data Explorer](https://gssdataexplorer.norc.org/trends).

## Other Variables to Check

I flagged these for future exploration:

- `fechld`: Mother working doesn't harm children.
- `fefam`: Better for man to work, woman stay home.
- `fepol`: Women not suited for politics.
- `fepresch`: Preschool kids suffer if mother works.
- `abany`: Abortion if woman wants for any reason.
- `pillok`: Birth control for teens.
- `attend`: Frequency of attending religious services.
- `bible`: Feelings about the Bible.
- `cappun`: Death penalty for murder.
- `gunlaw`: Gun permits.
- `helpblk`: Government should help Black folks.
- `natrace`: Spending to help Black folks.
- `helppoor`: Government should help poor folks.
- `natfare`: Spending on welfare.
- `natarms`: Spending to increase military.
- `natcrime`: Spending to decrease crime.
- `natenvir`: Spending to protect environment.
- `natheal`: Spending to improve health.
