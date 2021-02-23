using FileIO
using Images
using ImageMagick
using TestImages
using ImageEdgeDetection

img = testimage("mandrill");

imgg = imfilter(img, Kernel.gaussian(5));

save("D://1.png", imgg)

imgg2 = detect_edges(img, Canny(spatial_scale = 1.4))

save("D://2.png", imgg2)

# https://juliahub.com/docs/ImageEdgeDetection/5h14T/0.1.0/