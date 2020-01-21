# Seam Carving

- The goal of this project is to resize an image using seam carving techniques outlined in the paper: "Seam Carving for Content-Aware Image Resizing"; Avidan, S. & Shamir, A.; 2007

- For this project, I used two images, namely 'person.jpg' and 'sfo.jpg' with 20 horizontal and vertical and 25 horizontal and vertical seam removals.

- To run the code and generate resized images, download the files and run either one of the following in the MATLAB command window. The first input is the image you want to resize, the second input is the number of horizontal seams you want to remove and the third input is the number of vertical seams you want to remove:

  - `[Ic, T] = carv('person.jpg', 20, 20)`
  
  - `[Ic, T] = carv('person.jpg', 25, 25)`
  
  - `[Ic, T] = carv('sfo.jpg', 20, 20)`
  
  - `[Ic, T] = carv('sfo.jpg', 25, 25)`
 
 - `carv.m` will always output the gif with the name "seam_gif".
 
 - The resulting seam removal process on the images is shown below.
 
 20 horizontal and vertical seams removed:
 
 ![](Images/person_20.gif)
 
 ![](Images/sfo_20.gif)

25 horizontal and vertical seams removed:

 ![](Images/person_25.gif)
 
 ![](Images/sfo_25.gif)
