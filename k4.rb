require 'rubygems'
require 'imlib2'

def calcsize (inimagew, inimageh, outimagew, outimageh)

  src = {:x => 0, :y => 0, :w => inimagew, :h => inimageh}
  dst = {:x => 0, :y => 0, :w => inimagew, :h => inimageh}

  if inimagew > outimagew then
    src[:x] = (inimagew - outimagew) / 2.0
  else
    dst[:x] = (outimagew - inimagew) / 2.0
  end
  if inimageh > outimageh then
    src[:y] = (inimageh - outimageh) / 2.0
  else
    dst[:y] = (outimageh - inimageh) / 2.0
  end
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
#dst =   {:x => 0, :y => 0, :w => 553, :h => 553}
#src =   {:x => (553-480)/2, :y => (553-360)/2, :w => 553, :h => 553}

p "dst:#{dst}"#.roundを忘れずに
p "src:x#{src[:x]}y#{src[:y]}w#{src[:w]}h#{src[:h]}"
#canvas.blend_image!(image, dst[:x].abs, dst[:y].abs, dst[:w].abs, dst[:h].abs, 0, 0, canvas_width, canvas_height)
canvas.blend_image!(image, src[:x], src[:y], src[:w], src[:h], dst[:x], dst[:y], dst[:w], dst[:h])

canvas.save("/home/ttakahashi/resize/canvas.png")#ファイルに書き出す
