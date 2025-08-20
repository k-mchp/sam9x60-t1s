Prerequisites:
-This script was tested on Ubuntu 24.04.3

Description:
-This script clones all repos needed to build a t1s image for the SAM9X60 MPU into the newly created directory
-The script copies rebuild script into the build folder, so the image can be rebuilt by just running this script as ". t1s.rebuild" from the build folder
-The script also puts t1s.clean script into the build folder to clean a build
-Lastly it builds the final image


Usage:
". sam9x60-t1s-build.sh"

(You will be prompted for your password one time, this is your login password)

(Note - If you would like to do all of this manually, just follow the commands in azure-build script)
