require 'rubygems'
require 'imlib2'

def calcsize (inimagew, inimageh, outimagew, outimageh)
  b_pic = {:x => 0, :y => 0, :w => 0, :h => 0}
  a_pic = {:x => 0, :y => 0, :w => 0, :h => 0}
  b_pic[:w] = inimagew
  b_pic[:h] = inimageh
  basesize = "1"#1なら横長0なら縦長
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

canvas.blend_image!(image, 0, 0, image.width, image.height, dst[:x], dst[:y], dst[:w], dst[:h])

canvas.save("/home/ttakahashi/resize/canvas.png")#ファイルに書き出す
