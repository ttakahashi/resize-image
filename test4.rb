  require 'rubygems'
require 'imlib2'

def calcsize (inimagew, inimageh, outimagew, outimageh)
  b_pic = {:x => 0, :y => 0, :w => 0, :h => 0}
  a_pic = {:x => 0, :y => 0, :w => 0, :h => 0}
  b_pic[:w] = inimagew
  b_pic[:h] = inimageh
  basesize = "1"#1‚È‚ç‰¡’·0‚È‚çc’·
  if b_pic[:w] <= b_pic[:h] then
    basesize = "0"
  end

  if basesize == "1" then
    a_pic[:w] = outimagew
    a_pic[:h] = outimagew.to_f / b_pic[:w] * b_pic[:h]
    a_pic[:y] = outimageh - a_pic[:h]
    a_pic[:y] = a_pic[:y].to_f / 2
  else
    a_pic[:h] = outimageh
    a_pic[:w] = a_pic[:h] / b_pic[:h].to_f * b_pic[:w]
    a_pic[:x] = outimagew - a_pic[:w]
    a_pic[:x] = a_pic[:x].to_f / 2
  end

  a_pic[:x] = a_pic[:x].round
  a_pic[:y] = a_pic[:y].round
  a_pic[:w] = a_pic[:w].round
  a_pic[:h] = a_pic[:h].round
  return [a_pic,b_pic]
end


orgimg = Imlib2::Image.load('yokonaga.png')
baseimg = Imlib2::Image.load('Lighthouse.jpg')
p ("output image size")
p ('1. 200*150')
p ('2. 480*360')
p ('3. 720*540')
p ('4. 900*675')
order = $stdin.gets.to_i
case order
when 1 then
  outimagew = 200
  outimageh = 150
when 2 then
  outimagew = 480
  outimageh = 360
when 3 then
  outimagew = 720
  outimageh = 540
when 4 then
  outimagew = 900
  outimageh = 675
end
 iw, ih = orgimg.width, orgimg.height
 p "width:#{iw}, height:#{ih}"

src, dst =  calcsize(iw, ih, outimagew, outimageh)
p "after:#{src}"
p "before:#{dst}"

  new_w, new_h = src[:w], src[:h]
  x, y, w, h = src[:x], src[:y], src[:w], src[:h]
  p "x:#{x}, y:#{y}, w:#{w}, h:#{h}"
  orgimg.crop_scaled! x, y, w, h, new_w, new_h
  orgimg.save("/home/ttakahashi/resize/slice4-orgimg.png")


baseimg.blend_image!(orgimg, 0, 0, src[:w], src[:h], x, y, iw, ih)

baseimg.save("/home/ttakahashi/resize/slice4.png")