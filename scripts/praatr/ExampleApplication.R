# Example of a real application of PraatR
# Aaron Albin (www.aaronalbin.com)

# The tutorial on the PraatR website ( http://www.aaronalbin.com/praatr/tutorial.html ) focused on demonstrating the full range of PraatR's functionality.
# However, the actual analyses performed therein were not particularly useful ones for speech scientists.
# To see an example of how PraatR can be used in one common analysis task (formant extraction and analysis), work through the following script.

# ----------------------------
#  Getting everything set up 
# ----------------------------

# (1) Make sure PraatR is installed and loaded into an active R session:
library("PraatR")

# (2) Create a sub-folder named 'formants' inside the 'Tutorial' directory (which was created under 'Getting everything set up' at the beginning of the tutorial).
#     Into this sub-folder, download the following four files from the North Texas vowel database ( http://www.utdallas.edu/~assmann/KIDVOW1/North_Texas_vowel_database.html ):
#     - http://www.utdallas.edu/~assmann/KIDVOW1/kabrii01.wav  -->  Save as "heed.wav"
#     - http://www.utdallas.edu/~assmann/KIDVOW1/kabril11.wav  -->  Save as "hid.wav"
#     - http://www.utdallas.edu/~assmann/KIDVOW1/kabrel01.wav  -->  Save as "head.wav"
#     - http://www.utdallas.edu/~assmann/KIDVOW1/kabral01.wav  -->  Save as "had.wav"
#     These correspond to the four front monophthongs of a single speaker of American English from Dallas, Texas.

# (3) Adjust the first line below so it points to the 'formants' subfolder.
#     Then, run both lines to redefine the FullPath() function.
FormantDirectory = "C:/Users/MyUsername/Desktop/Tutorial/formants/"
FullPath = function(FileName){ return( paste(FormantDirectory,FileName,sep="") ) }

# (4) Install the 'audio' package from CRAN.
#     This package is highly recommended for any analysis dealing with soundfiles.
#     Its 'load.wave()' function is by far the fastest way of reading soundfiles into R.
AudioInstalled = require("audio") # TRUE if already installed, FALSE if not
if(!AudioInstalled){ install.packages("audio") } # You may need to open R as administrator/root in order for this to work

##############################
##############################
##############################

# Set the working directory to the folder where the data for the formant analysis are
setwd(FormantDirectory)

# See what files are in this directory
list.files()
# [1] "had.wav"  "head.wav" "heed.wav" "hid.wav"

# Play all four soundfiles to hear what we are working with
praat( "Play", input=FullPath("heed.wav") )
praat( "Play", input=FullPath("hid.wav") )
praat( "Play", input=FullPath("head.wav") )
praat( "Play", input=FullPath("had.wav") )

# Select which vowel you want to analyze:
TargetVowel = c( "heed", # 1
                 "hid",  # 2
                 "head", # 3
                 "had"   # 4
               )[2] # CHANGE THIS NUMBER AND RUN THE CODE

###########################
# Extract formant contour #
###########################

# Add '.wav' to the end of this to make a filename
AudioFilename = paste(TargetVowel,".wav",sep="")

# Do similarly for the Formant object we will create
FormantFilename = paste(TargetVowel,".Formant",sep="")

# Set the parameters for the formant analysis
FormantArguments = list( 0.001, # Time step (s)
                         5,     # Max. number of formants
                         5500,  # Maximum formant (Hz)
                         0.025, # Window length (s)
                         50    )# Pre-emphasis from (Hz)

# Use PraatR to extract out the formant contour
praat( "To Formant (burg)...",
       arguments = FormantArguments,
       input = FullPath(AudioFilename),
       output = FullPath(FormantFilename)
      ) # End praat()

# Next we will summarize the data in this Formant object as a table
# Create the filename for the table
TableFilename = paste(TargetVowel,"_Table.txt",sep="")

# Specify the parameters for how the formant data should be summarized in a table
TabulationArguments = list( TRUE, # Include frame number
                            TRUE, # Include time
                            3,    # Time decimals
                            TRUE, # Include intensity
                            3,    # Intensity decimals
                            TRUE, # Include number of formants
                            3,    # Frequency decimals
                            TRUE )# Include bandwidths

# Summarize the formant object as a table 
praat( "Down to Table...",
       arguments = TabulationArguments,
       input = FullPath(FormantFilename),
       output = FullPath(TableFilename),
       filetype = "tab-separated"
      ) # End praat()

# Show what the header row of the resulting table looks like (hence what information it contains)
cat( readLines( TableFilename )[1], "\n" )

# Read the table into R
Dataframe = read.table( file=TableFilename, header=TRUE, sep="\t", na.strings="--undefined--" )

# Show what the column names are
colnames(Dataframe)
# Note that R changed all parentheses to periods

#####################################
# Identify vowel's start/end points #
#####################################

# Use the load.wave() function from the 'audio' package to read the soundfile into R
Audio = load.wave(AudioFilename)

# Reconstruct the time domain from the audio
Time = ( 1:length(Audio) ) / Audio$rate

# Plot the waveform
plot(x=Time, y=Audio, type="l", las=1, main=TargetVowel)
# If you would like to generate a spectrogram instead, use the following script: https://raw.githubusercontent.com/usagi5886/dsp/master/Spectrogram().r

