pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--intro
function intro_draw()
 cls()
--[[
 for c=0,15 do
  rectfill(c*16,0,c*16,(c*16)+16,128,c)
 end
--]]
-- print(string,0,5,6)
 print(itext,0,5,6)
 print('❎ = pular',83,120,5)
 print('2025',3,120,5)
end

function intro_update()
--[[
 if i % 40 == 0 do
  if n<=#txts do
   txt=txts[n]
   itext=itext .. prompt
 	 if i % 5 == 0 then
 	 	if c<=#txt do
 		  itext = itext .. txt[c]
    end		 
		 end
	  c+=1
		 i+=1
   itext=itext .. '\n'
  end
  n+=1
 end
 i+=1
--]]
---[[
 if n<#text then
	 if i % 5 == 0 then
	  sfx(0)
	  itext = itext .. text[n]
	  n+=1
	 end
	 i+=1
 else
  state='menu'
 end
--]]
 if (btnp(❎)) state='menu'
end	
-->8
--menu
function menu_draw()
 cls(13)
 print(logo,0,0)
 w:draw()
 print('aperte ❎ para comecar',22,120,5)
end

function menu_update()
 w:update()
 if btnp(❎) then
  state='game'
 end
end
-->8
--game
function game_draw()
 cls(13)
 map(0,-2,b1,0,128,16,0x08)
 map(0,0,0,0,128,16)
 p:draw()	 
 for e in all(enemies) do
  e:draw()
 end
 camera(cx,cy)
 draw_hud()
end

function game_update()
 i+=1
 b1+= b1>-256 and -1 or 256
 cam(p)
 if i%40==0 then
-- 	e_spd
  add(enemies, enemy:new(rnd(1024),-8,-0.1))
 end
 for e in all(enemies) do
   e:update()
  if hit(e,p) then
   p:hit()
   del(enemies,e)
   if p.lives<=0 then
    state='gameover'
    camera(0,0)
   end
  end
 end
 p:update()
 p:animate()
 updt_hud(p)
 if (p.y>128) p:die()
end
-->8
--gameover
function gameover_draw()
 cls()
 print('game over!',46,58,8)
 print('aperte ❎ para reiniciar',18,65,5)
end

function gameover_update()
 if btnp(❎) then
  _init()
  state='menu'
  camera(cx,cy)
 end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000c00000c34300300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
