require 'rubygems'
require 'imlib2'

def calcsize_scale_and_cut (inimagew, inimageh, outimagew, outimageh)
  b_pic = {:x => 0, :y => 0, :w => inimagew, :h => inimageh}
  a_pic = {:x => 0, :y => 0, :w => 0, :h => 0}
  basesize = "1"#1�Ȃ牡��0�Ȃ�c��
  if b_pic[:w] <= b_pic[:h] then
    basesize = "0"
  end

  if basesize == "1" then
    a_pic[:w] = outimagew
       a_pic[:h] = (outimagew.to_f / inimagew * inimageh)
    #a_pic[:y] = outimageh - a_pic[:h]
    #�]���͉���after��y�����ł���

  else
    a_pic[:h] = outimageh
   
    a_pic[:w] = (outimageh.to_f / inimageh * inimagew)
    #a_pic[:x] = outimagew - a_pic[:w]
    #�]���͉���after��x�����ł���

  end
  
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

canvas = Imlib2::Image.new(canvas_width, canvas_height)#�L�����o�X�쐬

canvas.fill_rect [0, 0, canvas_width, canvas_height]#�F�𔒂ɐ��߂�

image = Imlib2::Image.load('yokonaga.png')#�C���[�W���[�h

dst, src =  calcsize_scale_and_cut(image.width, image.height, canvas_width, canvas_height)#�T�C�Y�v�Z
p "dst:#{dst}"#.round��Y�ꂸ��
p "src:x#{src[:x]}y#{src[:y]}w#{src[:w]}h#{src[:h]}"
#canvas.blend_image!(image, 0, 0, src[:w].round, src[:h].round, 0, 0, dst[:w].round, dst[:h].round)
canvas.blend_image!(image, src[:x], src[:y], src[:w], src[:h], dst[:x], dst[:y], dst[:w], dst[:h])

canvas.save("/home/ttakahashi/resize/canvas.png")#�t�@�C���ɏ����o��
