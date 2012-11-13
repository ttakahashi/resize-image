  require 'rubygems'
require 'imlib2'

orgimg = Imlib2::Image.load('Chrysanthemum.jpg')
baseimg = Imlib2::Image.load('Lighthouse.jpg')
 iw, ih = orgimg.width, orgimg.height
  new_w, new_h = iw / 2, ih / 2
  x, y, w, h = 100, 100, iw - 100, ih - 100
  orgimg.crop_scaled! x, y, w, h, new_w, new_h
  orgimg.save("/home/ttakahashi/resize/slice4.png")