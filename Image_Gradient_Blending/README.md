The goal of this project is to seamlessly blend an object from a source image into a target image. The blending is done as described in the paper "Poisson Image Editing" by Patrick Perez, Michel Gangnet and Andrew Blake.


1) To run this assignment, unzip the zip folder, open MATLAB and run the following:

resultImg = seamlessCloningPoisson('1_source.jpg','1_background.jpg', imread('1_mask.png'), 300, 250)

2) Results with the minnion are in the folder. Unfortunately, I was not able to get rid of the white spot near the bottom of the minion. 
