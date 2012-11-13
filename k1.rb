require 'rubygems'
require 'imlib2'

def calcsize (inimagew, inimageh, outimagew, outimageh)
  b_pic = {:x => 0, :y => 0, :w =>0, :h => 0}
  a_pic = {:x => 0, :y => 0, :w => outimagew, :h => outimageh}

  basesize = "1"#1なら横長0なら縦長
  if inimagew < inimageh then
    basesize = "0"
  elsif inimagew == inimageh then
    basesize = "2"
  end

  if basesize == "1" then
    b_pic[:x] = (outimagew.to_f - inimagew.to_f) / 2.0
    b_pic[:w] = outimagew
    
    b_pic[:y] = 0
    b_pic[:h] = inimageh
  elsif basesize == "0" then
    b_pic[:x] = 0
    b_pic[:w] = inimagew
        
    b_pic[:y] = (inimageh.to_f - outimageh.to_f) / 2.0
    b_pic[:h] = outimageh
  else
    b_pic[:x] = 0
    b_pic[:w] = outimagew

    b_pic[:y] = (inimageh.to_f - outimageh.to_f) / 2.0
    b_pic[:h] = outimageh
  end
  b_pic[:x]=b_pic[:x].abs
  b_pic[:y]=b_pic[:y].abs

  return [a_pic,b_pic]
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
p "width#{image.width} height#{image.height}"
dst, src =  calcsize(image.width, image.height, canvas_width, canvas_height)#サイズ計算
#src =   {:x => (1045-480)/2, :y => 0, :w => 480, :h => 387}
#dst =   {:x => 0, :y => 0, :w => 480, :h => 360}
#src =   {:x => 0, :y => (751 - 360) / 2, :w => 312, :h => 360}
#dst =   {:x => 0, :y => 0, :w => 480, :h => 360}
#src =   {:x => 0, :y => (551 - 360) / 2, :w => 551, :h => 360}
#dst =   {:x => 0, :y => 0, :w => 480, :h => 360}
#src =   {:x => 0, :y => 27, :w => 221, :h => 221-27}#square_s
#dst =   {:x => 0, :y => 0, :w => 480, :h => 360+27}#square_s
#src =   {:x => 0, :y => 52, :w => 553, :h => 553-52}#square_b
#dst =   {:x => 0, :y => 0, :w => 480, :h => 360+52}#square_b
p "src:x#{src[:x]}y#{src[:y]}w#{src[:w]}h#{src[:h]}"
p "dst:#{dst}"

canvas.blend_image!(image, src[:x], src[:y], src[:w], src[:h], dst[:x], dst[:y], dst[:w], dst[:h])

canvas.save("/home/ttakahashi/resize/canvas.png")