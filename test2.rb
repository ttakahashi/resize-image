require 'rubygems'
require 'imlib2'

orgimg = Imlib2::Image.load('Chrysanthemum.jpg')
baseimg = Imlib2::Image.load('Lighthouse.jpg')
p orgimg.width
p orgimg.height

baseimg.blend_image!(orgimg, 50, 50, orgimg.width, orgimg.height, 100, 100, 500, 500)

baseimg.save("/home/ttakahashi/resize/slice3.png")#‚±‚ê‚¾‚Æ—]”’‚ª¶‚Ü‚ê‚È‚¢