require 'rubygems'
require 'imlib2'


def calcsize (inimagew, inimageh, outimagew, outimageh)

  src = {:x => 0, :y => 0, :w => inimagew, :h => inimageh}
  dst = {:x => 0, :y => 0, :w => outimagew, :h => outimageh}
 return [dst,src]
end


p ("canvas size")
p ('1. 200*150')
p ('2. 480*360')
p ('3. 720*540')
p ('4. 900*675')
order = $stdin.gets.to_i
case order
when 1 then
  canvas_width = 200
  canvas_height = 150
when 2 then
  canvas_width = 480
  canvas_height = 360
when 3 then
  canvas_width = 720
  canvas_height = 540
when 4 then
  canvas_width = 900
  canvas_height = 675
end

canvas = Imlib2::Image.new(canvas_width, canvas_height)#キャンバス作成

canvas.fill_rect [0, 0, canvas_width, canvas_height]#色を白に染める

image = Imlib2::Image.load('yokonaga.png')#イメージロード

dst, src =  calcsize(image.width, image.height, canvas_width, canvas_height)#サイズ計算
#p "dst:#{dst}"
#canvas.blend_image!(image, 0, 0, image.width, image.height, 0, 0, canvas_width, canvas_height)
canvas.blend_image!(image, src[:x], src[:y], src[:w], src[:h], dst[:x], dst[:y], dst[:w], dst[:h])

canvas.save("/home/ttakahashi/resize/canvas.png")#ファイルに書き出す