# Based on where you see the large-amplitude vibrations, mark the beginning point of the vowel.
# (Don't worry about where you click vertically; just pay attention to the horizontal location of your click.)
BeginningPoint = locator(1)$x

# Show where you clicked
abline( v=BeginningPoint, col="red", lty="dashed", lwd=2 )

# Do the same for the ending point of the vowel
EndingPoint = locator(1)$x
abline( v=EndingPoint, col="red", lty="dashed", lwd=2 )

# Close the plot window
graphics.off()

############################
# Plot the formant contour #
############################

# Using the start/end points just identified, determine which sampled time points correspond to the vowel
TimeRange = ( Dataframe$time > BeginningPoint ) & ( Dataframe$time < EndingPoint )

# Use this information to extract out vectors for each formant
F1 = Dataframe[TimeRange,"F1.Hz."]
F2 = Dataframe[TimeRange,"F2.Hz."]
F3 = Dataframe[TimeRange,"F3.Hz."]
F4 = Dataframe[TimeRange,"F4.Hz."]
F5 = Dataframe[TimeRange,"F5.Hz."]

# Also make a sequence of time values
TimeSequence = Dataframe[TimeRange,"time.s."]

# Plot the formant track
plot(NULL, xlim=range(TimeSequence), ylim=c(0,FormantArguments[[3]]), las=1, main=TargetVowel, xlab="Time", ylab="Hertz" )
lines( x=TimeSequence[!is.na(F1)], y=F1[!is.na(F1)] )
lines( x=TimeSequence[!is.na(F2)], y=F2[!is.na(F2)] )
lines( x=TimeSequence[!is.na(F3)], y=F3[!is.na(F3)] )
lines( x=TimeSequence[!is.na(F4)], y=F4[!is.na(F4)] )
lines( x=TimeSequence[!is.na(F5)], y=F5[!is.na(F5)] )

# Find the median value for F1 and F2 across the vowel's duration
MedianF1 = median(F1, na.rm=TRUE)
MedianF2 = median(F2, na.rm=TRUE)

# Show these values in the plot
abline(h=MedianF1, col="blue", lty="dotted")
abline(h=MedianF2, col="blue", lty="dotted")

# Plot the formant trajectory in F1-F2 space
plot(F2, F1, xlim=rev(range(F2)), ylim=rev(range(F1)), col="#33333333", pch=16, type="o", las=1, main=TargetVowel)

# Add a marker to indicate where the trajectory begins
points(x=F2[1], y=F1[1], col="red", cex=2)

# Show the F1-F2 median point
points(x=MedianF2, y=MedianF1, pch=15, col="blue", cex=2)

# Close any open plots
graphics.off()

################################
# Loop through all four vowels #
################################

# Turn off the 'bell' sound when you click on the plot
options(locatorBell=FALSE)

# The code below is almost identical to the code above, but in a more condensed form, and it loops through all 4 vowel tokens.
AllTargetVowels = c( "heed", "hid", "head", "had" )
nVowels = length(AllTargetVowels)
AllMedianF1s = rep(NA,times=nVowels)
AllMedianF2s = rep(NA,times=nVowels)
for(EachVowel in 1:nVowels){ # EachVowel=1
TargetVowel = AllTargetVowels[EachVowel]
AudioFilename = paste(TargetVowel,".wav",sep="")
FormantFilename = paste(TargetVowel,".Formant",sep="")
TableFilename   = paste(TargetVowel,"_Table.txt",sep="")
praat( "To Formant (burg)...", arguments=FormantArguments, input=FullPath(AudioFilename),
        output=FullPath(FormantFilename), overwrite=TRUE )
praat( "Down to Table...", arguments=TabulationArguments, input=FullPath(FormantFilename),
        output=FullPath(TableFilename), filetype="tab-separated", overwrite=TRUE )
Dataframe = read.table( file=TableFilename, header=TRUE, sep="\t", na.strings="--undefined--" )
Audio = load.wave(AudioFilename)
Time = ( 1:length(Audio) ) / Audio$rate
main=paste(EachVowel,"/",nVowels,": ",TargetVowel, sep="")
plot(x=Time, y=Audio, type="l", las=1, main=main )
praat( "Play", input=FullPath(AudioFilename) )
BeginningPoint = locator(1)$x
abline( v=BeginningPoint, col="red", lty="dashed", lwd=2 )
EndingPoint = locator(1)$x
abline( v=EndingPoint, col="red", lty="dashed", lwd=2 )
TimeRange = ( Dataframe$time > BeginningPoint ) & ( Dataframe$time < EndingPoint )
F1 = Dataframe[TimeRange,"F1.Hz."]
F2 = Dataframe[TimeRange,"F2.Hz."]
AllMedianF1s[EachVowel] = median(F1, na.rm=TRUE)
AllMedianF2s[EachVowel] = median(F2, na.rm=TRUE)
} # End 'EachVowel' loop
graphics.off()

# Take a look the data we just obtained
data.frame( Vowel=AllTargetVowels, F1=AllMedianF1s, F2=AllMedianF2s )

# Make a traditional F1-F2 plot of this data
IPA = c("i", "ɪ", "ɛ", "æ")
plot( NULL, xlim=rev(range(AllMedianF2s)), ylim=rev(range(AllMedianF1s)), las=1, xlab="F2", ylab="F1", main="Front vowels" )
text( x=AllMedianF2s, y=AllMedianF1s, labels=IPA )

